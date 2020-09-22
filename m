Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995B9273FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgIVKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVKaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:30:55 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65ACD208A9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600770654;
        bh=2ac03d4BXzs1X3AYPJCuz5ExNkZUTf6oOD/aA3BHgH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BbaUIqdy9UvDS/fEa0atMg7wfx0Af65EH5xLBe6kUCygWHGXGKp/iSmmVZ+dZW5lQ
         gGlghh17C4ugcD8oXkZPreLZBcNjeDSkEHGCJlciiKJisb+AgPA6J8SoxqFhs6EHGm
         u6cNFIYLgaiVzswuEuJryNcBopVEX37B/DRXVtlE=
Received: by mail-oi1-f174.google.com with SMTP id x14so20489203oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:30:54 -0700 (PDT)
X-Gm-Message-State: AOAM532lLVT6Rk7E741jJelHHkpBrRzHeVck1vUN2Pk/qGJMM7HbkA5e
        iL34w4N50SrbuvsHEOqIIs0v5EuuF+Vr8UOwl3Q=
X-Google-Smtp-Source: ABdhPJy5koXapG5/lzMLd71HJP/MZCjH9OUE7reHhjnCIvIH5UqvfIF7ed9zY0zap7q+aeXU/4hQ1CY2G++93kHEr1o=
X-Received: by 2002:aca:d845:: with SMTP id p66mr2048119oig.47.1600770653616;
 Tue, 22 Sep 2020 03:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
 <ad9108e155ba4245a2005e9212a7d2b5@AcuMS.aculab.com>
In-Reply-To: <ad9108e155ba4245a2005e9212a7d2b5@AcuMS.aculab.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 12:30:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEF9SHnas_Hy=eU+=hHuuyxMb2_UtPtsuU2CCH6BaUPbg@mail.gmail.com>
Message-ID: <CAMj1kXEF9SHnas_Hy=eU+=hHuuyxMb2_UtPtsuU2CCH6BaUPbg@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the fastest
To:     David Laight <David.Laight@aculab.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
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

On Tue, 22 Sep 2020 at 10:26, David Laight <David.Laight@aculab.com> wrote:
>
> From: Douglas Anderson
> > Sent: 22 September 2020 01:26
> >
> > On every boot time we see messages like this:
> >
> > [    0.025360] calling  calibrate_xor_blocks+0x0/0x134 @ 1
> > [    0.025363] xor: measuring software checksum speed
> > [    0.035351]    8regs     :  3952.000 MB/sec
> > [    0.045384]    32regs    :  4860.000 MB/sec
> > [    0.055418]    arm64_neon:  5900.000 MB/sec
> > [    0.055423] xor: using function: arm64_neon (5900.000 MB/sec)
> > [    0.055433] initcall calibrate_xor_blocks+0x0/0x134 returned 0 after 29296 usecs
> >
> > As you can see, we spend 30 ms on every boot re-confirming that, yet
> > again, the arm64_neon implementation is the fastest way to do XOR.
> > ...and the above is on a system with HZ=1000.  Due to the way the
> > testing happens, if we have HZ defined to something slower it'll take
> > much longer.  HZ=100 means we spend 300 ms on every boot re-confirming
> > a fact that will be the same for every bootup.
>
> Can't the code use a TSC (or similar high-res counter) to
> see how long it takes to process a short 'hot cache' block?
> That wouldn't take long at all.
>

This is generic code that runs from an core_initcall() so I am not
sure we can easily implement this in a portable way.

Doug: would it help if we deferred this until late_initcall()? We
could take an arbitrary pick from the list at core_initcall() time to
serve early users, and update to the fastest one at a later time.
