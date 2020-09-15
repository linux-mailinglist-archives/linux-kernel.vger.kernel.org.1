Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289BA26B925
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIPA5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIOLPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:15:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCDFC06121F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:01:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so2390696ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mc2gdazpP2I7bg6WRsLz8UwRyinpHdK0stSWn7q23gw=;
        b=WjZlN/Kd9Jjxj+pMCooXrtqM/Mbi0szwmTXaJ7skiL/yJ5v/3ifkWd5b/hsdl5pPaq
         JBv/2KOxLgfMry2/ioIZAV9/oRcP9+nkFJyAUzwBcbyaRSfazV9xJvJMJE5AuXtzGdTS
         KNswQQrHg28VxTj2qkvyl/G1Kd56qkD9wzLZFuMfa8KhP2wREIPZ+pGNTxIyAPNP7JLC
         SpaPsbtFbM0Y6pgCO0PPD6BACZHwiSIgMZusSUzrUSX8WhA/a3yGEVl+RYOUXdAQkqsG
         vPmkFc/nLjlgLirmnrW/qNsLeX3NGpeNinQSLd2S7DF09oAg+p2dwGSBv38MguzYpYS3
         h9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mc2gdazpP2I7bg6WRsLz8UwRyinpHdK0stSWn7q23gw=;
        b=tFVvMldLC6vTG9xS/aNcGk0c7xXoL/MQb5XVPnYvC5IHyN7n3lN/1xgMjITPkd3pbE
         06QUa9kmW2nmyrr1MYEkmwvePiDYFJx69UGAKNu//8dACYAYHu5aDiGBpDyWWZ2yfazP
         NxxzcU0g+pO5CtWIOK1ufkHE4nC5XjfeU+LpFhfS8DUrbfUFuZ0bGmXJYFN57w6wqtEC
         8hQ6snXJIy07Vqq45auIE4fle8Dqe3k6uB3RuHpUhfkSQVpEIpxVTh25XDsJ2JB4jd82
         isOpMK6y3bxJfeOs+MizOjDj+kbEZgDB3EG6TfP1/WEBm7ZDw0cv6CgPjyOBTlTPJotY
         OUtQ==
X-Gm-Message-State: AOAM533MJHnX9HuuGpAq35LRe6xGS5X386G+PuNND0+ARC5wsvIEXCV4
        LtuFUSEt6VFpCqJrXYhMMgmEZA==
X-Google-Smtp-Source: ABdhPJxBkYyDeMqg+OlqkRJ0ZOsCdWm1KltQZ9+g3/C6bPryvTmE1Oviffi01zfdU/xTwMGiInoe6w==
X-Received: by 2002:a2e:895a:: with SMTP id b26mr6623334ljk.468.1600167685701;
        Tue, 15 Sep 2020 04:01:25 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id n3sm4588916ljj.59.2020.09.15.04.01.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:01:25 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        praneeth@ti.com
Subject: [PATCH v6 5/5] irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs
Date:   Tue, 15 Sep 2020 13:00:51 +0200
Message-Id: <1600167651-20851-6-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600167651-20851-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1600167651-20851-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The K3 AM65x and J721E SoCs have the next generation of the PRU-ICSS IP,
commonly called ICSSG. The PRUSS INTC present within the ICSSG supports
more System Events (160 vs 64), more Interrupt Channels and Host Interrupts
(20 vs 10) compared to the previous generation PRUSS INTC instances. The
first 2 and the last 10 of these host interrupt lines are used by the
PRU and other auxiliary cores and sub-modules within the ICSSG, with 8
host interrupts connected to MPU. The host interrupts 5, 6, 7 are also
connected to the other ICSSG instances within the SoC and can be
partitioned as per system integration through the board dts files.

Enhance the PRUSS INTC driver to add support for this ICSSG INTC
instance.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
v5->v6:
- No change.
v4->v5:
- Rename: s/num_host_intrs/num_host_events/ regarding to change
  introduced in patch #2.
v3->v4:
- Move generic part to "irqchip/irq-pruss-intc: Add a PRUSS irqchip
  driver for PRUSS interrupts" patch and leave only platform related
  code.
v2->v3:
- Change patch order: use it directly after "irqchip/irq-pruss-intc:
  Implement irq_{get,set}_irqchip_state ops" and before new
  "irqchip/irq-pruss-intc: Add event mapping support" in order to reduce
  diff.
v1->v2:
- https://patchwork.kernel.org/patch/11069773/
---
 drivers/irqchip/Kconfig          | 2 +-
 drivers/irqchip/irq-pruss-intc.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 733e59f..25c8944 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -495,7 +495,7 @@ config TI_SCI_INTA_IRQCHIP
 
 config TI_PRUSS_INTC
 	tristate "TI PRU-ICSS Interrupt Controller"
-	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
 	select IRQ_DOMAIN
 	help
 	  This enables support for the PRU-ICSS Local Interrupt Controller
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 41c6271..4be501e 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -628,11 +628,20 @@ static const struct pruss_intc_match_data pruss_intc_data = {
 	.num_host_events = 10,
 };
 
+static const struct pruss_intc_match_data icssg_intc_data = {
+	.num_system_events = 160,
+	.num_host_events = 20,
+};
+
 static const struct of_device_id pruss_intc_of_match[] = {
 	{
 		.compatible = "ti,pruss-intc",
 		.data = &pruss_intc_data,
 	},
+	{
+		.compatible = "ti,icssg-intc",
+		.data = &icssg_intc_data,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
-- 
2.7.4

