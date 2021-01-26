Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73271303A34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbhAZK1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbhAZBbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:31:25 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D19C0698C5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:18:23 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q2so5997195plk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cW8krSz9Suh27i3kFLRH+rKbVyIy/nSf3JAVtiB3NGg=;
        b=OMcAX8e+LPP25ZJuWYYSgfhNFgcP++z9OXPz3H76Ovwj4lxCkaDbAt80h+rthknDrq
         iJuS3q9mOu9ltZ1mqU9i7psDGke7EPWs5StZWbYFBwnQdv6EuQAYuIrrSMk00/dCcYP8
         TXAomikkDj+f0/yxJkFL1lBn852p9TZcaJI+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cW8krSz9Suh27i3kFLRH+rKbVyIy/nSf3JAVtiB3NGg=;
        b=aR3U6kRcEh2+uJYLBFVqrnxjqzQRSSYc6NfOZ6hAoD38keIkOs8U5RWEA0rnhSF5ud
         V0AWu7BrUy5GLTVegjSYaq2psc881z/wBeD01lxK9Xyvr/425uV9dD3bxPNxfrzz6RcU
         SWMsHHU2sSDFCmXRnyvhWT3taNqnFl8tFBqVbQwUPPG9XfxzRqkA69OVKCDpQCX2TlPN
         eIQnlo8qi0ajnNAilzj9jKPc8NXUof6ay3yyuEsAr9+t5xrMdPZGlzROV+rRK+5RHzhB
         bLlb7dVBFxlBgwt1+wIzejf9mZ1ia5zYQwJePWgBerNzIpy49rCmEGMDonv2wkRywob3
         ZsxQ==
X-Gm-Message-State: AOAM531kmWmAGC1AUbdADMwDmiSnZ3QSUdI1P63fj0bYuPcwNC1s/mli
        MIxJl7Pdjg/Nwf2jXyt3OXg5kg==
X-Google-Smtp-Source: ABdhPJz1KwRDKhFH1+4vA/V0bCaojV/wBSjNoY/yJR26q15uQ6o7lk+MBQ0LDf1TE+A2gIPGNnJuTg==
X-Received: by 2002:a17:902:bccc:b029:de:8483:506d with SMTP id o12-20020a170902bcccb02900de8483506dmr3201535pls.53.1611623903115;
        Mon, 25 Jan 2021 17:18:23 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:50cc:9282:4fdd:3979])
        by smtp.gmail.com with ESMTPSA id k9sm522248pji.8.2021.01.25.17.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:18:22 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        hoegsberg@chromium.org, boris.brezillon@collabora.com,
        hsinyi@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v11 4/4] drm/panfrost: Add mt8183-mali compatible string
Date:   Tue, 26 Jan 2021 09:17:59 +0800
Message-Id: <20210126091747.v11.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126011759.1605641-1-drinkcat@chromium.org>
References: <20210126011759.1605641-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT8183's G72 Bifrost.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---

Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7:
 - Fix GPU ID in commit message

Changes in v6:
 - Context conflicts, reflow the code.
 - Use ARRAY_SIZE for power domains too.

Changes in v5:
 - Change power domain name from 2d to core2.

Changes in v4:
 - Add power domain names.

Changes in v3:
 - Match mt8183-mali instead of bifrost, as we require special
   handling for the 2 regulators and 3 power domains.

Changes in v2: None

 drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 83a461bdeea8..ca07098a6141 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -665,6 +665,15 @@ static const struct panfrost_compatible amlogic_data = {
 	.vendor_quirk = panfrost_gpu_amlogic_quirk,
 };
 
+const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
+const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
+static const struct panfrost_compatible mediatek_mt8183_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
+	.supply_names = mediatek_mt8183_supplies,
+	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
+	.pm_domain_names = mediatek_mt8183_pm_domains,
+};
+
 static const struct of_device_id dt_match[] = {
 	/* Set first to probe before the generic compatibles */
 	{ .compatible = "amlogic,meson-gxm-mali",
@@ -681,6 +690,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t860", .data = &default_data, },
 	{ .compatible = "arm,mali-t880", .data = &default_data, },
 	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
+	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.30.0.280.ga3ce27912f-goog

