Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFB2D78BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgLKPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437571AbgLKPDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:03:10 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70BE22581;
        Fri, 11 Dec 2020 15:01:53 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knjvc-000TxV-0S; Fri, 11 Dec 2020 15:01:52 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com,
        mark.rutland@arm.com, zhiqiang.hou@nxp.com,
        Biwen Li <biwen.li@oss.nxp.com>, robh+dt@kernel.org,
        tglx@linutronix.de, Lokesh Vutla <lokeshvutla@ti.com>
Cc:     xiaobo.xie@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Sekhar Nori <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] irqchip/ti-sci-inta: Fix printing of inta id on probe success
Date:   Fri, 11 Dec 2020 15:01:37 +0000
Message-Id: <160769813659.482133.1535871338934448366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201102120614.11109-1-lokeshvutla@ti.com>
References: <20201102120614.11109-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com, mark.rutland@arm.com, zhiqiang.hou@nxp.com, biwen.li@oss.nxp.com, robh+dt@kernel.org, tglx@linutronix.de, lokeshvutla@ti.com, xiaobo.xie@nxp.com, Zhiqiang.Hou@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, nsekhar@ti.com, nm@ti.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Nov 2020 17:36:14 +0530, Lokesh Vutla wrote:
> On a successful probe, the driver tries to print a success message with
> INTA device id. It uses pdev->id for printing the id but id is stored in
> inta->ti_sci_id. Fix it by correcting the dev_info parameter.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/ti-sci-inta: Fix printing of inta id on probe success
      commit: b10d5fd489b0c67f59cbdd28d95f4bd9f76a62f2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


