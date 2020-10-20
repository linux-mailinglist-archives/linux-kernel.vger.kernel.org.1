Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78DF284BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJFMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgJFMgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:36:20 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1356D2075A;
        Tue,  6 Oct 2020 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601987779;
        bh=4kZKdjlI1YcO8okfFppVkg2wYW38PBZcajjtjvO2oRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XvTZ1uVf+238iD4WIBCMB2M6orfVHnZsYFJhI0iFX7my5rtXmerbRXFBvNOIq20lM
         aBk4er9WY6Gt9lXtvrIejTxhdKcCWB5xKSZtD+d8LfenOcFHxRYpiUZ5jICfwslaiJ
         n8f8TwxAHD5uQ+QYRqiI+boxCNEOVNX7avaysTtg=
Received: by mail-ot1-f54.google.com with SMTP id s66so12116636otb.2;
        Tue, 06 Oct 2020 05:36:19 -0700 (PDT)
X-Gm-Message-State: AOAM531nTy1lM1Sr9cizh17m2wT2PgUsLWO7ag9Ao2g1cKGlcQnoII/t
        ifbSk9M0XUHLNlVrQhoBawLks9NKS45hova8mk8=
X-Google-Smtp-Source: ABdhPJzHgJXzYBsBKdRio0TRc/qog4T9bWYgukR/cxeMqS1guB3oBKvglOpyPiUPEA3NAlHwvF8q0xrh3zDnFqbcAG0=
X-Received: by 2002:a9d:335:: with SMTP id 50mr2648025otv.90.1601987778324;
 Tue, 06 Oct 2020 05:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201006034854.2277538-1-jeremy.linton@arm.com>
 <20201006082748.GB25305@willie-the-truck> <20201006100121.GW6642@arm.com>
 <20201006102507.GA19213@gaia> <20201006104313.GX6642@arm.com> <20201006123350.GB19213@gaia>
In-Reply-To: <20201006123350.GB19213@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Oct 2020 14:36:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH0jK3HQSHyAzuzzfeyvUmrWhf2dN9CLZ=hzzUxF-xuSw@mail.gmail.com>
Message-ID: <CAMj1kXH0jK3HQSHyAzuzzfeyvUmrWhf2dN9CLZ=hzzUxF-xuSw@mail.gmail.com>
Subject: Re: [BUG][PATCH] crypto: arm64: Avoid indirect branch to bti_c
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 at 14:33, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Oct 06, 2020 at 11:43:14AM +0100, Dave P Martin wrote:
> > On Tue, Oct 06, 2020 at 11:25:11AM +0100, Catalin Marinas wrote:
> > > On Tue, Oct 06, 2020 at 11:01:21AM +0100, Dave P Martin wrote:
> > > > On Tue, Oct 06, 2020 at 09:27:48AM +0100, Will Deacon wrote:
> > > > > On Mon, Oct 05, 2020 at 10:48:54PM -0500, Jeremy Linton wrote:
> > > > > > The AES code uses a 'br x7' as part of a function called by
> > > > > > a macro. That branch needs a bti_j as a target. This results
> > > > > > in a panic as seen below. Instead of trying to replace the branch
> > > > > > target with a bti_jc, lets replace the indirect branch with a
> > > > > > bl/ret, bl sequence that can target the existing bti_c.
> > > > > >
> > > > > >   Bad mode in Synchronous Abort handler detected on CPU1, code 0x34000003 -- BTI
> > > > > >   CPU: 1 PID: 265 Comm: cryptomgr_test Not tainted 5.8.11-300.fc33.aarch64 #1
> > > > > >   pstate: 20400c05 (nzCv daif +PAN -UAO BTYPE=j-)
> > > > > >   pc : aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
> > > > > >   lr : aesbs_xts_encrypt+0x48/0xe0 [aes_neon_bs]
> > > > > >   sp : ffff80001052b730
> > > > > >
> > > > > >   aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
> > > > > >    __xts_crypt+0xb0/0x2dc [aes_neon_bs]
> > > > > >    xts_encrypt+0x28/0x3c [aes_neon_bs]
> > > > > >   crypto_skcipher_encrypt+0x50/0x84
> > > > > >   simd_skcipher_encrypt+0xc8/0xe0
> > > > > >   crypto_skcipher_encrypt+0x50/0x84
> > > > > >   test_skcipher_vec_cfg+0x224/0x5f0
> > > > > >   test_skcipher+0xbc/0x120
> > > > > >   alg_test_skcipher+0xa0/0x1b0
> > > > > >   alg_test+0x3dc/0x47c
> > > > > >   cryptomgr_test+0x38/0x60
> > > > > >
> > > > > > Fixes: commit 0e89640b640d ("crypto: arm64 - Use modern annotations for assembly functions")
> > > > >
> > > > > nit: the "commit" string shouldn't be here, and I think the linux-next
> > > > > scripts will yell at us if we don't remove it.
> > > > >
> > > > > > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > > ---
> > > > > >  arch/arm64/crypto/aes-neonbs-core.S | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/crypto/aes-neonbs-core.S b/arch/arm64/crypto/aes-neonbs-core.S
> > > > > > index b357164379f6..32f53ebe5e2c 100644
> > > > > > --- a/arch/arm64/crypto/aes-neonbs-core.S
> > > > > > +++ b/arch/arm64/crypto/aes-neonbs-core.S
> > > > > > @@ -788,7 +788,7 @@ SYM_FUNC_START_LOCAL(__xts_crypt8)
> > > > > >
> > > > > >  0:   mov             bskey, x21
> > > > > >       mov             rounds, x22
> > > > > > -     br              x7
> > > > > > +     ret
> > > >
> > > > Dang, replied on an old version.
> > >
> > > Which I ignored (by default, when the kbuild test robot complains ;)).
> > >
> > > > Since this is logically a tail call, could we simply be using br x16 or
> > > > br x17 for this?
> > > >
> > > > The architecture makes special provision for that so that the compiler
> > > > can generate tail-calls.
> > >
> > > So a "br x16" is compatible with a bti_c landing pad. I think it makes
> > > more sense to keep it as a tail call.
> >
> > Just to be clear, I'm happy either way, but I thought it would make
> > sense to point this out.
>
> I'd prefer the replacement with a br x16/17, it keeps the code pretty
> much unchanged.
>

+1

> Jeremy, could you please respin this patch and give it a try?
>
> Thanks.
>
> --
> Catalin
