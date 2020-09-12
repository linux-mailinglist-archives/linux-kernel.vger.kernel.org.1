Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F73267A85
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgILMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgILMwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:52:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FB321D7E;
        Sat, 12 Sep 2020 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599915128;
        bh=DPWkUxUtqipogOhfaHoqp5WHum0apD13m8vxx788EWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdfI7TjjDjATcKlg2Cl53ui3B4WG9+rzCJJSRZUAg1uwvo8FePA7tw1OFnJvk2+eU
         EQ+oy7zoUSQncI14ziVIejO6MV4b2Ncv3yVL6hyH6g7lNo+SnDQOSwzi/VFFl9l8XB
         z8C0vdLCyxJ2SIom0UaHbbODq9wSxjmgl4fytUMk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kH50h-00BEw6-8z; Sat, 12 Sep 2020 13:52:07 +0100
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
Subject: [PATCH 4/6] irqchip/mtk-cirq: Allow modular build
Date:   Sat, 12 Sep 2020 13:51:46 +0100
Message-Id: <20200912125148.1271481-5-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912125148.1271481-1-maz@kernel.org>
References: <20200912125148.1271481-1-maz@kernel.org>
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

Switch the driver to a "hybrid probe" model which preserves the
built-in behaviour while allowing the driver to be optionnally
built as a module for development purposes.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-mtk-cirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 69ba8ce3c178..43e880b63ed2 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -295,4 +295,6 @@ static int __init mtk_cirq_of_init(struct device_node *node,
 	return ret;
 }
 
-IRQCHIP_DECLARE(mtk_cirq, "mediatek,mtk-cirq", mtk_cirq_of_init);
+IRQCHIP_HYBRID_DRIVER_BEGIN(mtk_cirq)
+IRQCHIP_MATCH("mediatek,mtk-cirq", mtk_cirq_of_init)
+IRQCHIP_HYBRID_DRIVER_END(mtk_cirq)
-- 
2.28.0

