Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4D267A82
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgILMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgILMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:52:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E91C2073E;
        Sat, 12 Sep 2020 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599915130;
        bh=GF65RgPizxOvsdxgQQL/c07GFhNfm31zP65Jgj0JLF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgX7kOXn4qlNeZuyeyJA0y1DSEkbQl+6igYcTVl6AmM0ezg4Q+E3sQZ/4X79uN7Vo
         tQvnJFu/sZNmdnUqTvtfZvpg7rpJ70vmXcTD3qOvWkt47U6dh2GNAy3Sh9evZKMctF
         Oq6cyVKB2kfkY0pI6sDXArWnDrcFS70shwQOv31Q=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kH50i-00BEw6-TL; Sat, 12 Sep 2020 13:52:09 +0100
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
Subject: [PATCH 6/6] irqchip/qcom-pdc: Allow modular build
Date:   Sat, 12 Sep 2020 13:51:48 +0100
Message-Id: <20200912125148.1271481-7-maz@kernel.org>
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
 drivers/irqchip/qcom-pdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 6ae9e1f0819d..8543fa23da10 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -430,4 +430,6 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
-IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
+IRQCHIP_HYBRID_DRIVER_BEGIN(qcom_pdc)
+IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
+IRQCHIP_HYBRID_DRIVER_END(qcom_pdc)
-- 
2.28.0

