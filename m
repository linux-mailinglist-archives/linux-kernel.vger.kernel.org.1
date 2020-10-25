Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72489298193
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 13:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415614AbgJYMI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 08:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415604AbgJYMG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 08:06:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF3F22202;
        Sun, 25 Oct 2020 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603627588;
        bh=nUS2kYGYuhzsne/r04hu9MAGBT2diuzU21HdRmbbVqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYj+khaNLYyL3OTVke9xc2SyeZgh8R0qQFdpGJRvgnqu1fKnl4aXO9GIFN9MbC72H
         4czmgTFqOpn36EB/108Kg4Eikqx9YJpBiIebtuNE2m9usdO9Y+clR9SsmwA5nPZLtE
         OVG/DTfU9xGYDbZJOAKLwsU5yaEPC07WVOOZikbw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kWen4-0043Ku-Sg; Sun, 25 Oct 2020 12:06:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     tglx@linutronix.de, alexandre.torgue@st.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>, jason@lakedaemon.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/3] Add STM32 LP timer EXTI interrupts
Date:   Sun, 25 Oct 2020 12:06:23 +0000
Message-Id: <160362752949.263598.6286411876181120842.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
References: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, alexandre.torgue@st.com, fabrice.gasnier@st.com, jason@lakedaemon.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 16:40:16 +0200, Fabrice Gasnier wrote:
> STM32 LP timer that's available on STM32MP15x can wakeup the platform
> using EXTI interrupts.
> 
> This series add:
> - LP timer EXTI - GIC interrupt events to EXTI driver and device-tree
> - LP timer wakeup-source to device-tree
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/3] irqchip/stm32-exti: Add all LP timer exti direct events support
      commit: a00e85b581fd5ee47e770b6b8d2038dbebbe81f9

Please route the last two patches via arm-soc.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


