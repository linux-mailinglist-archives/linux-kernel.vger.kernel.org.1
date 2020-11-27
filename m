Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BC12C74C1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgK1Vtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730498AbgK0TvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:51:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1275D24101;
        Fri, 27 Nov 2020 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606506222;
        bh=7ujO+KYr0YlgsozIs8GtOPMUFRnhc+7f76/at6EGjss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yzOuRLDlBY/lQvtkbXcRWppVCTvoqXGJhgcJc4Q2PhCCeDP4gQ/T+HvVXDArxv744
         yakYiDQcJJzrjncJ1/FAUFxxs4/2JWkDf28VtCu0lYifHffnQ4V2nz4jv7Rs+GoJEE
         bVa5VV9wbXRsJQQIhPS6Yoij9cx+9aHBLTCy9P0I=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kijee-00E99B-5i; Fri, 27 Nov 2020 19:43:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Nov 2020 19:43:40 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
In-Reply-To: <20201127185610.GA30096@gaia>
References: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
 <1606486531-25719-2-git-send-email-hanks.chen@mediatek.com>
 <a3bd54fb5fe1c8ea11559d7459710263@kernel.org> <20201127185610.GA30096@gaia>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <dab968d8c7629c7aebc5e62770a9743d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, hanks.chen@mediatek.com, tglx@linutronix.de, matthias.bgg@gmail.com, linux@armlinux.org.uk, will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, cc.hwang@mediatek.com, kuohong.wang@mediatek.com, loda.chou@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-27 18:56, Catalin Marinas wrote:
> On Fri, Nov 27, 2020 at 06:11:01PM +0000, Marc Zyngier wrote:
>> On 2020-11-27 14:15, Hanks Chen wrote:
>> > Support for interrupt distribution design for SMP system solutions.
>> 
>> As far as I know, we have been supporting interrupt distribution on
>> ARM SMP systems pretty well for the past... what... 15 years?
>> I'm sure Russell can dig out an ARM926 SMP system that even predates
>> that.
>> 
>> > With this feature enabled ,the SPI interrupts would be routed to
>> > all the cores rather than boot core to achieve better
>> > load balance of interrupt handling.
>> 
>> Please quantify this compared to the current distribution method.
>> 
>> > That is, interrupts might be serviced simultaneously on different CPUs.
>> 
>> They already can. What is new here? Or do you mean the *same* 
>> interrupt
>> being serviced by different CPUs *at the same time*? That'd be fun.
> 
> IIRC (it's been many years since I looked at the GIC), more than one 
> CPU
> is woken and if they all read the INTACK, only one of them gets the
> actual IRQ number, the others see a spurious interrupt. I thought we
> decided that's not an efficient way to handle interrupts, so a software
> irqbalancer is better.
> 
> Has anything changed since then?

What you describe is mostly the GICv1/v2 behaviour.

GICv3 *can* be slightly better in that respect, as long as you force
the synchronization from the CPU interface back to the redistributor
via PHME and a DSB SY on each priority change.

Which means what whatever you gain from not interrupting the other CPUs,
you waste it by forcing synchronization system wide.

> I'm also concerned that in a big.LITTLE system, you may see the big 
> CPUs
> taking the interrupts all the time, which is nice for energy 
> efficiency.

Yes, this is bound to happen. It means you cannot place interrupts
on a small cluster unless you completely hotplug the big cores off,
thanks to the "more than one means all" nonsense.

And since these patches seem to also break hotplug, that's... fun.

         M.
-- 
Jazz is not dead. It just smells funny...
