Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEF2EA15C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbhAEAM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhAEAM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:12:57 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EDC0617A2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:11:49 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x18so15423540pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CvqJReQ8p0Q2wrcytP2TtmywERHqcvpbJnQQt8vIrRI=;
        b=ScUimOvRWjQnaVl3XASbOdDlbmovU5P/7tEX4ORdNnIB9j9wH5ytoq2cCDVznY8O30
         eWgD9UXUHHlO9+50t+PPEVX+4CPMTPPcRsOA9d9fy6QHgz6DC0RWtq4zVhuKED0lX97P
         m0r1OSN/9xz2wHbXEElVpx3wFAvjk4kL5TQ5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvqJReQ8p0Q2wrcytP2TtmywERHqcvpbJnQQt8vIrRI=;
        b=YecjKCUYR3TBTzqDeoJoVPo1UkFNXuzjnIbEDMxW7i7cKTWpr1xP6/8MW4kX9Uu5Uw
         JOSGEQ7ALoKCuc+vt7swz5I7g/9bqdzMD8SguKaS2hSDS4BkV71CvHsf9SC0/wVQ0AMe
         QZWh6LMksGXfULNBqj5Etjm4xrRfuCr1B7YFDEMp75vSdiEVZGbbfl02l2DSQKnMjOVd
         bgO8RZP0t1jiiU87o37aLSgUe0cRuFqonbwzD9IsXBABVRobrVT9XPTn0js0aMUes4Wj
         Mff+ye7OyeN+UfiyUgU8vJfFOJ/pNCS4n9Z6nPCgNV/fiCwxOXM5U9IbT9iJYPlSPYIK
         wWvg==
X-Gm-Message-State: AOAM533NF1zh1dFhfltQcIUsNT2r1SUi/8JLMd+HaFDT0+ixlB2mAJFe
        OYxfBFe+fn08f+U4vSknOv7aGA==
X-Google-Smtp-Source: ABdhPJz9/LbtEhIm8FWyQjCxzQx0i1/dDotSyolZEhpKdMauZYRkQLUTKYO5bNPm7nnBtipcZbEHrQ==
X-Received: by 2002:a17:902:8a8d:b029:dc:8ac6:a149 with SMTP id p13-20020a1709028a8db02900dc8ac6a149mr14187800plo.18.1609805508768;
        Mon, 04 Jan 2021 16:11:48 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id bf3sm465620pjb.45.2021.01.04.16.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 16:11:48 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hsinyi@chromium.org, hoegsberg@chromium.org, fshao@chromium.org,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v6 4/4] drm/panfrost: Add mt8183-mali compatible string
Date:   Tue,  5 Jan 2021 08:11:19 +0800
Message-Id: <20210105081111.v6.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210105001119.2129559-1-drinkcat@chromium.org>
References: <20210105001119.2129559-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT8183's G-57 Bifrost.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

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

