Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63762D7917
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390872AbgLKPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:21:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392987AbgLKPUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:20:35 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3845B20793;
        Fri, 11 Dec 2020 15:19:55 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knjvh-000TxV-2f; Fri, 11 Dec 2020 15:01:57 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com,
        mark.rutland@arm.com, zhiqiang.hou@nxp.com,
        Biwen Li <biwen.li@oss.nxp.com>, robh+dt@kernel.org,
        tglx@linutronix.de, Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org
Cc:     xiaobo.xie@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>, jiafei.pan@nxp.com,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH 0/3] Remove drivers used by EZChip NPS platform
Date:   Fri, 11 Dec 2020 15:01:42 +0000
Message-Id: <160769813659.482133.7482270195776095716.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201105212210.1891598-1-vgupta@synopsys.com>
References: <20201105212210.1891598-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com, mark.rutland@arm.com, zhiqiang.hou@nxp.com, biwen.li@oss.nxp.com, robh+dt@kernel.org, tglx@linutronix.de, Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org, xiaobo.xie@nxp.com, Zhiqiang.Hou@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com, jiafei.pan@nxp.com, linux-snps-arc@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 13:22:07 -0800, Vineet Gupta wrote:
> This series removes any drivers associated with EZChip NPS platform
> which was removed from ARC in 5.10-rc1.
> 
> Vineet Gupta (3):
>   drivers/clocksource: Remove EZChip NPS clocksource driver
>   drivers/irqchip: Remove EZChip NPS interrupt controller
>   include/soc: remove headers for EZChip NPS
> 
> [...]

Applied to irq/irqchip-next, thanks!

[2/3] drivers/irqchip: Remove EZChip NPS interrupt controller
      commit: 04e7f423f4a96ad492fd51bf2234b8982400ab5f

Please route the two other patches via their respective trees.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


