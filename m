Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47832849F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:01:27 -0400
Received: from foss.arm.com ([217.140.110.172]:43486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgJFKB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:01:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE3BE113E;
        Tue,  6 Oct 2020 03:01:25 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 894AB3F66B;
        Tue,  6 Oct 2020 03:01:24 -0700 (PDT)
Date:   Tue, 6 Oct 2020 11:01:21 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, herbert@gondor.apana.org.au,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        ardb@kernel.org, broonie@kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [BUG][PATCH] crypto: arm64: Avoid indirect branch to bti_c
Message-ID: <20201006100121.GW6642@arm.com>
References: <20201006034854.2277538-1-jeremy.linton@arm.com>
 <20201006082748.GB25305@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006082748.GB25305@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:27:48AM +0100, Will Deacon wrote:
> On Mon, Oct 05, 2020 at 10:48:54PM -0500, Jeremy Linton wrote:
> > The AES code uses a 'br x7' as part of a function called by
> > a macro. That branch needs a bti_j as a target. This results
> > in a panic as seen below. Instead of trying to replace the branch
> > target with a bti_jc, lets replace the indirect branch with a
> > bl/ret, bl sequence that can target the existing bti_c.
> > 
> >   Bad mode in Synchronous Abort handler detected on CPU1, code 0x34000003 -- BTI
> >   CPU: 1 PID: 265 Comm: cryptomgr_test Not tainted 5.8.11-300.fc33.aarch64 #1
> >   pstate: 20400c05 (nzCv daif +PAN -UAO BTYPE=j-)
> >   pc : aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
> >   lr : aesbs_xts_encrypt+0x48/0xe0 [aes_neon_bs]
> >   sp : ffff80001052b730
> > 
> >   aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
> >    __xts_crypt+0xb0/0x2dc [aes_neon_bs]
> >    xts_encrypt+0x28/0x3c [aes_neon_bs]
> >   crypto_skcipher_encrypt+0x50/0x84
> >   simd_skcipher_encrypt+0xc8/0xe0
> >   crypto_skcipher_encrypt+0x50/0x84
> >   test_skcipher_vec_cfg+0x224/0x5f0
> >   test_skcipher+0xbc/0x120
> >   alg_test_skcipher+0xa0/0x1b0
> >   alg_test+0x3dc/0x47c
> >   cryptomgr_test+0x38/0x60
> > 
> > Fixes: commit 0e89640b640d ("crypto: arm64 - Use modern annotations for assembly functions")
> 
> nit: the "commit" string shouldn't be here, and I think the linux-next
> scripts will yell at us if we don't remove it.
> 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  arch/arm64/crypto/aes-neonbs-core.S | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/crypto/aes-neonbs-core.S b/arch/arm64/crypto/aes-neonbs-core.S
> > index b357164379f6..32f53ebe5e2c 100644
> > --- a/arch/arm64/crypto/aes-neonbs-core.S
> > +++ b/arch/arm64/crypto/aes-neonbs-core.S
> > @@ -788,7 +788,7 @@ SYM_FUNC_START_LOCAL(__xts_crypt8)
> >  
> >  0:	mov		bskey, x21
> >  	mov		rounds, x22
> > -	br		x7
> > +	ret

Dang, replied on an old version.

Since this is logically a tail call, could we simply be using br x16 or
br x17 for this?

The architecture makes special provision for that so that the compiler
can generate tail-calls.


This assumes that those regs aren't clobbered by any veneered function
call in the meantime, but all the calls here are local, so I don't think
that is a concern.

[...]

Cheers
---Dave
