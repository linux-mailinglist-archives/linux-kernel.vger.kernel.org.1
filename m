Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E5A267A86
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgILMxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgILMwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:52:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067DE21D6C;
        Sat, 12 Sep 2020 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599915128;
        bh=E+BZblSWsWqcokwAv8F7Mg2fMTtKC3laJsPFzStMtz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j06z+5fH97R+cPudPyUlkXMHqb931PSbU8oTUd0LggdbAhadFOT12DEcKMimHmYiM
         tGfKYNCITlub6x82vkzUK61HiX4lhFcCuhkHoRDcR+JdAUpsjI6uTAaVpuFwchmp+C
         M8DYjp3sTCxsxpoQu0txm8HIYNFY2bTd/WR7x1LA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kH50g-00BEw6-HQ; Sat, 12 Sep 2020 13:52:06 +0100
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
Subject: [PATCH 3/6] irqchip: Introduce IRQCHIP_HYBRID_DRIVER_{BEGIN,END} macros
Date:   Sat, 12 Sep 2020 13:51:45 +0100
Message-Id: <20200912125148.1271481-4-maz@kernel.org>
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

Although we are trying to move to a world where a large number
of irqchip drivers can safely be built as platform drivers
the reality is that most endpoint drivers are not ready for that,
and will fail to probe as they expect their interrupt controller
to be up and running.

A halfway house solution is to let the driver indicate that if
it is built-in (i.e. not a module), then it must use the earily
probe mechanism, IRQCHIP_DECLARE() style. Otherwise, it is a
normal module implemenenting a platform driver, and we can
fallback to the existing code.

Hopefully we'll one day be able to drop this code altogether,
but that's not for tomorrow.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqchip.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index f8f25e9f8200..31fc9d00101f 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -50,6 +50,18 @@ static struct platform_driver drv_name##_driver = {		\
 };									\
 builtin_platform_driver(drv_name##_driver)
 
+#ifdef MODULE
+#define IRQCHIP_HYBRID_DRIVER_BEGIN(drv)	\
+	IRQCHIP_PLATFORM_DRIVER_BEGIN(drv)
+#define IRQCHIP_HYBRID_DRIVER_END(drv)		\
+	IRQCHIP_PLATFORM_DRIVER_END(drv)
+#else
+#define IRQCHIP_HYBRID_DRIVER_BEGIN(drv)	\
+	_OF_DECLARE_ARRAY_START(irqchip, drv)
+#define IRQCHIP_HYBRID_DRIVER_END(drv)		\
+	_OF_DECLARE_ARRAY_END;
+#endif
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their version and their initialization function.
-- 
2.28.0

