Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B878529C93B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830548AbgJ0Tsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:48:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54440 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830536AbgJ0Tsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:48:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id w23so2503348wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OM5LInUEcm+wSfTxPM6NIPhrpwKnDjCgwYKH85O1BGM=;
        b=dzrKwlieZrRyqQhGY0/B384MnSh6q5j5qZdrKXCIsrATYhg38T8b4adxQMFpsE/G6c
         cnp9L+8Tzykok/k72SnOevf3SjhmgUJH7hC3usd/A7ZO02OKYETu471jWPrya1YIxDy/
         WdBnGCDKa48PAChUqtIdB/OnNQdPT/Fu9WEN35IHmEOeE0w3Byii75vq4lLS2BBrA15H
         sQaGOOKVQV0RW4/18KTLgN4xCsN+4UBZmxSEVj8elhwDjEKNsUmG2Y5CG5JuaqMgodRO
         SH03eT32d+Kg/3omAleMIrK3HJ1NFHXMae5GwhhzIxWi0UKQeuwvG6+Oht04O1Eb1nAD
         7VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OM5LInUEcm+wSfTxPM6NIPhrpwKnDjCgwYKH85O1BGM=;
        b=f5CRoGQ/sUHipyGiFGp/WmXuznKid83e4qN3xw/Mu4KRylD+Jq4KLTULQtvC1h5ZK9
         JUF2B16H1bTnICoB+2QKiX82an1Kwc3IOD9APfxnE4WN76F/4S2fDt/T0Z38a7/Vm0aw
         Fx+WvSCvb99XJRAaenzASWSvhX3frZnimHDE6RHIUHrq1/PDgpxYkre+4dFvgfrOwOnL
         Rk2cqCSvTmjeeI3hks5xb1RGdIC0qvfU2lTQ4w3YPqAC6uctuwGHgch7EoDkMZKFTdhi
         RoxZv0/QX+3esInpGYZDp1FHKaIz+fW4Y/+cu4htMZutCPHdlXeT6xKrSzGFQ+gqBL/q
         rpuw==
X-Gm-Message-State: AOAM531BpojGpKjFYBDmJTrmuypSLGLWKkQAzQD53oOVShhxIpCLYQTG
        bBm4QaOehv13PmO5rwtdaZSVTQ==
X-Google-Smtp-Source: ABdhPJy6CncuhXQfiwvE/R48xeKNyaogkfdxWRMSh2NZq75O2YHmbHlVztooFbCDyF9nSFYcPtptsQ==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr4268431wmh.72.1603828120449;
        Tue, 27 Oct 2020 12:48:40 -0700 (PDT)
Received: from localhost.localdomain (159.174.185.81.rev.sfr.net. [81.185.174.159])
        by smtp.gmail.com with ESMTPSA id h62sm323222wrh.82.2020.10.27.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:48:39 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: mediatek: add MT8167 pumpkin board dts
Date:   Tue, 27 Oct 2020 20:48:15 +0100
Message-Id: <20201027194816.1227654-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027194816.1227654-1-fparent@baylibre.com>
References: <20201027194816.1227654-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pumpkin board is  made by Gossamer Engineering and is using
a MediaTek SoC. The board currently comes in two available version:
MT8516 SoC and MT8167 SoC.
The board provides the following IOs: eMMC, NAND, SD card, USB type-A,
Ethernet, Wi-Fi, Bluetooth, Audio (jack out, 2 PDM port, 1 analog in),
serial over USB, HDMI, DSI, CSI, and an expansion header.

The board can be powered by battery and/or via a USB Type-C port and
is using a PMIC MT6392.

The eMMC and NAND are sharing pins and cannot be used together.

This commit is adding the basic boot support for the Pumpkin MT8167
board.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../boot/dts/mediatek/mt8167-pumpkin.dts      | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 3ee682c266cc..8012216987ef 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts
new file mode 100644
index 000000000000..774a2f3fb4b2
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "mt8167.dtsi"
+#include "pumpkin-common.dtsi"
+
+/ {
+	model = "Pumpkin MT8167";
+	compatible = "mediatek,mt8167-pumpkin", "mediatek,mt8167";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+};
-- 
2.28.0

