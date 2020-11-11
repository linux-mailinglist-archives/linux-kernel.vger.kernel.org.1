Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEFC2AE944
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgKKG4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:56:43 -0500
Received: from muru.com ([72.249.23.125]:48028 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgKKG4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:56:42 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 241D88126;
        Wed, 11 Nov 2020 06:56:44 +0000 (UTC)
Date:   Wed, 11 Nov 2020 08:56:35 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        v.narang@samsung.com, a.sahrawat@samsung.com,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
Message-ID: <20201111065635.GO26857@atomide.com>
References: <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
 <20201021124542.GL1551@shell.armlinux.org.uk>
 <20201021125740.GM1551@shell.armlinux.org.uk>
 <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com>
 <20201109144549.GA26857@atomide.com>
 <CAK8P3a2tM1Gzy7Y98tiYGoNcLye77je_UCtTUQYcP2UuRNRKwQ@mail.gmail.com>
 <20201110091904.GC26857@atomide.com>
 <CAK8P3a3dZMnEV-Sg_ep6_dQ3XEf73fEpCF0T03255KxMrJZH8g@mail.gmail.com>
 <20201110120422.GE26857@atomide.com>
 <CAK8P3a2Hh=-VtvCiztNDZvW=ssx5zbvbccYcLXSNUt=xF6mwwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Hh=-VtvCiztNDZvW=ssx5zbvbccYcLXSNUt=xF6mwwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [201110 13:35]:
> On Tue, Nov 10, 2020 at 1:06 PM Tony Lindgren <tony@atomide.com> wrote:
> 
> > > Are these actually ARMv6? Most ARM11 cores you'd come across
> > > in practice are ARMv6K (ARM1136r1, ARM1167, ARM11MPCore),
> > > in particular every SoC that has any mainline support except for
> > > the ARM1136r0 based OMAP2 and i.MX3.
> >
> > I've been only using smp_on_up for the ARMv6 ARM1136r0 variants
> > for omap2, no SMP on those.
> 
> Obviously all SMP hardware is ARMv6K, the only question I raised
> in point "c)" is what we would lose by making ARMv6 (ARM1136r0)
> support and SMP mutually exclusive in a kernel configuration, and
> I suppose the answer remains "testing".

Agreed that is probably the biggest reason to keep it at this point.

Regards,

Tony
