Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE526FE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIRNXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRNXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF770C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:23:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so5614490wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E+2fT5wM+IZ7ws6Rc2lCDmiMKB5AnOCmm2bmSr1dNrg=;
        b=o9jAl37RrSFdIChE9ReD+aXUZk7+TRgDEmYW6GLhpBpcJSxeteQIYXE7n1HoKJWZaU
         Oj/TWQo2EwXJ5quAP/MiWefyKx3Iba5vCmrqCQXsvgtMy30503kYtXv8NOUKZUj8605G
         9Tj5sVVVs/XRGPskbLX6IDgvHxMZQvaFnGuP6jgwosSYw2E6LOyU9/hz7oQnb1rKDLWT
         3P3Tl9Gi5RvkvOX1ILGr6yigR+MI3pKHxjWgls5h/QgTaTofnn6nDvL7a5y8Vpr66AH5
         hB5yTNRLXAH+giirpMgDm6t0784wwhr+I0yE1uqs62SkknrNaxFDX3w+7mRMYlJAPMEZ
         BFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E+2fT5wM+IZ7ws6Rc2lCDmiMKB5AnOCmm2bmSr1dNrg=;
        b=Rt6oF0A5ylW2WikgF1twKVe/2ItFLLixSJId7F7TcG7Wh5vq0GymWxcockswBjPZ1/
         /EyL2qC5/6jVwBuNH/LXiGS7CHr32LA5Oh9Ltuh50vXQ7A/ZRq7LoVn5QXgkMqwOvR4J
         DedWoF6vnvJHUO+0ZP7u+4U5LVO6ypQBr/0iP0sX8PqTu7Tm+g9t08UevtTcQMDXbb+N
         EnJg1uRAT+fAwQAVMnn7qQl9YzrD8lUz8roIlybRObfHrcbcDkBWQT11kwli2Nd5ZKfe
         ncxXAfmeot6/CPKwftyIzpiCYp55LriRo3GbJZD8MbshAUICosMyOJEyqhsl6vxsCSUw
         4iCA==
X-Gm-Message-State: AOAM532YAjJuNIozkobIBSd4JD/NNtwYkt9BcePd2oum9LNjegP+Z23Q
        o8hN3srpA86PcHbdEU7fLUvdRQ==
X-Google-Smtp-Source: ABdhPJzESeyjG/+3tK6kmvqZJQ+SOr4mqJxfDabzZh8KvcLlOtPJE4OmYFxENnG6q/vl5mlUx6bxbQ==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr39179259wrx.350.1600435388245;
        Fri, 18 Sep 2020 06:23:08 -0700 (PDT)
Received: from localhost.localdomain (156.18.23.93.rev.sfr.net. [93.23.18.156])
        by smtp.gmail.com with ESMTPSA id c16sm5917048wrx.31.2020.09.18.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:23:07 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     krzk@kernel.org, masahiroy@kernel.org, ck.hu@mediatek.com,
        macpaul.lin@mediatek.com, owen.chen@mediatek.com,
        matthias.bgg@gmail.com, sboyd@kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: mediatek: add bindings for MT8167 clocks
Date:   Fri, 18 Sep 2020 15:23:02 +0200
Message-Id: <20200918132303.2831815-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for topckgen, apmixedsys, infracfg, audsys,
imgsys, mfgcfg, vdecsys on MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

ChangeLog:
	V2: no changes

 .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |   1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt |   1 +
 .../arm/mediatek/mediatek,infracfg.txt        |   1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |   1 +
 .../arm/mediatek/mediatek,topckgen.txt        |   1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |   1 +
 include/dt-bindings/clock/mt8167-clk.h        | 131 ++++++++++++++++++
 8 files changed, 138 insertions(+)
 create mode 100644 include/dt-bindings/clock/mt8167-clk.h

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index bd7a0fa5801b..ea827e8763de 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt7629-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
+	- "mediatek,mt8167-apmixedsys", "syscon"
 	- "mediatek,mt8173-apmixedsys"
 	- "mediatek,mt8183-apmixedsys", "syscon"
 	- "mediatek,mt8516-apmixedsys"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 38309db115f5..b32d374193c7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6779-audio", "syscon"
 	- "mediatek,mt7622-audsys", "syscon"
 	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
+	- "mediatek,mt8167-audiosys", "syscon"
 	- "mediatek,mt8183-audiosys", "syscon"
 	- "mediatek,mt8516-audsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index 1e1f00718a7d..dce4c9241932 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -12,6 +12,7 @@ Required Properties:
 	- "mediatek,mt6779-imgsys", "syscon"
 	- "mediatek,mt6797-imgsys", "syscon"
 	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
+	- "mediatek,mt8167-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
 	- "mediatek,mt8183-imgsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 49a968be1a80..eb3523c7a7be 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -16,6 +16,7 @@ Required Properties:
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt7629-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
+	- "mediatek,mt8167-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
 	- "mediatek,mt8183-infracfg", "syscon"
 	- "mediatek,mt8516-infracfg", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
