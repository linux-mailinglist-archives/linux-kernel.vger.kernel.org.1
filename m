Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11B22B307F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKNUB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgKNUBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:01:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D8C0613D1;
        Sat, 14 Nov 2020 12:01:51 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so14137399wrx.2;
        Sat, 14 Nov 2020 12:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6AIoFNZ/yLqMb8IJ3uIxUoE5cACLn4dM8V8GVRWjKYI=;
        b=hmVK45Xu0/R8zNP4CFJ4Ftzi4wcJj3/cd20qg6nP3qEDEfzLJ96R+PlXYsOSrbKum2
         MFB3zkRU0cGvamQmMVKvo3ZGAFVS2mFDuW64XyW045tkuJDf+tvT23YZRpJ4tBAAqX2o
         hkKaM6ReHL9LH7FTtrA6Q6hFsqVVIblYbfAli5u09DLHQPcAdHoF0Q9CGeGFGWvQ0zoU
         dPq9uUwHmW/TgLcQXNjiCR20+7jrB7Ao621r7DMuI1d1taNrq0fgaGXmX/LcHhkwpmEd
         oUUKuninLoelAHlr9GGhuNKhJh26iv8PjsxXTXgbvopw78tN69q+Hn4STTpIc5SIqbG5
         s7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6AIoFNZ/yLqMb8IJ3uIxUoE5cACLn4dM8V8GVRWjKYI=;
        b=BsVqnHJICM8+ahOQt5T6Y7zvfp/qgwOhOnOd989BS7orco+ke8Nk/OzTM99SKmsTWy
         a9+ib3r/38jwiYdw88u1kGEiMj26PkPsxxJs429LFvvjEojZXrAeupBNP/mtC7aQAk+a
         U43WwCYsfDjMItKWY1zFHrmKt0olI32QvbdXrQ2KvfqHrZDxleot49S4MSURZPa2V7RE
         s7tbN/KvL5vm1iUQr08iEyu8ZqdBVRhX5jmX1ieTSkvU4Hh/juBiLmvCdXhBAgwzW4qE
         vkfzVCF9YU2v43klMHV2qEhaVePGPZDyONwif3K9eYDIk1ciPMp8ANjNPMn6maOnwnCO
         t79w==
X-Gm-Message-State: AOAM530tHt7iwmt9O2cEnRj+uB2qyrlEITBvR8OW+WOSdMqEIvEeiJsm
        WJhTntWA6EFd6RfiHGBDlXs=
X-Google-Smtp-Source: ABdhPJydEBL73jFweyqT4tskHwRL1D3qKsJIU1phA9V/TJ+4GuwNhYYV/yNr2BFvAUO19LdSLTdetA==
X-Received: by 2002:adf:fc41:: with SMTP id e1mr10914610wrs.406.1605384110061;
        Sat, 14 Nov 2020 12:01:50 -0800 (PST)
Received: from localhost.localdomain (p4fc3ea77.dip0.t-ipconnect.de. [79.195.234.119])
        by smtp.googlemail.com with ESMTPSA id g138sm14342953wme.39.2020.11.14.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 12:01:49 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     davem@davemloft.net, kuba@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        narmstrong@baylibre.com, jbrunet@baylibre.com, andrew@lunn.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 2/4] net: stmmac: dwmac-meson8b: use picoseconds for the RGMII RX delay
Date:   Sat, 14 Nov 2020 21:01:02 +0100
Message-Id: <20201114200104.4148283-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
References: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson G12A, G12B and SM1 SoCs have a more advanced RGMII RX
delay register which allows picoseconds precision. Parse the new
"amlogic,rgmii-rx-delay-ps" property or fall back to the old
"amlogic,rx-delay-ns".

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index dc0b8b6d180d..465eaf000da1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -83,7 +83,7 @@ struct meson8b_dwmac {
 	phy_interface_t			phy_mode;
 	struct clk			*rgmii_tx_clk;
 	u32				tx_delay_ns;
-	u32				rx_delay_ns;
+	u32				rx_delay_ps;
 	struct clk			*timing_adj_clk;
 };
 
@@ -276,7 +276,7 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	tx_dly_config = FIELD_PREP(PRG_ETH0_TXDLY_MASK,
 				   dwmac->tx_delay_ns >> 1);
 
-	if (dwmac->rx_delay_ns == 2)
+	if (dwmac->rx_delay_ps == 2000)
 		rx_dly_config = PRG_ETH0_ADJ_ENABLE | PRG_ETH0_ADJ_SETUP;
 	else
 		rx_dly_config = 0;
@@ -406,14 +406,20 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 				 &dwmac->tx_delay_ns))
 		dwmac->tx_delay_ns = 2;
 
-	/* use 0ns as fallback since this is what most boards actually use */
-	if (of_property_read_u32(pdev->dev.of_node, "amlogic,rx-delay-ns",
-				 &dwmac->rx_delay_ns))
-		dwmac->rx_delay_ns = 0;
+	/* RX delay defaults to 0ps since this is what many boards use */
+	if (of_property_read_u32(pdev->dev.of_node,
+				 "amlogic,rgmii-rx-delay-ps",
+				  &dwmac->rx_delay_ps)) {
+		if (!of_property_read_u32(pdev->dev.of_node,
+					  "amlogic,rx-delay-ns",
+					  &dwmac->rx_delay_ps))
+			/* convert ns to ps */
+			dwmac->rx_delay_ps *= 1000;
+	}
 
-	if (dwmac->rx_delay_ns != 0 && dwmac->rx_delay_ns != 2) {
+	if (dwmac->rx_delay_ps != 0 && dwmac->rx_delay_ps != 2000) {
 		dev_err(&pdev->dev,
-			"The only allowed RX delays values are: 0ns, 2ns");
+			"The only allowed RX delays values are: 0ps, 2000ps");
 		ret = -EINVAL;
 		goto err_remove_config_dt;
 	}
-- 
2.29.2

