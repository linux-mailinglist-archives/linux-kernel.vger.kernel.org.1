Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D42D78B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437595AbgLKPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437562AbgLKPCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:02:32 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8113221E3;
        Fri, 11 Dec 2020 15:01:51 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knjva-000TxV-1z; Fri, 11 Dec 2020 15:01:50 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com,
        mark.rutland@arm.com, zhiqiang.hou@nxp.com,
        Biwen Li <biwen.li@oss.nxp.com>, robh+dt@kernel.org,
        tglx@linutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     xiaobo.xie@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>,
        jiafei.pan@nxp.com, Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH v5 0/6] Extend irqchip ocelot driver to support other SoCs
Date:   Fri, 11 Dec 2020 15:01:35 +0000
Message-Id: <160769813659.482133.16393619984882086839.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125103206.136498-1-gregory.clement@bootlin.com>
References: <20201125103206.136498-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com, mark.rutland@arm.com, zhiqiang.hou@nxp.com, biwen.li@oss.nxp.com, robh+dt@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, xiaobo.xie@nxp.com, Zhiqiang.Hou@nxp.com, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com, jiafei.pan@nxp.com, lars.povlsen@microchip.com, alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com, Steen.Hegelund@microchip.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 11:32:00 +0100, Gregory CLEMENT wrote:
> Ocelot SoC belongs to a larger family of SoCs which use the same
> interrupt controller with a few variation.
> 
> This series of patches add support for Luton, Serval and Jaguar2, they
> are all MIPS based.
> 
> The first patches of the series also updates the binding documentation
> with the new compatible strings.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/6] dt-bindings: interrupt-controller: convert icpu intr bindings to json-schema
      commit: 47d5e0b0e1c151c06885a78a108001ead96adc75
[2/6] dt-bindings: interrupt-controller: Add binding for few Microsemi interrupt controllers
      commit: b307ee828f61bc65d918e820a93b5c547a73dda3
[3/6] irqchip: ocelot: prepare to support more SoC
      commit: 5f0c75e7a1333f5ebb5303af55d8c863ea292c23
[4/6] irqchip: ocelot: Add support for Luton platforms
      commit: ffce73d4415391b2d6da4878bf04d6610edf56db
[5/6] irqchip: ocelot: Add support for Serval platforms
      commit: 7efdfbd15a21788de8c0743590e777f151a3031b
[6/6] irqchip: ocelot: Add support for Jaguar2 platforms
      commit: 550c1424acf0123ba0c17e22dfcac92d152b2f0e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


