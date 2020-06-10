Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1917A1F568A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgFJOJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbgFJOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:09:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD6C03E96F;
        Wed, 10 Jun 2020 07:09:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k26so1965330wmi.4;
        Wed, 10 Jun 2020 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzxDdWHYnpz+UV20TRPo/jYL7PQqEKAVp/cR0HQ2iGA=;
        b=aCneJ/RgvE7ihulcdPqsMvrXm4lRmQ0b6MBM2yEfoGrn0Wr4oP3iSo0ieYIbqWFogO
         YTEDUe6Jzmc3+qkKGsxIxUI2ftwbf1vTEWc495pmxYeMkvaXma4wS/pjSYuzdwv+kjrG
         1W/HsX3m7irH1GtjpZnCWN2vh1MoEoTiq/00FXoA1hK3bSTTONrvJm6IjApu03Mvpn/O
         2fdl1gCLBDvbg8Yc+ddQpKALchwBMeZ93OA5svylHZBnJUdsAlmxCvy9dRj9Twc/xz19
         V/4MhD2EnazLxlwq/N0sItFpo5uPZIszIDpMFG8aiVEY4zeNVgaloI92+gUhhsdyc5VY
         Fbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzxDdWHYnpz+UV20TRPo/jYL7PQqEKAVp/cR0HQ2iGA=;
        b=ApcxZK3/YScxQgqnGEb4TvVlhFVUNC0dGbKUUuW8QhDJXFjMQA4YUKLvkYXqceTFdI
         DbCuzsIYQErIRORF1Oz/6DTROR6vSocGJYnt232B1/myfKiTxIAp+Rrs2dr/mJSB53rL
         vYThLV+//m6hKf1h7lSTzZKIohYN7ON+l+yqMdI+ymqh+mZtI7/235NhlYDzoDwYVcNt
         FjJFjcRTjil10nYsGDPbXJqI0/VpHjmqpMA+H0HesOfsmP+vZdnylq3O56COqyW18UiY
         gi85t1oKTE7EPOv1q5gtenO96NHP2UMl2RHqklJm6PyMbTWsP+lX6z6N+u8l5ncJLiww
         xgMg==
X-Gm-Message-State: AOAM532TdVTYxhKayMQnw2esLC58TmBFKHbIL16VVbUjBaTrmDO19NaP
        /RYJ9MRSIZRyRmyhzZ7/paU=
X-Google-Smtp-Source: ABdhPJwjA1lzuZpA0iQqJVOU45YWAyA1FnmOrVMGhFR8zeqt5kx6TcJYW/D0bGDI7jZypR2TyuydqA==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr3674074wmb.168.1591798144457;
        Wed, 10 Jun 2020 07:09:04 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id r5sm8565883wrq.0.2020.06.10.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 07:09:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        julia.lawall@lip6.fr, f4bug@amsat.org, jonas.gorski@gmail.com,
        lkp@intel.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 2/2] clk: bcm63xx-gate: add BCM6318 support
Date:   Wed, 10 Jun 2020 16:08:58 +0200
Message-Id: <20200610140858.207329-3-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610140858.207329-1-noltari@gmail.com>
References: <20200609113049.4035426-1-noltari@gmail.com>
 <20200610140858.207329-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the gated clock controllers found on the BCM6318.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v2: correct names for sar125 and usbd

 drivers/clk/bcm/clk-bcm63xx-gate.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm63xx-gate.c b/drivers/clk/bcm/clk-bcm63xx-gate.c
index 98e884957db8..fce6746cc607 100644
--- a/drivers/clk/bcm/clk-bcm63xx-gate.c
+++ b/drivers/clk/bcm/clk-bcm63xx-gate.c
@@ -40,6 +40,48 @@ static const struct clk_bcm63xx_table_entry bcm3368_clocks[] = {
 	{ },
 };
 
+static const struct clk_bcm63xx_table_entry bcm6318_clocks[] = {
+	{ .name = "adsl_asb", .bit = 0, },
+	{ .name = "usb_asb", .bit = 1, },
+	{ .name = "mips_asb", .bit = 2, },
+	{ .name = "pcie_asb", .bit = 3, },
+	{ .name = "phymips_asb", .bit = 4, },
+	{ .name = "robosw_asb", .bit = 5, },
+	{ .name = "sar_asb", .bit = 6, },
+	{ .name = "sdr_asb", .bit = 7, },
+	{ .name = "swreg_asb", .bit = 8, },
+	{ .name = "periph_asb", .bit = 9, },
+	{ .name = "cpubus160", .bit = 10, },
+	{ .name = "adsl", .bit = 11, },
+	{ .name = "sar125", .bit = 12, },
+	{ .name = "mips", .bit = 13, .flags = CLK_IS_CRITICAL, },
+	{ .name = "pcie", .bit = 14, },
+	{ .name = "robosw250", .bit = 16, },
+	{ .name = "robosw025", .bit = 17, },
+	{ .name = "sdr", .bit = 19, .flags = CLK_IS_CRITICAL, },
+	{ .name = "usbd", .bit = 20, },
+	{ .name = "hsspi", .bit = 25, },
+	{ .name = "pcie25", .bit = 27, },
+	{ .name = "phymips", .bit = 28, },
+	{ .name = "afe", .bit = 29, },
+	{ .name = "qproc", .bit = 30, },
+	{ },
+};
+
+static const struct clk_bcm63xx_table_entry bcm6318_ubus_clocks[] = {
+	{ .name = "adsl-ubus", .bit = 0, },
+	{ .name = "arb-ubus", .bit = 1, .flags = CLK_IS_CRITICAL, },
+	{ .name = "mips-ubus", .bit = 2, .flags = CLK_IS_CRITICAL, },
+	{ .name = "pcie-ubus", .bit = 3, },
+	{ .name = "periph-ubus", .bit = 4, .flags = CLK_IS_CRITICAL, },
+	{ .name = "phymips-ubus", .bit = 5, },
+	{ .name = "robosw-ubus", .bit = 6, },
+	{ .name = "sar-ubus", .bit = 7, },
+	{ .name = "sdr-ubus", .bit = 8, },
+	{ .name = "usb-ubus", .bit = 9, },
+	{ },
+};
+
 static const struct clk_bcm63xx_table_entry bcm6328_clocks[] = {
 	{ .name = "phy_mips", .bit = 0, },
 	{ .name = "adsl_qproc", .bit = 1, },
@@ -217,6 +259,8 @@ static int clk_bcm63xx_remove(struct platform_device *pdev)
 
 static const struct of_device_id clk_bcm63xx_dt_ids[] = {
 	{ .compatible = "brcm,bcm3368-clocks", .data = &bcm3368_clocks, },
+	{ .compatible = "brcm,bcm6318-clocks", .data = &bcm6318_clocks, },
+	{ .compatible = "brcm,bcm6318-ubus-clocks", .data = &bcm6318_ubus_clocks, },
 	{ .compatible = "brcm,bcm6328-clocks", .data = &bcm6328_clocks, },
 	{ .compatible = "brcm,bcm6358-clocks", .data = &bcm6358_clocks, },
 	{ .compatible = "brcm,bcm6362-clocks", .data = &bcm6362_clocks, },
-- 
2.26.2

