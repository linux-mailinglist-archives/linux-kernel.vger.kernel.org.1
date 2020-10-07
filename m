Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE172285B52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgJGIxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgJGIxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:53:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78DB21D7A;
        Wed,  7 Oct 2020 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602060832;
        bh=xcYFST4YZ+qt7XrJpNgrw7ltFAWNOwJPWgwK/Lvl5k4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IrHPWfp++rFwKXKCJsCgS7gbvfpXwW0IBRtvEDh3jmgFaYzfAPEATaClxn63tvvbs
         9o5J8UwRcGtH99ZKDi8MIGbKJh+fSjDhCvyELAxsSFMKC8CV7EpNWyosO5qUKRtkuI
         L51AQtKPZW+5jE3xs9Ar03VPf3RwMzyitnFGauas=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kQ5Cn-000Iql-PM; Wed, 07 Oct 2020 09:53:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Oct 2020 09:53:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/4] genirq/irqdomain: Allow partial trimming of
 irq_data hierarchy
In-Reply-To: <10788c0d08fccbcbc1ac590a855e70d3@kernel.org>
References: <20201006101137.1393797-1-maz@kernel.org>
 <20201006101137.1393797-2-maz@kernel.org>
 <87eemb6qdj.fsf@nanos.tec.linutronix.de>
 <10788c0d08fccbcbc1ac590a855e70d3@kernel.org>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <738593a42b62ea7905e4a680775cb996@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com, skomatineni@nvidia.com, vreddytalla@nvidia.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-07 09:05, Marc Zyngier wrote:
> On 2020-10-06 21:39, Thomas Gleixner wrote:
>> On Tue, Oct 06 2020 at 11:11, Marc Zyngier wrote:
>>> It appears that some HW is ugly enough that not all the interrupts
>>> connected to a particular interrupt controller end up with the same
>>> hierarchy repth (some of them are terminated early). This leaves
>> 
>>   depth?
>> 
>>> the irqchip hacker with only two choices, both equally bad:
>>> 
>>> - create discrete domain chains, one for each "hierarchy depth",
>>>   which is very hard to maintain
>>> 
>>> - create fake hierarchy levels for the shallow paths, leading
>>>   to all kind of problems (what are the safe hwirq values for these
>>>   fake levels?)
>>> 
>>> Instead, let's offer the possibility to cut short a single interrupt
>> 
>> s/let's offer/implement/
> 
> Thanks for that, I'll fix it locally.
> 
> [...]
> 
>> This is butt ugly, really. Especially the use case where the tegra PMC
>> domain removes itself from the hierarchy from .alloc()
> 
> I don't disagree at all. It is both horrible and dangerous.
> 
> My preference would have been to split the PMC domain into discrete
> domains, each one having having its own depth. But that's incredibly
> hard to express in DT, and would break the combination of old/new
> DT and kernel.
> 
>> That said, I don't have a better idea either. Sigh...
> 
> A (very minor) improvement would be to turn the trim call in the PMC 
> driver into
> a flag set in the first invalid irq_data structure, and let
> __irq_domain_alloc_irqs() do the dirty work.
> 
> Still crap, but at least would prevent some form of abuse. Thoughts?

Actually, I wonder whether we can have a more general approach:

A partial hierarchy that doesn't have an irq_data->chip pointer 
populated
cannot be valid. So I wonder if the least ugly thing to do is to just 
drop
any messing about in the PMC driver, and instead to let 
__irq_domain_alloc_irqs()
do the culling, always, by looking for a NULL pointer in irq_data->chip.

Not any less ugly, but at least doesn't need any driver intervention.

          M.
-- 
Jazz is not dead. It just smells funny...