index ad5f9d2f6818..054424fb64b4 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2712-mfgcfg", "syscon"
 	- "mediatek,mt6779-mfgcfg", "syscon"
+	- "mediatek,mt8167-mfgcfg", "syscon"
 	- "mediatek,mt8183-mfgcfg", "syscon"
 - #clock-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index 9b0394cbbdc9..5ce7578cf274 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
 	- "mediatek,mt7629-topckgen"
 	- "mediatek,mt8135-topckgen"
+	- "mediatek,mt8167-topckgen", "syscon"
 	- "mediatek,mt8173-topckgen"
 	- "mediatek,mt8183-topckgen", "syscon"
 	- "mediatek,mt8516-topckgen"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index 7894558b7a1c..98195169176a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6779-vdecsys", "syscon"
 	- "mediatek,mt6797-vdecsys", "syscon"
 	- "mediatek,mt7623-vdecsys", "mediatek,mt2701-vdecsys", "syscon"
+	- "mediatek,mt8167-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
 	- "mediatek,mt8183-vdecsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/include/dt-bindings/clock/mt8167-clk.h b/include/dt-bindings/clock/mt8167-clk.h
new file mode 100644
index 000000000000..a96158edd817
--- /dev/null
+++ b/include/dt-bindings/clock/mt8167-clk.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2020 BayLibre, SAS.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *         Fabien Parent <fparent@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8167_H
+#define _DT_BINDINGS_CLK_MT8167_H
+
+/* MT8167 is based on MT8516 */
+#include <dt-bindings/clock/mt8516-clk.h>
+
+/* APMIXEDSYS */
+
+#define CLK_APMIXED_TVDPLL		(CLK_APMIXED_NR_CLK + 0)
+#define CLK_APMIXED_LVDSPLL		(CLK_APMIXED_NR_CLK + 1)
+#define CLK_APMIXED_HDMI_REF		(CLK_APMIXED_NR_CLK + 2)
+#define MT8167_CLK_APMIXED_NR_CLK	(CLK_APMIXED_NR_CLK + 3)
+
+/* TOPCKGEN */
+
+#define CLK_TOP_DSI0_LNTC_DSICK		(CLK_TOP_NR_CLK + 0)
+#define CLK_TOP_VPLL_DPIX		(CLK_TOP_NR_CLK + 1)
+#define CLK_TOP_LVDSTX_CLKDIG_CTS	(CLK_TOP_NR_CLK + 2)
+#define CLK_TOP_HDMTX_CLKDIG_CTS	(CLK_TOP_NR_CLK + 3)
+#define CLK_TOP_LVDSPLL			(CLK_TOP_NR_CLK + 4)
+#define CLK_TOP_LVDSPLL_D2		(CLK_TOP_NR_CLK + 5)
+#define CLK_TOP_LVDSPLL_D4		(CLK_TOP_NR_CLK + 6)
+#define CLK_TOP_LVDSPLL_D8		(CLK_TOP_NR_CLK + 7)
+#define CLK_TOP_MIPI_26M		(CLK_TOP_NR_CLK + 8)
+#define CLK_TOP_TVDPLL			(CLK_TOP_NR_CLK + 9)
+#define CLK_TOP_TVDPLL_D2		(CLK_TOP_NR_CLK + 10)
+#define CLK_TOP_TVDPLL_D4		(CLK_TOP_NR_CLK + 11)
+#define CLK_TOP_TVDPLL_D8		(CLK_TOP_NR_CLK + 12)
+#define CLK_TOP_TVDPLL_D16		(CLK_TOP_NR_CLK + 13)
+#define CLK_TOP_PWM_MM			(CLK_TOP_NR_CLK + 14)
+#define CLK_TOP_CAM_MM			(CLK_TOP_NR_CLK + 15)
+#define CLK_TOP_MFG_MM			(CLK_TOP_NR_CLK + 16)
+#define CLK_TOP_SPM_52M			(CLK_TOP_NR_CLK + 17)
+#define CLK_TOP_MIPI_26M_DBG		(CLK_TOP_NR_CLK + 18)
+#define CLK_TOP_SCAM_MM			(CLK_TOP_NR_CLK + 19)
+#define CLK_TOP_SMI_MM			(CLK_TOP_NR_CLK + 20)
+#define CLK_TOP_26M_HDMI_SIFM		(CLK_TOP_NR_CLK + 21)
+#define CLK_TOP_26M_CEC			(CLK_TOP_NR_CLK + 22)
+#define CLK_TOP_32K_CEC			(CLK_TOP_NR_CLK + 23)
+#define CLK_TOP_GCPU_B			(CLK_TOP_NR_CLK + 24)
+#define CLK_TOP_RG_VDEC			(CLK_TOP_NR_CLK + 25)
+#define CLK_TOP_RG_FDPI0		(CLK_TOP_NR_CLK + 26)
+#define CLK_TOP_RG_FDPI1		(CLK_TOP_NR_CLK + 27)
+#define CLK_TOP_RG_AXI_MFG		(CLK_TOP_NR_CLK + 28)
+#define CLK_TOP_RG_SLOW_MFG		(CLK_TOP_NR_CLK + 29)
+#define CLK_TOP_GFMUX_EMI1X_SEL		(CLK_TOP_NR_CLK + 30)
+#define CLK_TOP_CSW_MUX_MFG_SEL		(CLK_TOP_NR_CLK + 31)
+#define CLK_TOP_CAMTG_MM_SEL		(CLK_TOP_NR_CLK + 32)
+#define CLK_TOP_PWM_MM_SEL		(CLK_TOP_NR_CLK + 33)
+#define CLK_TOP_SPM_52M_SEL		(CLK_TOP_NR_CLK + 34)
+#define CLK_TOP_MFG_MM_SEL		(CLK_TOP_NR_CLK + 35)
+#define CLK_TOP_SMI_MM_SEL		(CLK_TOP_NR_CLK + 36)
+#define CLK_TOP_SCAM_MM_SEL		(CLK_TOP_NR_CLK + 37)
+#define CLK_TOP_VDEC_MM_SEL		(CLK_TOP_NR_CLK + 38)
+#define CLK_TOP_DPI0_MM_SEL		(CLK_TOP_NR_CLK + 39)
+#define CLK_TOP_DPI1_MM_SEL		(CLK_TOP_NR_CLK + 40)
+#define CLK_TOP_AXI_MFG_IN_SEL		(CLK_TOP_NR_CLK + 41)
+#define CLK_TOP_SLOW_MFG_SEL		(CLK_TOP_NR_CLK + 42)
+#define MT8167_CLK_TOP_NR_CLK		(CLK_TOP_NR_CLK + 43)
+
+/* MFGCFG */
+
+#define CLK_MFG_BAXI			0
+#define CLK_MFG_BMEM			1
+#define CLK_MFG_BG3D			2
+#define CLK_MFG_B26M			3
+#define CLK_MFG_NR_CLK			4
+
+/* MMSYS */
+
+#define CLK_MM_SMI_COMMON		0
+#define CLK_MM_SMI_LARB0		1
+#define CLK_MM_CAM_MDP			2
+#define CLK_MM_MDP_RDMA			3
+#define CLK_MM_MDP_RSZ0			4
+#define CLK_MM_MDP_RSZ1			5
+#define CLK_MM_MDP_TDSHP		6
+#define CLK_MM_MDP_WDMA			7
+#define CLK_MM_MDP_WROT			8
+#define CLK_MM_FAKE_ENG			9
+#define CLK_MM_DISP_OVL0		10
+#define CLK_MM_DISP_RDMA0		11
+#define CLK_MM_DISP_RDMA1		12
+#define CLK_MM_DISP_WDMA		13
+#define CLK_MM_DISP_COLOR		14
+#define CLK_MM_DISP_CCORR		15
+#define CLK_MM_DISP_AAL			16
+#define CLK_MM_DISP_GAMMA		17
+#define CLK_MM_DISP_DITHER		18
+#define CLK_MM_DISP_UFOE		19
+#define CLK_MM_DISP_PWM_MM		20
+#define CLK_MM_DISP_PWM_26M		21
+#define CLK_MM_DSI_ENGINE		22
+#define CLK_MM_DSI_DIGITAL		23
+#define CLK_MM_DPI0_ENGINE		24
+#define CLK_MM_DPI0_PXL			25
+#define CLK_MM_LVDS_PXL			26
+#define CLK_MM_LVDS_CTS			27
+#define CLK_MM_DPI1_ENGINE		28
+#define CLK_MM_DPI1_PXL			29
+#define CLK_MM_HDMI_PXL			30
+#define CLK_MM_HDMI_SPDIF		31
+#define CLK_MM_HDMI_ADSP_BCK		32
+#define CLK_MM_HDMI_PLL			33
+#define CLK_MM_NR_CLK			34
+
+/* IMGSYS */
+
+#define CLK_IMG_LARB1_SMI		0
+#define CLK_IMG_CAM_SMI			1
+#define CLK_IMG_CAM_CAM			2
+#define CLK_IMG_SEN_TG			3
+#define CLK_IMG_SEN_CAM			4
+#define CLK_IMG_VENC			5
+#define CLK_IMG_NR_CLK			6
+
+/* VDECSYS */
+
+#define CLK_VDEC_CKEN			0
+#define CLK_VDEC_LARB1_CKEN		1
+#define CLK_VDEC_NR_CLK			2
+
+#endif /* _DT_BINDINGS_CLK_MT8167_H */
-- 
2.28.0

