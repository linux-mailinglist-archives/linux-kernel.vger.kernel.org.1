Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6952B307C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKNUBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgKNUBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:01:52 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56685C0613D2;
        Sat, 14 Nov 2020 12:01:52 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so14087565wrl.7;
        Sat, 14 Nov 2020 12:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVMUgeyZKuWrvaXuwrPFfDV9ehe24R8AloJfk4H/7KE=;
        b=T3RFYqK91Z9IiHxLhucv8O/w7eZKfuCJNvkpEmhrzlWUroBUdgQJ07Vo8dg2yDtTuB
         mn1T8IE3KzgsfaH5p3LAjPNLMFPccmbj7uOtlj6w6pXq7ktcXjiKmiRO+e9V9s4z8Y+p
         o4Scu4nPdkYdsN+gSOpcrZn7tc3B9JV+Ntr9cThyukXkbGM0cRhycBtYB0Z64VhY8QZT
         igf/9QTpIWQBjEiwJksxbt8CpEcU3A09nczW2MsePb33jtaDDrWbYgMF26M87Zj7T7Ah
         e76GaI2iMUqbXxDxqT2dVoCKBz1MfPDDyy8zZR6Wzc4CuRAv2irRB1JZ4fzVwJtgfxnS
         vwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVMUgeyZKuWrvaXuwrPFfDV9ehe24R8AloJfk4H/7KE=;
        b=AbVWAUY/Ok4YxYRzCGp6mdHZq1qHDaLYOsGRXleAPtOAomTnzAd6tzSEfG511JFkg9
         rR2Vt9SEDWGEQJLDSWQaPJvu285Nj5q/RMjP2FAx1f38pb9uW4Y1fMk1Lt/J/EUV64ju
         0KzHo4uZLmKmRi5ltvdqa/fz3DNC/eJ2cq8Ov83Nr2+fNc/xVhV0BbULx7W9TofVNwFg
         CycxBW52MVwfWUie5xzWi6mGJQ68wdIir+K/pS52dOStA8Ur1GhtmmVdxGjJXDOh3GFp
         JLaxL7mMKC9r2jM0XMeC6379+OPn0TpFMJQfZ9CuYqIpyyIe7FJigvRXd+CA3+jRZDDQ
         fBWQ==
X-Gm-Message-State: AOAM532P8Ad9aHjyMFiuiAoQbmq4b0orFIdTIzdI4APHy+PMCx/AA0qh
        izbUi8NnZibqzaWuZwIgMs+ewMw1nthDzA==
X-Google-Smtp-Source: ABdhPJyMtw9Jp1TkxZvWYEt21lqHXG31OvFS/02u+jppFkJOIZYIc26e4dd0MCeg/UYqHovxE/dlVw==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr10454761wrq.33.1605384111112;
        Sat, 14 Nov 2020 12:01:51 -0800 (PST)
Received: from localhost.localdomain (p4fc3ea77.dip0.t-ipconnect.de. [79.195.234.119])
        by smtp.googlemail.com with ESMTPSA id g138sm14342953wme.39.2020.11.14.12.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 12:01:50 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     davem@davemloft.net, kuba@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        narmstrong@baylibre.com, jbrunet@baylibre.com, andrew@lunn.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 3/4] net: stmmac: dwmac-meson8b: move RGMII delays into a separate function
Date:   Sat, 14 Nov 2020 21:01:03 +0100
Message-Id: <20201114200104.4148283-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
References: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer SoCs starting with the Amlogic Meson G12A have more a precise
RGMII RX delay configuration register. This means more complexity in the
code. Extract the existing RGMII delay configuration code into a
separate function to make it easier to read/understand even when adding
more logic in the future.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 465eaf000da1..a6e2077ed871 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -268,7 +268,7 @@ static int meson8b_devm_clk_prepare_enable(struct meson8b_dwmac *dwmac,
 	return 0;
 }
 
-static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
+static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
 {
 	u32 tx_dly_config, rx_dly_config, delay_config;
 	int ret;
@@ -323,6 +323,13 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 				PRG_ETH0_ADJ_DELAY | PRG_ETH0_ADJ_SKEW,
 				delay_config);
 
+	return 0;
+}
+
+static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
+{
+	int ret;
+
 	if (phy_interface_mode_is_rgmii(dwmac->phy_mode)) {
 		/* only relevant for RMII mode -> disable in RGMII mode */
 		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
@@ -431,6 +438,10 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 		goto err_remove_config_dt;
 	}
 
+	ret = meson8b_init_rgmii_delays(dwmac);
+	if (ret)
+		goto err_remove_config_dt;
+
 	ret = meson8b_init_rgmii_tx_clk(dwmac);
 	if (ret)
 		goto err_remove_config_dt;
-- 
2.29.2

