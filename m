Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB72D78B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437631AbgLKPDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437576AbgLKPDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:03:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CC32312A;
        Fri, 11 Dec 2020 15:01:57 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knjvg-000TxV-3j; Fri, 11 Dec 2020 15:01:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com,
        mark.rutland@arm.com, zhiqiang.hou@nxp.com,
        Biwen Li <biwen.li@oss.nxp.com>, robh+dt@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     xiaobo.xie@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        jiafei.pan@nxp.com, Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
        Scott Branden <sbranden@broadcom.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/5] genirq: Get rid of handle_percpu_devid_fasteoi_ipi()
Date:   Fri, 11 Dec 2020 15:01:41 +0000
Message-Id: <160769813659.482133.5814325145566604439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109094121.29975-1-valentin.schneider@arm.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com, mark.rutland@arm.com, zhiqiang.hou@nxp.com, biwen.li@oss.nxp.com, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, xiaobo.xie@nxp.com, Zhiqiang.Hou@nxp.com, devicetree@vger.kernel.org, biwen.li@nxp.com, jiafei.pan@nxp.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, Lorenzo.Pieralisi@arm.com, rjui@broadcom.com, andrew@lunn.ch, sbranden@broadcom.com, sebastian.hesselbarth@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 09:41:16 +0000, Valentin Schneider wrote:
> While hacking on the GIC flow handlers, I grew increasingly suspicious of
> handle_percpu_devid_fasteoi_ipi() and thus did a bit of digging. AFAICT it isn't
> actually needed and handle_percpu_devid_irq() would suffice. Argumentation is in
> patch 1.
> 
> Tested on my Juno (GICv2) and eMAG (GICv3).
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/5] irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()
      commit: 6abbd6988971aaa607b026eaa0ffd2301352f2ea
[2/5] irqchip/armada-370-xp: Make IPIs use handle_percpu_devid_irq()
      commit: e52e73b7e9f7d08b8c2ef6fb1657105093e22a03
[3/5] irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()
      commit: ffdad793d579c9286c7b67a86d1a3c890fb32082
[4/5] irqchip/hip04: Make IPIs use handle_percpu_devid_irq()
      commit: a2e042e13ff322ad523a2f131dd6e03e8bc05053
[5/5] Revert "genirq: Add fasteoi IPI flow"
      commit: b388fa50142510fb6477f130bb1b3f05a0a263a1

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


