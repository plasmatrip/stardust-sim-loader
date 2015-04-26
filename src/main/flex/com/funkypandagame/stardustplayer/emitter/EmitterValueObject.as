package com.funkypandagame.stardustplayer.emitter
{

import com.funkypandagame.stardustplayer.Particle2DSnapshot;

import flash.net.registerClassAlias;
import flash.utils.ByteArray;
import flash.utils.getQualifiedClassName;

import idv.cjcat.stardustextended.common.emitters.Emitter;

import idv.cjcat.stardustextended.common.particles.Particle;
import idv.cjcat.stardustextended.common.particles.PooledParticleFactory;

import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

import starling.textures.SubTexture;

import starling.textures.Texture;

public class EmitterValueObject
{
    public var emitter : Emitter;
    /** Snapshot of the particles. If its not null then the emitter will have the particles here upon creation. */
    public var emitterSnapshot : ByteArray;
    private var _id : uint;

    public function EmitterValueObject( emitterId : uint, _emitter : Emitter )
    {
        emitter = _emitter;
        _id = emitterId;
    }

    public function get id() : uint
    {
        return _id;
    }

    public function get texture() : Vector.<SubTexture>
    {
        if (emitter.particleHandler is StarlingHandler)
        {
            return StarlingHandler(emitter.particleHandler).textures;
        }
        return null;
    }

    public function addParticlesFromSnapshot() : void
    {
        registerClassAlias(getQualifiedClassName(Particle2DSnapshot), Particle2DSnapshot);
        emitterSnapshot.position = 0;
        var particlesData : Array = emitterSnapshot.readObject();
        var factory : PooledParticleFactory = new PooledParticleFactory();
        var particles:Vector.<Particle> = factory.createParticles(particlesData.length, 0);
        for (var j:int = 0; j < particlesData.length; j++) {
            Particle2DSnapshot(particlesData[j]).writeDataTo(particles[j]);
        }
        emitter.addParticles(particles);
    }

}
}
