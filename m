Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AEC279841
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIZKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 06:17:12 -0400
Received: from [78.8.192.131] ([78.8.192.131]:20054 "EHLO orcam.me.uk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725208AbgIZKRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:17:12 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2020 06:17:11 EDT
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
        by orcam.me.uk (Postfix) with ESMTPS id 2F9902BE086;
        Sat, 26 Sep 2020 11:09:42 +0100 (BST)
Date:   Sat, 26 Sep 2020 11:09:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>
Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
In-Reply-To: <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
Message-ID: <alpine.LFD.2.21.2009261054270.3561363@eddie.linux-mips.org>
References: <20200926072750.807764-1-anup.patel@wdc.com> <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com> <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com> <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020, Damien Le Moal wrote:

> > > Applying this on top of rc6, I now get a hang on Kendryte boot...
> > > No problems without the patch on the other hand.
> > 
> > Not sure about the issue with Kendryte but I get a crash on
> > QEMU virt machine without this patch.
> 
> With this applied in addition to your patch, it works.
> 
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-
> clint.c
> index d17367dee02c..8dbec85979fd 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -37,7 +37,7 @@ static unsigned long clint_timer_freq;
>  static unsigned int clint_timer_irq;
>  
>  #ifdef CONFIG_RISCV_M_MODE
> -u64 __iomem *clint_time_val;
> +u64 __iomem *clint_time_val = NULL;
>  #endif

 Hmm, BSS initialisation issue?

  Maciej
