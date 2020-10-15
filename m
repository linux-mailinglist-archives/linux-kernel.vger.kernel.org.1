Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2811028FAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgJOV3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731161AbgJOV3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:29:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABCE20759;
        Thu, 15 Oct 2020 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602797393;
        bh=CiUCwxHbHrlvIPc9xjyS/u2IK6Z/5M3q0g1e1W+9hk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLtRCMeNiiJh736Fdf8BT7P39glGuBhH0fYhrvMgv7E8C7EfbEPbgq+2lZnmAEoJu
         hxdfe4FWFeRmvdBMMdi3ApvL0L/IU5SAflKDFYCoC5HS2qe/qiASWKDeDS+dZyc0j2
         sMs1jQuG0M3a+MDYFYuLmrX4gx35vQx2YQ5VDnec=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kTAoo-001Uc3-Rd; Thu, 15 Oct 2020 22:29:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Palmer <daniel@thingy.jp>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
Date:   Thu, 15 Oct 2020 22:29:47 +0100
Message-Id: <160279736145.714857.6241201517458761558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014131703.18021-1-geert+renesas@glider.be>
References: <20201014131703.18021-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, geert+renesas@glider.be, daniel@thingy.jp, mark-pk.tsai@mediatek.com, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 15:17:03 +0200, Geert Uytterhoeven wrote:
> The MStar interrupt controller is only found on MStar, SigmaStar, and
> Mediatek SoCs.  Hence add dependencies on ARCH_MEDIATEK and
> ARCH_MSTARV7, to prevent asking the user about the MStar interrupt
> controller driver when configuring a kernel without support for MStar,
> SigmaStar, and Mediatek SoCs.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
      commit: 61b0648d569aca932eab87a67f7ca0ffd3ea2b68

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


