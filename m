Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066B3267A80
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgILMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgILMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:52:07 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E74208E4;
        Sat, 12 Sep 2020 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599915127;
        bh=j+V8uWlUtBGKarWfp0I9mmthwCt2ao2kD0ZxDnNDsvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6Hl4lp/5mOmiCJXgaeJg0eumwQOGB4Rwe86ye49rsvBIgtXv76eHrXZ+zF1/L2SL
         w0Z090LBWKufpRqerefXzdSJmtHHVF8hsRUYa3rWKxbZ2END92h5ovrWqUQKqcQaDX
         DrgFa94DOPC84/os/np4qKt73p4eVlNxeCeCSCUY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kH50f-00BEw6-Or; Sat, 12 Sep 2020 13:52:05 +0100
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
Subject: [PATCH 2/6] irqchip: Make IRQCHIP_MATCH() type safe
Date:   Sat, 12 Sep 2020 13:51:44 +0100
Message-Id: <20200912125148.1271481-3-maz@kernel.org>
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

IRQCHIP_DECLARE() is backed by macros that perform some elementary
type checking on the probe function. Unfortunately, IRQCHIP_MATCH()
doesn't, risking difficult debugging sessions...

Rewrite IRQCHIP_MATCH() in terms of _OF_DECLARE_ELMT() restore
the missing type safety.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqchip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 67351aac65ef..f8f25e9f8200 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -33,7 +33,7 @@ extern int platform_irqchip_probe(struct platform_device *pdev);
 #define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
 static const struct of_device_id drv_name##_irqchip_match_table[] = {
 
-#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
+#define IRQCHIP_MATCH(compat, fn) _OF_DECLARE_ELMT(compat, fn, of_init_fn_2)
 
 #define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
 	{},								\
-- 
2.28.0

