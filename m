Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F52FF605
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbhAUUhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbhAUUge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:36:34 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E118230F9;
        Thu, 21 Jan 2021 20:35:52 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2ggI-009HNZ-6S; Thu, 21 Jan 2021 20:35:50 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/10] sunxi: Support IRQ wakeup from deep sleep
Date:   Thu, 21 Jan 2021 20:35:43 +0000
Message-Id: <161126112131.135928.7664552660827790510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jernej.skrabec@siol.net, tglx@linutronix.de, mripard@kernel.org, robh+dt@kernel.org, wens@csie.org, samuel@sholland.org, megous@megous.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 23:50:30 -0600, Samuel Holland wrote:
> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
> the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
> 
> This series replaces the existing chained irqchip driver that could only
> control the NMI, with a stacked irqchip driver that also provides wakeup
> capability for those multiplexed SPI IRQs. The idea is to preconfigure
> the ARISC's IRQ controller, and then the ARISC firmware knows to wake up
> as soon as it receives an IRQ. It can also decide how deep it can
> suspend based on the enabled wakeup IRQs.
> 
> [...]

Applied to irq/irqchip-5.12, thanks!

[01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
        commit: ad6b47cdef760410311f41876b21eb0c6fda4717
[02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
        commit: 6436eb4417094ea3308b33d8392fc02a1068dc78
[03/10] irqchip/sun6i-r: Use a stacked irqchip driver
        commit: 4e34614636b31747b190488240a95647c227021f
[04/10] irqchip/sun6i-r: Add wakeup support
        commit: 7ab365f6cd6de1e2b0cb1e1e3873dbf68e6f1003

Please route the dts patches via the soc tree. Also, I had to
manually fix the first patch as it wouldn't apply on top of
5.11-rc4 (which tree has it been diffed against?). Please
check that the resolution is correct.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


