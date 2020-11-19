Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026152B8F25
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgKSJik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:38:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:56340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgKSJij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:38:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2886AC59;
        Thu, 19 Nov 2020 09:38:37 +0000 (UTC)
Date:   Thu, 19 Nov 2020 09:38:34 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
Message-ID: <20201119093834.GH3306@suse.de>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.269943012@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20201118204007.269943012@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 08:48:42PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> Now that the scheduler can deal with migrate disable properly, there is no
> real compelling reason to make it only available for RT.
>=20
> There are quite some code pathes which needlessly disable preemption in
> order to prevent migration and some constructs like kmap_atomic() enforce
> it implicitly.
>=20
> Making it available independent of RT allows to provide a preemptible
> variant of kmap_atomic() and makes the code more consistent in general.
>=20
> FIXME: Rework the comment in preempt.h - Peter?
>=20

I didn't keep up to date and there is clearly a dependency on patches in
tip for migrate_enable/migrate_disable . It's not 100% clear to me what
reworking you're asking for but then again, I'm not Peter!

=46rom tip;

/**
 * migrate_disable - Prevent migration of the current task
 *
 * Maps to preempt_disable() which also disables preemption. Use
 * migrate_disable() to annotate that the intent is to prevent migration,
 * but not necessarily preemption.
 *
 * Can be invoked nested like preempt_disable() and needs the corresponding
 * number of migrate_enable() invocations.
 */

I assume that the rework is to document the distinction between
migrate_disable and preempt_disable() because it may not be clear to some
people why one should be used over another and the risk of cut&paste
cargo cult programming.

So I assume the rework is for the middle paragraph

 * Maps to preempt_disable() which also disables preemption. Use
 * migrate_disable() to annotate that the intent is to prevent migration,
 * but not necessarily preemption. The distinction is that preemption
 * disabling will protect a per-cpu structure from concurrent
 * modifications due to preemption. migrate_disable partially protects
 * the tasks address space and potentially preserves the TLB entries
 * even if preempted such as an needed for a local IO mapping or a
 * kmap_atomic() referenced by on-stack pointers to avoid interference
 * between user threads or kernel threads sharing the same address space.

I know it can have other examples that are rt-specific and some tricks on
percpu page alloc draining that relies on a combination of migrate_disable
and interrupt disabling to protect the structures but the above example
might be understandable to a non-RT audience.

--=20
Mel Gorman
SUSE Labs

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEElcbIJ2qkxLDKryriKjSY26pIcMkFAl+2PRoACgkQKjSY26pI
cMnvPgf8C0Rz6379u3SiizulY/2x+DGd943six/cqbAevyKsHg44fG6DLNobVUIY
vzIcm+xG8K3Y6JoLem7YN05cIW8ex36spIKu3Efjc5f7jnrr+kpkJ4iM9M6P1o32
UnEXwAJrONi/DpJxyNT/oWhAsyvPiHam/XeOL+b6w6OuUclG4z/zWSVaWIoE1l6t
kiTuAXrLRNeY7oUk4tWLd/eFSj+IqGB/te3+d/MO/rS4uKE6CArLpmvH0X/TcvGC
su9aEnObX/kRphCpcAXH+DBaiVryoC1G8k6GQYhG6ymlksq3jNpfidB9zwsgJee8
KgH+bSJw22QhfZjni+fv63YXgTjpyQ==
=600v
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
