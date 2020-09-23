Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8AC27555F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIWKPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:15:09 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38472145D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600856109;
        bh=78Wi9zuhU4MDIiFwhcs5urBVnDFgHsmd3gVruFuwOac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R1nG/3T3RJgDtO1Bkpws8RIzukkYai1qoBKpZTwDAexr3TrxjH1syv7mISSklr39U
         gO3NvuZpzzp6x+BzyLc7P9hmiIT1JaZ//AaWb0SXpqneQ3eO8AS+hdGIkKAd67IYH7
         Ec11qwJP83+YdqoJjMTqGw4Oa2vFsOD8rBerZZ4U=
Received: by mail-ot1-f49.google.com with SMTP id y5so18434395otg.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:15:08 -0700 (PDT)
X-Gm-Message-State: AOAM533lHfQWXImQ34TM0WPrwPraEZFsirAqVXL61laBimtxpu7F3u0k
        Ti+LFuUJqF7GnWykr6lFpkAvHY3NaAIX+pTf/oc=
X-Google-Smtp-Source: ABdhPJyjSp5/Spt0IdZZXmghSpOQ+XwGrsDyxPanP4cVdom6we+nl8VFuc3RoJHUDEW8Kdv3zDTb2mWtdzg+p3vKV8s=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr5508915otk.108.1600856108198;
 Wed, 23 Sep 2020 03:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
 <ad9108e155ba4245a2005e9212a7d2b5@AcuMS.aculab.com> <CAMj1kXEF9SHnas_Hy=eU+=hHuuyxMb2_UtPtsuU2CCH6BaUPbg@mail.gmail.com>
 <CAD=FV=VG-BzzEJ2jn6hAYjre+BtOu-uyi4OQst=Lg9QQqAtKNw@mail.gmail.com>
In-Reply-To: <CAD=FV=VG-BzzEJ2jn6hAYjre+BtOu-uyi4OQst=Lg9QQqAtKNw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Sep 2020 12:14:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4=b1eSGq+4tQNKsXkzEyWKRvUEcjyez=1yST4kVAMRQ@mail.gmail.com>
Message-ID: <CAMj1kXH4=b1eSGq+4tQNKsXkzEyWKRvUEcjyez=1yST4kVAMRQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the fastest
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jackie Liu <liuyun01@kylinos.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 at 02:39, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Sep 22, 2020 at 3:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 22 Sep 2020 at 10:26, David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Douglas Anderson
> > > > Sent: 22 September 2020 01:26
> > > >
> > > > On every boot time we see messages like this:
> > > >
> > > > [    0.025360] calling  calibrate_xor_blocks+0x0/0x134 @ 1
> > > > [    0.025363] xor: measuring software checksum speed
> > > > [    0.035351]    8regs     :  3952.000 MB/sec
> > > > [    0.045384]    32regs    :  4860.000 MB/sec
> > > > [    0.055418]    arm64_neon:  5900.000 MB/sec
> > > > [    0.055423] xor: using function: arm64_neon (5900.000 MB/sec)
> > > > [    0.055433] initcall calibrate_xor_blocks+0x0/0x134 returned 0 after 29296 usecs
> > > >
> > > > As you can see, we spend 30 ms on every boot re-confirming that, yet
> > > > again, the arm64_neon implementation is the fastest way to do XOR.
> > > > ...and the above is on a system with HZ=1000.  Due to the way the
> > > > testing happens, if we have HZ defined to something slower it'll take
> > > > much longer.  HZ=100 means we spend 300 ms on every boot re-confirming
> > > > a fact that will be the same for every bootup.
> > >
> > > Can't the code use a TSC (or similar high-res counter) to
> > > see how long it takes to process a short 'hot cache' block?
> > > That wouldn't take long at all.
> > >
> >
> > This is generic code that runs from an core_initcall() so I am not
> > sure we can easily implement this in a portable way.
>
> If it ran later, presumably you could just use ktime?  That seems like
> it'd be a portable enough way?
>

That should work, I suppose. That should also permit us to simply time
N iterations of the benchmark instead of running it as many times as
we can while waiting for a jiffy to elapse.

>
> > Doug: would it help if we deferred this until late_initcall()? We
> > could take an arbitrary pick from the list at core_initcall() time to
> > serve early users, and update to the fastest one at a later time.
>
> Yeah, I think that'd work OK.  One advantage of it being later would
> be that it could run in parallel to other things that were happening
> in the system (anyone who enabled async probe on their driver).  Even
> better would be if your code itself could run async and not block the
> rest of boot.  ;-)

My code? :-)

> I do like the idea that we could just arbitrarily
> pick one implementation until we've calibrated.  I guess we'd want to
> figure out how to do this lockless but it shouldn't be too hard to
> just check to see if a single pointer is non-NULL and once it becomes
> non-NULL then you can use it...  ...or a pointer plus a sentinel if
> writing the pointer can't be done atomically...
>

Surely, any SMP capable architecture that cares about atomicity at
that level can update a function pointer, which is guaranteed to be
the native word size, without tearing?

This should do it afaict:

--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -21,7 +21,7 @@
 #endif

 /* The xor routines to use.  */
-static struct xor_block_template *active_template;
+static struct xor_block_template *active_template = xor_block_8regs;

 void
 xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
@@ -150,6 +150,5 @@ static __exit void xor_exit(void) { }

 MODULE_LICENSE("GPL");

-/* when built-in xor.o must initialize before drivers/md/md.o */
-core_initcall(calibrate_xor_blocks);
+late_initcall(calibrate_xor_blocks);
 module_exit(xor_exit);


> It also feels like with the large number of big.LITTLE systems out
> there you'd either want a lookup table per core or you'd want to do
> calibration per core.
>

I don't think the complexity is worth it, tbh, as there are too many
parameters to consider, although it would be nice if we could run the
benchmark on the best performing CPU (as that is where the scheduler
will run the code if it is on a sufficiently hot path, and if it is
not, it doesn't really matter)
