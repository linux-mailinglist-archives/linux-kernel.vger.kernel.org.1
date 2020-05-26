Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A311B5774
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDWIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 04:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWIqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:46:11 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 536EA20736;
        Thu, 23 Apr 2020 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587631571;
        bh=BtULDBd1INlNO1t48cFaq0bwcPUqYBLewU519ka9fvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yQ+KnUvb2doOAmmdkxRQV+tD4ewepGfoPvwfrrufH0i840Pgfl82X2spNzRia2TZe
         qKGWItKC4xis3+223XskoBzaLPD4j8x5P7BFfPX5IoRjHSj/k4Fqwc6CLI25a0L7q8
         rNd35J41KoEFX5/cNHRLz/lT7J4sCRALyJupbXIo=
Received: by mail-il1-f175.google.com with SMTP id f82so4764640ilh.8;
        Thu, 23 Apr 2020 01:46:11 -0700 (PDT)
X-Gm-Message-State: AGi0Puagy5X5x17aSIGyguZ2YiNG/Yuyp5YeMuLVY7n4WVNEDrIZSYxf
        KwGaDURy9gZDFOmfQ9Zi3u4KHoiwCH2VS0DDA/o=
X-Google-Smtp-Source: APiQypIUoTtFY20/Ak+dBlhK769JNfTrfnN3ElkMqP5y9tTU7iDQBhZKa/7s96NAfzaiqxJdL1Tpkbjnh29NwzNX5is=
X-Received: by 2002:a92:607:: with SMTP id x7mr2160202ilg.218.1587631570740;
 Thu, 23 Apr 2020 01:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200420075711.2385190-1-Jason@zx2c4.com> <20200422040415.GA2881@sol.localdomain>
 <CAHmME9q=hMRjBG=SBX8gCC3qx-t1wdEwMOYx952m9HkByjiofA@mail.gmail.com>
 <CAMj1kXE-UZxw0C3WRVh7RfuWE0BNDT4bt4qJa1SyOH3K-qBBcQ@mail.gmail.com>
 <CAHmME9qXy4X3GtCtt5_1+KTxTXd6+nfhvE_c8Xn6_iJdRWhQmA@mail.gmail.com> <CAHmME9rqG56i+TfOhY-yt52XZrFRRTv0Vwr27qn5yL0=OpQa-A@mail.gmail.com>
In-Reply-To: <CAHmME9rqG56i+TfOhY-yt52XZrFRRTv0Vwr27qn5yL0=OpQa-A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 23 Apr 2020 10:45:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGWMmLUO7Wida0OzK0rK4wDhdmjsx6fGsyED6gsrbsjXA@mail.gmail.com>
Message-ID: <CAMj1kXGWMmLUO7Wida0OzK0rK4wDhdmjsx6fGsyED6gsrbsjXA@mail.gmail.com>
Subject: Re: [PATCH crypto-stable] crypto: arch/lib - limit simd usage to
 PAGE_SIZE chunks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 22:17, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Apr 22, 2020 at 1:51 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Apr 22, 2020 at 1:39 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 22 Apr 2020 at 09:32, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > On Tue, Apr 21, 2020 at 10:04 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > > Seems this should just be a 'while' loop?
> > > > >
> > > > >         while (bytes) {
> > > > >                 unsigned int todo = min_t(unsigned int, PAGE_SIZE, bytes);
> > > > >
> > > > >                 kernel_neon_begin();
> > > > >                 chacha_doneon(state, dst, src, todo, nrounds);
> > > > >                 kernel_neon_end();
> > > > >
> > > > >                 bytes -= todo;
> > > > >                 src += todo;
> > > > >                 dst += todo;
> > > > >         }
> > > >
> > > > The for(;;) is how it's done elsewhere in the kernel (that this patch
> > > > doesn't touch), because then we can break out of the loop before
> > > > having to increment src and dst unnecessarily. Likely a pointless
> > > > optimization as probably the compiler can figure out how to avoid
> > > > that. But maybe it can't. If you have a strong preference, I can
> > > > reactor everything to use `while (bytes)`, but if you don't care,
> > > > let's keep this as-is. Opinion?
> > > >
> > >
> > > Since we're bikeshedding, I'd prefer 'do { } while (bytes);' here,
> > > given that bytes is guaranteed to be non-zero before we enter the
> > > loop. But in any case, I'd prefer avoiding for(;;) or while(1) where
> > > we can.
> >
> > Okay, will do-while it up for v2.
>
> I just sent v2 containing do-while, and I'm fine with that going in
> that way. But just in the interest of curiosity in the pan-tone
> palette, check this out:
>
> https://godbolt.org/z/VxXien
>
> It looks like on mine, the compiler avoids unnecessarily calling those
> adds on the last iteration, but on the other hand, it results in an
> otherwise unnecessary unconditional jump for the < 4096 case. Sort of
> interesting. Arm64 code is more or less the same difference too.

Yeah, even if shaving off 1 or 2 cycles mattered here (since we've
just decided that ugh() may take up to 20,000 cycles), hiding a couple
of ALU instructions in the slots between the subs (which sets the zero
flag) and the conditional branch that tests it probably comes for free
on in-order cores anyway. And even if it didn't, backwards branches
are usually statically predicted as taken, in which case their results
are actually needed.

On out-of-order cores under speculation, none of this matters anyway.
