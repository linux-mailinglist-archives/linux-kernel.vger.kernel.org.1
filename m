Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476042D78AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406538AbgLKPDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437559AbgLKPCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:02:30 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5398A206B2;
        Fri, 11 Dec 2020 15:01:49 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knjvX-000TxV-27; Fri, 11 Dec 2020 15:01:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com,
        mark.rutland@arm.com, zhiqiang.hou@nxp.com,
        Biwen Li <biwen.li@oss.nxp.com>, robh+dt@kernel.org,
        tglx@linutronix.de
Cc:     xiaobo.xie@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com
Subject: Re: [v4 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external interrupt
Date:   Fri, 11 Dec 2020 15:01:32 +0000
Message-Id: <160769813659.482133.8392979950247989648.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130101515.27431-1-biwen.li@oss.nxp.com>
References: <20201130101515.27431-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com, mark.rutland@arm.com, zhiqiang.hou@nxp.com, biwen.li@oss.nxp.com, robh+dt@kernel.org, tglx@linutronix.de, xiaobo.xie@nxp.com, Zhiqiang.Hou@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 18:15:05 +0800, Biwen Li wrote:
> Add an new IRQ chip declaration for LS1043A and LS1088A
> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA.
> - get mask value directly according to compatible property of DT
>   and remove confused code(bit_reverse field of struct ls_extirq_data,
>   no need this field for SoC LS1021A. Because the register
>   LS1021A_SCFGREVCR is initialized to 0xffffffff by the relative rcw)

Applied to irq/irqchip-next, thanks!

[01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external interrupt
        commit: b16a1caf4686895427c810219d4b2f796e676160
[11/11] dt-bindings: interrupt-controller: update bindings for supporting more SoCs
        commit: 9898a59358d7cb925f63bb77bd40224d1bc4857e

Patches 2-10 should be routed via the SoC tree.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


