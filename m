Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC992C6BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgK0S62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbgK0S4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:56:18 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EE421D7A;
        Fri, 27 Nov 2020 18:56:13 +0000 (UTC)
Date:   Fri, 27 Nov 2020 18:56:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hanks Chen <hanks.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        CC Hwang <cc.hwang@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH v1 1/3] irqchip/gic: enable irq target all
Message-ID: <20201127185610.GA30096@gaia>
References: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
 <1606486531-25719-2-git-send-email-hanks.chen@mediatek.com>
 <a3bd54fb5fe1c8ea11559d7459710263@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3bd54fb5fe1c8ea11559d7459710263@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 06:11:01PM +0000, Marc Zyngier wrote:
> On 2020-11-27 14:15, Hanks Chen wrote:
> > Support for interrupt distribution design for SMP system solutions.
> 
> As far as I know, we have been supporting interrupt distribution on
> ARM SMP systems pretty well for the past... what... 15 years?
> I'm sure Russell can dig out an ARM926 SMP system that even predates
> that.
> 
> > With this feature enabled ,the SPI interrupts would be routed to
> > all the cores rather than boot core to achieve better
> > load balance of interrupt handling.
> 
> Please quantify this compared to the current distribution method.
> 
> > That is, interrupts might be serviced simultaneously on different CPUs.
> 
> They already can. What is new here? Or do you mean the *same* interrupt
> being serviced by different CPUs *at the same time*? That'd be fun.

IIRC (it's been many years since I looked at the GIC), more than one CPU
is woken and if they all read the INTACK, only one of them gets the
actual IRQ number, the others see a spurious interrupt. I thought we
decided that's not an efficient way to handle interrupts, so a software
irqbalancer is better.

Has anything changed since then?

I'm also concerned that in a big.LITTLE system, you may see the big CPUs
taking the interrupts all the time, which is nice for energy efficiency.

-- 
Catalin
