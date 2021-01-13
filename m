Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9C2F446C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbhAMGI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbhAMGI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:08:57 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92EFC0617A4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:51 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so810598pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8oDQSUPDPIZ8NaaCZ5DAZUEBj1ULsJVWJe4P257n4A=;
        b=A7Kyq5kC/V5KEnMvYnWznp8obfbZFNz7Q75x+j9cybVRIEJVj8RRvtYgkvCdfkj4nU
         521LMeZBAl85703xY6xQhxoKkgW+wH62+4FyLws2+coNUH92ka0w496chxiqiDpKS29h
         gSUHmfnYX3KpR3Ojyj/Ngd9/Sg8z5kcl8xH7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8oDQSUPDPIZ8NaaCZ5DAZUEBj1ULsJVWJe4P257n4A=;
        b=bHrOaxRKfn5OIi890T35hu/7DwP1Fx0DgBFdRAsXZCwF5f74iZkbrdjJlWAUretGc+
         FLQ3O9/SwhrkPZdafS7/b76MOV9t3zW6400q1cPC/laom7hG/6hW+i7FibsyRmLVBzfQ
         w8Xu70oo3fpTv6UclV4f3rMuE1skECEyy8JNHI3JhoKlpvBkExqLTJ3RXH2Y8D/1wL7q
         V6wKHfMWpNUbfsiIPHCBueQr0Q+zNHYLJVvs4wQnujEtrCVdH9OSrwF/ztZdPUhKTk/C
         1khxtxau8/Odmqrg+vzdPqqYkgIn5WFA1Tmk7VpwQKmntca1nykNRI0TvWj1jidOUeOQ
         QlGQ==
X-Gm-Message-State: AOAM531WE2u9KGcM31txxDLb5/F/nSnrS1S9zOhr5zXFJs03AsnEdv//
        4pLpAgTKk4wy/Z4583gRPDNu29St+KPFVA==
X-Google-Smtp-Source: ABdhPJxpSKoqoT7Wv4sRg+G/uwEEec2IxAJzJ0Qjx6lnTAm6pNTO31P7Hpdv227om5lIq3s+h6RCWg==
X-Received: by 2002:a63:34d:: with SMTP id 74mr619389pgd.388.1610518071493;
        Tue, 12 Jan 2021 22:07:51 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id y21sm1263556pfr.90.2021.01.12.22.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:07:50 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        boris.brezillon@collabora.com, hsinyi@chromium.org,
        hoegsberg@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v10 4/4] drm/panfrost: Add mt8183-mali compatible string
Date:   Wed, 13 Jan 2021 14:07:03 +0800
Message-Id: <20210113140546.v10.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210113060703.3122661-1-drinkcat@chromium.org>
References: <20210113060703.3122661-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT8183's G72 Bifrost.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

(no changes since v7)

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
2.30.0.284.gd98b1dd5eaa7-goog

