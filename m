Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556F828D31D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgJMR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgJMR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:28:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEF8C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:28:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so267811wrl.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlvyC7xO8X+UHJiYhKqKJwROYowmoGRyG38cye9lek4=;
        b=D0TVrEykWlhUm/bhD8ZKE0gqYKXdhzaQPwZnWz2KAvB+bJoSW4qWFnIWLlwPD8HqCV
         07pjsS3ciagYi1TM74PzjqWI/LHA8n4Vmq2SVyVa3BLpXuDL+71kspidJi2ih8Qk1Nnx
         vV5/69FEsmRN85s9O9nXCt/zXoXMfuQYZHQDRYM2h1kdc8BVhudtr40OxORl1pVWBHdo
         Jz8N/i+sFqoHRircz4tWcKo4vXBbCZcpxY3+0byc28QSDoxEqtzXWJaA2Do1uYYWNGks
         6rkMAECv++08P5bTNC6qU3aVYzM2+NnF2RC2mWfhlX1oFGVsit5GA6/PTwhZRBfMi+Jg
         EFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlvyC7xO8X+UHJiYhKqKJwROYowmoGRyG38cye9lek4=;
        b=FUjsa2sagxjGN+P2WSHJ4Q+vXC1YzIJ3m8EA84bz+tMaFt0QGnWUlz3NhXhw8BpHwJ
         vjM+Q56G/mfm2eS9EHkXSiGmJO5MdS9n0bJ3eHK/xFBAsPclml59IoyRBDDDDM8NnKUf
         y0tvLNznI5tTElfe945dDa8LXl7mrpC9+klHE4R0f1NVuBEmNwDcm/i4m+2gah7dPt0w
         +wxteZcV84IAQa9i1tvngviwy2i5t7chhGP+Fw9GplHufgaaU3j45NBH0PBBu2ZbxkiK
         uCufq/MBl1XS3jy3i9tkHtBljveHBSZMPSpvdXn91uWHrU8kw2daJrDw0/tNmfG97inX
         HL5Q==
X-Gm-Message-State: AOAM531tuRhq02p9wB3wFxHG5JipCDmsbTpbLr3twzmcfWBi3PmR4p4N
        PsbgDtj1hK7gHxLYDHRkXOKhfSqRVH+bz4F4
X-Google-Smtp-Source: ABdhPJyqabbY0J2ewYDvY5SXI4bIKi5qYlD68/sg3m435CHU1JYk/TdfVENPchAt/0NsWUmXwDj2Xg==
X-Received: by 2002:adf:80e4:: with SMTP id 91mr795643wrl.223.1602610120882;
        Tue, 13 Oct 2020 10:28:40 -0700 (PDT)
Received: from localhost.localdomain (26.165.185.81.rev.sfr.net. [81.185.165.26])
        by smtp.gmail.com with ESMTPSA id c14sm315131wrv.12.2020.10.13.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 10:28:40 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] drm/mediatek: mtk_hdmi: add MT8167 support for HDMI
Date:   Tue, 13 Oct 2020 19:28:32 +0200
Message-Id: <20201013172832.4055545-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013172832.4055545-1-fparent@baylibre.com>
References: <20201013172832.4055545-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDMI on MT8167. HDMI on MT8167 is similar to
MT8173/MT2701 execpt for the two registers: SYS_CFG1C and SYS_CFG20

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c      | 7 +++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_regs.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index c70f195c21be..7762be5cb446 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1835,9 +1835,16 @@ static struct mtk_hdmi_data mt8173_hdmi_driver_data = {
 	.sys_cfg20 = HDMI_SYS_CFG20,
 };
 
+static struct mtk_hdmi_conf mt8167_hdmi_driver_data = {
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

