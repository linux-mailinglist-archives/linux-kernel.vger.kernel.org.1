Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCC27989B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIZKwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 06:52:41 -0400
Received: from [78.8.192.131] ([78.8.192.131]:22195 "EHLO orcam.me.uk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725208AbgIZKwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:52:38 -0400
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
        by orcam.me.uk (Postfix) with ESMTPS id BF1E92BE086;
        Sat, 26 Sep 2020 11:52:31 +0100 (BST)
Date:   Sat, 26 Sep 2020 11:52:25 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
In-Reply-To: <8a99b16ae3037487b762fb1bbcd81b576d9e11ab.camel@wdc.com>
Message-ID: <alpine.LFD.2.21.2009261141060.3561363@eddie.linux-mips.org>
References: <20200926072750.807764-1-anup.patel@wdc.com>         <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>         <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com>         <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
         <alpine.LFD.2.21.2009261054270.3561363@eddie.linux-mips.org> <8a99b16ae3037487b762fb1bbcd81b576d9e11ab.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020, Damien Le Moal wrote:

> > > With this applied in addition to your patch, it works.
> > > 
> > > diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-
> > > clint.c
> > > index d17367dee02c..8dbec85979fd 100644
> > > --- a/drivers/clocksource/timer-clint.c
> > > +++ b/drivers/clocksource/timer-clint.c
> > > @@ -37,7 +37,7 @@ static unsigned long clint_timer_freq;
> > >  static unsigned int clint_timer_irq;
> > >  
> > >  #ifdef CONFIG_RISCV_M_MODE
> > > -u64 __iomem *clint_time_val;
> > > +u64 __iomem *clint_time_val = NULL;
> > >  #endif
> > 
> >  Hmm, BSS initialisation issue?
> 
> Not a static variable, so it is not in BSS, no ?

 Maybe it has a weird declaration elsewhere which messes up things (I 
haven't checked), but it looks to me like it does have static storage 
(rather than automatic or thread one), so if uninitialised it goes to BSS, 
and it is supposed to be all-zeros whether explicitly assigned a NULL 
value or not.  It does have external rather than internal linkage (as it 
would if it had the `static' keyword), but it does not matter.  Best check 
with `objdump'/`readelf'.

  Maciej
