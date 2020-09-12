Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6388D267A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgILMwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgILMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:52:07 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D1CC2073E;
        Sat, 12 Sep 2020 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599915126;
        bh=SngN3KVo+uCehkPIcuGTa6gjVun+U3xzppx3ffSqK3M=;
        h=From:To:Cc:Subject:Date:From;
        b=i1LG5xSiAM52TqKv1DcvJu0yKRyG8oT7eXZimJfpnxIQEWnCitx06UOLpkjZKOwzm
         Cl04wO/J6b2d304uo2BjHSS8ryfIhKTmuAV+5CzslCZr2RztSDQ7Mmzlcd+icfehc2
         W4rK0ZMnLynH+1oheLuxFkdqmr5LvPJA8S846mlE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kH50e-00BEw6-5G; Sat, 12 Sep 2020 13:52:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com
Subject: [PATCH 0/6] irqchip: Hybrid probing
Date:   Sat, 12 Sep 2020 13:51:42 +0100
Message-Id: <20200912125148.1271481-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, enric.balletbo@collabora.com, linux@fw-web.de, john.stultz@linaro.org, saravanak@google.com, hanks.chen@mediatek.com, agross@kernel.org, bjorn.andersson@linaro.org, matthias.bgg@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, frowand.list@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent attempt at converting a couple of interrupt controllers from
early probing to standard platform drivers have badly failed, as it
became evident that although an interrupt controller can easily probe
late, device drivers for the endpoints connected to it are rarely
equipped to deal with probe deferral. Changes were swiftly reverted.

However, there is some value in *optionally* enabling this, if only
for development purposes, as there is otherwise a "chicken and egg"
problem, and a few people (cc'd) are working on a potential solution.

This short series enables the infrastructure for modular building
whilst retaining the usual early probing for monolithic build, and
introduces it to the three drivers that were previously made to probe
as platform drivers.

As I don't have any of the HW, this series is fully untested and I'd
welcome some feedback on it.

Thanks,

	M.

Marc Zyngier (6):
  of: Add basic infrastructure to create early probe arrays
  irqchip: Make IRQCHIP_MATCH() type safe
  irqchip: Introduce IRQCHIP_HYBRID_DRIVER_{BEGIN,END} macros
  irqchip/mtk-cirq: Allow modular build
  irqchip/mtk-sysirq: Allow modular build
  irqchip/qcom-pdc: Allow modular build

 drivers/irqchip/irq-mtk-cirq.c   |  4 +++-
 drivers/irqchip/irq-mtk-sysirq.c |  4 +++-
 drivers/irqchip/qcom-pdc.c       |  4 +++-
 include/linux/irqchip.h          | 14 +++++++++++++-
 include/linux/of.h               | 15 +++++++++++++++
 5 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.28.0

