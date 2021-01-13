Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AFC2F446B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAMGI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbhAMGI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:08:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C43C0617A3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m5so490620pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCU+PqhEWezTw2ZPt5auPvzhMgYd3zUnYvcsCAHOrFc=;
        b=RZo9hecfkmLCLrEAA+Esn1wktnCUuPVVGhDxzfEa+8Qa42oumC92OA/IkdU+uLVHtF
         PMfpzDOLNhXeiSUEDjbm05XF66wNVArDODjg0Eul9orRoTHkbrhjkn6NKaOdNaEZnhLI
         SEyBqasonHJqnqjWaARq4/drtPKUyILGKBMw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCU+PqhEWezTw2ZPt5auPvzhMgYd3zUnYvcsCAHOrFc=;
        b=mcOAnb6aDEudlwMk2OZtcylJTt2Qc/ZdUvtXrvi2NNxUqkndS904t1oFlJWqpQfNSp
         f4GelEQV/VzyBNPGt4C8KFTkVFwUySZ9/psy20Gql5HYaHR6sXyt0AP523klCItey6t9
         BbUpzTDOuiIIqeP6ZkUBK9cZ5I/KvtKprALQQFbrr0m4PbISMJ8Z4DZnX0XqQVTHS8h/
         MsIDZ0Xbr6hxTCbtcZt9rs4Sez5P+qeI83POQFln/dAjQUk16EQ1jaf6qocSr1M3g/YU
         q+eswBAXvOXBnvATrNgjVgCOV8E5Hv+UDj9kKfHFsnHosHXAGId04hH+QaQeiPBX066k
         5NeQ==
X-Gm-Message-State: AOAM531Ek+77YpXPegzsIzVfMpSkdtvj6AbufeDEOTtkOo0Zo8+sTH3e
        uPEwbjNGsIeFm1AsBvHnhQZfwg==
X-Google-Smtp-Source: ABdhPJxWa7zfR5BtclGM1k98qcWG8hY8CikWMIJLdiAdmFTAInCRR/4YlpS0XoVJZbdC3XMMjgnIZQ==
X-Received: by 2002:a17:90a:fc97:: with SMTP id ci23mr543919pjb.83.1610518068204;
        Tue, 12 Jan 2021 22:07:48 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id y21sm1263556pfr.90.2021.01.12.22.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:07:47 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        boris.brezillon@collabora.com, hsinyi@chromium.org,
        hoegsberg@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/4] drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
Date:   Wed, 13 Jan 2021 14:07:02 +0800
Message-Id: <20210113140546.v10.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210113060703.3122661-1-drinkcat@chromium.org>
References: <20210113060703.3122661-1-drinkcat@chromium.org>
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
---

(no changes since v9)

Changes in v9:
 - Explain why devfreq needs to be disabled for GPUs with >1
   regulators.

Changes in v8:
 - Use DRM_DEV_INFO instead of ERROR

Changes in v7:
 - Fix GPU ID in commit message

Changes in v6:
 - New change

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index f44d28fad085..812cfecdee3b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -92,6 +92,15 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
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
2.30.0.284.gd98b1dd5eaa7-goog

