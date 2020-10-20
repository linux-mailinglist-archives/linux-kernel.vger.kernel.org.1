Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB72941A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437263AbgJTRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437225AbgJTRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:43:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA01C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n18so3225653wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUKyzhSGhUR/Bwwd5x38HZWQ53tYZ5QssSwc3z6VJCg=;
        b=WnvZJskixl0tYxIjUvfdGfd3sQFS/qQ7mBwPCXEslhPAIP8Mf53G5brThLZkuzn0PQ
         +N5GMsL02ari+rbsuqrlf032XTeg8kuwW3GwGPH1d4tNoXxfMqJ2Zez9pn/tIx2U1z/9
         jaenEiZWJsAmrEMpVm6IxMNe0N3rFNPM0qxiMdEG+GuZHrKd03khMy+vPcRYWJL3gsE2
         Ltm4+juqIRNNziZDNWoMPqgkpInngwFBFbdB+u6m3CDOXjQr9UWQciRtoA844ZGOAemA
         TswLIGcpSC7erqVAnCrGGIjwmnkplMMEYZOCkGEhCFQ2ukKKR72z5EmSwl4aLfH1dsS0
         /I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUKyzhSGhUR/Bwwd5x38HZWQ53tYZ5QssSwc3z6VJCg=;
        b=hpRRJNbJazam9o8Y9jzlNjaGFm8YbMZ2iTjGFA17qHuFJy1nWd9q3GKXJewOijK3um
         qURUo9MJBJqWTpBkRzl+dWMHG09qYbYURU5TOwxegYMHwIdA4ZqVWct7jCHO5u0TtDeQ
         GfOqbxAOhK62/zfpiNWu87P0sMiH5wmUds7OJAqysPUbj9cvcSVA7jrqW/Nmp3itvTOX
         N9Gdb3C0HqOfYXahDbkDN2xxNRh/vGmNJ5q38xfuuzVSV8LT3S42coXXJBgc17oHG59c
         e+QQfmN++Y8E5OeiUCvqasSHixfCdwvQJgEooQRrg1lHRfJGp9nIdCZxqkOwFbReU+Hb
         0dCg==
X-Gm-Message-State: AOAM533SiriOeAscOYb3M0uYZ+tYTd9aUpU8RryG0XhUXev9m164ZrUZ
        xZ7dK0Hc6fdocNC7Lc/SPbj3/A==
X-Google-Smtp-Source: ABdhPJylIT9S52zEh0LE5r5mbFdXBQ69vOLAAksKF1Kpq3OlZP0kKeEVshgGZzd/uO0H63x7NnFyfg==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr4614953wrv.140.1603215787049;
        Tue, 20 Oct 2020 10:43:07 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:43:06 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 6/8] drm/mediatek: dsi: add support for MT8167 SoC
Date:   Tue, 20 Oct 2020 19:42:51 +0200
Message-Id: <20201020174253.3757771-7-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020174253.3757771-1-fparent@baylibre.com>
References: <20201020174253.3757771-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform data to support the MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 08786734df8e..d90dd0f83292 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1182,6 +1182,11 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_dsi_driver_data mt8167_dsi_driver_data = {
+	.reg_cmdq_off = 0x180,
+	.use_hs_on_power_on = true,
+};
+
 static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
 	.reg_cmdq_off = 0x200,
 };
@@ -1199,6 +1204,8 @@ static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
 static const struct of_device_id mtk_dsi_of_match[] = {
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = &mt2701_dsi_driver_data },
+	{ .compatible = "mediatek,mt8167-dsi",
+	  .data = &mt8167_dsi_driver_data },
 	{ .compatible = "mediatek,mt8173-dsi",
 	  .data = &mt8173_dsi_driver_data },
 	{ .compatible = "mediatek,mt8183-dsi",
-- 
2.28.0

