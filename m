Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2288303A42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404082AbhAZK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbhAZBeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:34:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54962C0698C4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:18:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y205so9453309pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ls++7dy/D+OE/0mAqQ1jphnKDBawhWOPw5Hl68YzZ1w=;
        b=Cyi9mPit6QVOeNbwYj3sYqdYucTQltoS+LZ51/lagZE5y/+WXbGIT5fEwOAmwfoFcn
         9aVCh0beghqO+EFoeugRybVafeOjbOb6HZ4PnWXuGgclgUDiXO8LirlTY4YqdyOCG64o
         YnRilRHSE1dRWvETlj2hoEg3v+LRQ9kMIFPps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ls++7dy/D+OE/0mAqQ1jphnKDBawhWOPw5Hl68YzZ1w=;
        b=ZRa2oSJYVtuNZmBwxFF1H48iv7VTXiuMG59SpmxVDhyVUC1SZmV29bqSR2lPabX8Et
         4oOJHNe2w/BMdQOTwcqcVTg1VYpwvnatXdahhTvP5Ilk1YuzT0u3mw89z1Y8b0oNNn3V
         bEcJPHcsz0GQ0ZYltzmRcNNUpxarpcdx7LtYAuOt0f3LvG/QhHGcf+0nBWOusPk7G9hV
         dTFYhpO1YKLbD3Xab+dVs6dE6ze+GpvqJvL/r/NxmAvJpngpYBv1LFVmLhuADheVVVYC
         M1ayI+x18x9euZ2mbPEcyVb9J/TyzCl6xW4V6PxN7jC0DDUze2yQqjoockgIoErW5hQJ
         3zgQ==
X-Gm-Message-State: AOAM531RhhhxcRc/wHWRL4LRAHRnBtbnDnxqXV23a5vaAGsA87jxJB7p
        m3M0YdrmoXLS4Rg/RnzfB7gJ5g==
X-Google-Smtp-Source: ABdhPJzOy5uWtFIJjmtZn2uW8/3d8qaf1wHw+YrW+ZAtYsAizlSsy77+L1pukRlfkj/rhZPJKA/AOg==
X-Received: by 2002:aa7:829a:0:b029:1c1:1a3f:db25 with SMTP id s26-20020aa7829a0000b02901c11a3fdb25mr2821915pfm.60.1611623899866;
        Mon, 25 Jan 2021 17:18:19 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:50cc:9282:4fdd:3979])
        by smtp.gmail.com with ESMTPSA id k9sm522248pji.8.2021.01.25.17.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:18:19 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        hoegsberg@chromium.org, boris.brezillon@collabora.com,
        hsinyi@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/4] drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
Date:   Tue, 26 Jan 2021 09:17:58 +0800
Message-Id: <20210126091747.v11.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126011759.1605641-1-drinkcat@chromium.org>
References: <20210126011759.1605641-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPUs with more than a single regulator (e.g. G72 on MT8183) will
require platform-specific handling for devfreq, for 2 reasons:
 1. The opp core (drivers/opp/core.c:_generic_set_opp_regulator)
    does not support multiple regulators, so we'll need custom
    handlers.
 2. Generally, platforms with 2 regulators have platform-specific
    constraints on how the voltages should be set (e.g.
    minimum/maximum voltage difference between them), so we
    should not just create generic handlers that simply
    change the voltages without taking care of those constraints.

Disable devfreq for now on those GPUs.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---

Changes in v11: None
Changes in v10: None
Changes in v9:
 - Explain why devfreq needs to be disabled for GPUs with >1
   regulators.

Changes in v8:
 - Use DRM_DEV_INFO instead of ERROR

Changes in v7:
 - Fix GPU ID in commit message

Changes in v6:
 - devfreq: New change

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 7c5ffc81dce1..a544ae1e560a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -93,6 +93,15 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
+	if (pfdev->comp->num_supplies > 1) {
+		/*
+		 * GPUs with more than 1 supply require platform-specific handling:
+		 * continue without devfreq
+		 */
+		DRM_DEV_INFO(dev, "More than 1 supply is not supported yet\n");
+		return 0;
+	}
+
 	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
 					      pfdev->comp->num_supplies);
 	if (IS_ERR(opp_table)) {
-- 
2.30.0.280.ga3ce27912f-goog

