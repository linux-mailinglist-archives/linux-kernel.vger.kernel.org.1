Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2129ACE5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900503AbgJ0NL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:11:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40011 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900369AbgJ0NLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:11:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id k18so1385999wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNVNQ1C4yPexwHndr+DYW/xGHvtpoJAKylOs1IEPPgM=;
        b=fO7GhI+TZtPIbtW3DFMaaVYuhKOTCNAfVadXPYXBW/TBBJCx7CrTpTLWB+h+kWFc/4
         9X6pxsCQQvzBsa2fy3Ya3DlIA1Xb8mWtI0DcjfRfZVAGUf0WbTvtJkeG4bqV44Z5e+jB
         OksHNUv2kmIcNIB9XjbRA69ZEaxbt7LKzIRj1P2+N6OYFrnVp+vkGn4MtlZWRiBVk3aS
         KMIdUZVG6kcBthbyi36C04ie7xn7oROgDfWGwX+6VUzYxmVbVWF1Jo5vGOPsVoKu4gMU
         /RqD3CyGbBRy4ethJMkuV2PI6jrF4fl6xOGKrbS+jU8W0fCm22JN5SvgEFVTK/K5xZGG
         UCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNVNQ1C4yPexwHndr+DYW/xGHvtpoJAKylOs1IEPPgM=;
        b=MIIcXjZW0ydxsR1m/fMceJbzubkC78RZuei91EtFi4eQS1HdXxmLQLrWk8DHne0W+d
         nepEPH1/wPM1I91wYJ/ZXsC1BfIvuPQAK7XNeSA5ahuqILt8WTw+u7m46axMyyRgd5Us
         KS6T0G5oUVQIkLXeB3lgMgZMy8X9qMX7U/pMHRpOUwcTPfGPbydmi2Fh7ZMZVZ72HUrc
         WcmyVxsH2kPlru9yLeGygyu/hByt8I+jB3YuQ8xOT5qzv722jdPqgT58b9Gtp8bFm0lw
         TdX3FlKvQplB0QZB6GmIdjliDpsys/KzMukwBCs8AYQDPluXHj9qxdxnkgxtOQXzxmOi
         oqAg==
X-Gm-Message-State: AOAM531Y606sUYJ0Vo4XAHQWEEla/gRRPtxSmkEOxuVaeH+5jhLpGTvt
        SHCpL7zEOgV/IzYZ5qQQed3bwQ==
X-Google-Smtp-Source: ABdhPJxZXFIKc0Hpyvb9QsyEzWlj+7cvARDDgRDVOMUjKSMef72YMzDdd7aPCa5VUGK4KiFSR4lhiw==
X-Received: by 2002:a05:600c:2041:: with SMTP id p1mr2664300wmg.15.1603804311670;
        Tue, 27 Oct 2020 06:11:51 -0700 (PDT)
Received: from localhost.localdomain (54.169.185.81.rev.sfr.net. [81.185.169.54])
        by smtp.gmail.com with ESMTPSA id v6sm1780117wmj.6.2020.10.27.06.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:11:50 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     enric.balletbo@collabora.com, Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for mt8167
Date:   Tue, 27 Oct 2020 14:11:21 +0100
Message-Id: <20201027131122.374046-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027131122.374046-1-fparent@baylibre.com>
References: <20201027131122.374046-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the needed board data to support mt8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

This patch depends on the SCPSYS PM domains driver [0].

v2:
	* Implement on top of new SCPSYS PM domains driver [0]

[0] https://patchwork.kernel.org/project/linux-mediatek/list/?series=370737
 drivers/soc/mediatek/mt8167-pm-domains.h | 86 ++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |  5 ++
 drivers/soc/mediatek/mtk-pm-domains.h    |  1 +
 include/linux/soc/mediatek/infracfg.h    |  8 +++
 4 files changed, 100 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8167-pm-domains.h

diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/soc/mediatek/mt8167-pm-domains.h
new file mode 100644
index 000000000000..ff18139d0d6c
--- /dev/null
+++ b/drivers/soc/mediatek/mt8167-pm-domains.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8167_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8167_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mt8167-power.h>
+
+#define MT8167_PWR_STATUS_MFG_2D	BIT(24)
+#define MT8167_PWR_STATUS_MFG_ASYNC	BIT(25)
+
+/*
+ * MT8167 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
+	[MT8167_POWER_DOMAIN_DISP] = {
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MM_EMI |
+					       MT8167_TOP_AXI_PROT_EN_MCU_MM),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8167_POWER_DOMAIN_VDEC] = {
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8167_POWER_DOMAIN_ISP] = {
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8167_POWER_DOMAIN_MFG_ASYNC] = {
+		.sta_mask = MT8167_PWR_STATUS_MFG_ASYNC,
+		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MCU_MFG |
+					       MT8167_TOP_AXI_PROT_EN_MFG_EMI),
+		},
+	},
+	[MT8167_POWER_DOMAIN_MFG_2D] = {
+		.sta_mask = MT8167_PWR_STATUS_MFG_2D,
+		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8167_POWER_DOMAIN_MFG] = {
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8167_POWER_DOMAIN_CONN] = {
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = SPM_CONN_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_CONN_EMI |
+					       MT8167_TOP_AXI_PROT_EN_CONN_MCU |
+					       MT8167_TOP_AXI_PROT_EN_MCU_CONN),
+		},
+	},
+};
+
+static const struct scpsys_soc_data mt8167_scpsys_data = {
+	.domains = scpsys_domain_data_mt8167,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8167),
+	.pwr_sta_offs = SPM_PWR_STATUS,
+	.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+};
+
+#endif /* __SOC_MEDIATEK_MT8167_PM_DOMAINS_H */
+
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 293efa27b6ce..34c704865f01 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -15,6 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/infracfg.h>
 
+#include "mt8167-pm-domains.h"
 #include "mt8173-pm-domains.h"
 #include "mt8183-pm-domains.h"
 #include "mt8192-pm-domains.h"
@@ -515,6 +516,10 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
 }
 
 static const struct of_device_id scpsys_of_match[] = {
+	{
+		.compatible = "mediatek,mt8167-power-controller",
+		.data = &mt8167_scpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt8173-power-controller",
 		.data = &mt8173_scpsys_data,
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index eda453f55126..7c1e1a7209f1 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -14,6 +14,7 @@
 #define SPM_VEN_PWR_CON			0x0230
 #define SPM_ISP_PWR_CON			0x0238
 #define SPM_DIS_PWR_CON			0x023c
+#define SPM_CONN_PWR_CON		0x0280
 #define SPM_VEN2_PWR_CON		0x0298
 #define SPM_AUDIO_PWR_CON		0x029c
 #define SPM_MFG_2D_PWR_CON		0x02c0
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index e7842debc05d..4615a228da51 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -123,6 +123,14 @@
 #define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
 #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
 
+#define MT8167_TOP_AXI_PROT_EN_MM_EMI		BIT(1)
+#define MT8167_TOP_AXI_PROT_EN_MCU_MFG		BIT(2)
+#define MT8167_TOP_AXI_PROT_EN_CONN_EMI		BIT(4)
+#define MT8167_TOP_AXI_PROT_EN_MFG_EMI		BIT(5)
+#define MT8167_TOP_AXI_PROT_EN_CONN_MCU		BIT(8)
+#define MT8167_TOP_AXI_PROT_EN_MCU_CONN		BIT(9)
+#define MT8167_TOP_AXI_PROT_EN_MCU_MM		BIT(11)
+
 #define MT2701_TOP_AXI_PROT_EN_MM_M0		BIT(1)
 #define MT2701_TOP_AXI_PROT_EN_CONN_M		BIT(2)
 #define MT2701_TOP_AXI_PROT_EN_CONN_S		BIT(8)
-- 
2.28.0

