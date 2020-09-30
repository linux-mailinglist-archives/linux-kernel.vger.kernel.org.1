Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D083927E944
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgI3NNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgI3NNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:13:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBCB2075F;
        Wed, 30 Sep 2020 13:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601471611;
        bh=N6/eF3yhgVMwm5TkyG2yQLCE1Y1IytBNRnw4nZU0FxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=liJcJqAGt4iN95kRliW/ewKJBU/2b8pbLKBOt3tAiUkZsF4LJpZl4zylgIohSXpiE
         f6AGGFo4n6Par5hIDsrBIsMgkJ3hcri0j1SqbYPhB4bNzAiw7IT7b83IoS4KdbL+qs
         WOu1w0sgANTB7T8bLkfQmQTbgeNRzc/9uA2LeAmQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kNbvF-00GAID-90; Wed, 30 Sep 2020 14:13:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Sep 2020 14:13:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] irqchip/ti-sci-inta: Add support for unmapped
 event handling
In-Reply-To: <3dc2f27f-0a41-b538-11ac-970ad4310ccb@ti.com>
References: <20200930074559.18028-1-peter.ujfalusi@ti.com>
 <20200930074559.18028-3-peter.ujfalusi@ti.com>
 <af9ce252820bab9a21207ef2173da9fd@kernel.org>
 <3dc2f27f-0a41-b538-11ac-970ad4310ccb@ti.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <714738536a5566c511e83dc424e94bf7@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peter.ujfalusi@ti.com, nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30 11:01, Peter Ujfalusi wrote:
> On 30/09/2020 11.33, Marc Zyngier wrote:
>> On 2020-09-30 08:45, Peter Ujfalusi wrote:
>>> The DMA (BCDMA/PKTDMA and their rings/flows) events are under the 
>>> INTA's
>>> supervision as unmapped events in AM64.
>> 
>> What does "unmapped event" mean? An event that doesn't require a 
>> mapping?
>> Or an internally generated event? Or a proxy event?
>> 
>>> 
>>> In order to keep the current SW stack working, the INTA driver must
>>> replace
>>> the dev_id with it's own when a request comes for BCDMA or PKTDMA
>>> resources.
>> 
>> This seems to support my second option. Please clarify what you mean
>> exactly.
> 
> In previous devices with NAVSS we had event registers in UDMAP and in 
> rings.
> In AM64 with DMSS these event registers have been removed from the DMAs
> (rings are part of the DMAs).
> The event configuration registers in DMSS are part of the INTA and they
> under 'unmapped events'.

Is "unmapped events" an official TI wording, described as such in the 
TRM?

> 
> In essence the difference boils down to the fact that we do not
> configure event numbers (to be consumed by INTA) for the events coming
> from DMAs, but they already have their specific offsets within INTA's
> unmapped region.

OK, so they are not "unmapped". They are just permanently mapped, aren't 
they?

> With this change in hardware we can not use the DMA's ti_sci device
> identification number to configure these events to produce interrupts,
> they are under INTA.
> 
> The only difference in ti_sci API is that for DMA related
> interrupts/events we need to use the INTA's ti_sci device 
> identification
> number in place of the DMA component's.
> 
> I would say that I would describe the unmapped events with your first
> option. They kind of not require mapping from the source to INTA. The
> source of the event (DMA, ring) is pre-configured to send specific
> events to target the unmapped event area at specific offsets.

If they truly don't require a mapping, why is this patch actually 
mapping
them with the INTA as a source? Your explanation doesn't make much sense
to me.

> 
> But in the unmapped event register one can still define either:
> - to send a global event (to be used as trigger or for other purposes)
> - to generate interrupt (in a similar way as the IMAP registers were
> doing in NAVSS).
> 
> I'm not sure if this answers your question...

I still believe the term "unmapped event" doesn't describe what we have
here. These events seems, at least from what the patch does, internally
generated by the INTA.

Irrespective of this, my other comments still stand.

         M.
-- 
Jazz is not dead. It just smells funny...
