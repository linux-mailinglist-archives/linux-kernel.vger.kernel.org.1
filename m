Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D171C263AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 04:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgIJCiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 22:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbgIJCfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:35:34 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CA9221ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599696499;
        bh=UMqV0gNms+/YN0J4UoHozIqkDOwbFjYIjU/HXB1hJUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XRNW6eJbWsLI2dCSUJMZosNlb4e/tykXXido1LD8pPrbG5UZ5QGektxxF0uvXt+MV
         w18DIgFZLwTpusUyngmzMOF41INJKtd6YRyH6FUTTLzWTp3HRAndMz0AKC0VOELqGy
         nfyu9nrXrAKcS+bohj+9WtnQwRFM3oAWDSLPeQ40=
Received: by mail-wr1-f53.google.com with SMTP id k15so4721434wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 17:08:19 -0700 (PDT)
X-Gm-Message-State: AOAM532GxAjsUtQD3vXJsN2bZQsyh1C/Gsp/m0GXMUOvr9yMxfYgfzgZ
        aMx0OOYoAiqT/qeTRp/N6DMEbgzVrXfArCesFE5glg==
X-Google-Smtp-Source: ABdhPJyUSmXfx3HBBp7JJYedle+oX0ZnG2Dep5K1q7otSlaEM88vPubsDRmIYtoT+Ndy42FJLTTE15tPhnz9BNTJbcY=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr6110885wrn.257.1599696498201;
 Wed, 09 Sep 2020 17:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200907094843.1949-1-Jason@zx2c4.com> <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
 <20200908172558.GG25236@zn.tnic> <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
 <20200908173656.GI25236@zn.tnic> <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
 <20200908180112.GK25236@zn.tnic> <20200908191838.GA2014@sultan-box.localdomain>
 <20200908193029.GM25236@zn.tnic> <fa447f6b7c7f03cc0c55573d5736889cee81a1e6.camel@linux.intel.com>
In-Reply-To: <fa447f6b7c7f03cc0c55573d5736889cee81a1e6.camel@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 9 Sep 2020 17:08:06 -0700
X-Gmail-Original-Message-ID: <CALCETrWAa+WogyaZ+XGsVxQ+3-j3C+VoQnRWz8L+FUgRpY7nfw@mail.gmail.com>
Message-ID: <CALCETrWAa+WogyaZ+XGsVxQ+3-j3C+VoQnRWz8L+FUgRpY7nfw@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 6:02 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2020-09-08 at 21:30 +0200, Borislav Petkov wrote:
> > On Tue, Sep 08, 2020 at 12:18:38PM -0700, Sultan Alsawaf wrote:
> > > I'd like to point out that on Intel's recent 14nm parts,
> > > undervolting
> > > is not so much for squeezing every last drop of performance out of
> > > the
> > > SoC as it is for necessity.
> >
> > <snip interesting examples>
> >
> > Sounds to me that this undervolting functionality should be part of
> > the kernel and happen automatically. I have no clue, though, whether
> > people who do it, just get lucky and undervolting doesn't cause any
> > other hardware issues, or there's a real reason for this power
> > madness
> > and if not done, power-related failures happen only on some boxes so
> > they decided to do them on all.
> >
> > Or maybe BIOS is nuts, which is not a stretch.
> >
> The whole OC is based on experiments to come to correct values. This
> depends on whole system design not just CPUs.
> https://www.intel.com/content/www/us/en/gaming/resources/how-to-overclock.html
> It warns about system stability.
>
> > Srinivas, what's the story here?
> I checked and there is no public spec. There are several mailbox
> commands with version dependent on the processor.
>
> The actual OC mailbox implementation itself is implemented in Linux in
> intel_turbo_max_3 driver. So that is public.
> So someone can develop a driver and provide some sysfs to send mailbox
> commands, but kernel can't validate commands which can cause any
> security or stability issues. Not sure if this is acceptable standard.
> I don't think there is any precedent of creating such blind sysfs
> entries.
>
>

Having once written a rejected driver to poke at the Intel Xeon memory
controller SMBUS, there is at least precedent for writing drivers for
dangerous interfaces, if not merging said drivers :)

But we have drivers for various EC interfaces, for other SMBUS hosts,
etc, and all of these can cause all kinds of mischief if misused.
