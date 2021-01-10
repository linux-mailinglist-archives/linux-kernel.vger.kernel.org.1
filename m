Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A032F06B3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 12:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbhAJLjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 06:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbhAJLjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 06:39:19 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716CC06179F;
        Sun, 10 Jan 2021 03:38:39 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e7so73994ili.2;
        Sun, 10 Jan 2021 03:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiVkZdx785Za+C8kdKVbVCz+LRIKha9Es2RMYP4mnFE=;
        b=OW2wO5tS7j6itiIX8wCsOzfJeFvRJyNWFVk7TrM5FLrZ/GX5YwQ1BCEGcmI/jgsAGi
         pUVYo45d/4dj/g801rEpt2GWjUndKgDF743zxHuPHQ2EL+1ImwV6b1PKuhnCjmPavZS+
         ZkDgseHawdyvj3+7SoJ/LuwLe8V+Un6bb54FQ0CX1lx98lMMdbvFane3dysIVI7fkUgg
         jd2raJe4anaL42C+uHwRTxBxPxU4WUo4NHmZ/iHMglBMgaakP+rh+vWftnzVzzTI9lPV
         D/UwSUXYPXjgOECyLMyY779um0ZtBmkpVsobe5+YbgRxOLITMNC4EonaTwfEKbjxizTz
         5E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiVkZdx785Za+C8kdKVbVCz+LRIKha9Es2RMYP4mnFE=;
        b=PSunUuxu0JTG4hmHBVpa3J5CzYiZYae08L1Bpl4JKjzUgRIza69ggek/z08ZlIUWq6
         d7LgBZFp5uS0id6NXvUItKf2P9ZD0WKVthpQ8kWQgdLhV3s7+02d/ZmJZlkOHup+dsH9
         NivP7fWyAaixxiEBpbK1WPQwAVuH4ZbLLSXKz4Wxf8lVdKqU4t/nQcXBJzuVDwwjUHV1
         dfPNcpHRjPwJVWsPH2E8sRTr128SzECsTHBX/DmDUMlQvY696zGnqGQq27Ri4wx/ggAI
         kNLyWKXlSt/DfN9nrVKYlYh3rv2OQ99CEMeKyf3LKVME8PA1l2UYrjIaxKsy0zeEXsI6
         nidw==
X-Gm-Message-State: AOAM533/nGRmDQFBkMXWw/9D8dy7YvlmQopUDaHYjmgyUy2OwLj3mBnL
        pfieXfl7s6z1qEW7NP7KWcI=
X-Google-Smtp-Source: ABdhPJzPA2hMxXMj/qJ6jODlrDcBwV0h+yZaTKHszgc2tbi2+VxiJzwr0toPImBd3kc0Kj9vih+mYw==
X-Received: by 2002:a92:c692:: with SMTP id o18mr11946048ilg.215.1610278718651;
        Sun, 10 Jan 2021 03:38:38 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:4119:2ef1:4993:8ada])
        by smtp.gmail.com with ESMTPSA id e9sm6221298ill.60.2021.01.10.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 03:38:38 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon: add more pinctrl states for usdhc1
Date:   Sun, 10 Jan 2021 05:38:26 -0600
Message-Id: <20210110113826.1257293-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi chip is capable of communication at SDR104 speeds.
Enable 100Mhz and 200MHz pinmux to support this.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index d897913537ca..988f8ab679ad 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -256,8 +256,10 @@ bluetooth {
 &usdhc1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
-- 
2.25.1

