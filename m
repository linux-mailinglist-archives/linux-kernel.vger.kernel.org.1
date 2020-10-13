Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B428D386
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgJMSTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgJMSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:19:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5548C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:19:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so487059wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtmadPtoPcokiIT8ReATg1pXkhzL2SuRBo5LddIMSVk=;
        b=XaJ/M1ab0sb3wmangM5YA2nqcNI4cEEK4J6J89RdjZa7KK4sbY6rvX6VV/uDqCY7eO
         BprKBVKFXAG30XVHwS7YwvDUaWfw0dXOKYgetZjYxpT/n+Ia5D7O55KZihuxApT5Pyki
         sbzNbcI3uvDJ1ZBR/KYTICZUnQS/SlRcHS2ZEM/N2HSx665DzSjuHKS7vc8cWnrAYct8
         SbiI2gfLvKdP5sLgqQkcgjoxbuFtBm2XSjhdOeuz/kSJa1/HQIiF84fRT+s+N35dz+dn
         Bl/jOSnjWmGuofs/y0yw1TpV3mHyL/6vgt+zExdqElnlh3fGLf8nFLMl9Vf6SuTYbn3h
         SIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtmadPtoPcokiIT8ReATg1pXkhzL2SuRBo5LddIMSVk=;
        b=FuZTgCLUwR74b5NGZT7Z8+H/47wWVplAaZAipcGi7Xd/cFCl+hPsKq2f9uLfTpQtrS
         eCI3D5y8spuxoKi75ToBpRkv/8WQBIq0BVWZvaCPDvl7aa0rC2TWW3ykP5MexNNXE6zv
         QalcbZDrzZqbf/QH3wiKqX8rARua5NSqo4CziL5b5Wn8HPl/JGjElTyxkyEoblMYAvfa
         ku7XyEbUo77v5AmEW6X/uSBVf3pZFtXeqKrA2wtOGOT1qtdU5hcURwSugsa/Ffj4/GEa
         NUzoRyJBEgzUCX8SkvlqJyGhV9tKPORhEppPQQ7dtk+AARkDIxH+w4T0O05CqXZhRLEJ
         oPSw==
X-Gm-Message-State: AOAM533OSVJ8WAWmHNN3x2BayFhzHknV0qA0q8l8J4/AtzyRClGvmEb9
        NsQFJ7+NgDRD4FbF7UaPXiaFoyhbL3n/GHe5
X-Google-Smtp-Source: ABdhPJyYKFgxPBtvreY/bLMuxhTn3K88Do7E39RQO4MJweOu72cwzI7cuyOtwYsoYixEPS6WFk3dGg==
X-Received: by 2002:adf:8541:: with SMTP id 59mr1042100wrh.61.1602613177428;
        Tue, 13 Oct 2020 11:19:37 -0700 (PDT)
Received: from localhost.localdomain (26.165.185.81.rev.sfr.net. [81.185.165.26])
        by smtp.gmail.com with ESMTPSA id w11sm490261wrs.26.2020.10.13.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 11:19:36 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 2/2] drm/mediatek: mtk_hdmi: add MT8167 support for HDMI
Date:   Tue, 13 Oct 2020 20:19:24 +0200
Message-Id: <20201013181924.4143303-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013181924.4143303-1-fparent@baylibre.com>
References: <20201013181924.4143303-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDMI on MT8167. HDMI on MT8167 is similar to
MT8173/MT2701 execpt for the two registers: SYS_CFG1C and SYS_CFG20

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

Changelog:
v2: fix name of pdata structure

 drivers/gpu/drm/mediatek/mtk_hdmi.c      | 7 +++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_regs.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 57370c036497..484ea9cd654a 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1835,9 +1835,16 @@ static struct mtk_hdmi_data mt8173_hdmi_driver_data = {
 	.sys_cfg20 = HDMI_SYS_CFG20,
 };
 
+static struct mtk_hdmi_data mt8167_hdmi_driver_data = {
+	.sys_cfg1c = MT8167_HDMI_SYS_CFG1C,
+	.sys_cfg20 = MT8167_HDMI_SYS_CFG20,
+};
+
 static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-hdmi",
 	  .data = &mt8173_hdmi_driver_data },
+	{ .compatible = "mediatek,mt8167-hdmi",
+	  .data = &mt8167_hdmi_driver_data },
 	{}
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
index 2050ba45b23a..a0f9c367d7aa 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
@@ -195,6 +195,7 @@
 #define GEN_RGB				(0 << 7)
 
 #define HDMI_SYS_CFG1C		0x000
+#define MT8167_HDMI_SYS_CFG1C	0x800
 #define HDMI_ON				BIT(0)
 #define HDMI_RST			BIT(1)
 #define ANLG_ON				BIT(2)
@@ -211,6 +212,7 @@
 #define HTPLG_PIN_SEL_OFF		BIT(30)
 #define AES_EFUSE_ENABLE		BIT(31)
 #define HDMI_SYS_CFG20		0x004
+#define MT8167_HDMI_SYS_CFG20	0x804
 #define DEEP_COLOR_MODE_MASK		(3 << 1)
 #define COLOR_8BIT_MODE			(0 << 1)
 #define COLOR_10BIT_MODE		(1 << 1)
-- 
2.28.0

