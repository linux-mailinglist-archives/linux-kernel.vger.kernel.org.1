Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8F2EEAC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbhAHBLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbhAHBLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:11:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69CEC0612FD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:10:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j1so4814821pld.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Btr4GziZmSmF1Ub4qnq0SpstKPt2/2jleo6UAXy0j/A=;
        b=LOrd8IItXrtGowbDtoko3gWePPveGgoW5WaUJsm8w7E/QxLaVTqiviDlUa9zgRHnT/
         BDHmUwQBWPgo5pbofbVmc7kQF3yNI/G1aQy1cIwSfO+Fs5ZXVA2o7ng+YUEmm+ohkv8Q
         GnMG6BqZHHDUGYG+i2/5MOPE0acEdP+msOn1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Btr4GziZmSmF1Ub4qnq0SpstKPt2/2jleo6UAXy0j/A=;
        b=lXxq+3GRQqaGWFs/4Qv4q6Kb9YvhuyhUHXYJ8sGZoPz4fH/jai57W2HbewnCQBQLtV
         fjgqbqUq1HXKLpuzeq0mIGBvQPpWvbC7Dsrygga4J5YSAV/N2ux0wt4vw/shvhdXRPGZ
         5OriRwOWjlMxQcY2rRcf/s5XwE+29kBzkwbJok3OS6lJVXA3MsnTc+yOaCRO5HBS5w0B
         Nnx7IwsRENHDjh+1fpb5qqd7WaEe0gID0F8bNYmpKvthjNukTSmadCifDrV3uF1+zLs8
         OIJyoWO6VEYucWkzGPi5dnzfBrv1aAFRJfo5VsHIO1lEosqeVVNlxce4VMh1KRAKyOcN
         zIFA==
X-Gm-Message-State: AOAM532mQTmORBviFsOSFc3iGK6ODlvOltj7JzubwzdMJhxPv40/Egmk
        ApjlTTo8+6hliagQsZhpdXyrlQ==
X-Google-Smtp-Source: ABdhPJy8e1bhkVfYjTqYbpVkR/sIKL1iQSv/8jv8VQGzrgxJMKUQYZHjSXSKG1eGTP2lXsoOnN4Cjw==
X-Received: by 2002:a17:90a:bf05:: with SMTP id c5mr1099131pjs.95.1610068227384;
        Thu, 07 Jan 2021 17:10:27 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id s1sm6400083pfb.103.2021.01.07.17.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:10:26 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, hoegsberg@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/4] drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
Date:   Fri,  8 Jan 2021 09:10:10 +0800
Message-Id: <20210108091005.v9.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210108011011.4061575-1-drinkcat@chromium.org>
References: <20210108011011.4061575-1-drinkcat@chromium.org>
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
2.29.2.729.g45daf8777d-goog

