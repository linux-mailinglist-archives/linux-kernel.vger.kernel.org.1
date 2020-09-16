Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4226C59C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgIPRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIPRJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:09:22 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D6C02C2BA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 09:37:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x77so7727871lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i7gj/Nh8EGIMLYny0ckHHCC3KzEEY3dk78DyFkalFas=;
        b=OXV2czXHSzNB9gK5puIx4OtBccuHuoEEXxTJymesg/maaUyhIbM4Fp67x5jajv9xHZ
         ky++sC7oCo8Ln/6QkYF+T28lpqc7eFfJRuv8wx2mYDF3PEVoQ2Rsrm6ZMKrwIWHNnOKo
         y3+OacNOhef2bvFe61dQWjg53Z9MfRuAMNqzRbdiSvDYlatalaUsUiB2m8nY9t+xgD04
         /VoWYu3MjSidCsvpVLuLd/QNmEYcv2RvrMLyYeG5Jk+ja7oG4nq7fpF3Em4kz06wuQa0
         Q2L8pevz8GXJ+FoYBjJsxwTLumKGa1yZ7gV/3RI2zxdc00Mo6Hc4+ui1U03TQP6YmkVk
         C+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i7gj/Nh8EGIMLYny0ckHHCC3KzEEY3dk78DyFkalFas=;
        b=RANJjx8srWPLSTyv0cYtQrzbYUuq1dt6tknor1tqJP5emp+BhTKqdBVlw6/px7eHno
         w277eSaz0k2V3FiI9wnZF1rgt+56YRxBcgcskUytggMK06TbB7+6oEk6PMMEwOwjxIgs
         /8UZCTG2dHTVPlBklbMtALvH0Dr2oOj5FT3VG5GTSUZpV0k1qzPKMLIYM++mmOMoHyME
         N32bInQUX7hGaLqyt5NT6YCmdVbpQLIncgpw5EloMlrA7PjXfH5rt20jCbslnt+fe557
         PUJOf6021JNCWvyFVPm+mEpqSAqlNS7Ml19OaIUCmNDe7oJJWOcwAZrE5yPOdJaURbwo
         hoNA==
X-Gm-Message-State: AOAM5330+DReWcSGHrQFgxH2DASueJmsc4IZfx51UyfNud6de97VNEHB
        atEyl7qjWrOCWeQQoVdKFCL/4g==
X-Google-Smtp-Source: ABdhPJwjpyxBhzIMV0oPgMgroNqtgx1faULkhVJghwHXIfr9e5Cs9MpB4u/0hsLEoYs8TQ/sDqXIYQ==
X-Received: by 2002:a19:8142:: with SMTP id c63mr7926347lfd.175.1600274231059;
        Wed, 16 Sep 2020 09:37:11 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id o15sm4684400lfo.188.2020.09.16.09.37.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 09:37:10 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        praneeth@ti.com
Subject: [PATCH v7 5/5] irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs
Date:   Wed, 16 Sep 2020 18:36:38 +0200
Message-Id: <1600274198-30470-3-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600274198-30470-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1600274198-30470-1-git-send-email-grzegorz.jaszczyk@linaro.org>
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
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
v6->v7:
- Add Co-developed-by tag.
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
index bfe529a..92fb578 100644
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

