Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7F28AF12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgJLHbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgJLHbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:31:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2018C20790;
        Mon, 12 Oct 2020 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602487907;
        bh=ti7dARSubUADrR1c07/IAIywnspN6KHT1BN7cGBTwGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vn+aRm4A0BOsjKcZeOXpBsCm5Vtz4YR0liPBiA4KLz88Hga9tBBIG3WstLzDs+et8
         ABlmOSZ6KtJG4w8oCZB0pKdZVJiBQpX/iAGktEqb/OYzdNn8SKDX0VYV4QV2acX/aR
         asOHvBGQ/LnKe2EqSJ6DCVDcT/pBowaP/xts1/H0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kRsJ7-000R4b-3x; Mon, 12 Oct 2020 08:31:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Oct 2020 08:31:45 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, devicetree@vger.kernel.org, jason@lakedaemon.net,
        lokeshvutla@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
        robh+dt@kernel.org, ssantosh@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] irqchip/ti-sci-inta: Add support for unmapped
 event handling
In-Reply-To: <3e9974b8-c0ab-9de4-9b51-541c2093c42a@ti.com>
References: <20200930074559.18028-1-peter.ujfalusi@ti.com>
 <20200930074559.18028-3-peter.ujfalusi@ti.com>
 <af9ce252820bab9a21207ef2173da9fd@kernel.org>
 <3dc2f27f-0a41-b538-11ac-970ad4310ccb@ti.com>
 <714738536a5566c511e83dc424e94bf7@kernel.org>
 <d3180011-d9b4-3d3d-555c-3d81e1302028@ti.com>
 <3e9974b8-c0ab-9de4-9b51-541c2093c42a@ti.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <7e66c03285db40c6ce38b951b87bcb45@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peter.ujfalusi@ti.com, nm@ti.com, devicetree@vger.kernel.org, jason@lakedaemon.net, lokeshvutla@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, ssantosh@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-09 09:58, Peter Ujfalusi wrote:
> Marc,
> 

[...]

> The design of irqchip/irq-ti-sci-inta.c, soc/ti/ti_sci_inta_msi.c and
> irqchip/irq-ti-sci-intr.c created to handle the interrupt needs present
> in K3 devices with NAVSS.
> DMSS of newer K3 devices extends and simplifies the NAVSS components 
> and
> a big part of that change was done with the INTA and DMAs.
> System Firmware also changed to adopt to these changes.
> 
> As an example, let's assume that we want an interrupt from a ring.
> The high level of the events in this case are:
> 
> NAVSS:
> 1.1 ring generates an internal signal (up or down)
> 1.2 the ringacc will send a (mapped) Global Event to INTA
> 1.3 When INTA receives the global event, it will signal it's outgoing
>     VINT to INTR
> 1.4 INTR will trigger a host interrupt.
> 
> DMSS
> 1.1 ring generates an internal signal (up or down)
> 1.2 the DMA (ring is now part of the DMA) will send an unmapped event 
> to
>     INTA
> 1.3 When INTA receives the unmapped event, it will send a (mapped)
>     Global Event to itself
> 1.4 When INTA receives the global event, it will signal it's outgoing
>     VINT to INTR
> 1.5 INTR will trigger a host interrupt.
> 
> The API from sysfw is the same to configure the global events and VINT,
> but we need to use the INTA's tisci device identification number to let
> sysfw know that the Global event number can be programmed into INTA's
> unmapped event steering register. The DMA no longer have this register,
> it sends unmapped event to INTA.
> 
> The unmapped event number is fixed per sources, they will arrive at the
> specific unmapped event configuration register of INTA.
> 
> INTA itself does not know which source are allocated to be used by
> Linux, the allocation is for the DMA resources and only the DMA driver
> knows which channels, rings, flows can be used and can ask the INTA MSI
> domain to create interrupts for those.
> 
> By handling the ti,unmapped-event-sources the INTA driver can make
> decision on the correct tisci dev_id to be used for the sysfw API to
> where the global event must be configured and the client drivers does
> not need to know how things are working under the hood.
> 
> There are components in DMSS which use is exactly how they worked 
> within
> NAVSS, they are not using unmapped events. Ringacc comes to mind first.
> 
> I can add a comment block to explain the nature of unmapped events and
> the reason why we need to do what we do.
> 
> Would this be acceptable?

That'd be useful, as long as it is shorter than the above.

         M.
-- 
Jazz is not dead. It just smells funny...
