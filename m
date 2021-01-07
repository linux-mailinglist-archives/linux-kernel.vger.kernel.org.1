Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF63F2ECBBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbhAGI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbhAGI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:28:24 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A089C0612FD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:27:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s15so3102847plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIbF8BOOybLHCWqc59wyJcsKEyaAhWuDenEcPQgxfZw=;
        b=jPrpFaAFvjw0X3873nZRiJppA7K+apkFmzHYJFTLuOQQVtLD6sNRbqaBiB5wL3znBJ
         zJzETNk9SJXaNmp11Y2MseJeYUfhrYq5EGys10eRmqi10e3SWtTT+8qokmyqAfp9J7QM
         i7e1hxp54snaPlEMbXV4Q/uoAG4RTKA4Rdnfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIbF8BOOybLHCWqc59wyJcsKEyaAhWuDenEcPQgxfZw=;
        b=inDgUNF0GVLl6wUhKwEsfL1TkMcy3bY3NaDfOB90gL92UhCnRyz1kMKLvIB+6M6RW/
         lUcdafqyXc1xF2/b/AOVGkM69mr6jwwb6Y71ox6PBb/sXD/IJniJBYMtMx5Dc9lHh8Uu
         rtQxmwq7eOB+UyC2YlhmNLGUvNYUPcPZ0kfR+mJamRNtUZyzTS/o+SmgvKrua8dECCmu
         pstC0z5NrV2a6qdg2eaOhJlzIT/EexKkI/avxnr0r9x5TW84+rlR0lPf73SN9ZcmNgWU
         iIdwPM7FWGFhhdi2M96OOrou6BKe2CMeIp0jFYmP46clXbPebRh2AqJvIswT4olVW+k2
         bing==
X-Gm-Message-State: AOAM53041B9Smr9oYH9EKK5zM4LkXAOJ65jz3nALSV06fpmZQmwkARrj
        wJb++U7ukpQHyo24UlyfwMQQaQ==
X-Google-Smtp-Source: ABdhPJyP8/q5fNmHRDDhrkqPcpwWJP45UJ+SYR315cmXNF5eQCklwIZpeLN0+OjxEfF5KqzuCgO9wQ==
X-Received: by 2002:a17:902:8d82:b029:dc:20b8:3c19 with SMTP id v2-20020a1709028d82b02900dc20b83c19mr8080091plo.29.1610008036066;
        Thu, 07 Jan 2021 00:27:16 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id o14sm5825580pgr.44.2021.01.07.00.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 00:27:15 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hoegsberg@chromium.org, fshao@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v7 4/4] drm/panfrost: Add mt8183-mali compatible string
Date:   Thu,  7 Jan 2021 16:26:53 +0800
Message-Id: <20210107162632.v7.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107082653.3519337-1-drinkcat@chromium.org>
References: <20210107082653.3519337-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT8183's G72 Bifrost.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

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
2.29.2.729.g45daf8777d-goog

