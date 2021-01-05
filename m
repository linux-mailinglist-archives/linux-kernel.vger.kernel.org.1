Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5C2EA15A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbhAEAMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbhAEAMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:12:42 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D558C0617A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:11:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id h186so17377482pfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIB6bT25HUqJVnTMzY287Rsm2RovoewYK6tMaHbCshA=;
        b=gc4pGuHXHF8BYV9xB2luMT/mFtJhijVhaJHksLzP4ALZI4HEIjhIVSJfe/byXS8kZk
         IDmoGY1YlDdO744rrChNfBZVA9AO+k0ZArjBEAPyA2/J5PbVhaxh0gIUAuvnE8uDadpg
         th9TfxhxM4rE5Ts7j12KEt0CacR1ihte7rGnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIB6bT25HUqJVnTMzY287Rsm2RovoewYK6tMaHbCshA=;
        b=p5lDkg5RUmSs59uiJZAPGpup3yJaJxEQWzxB6AS2L0u8X8elfl/b91W629mGdwUqUi
         al5Zh2FYTXNRXjMohYtP87FyBhcGb/8GhYjw7lS+NB2kG5Pnm5BAA5n+rikfpMAjS4Ov
         7CK0XB1syTa6ZR2fYOFkOtHqvA9bcoaSEitVAHJp4lfmZSHa+cXcBqahdrMZ/cDrcRit
         G2i2aiw9Y1LD7iW5sE2tmNnwuxNjcXlmO5lPkWavRhL8cPsr/pjMOBqSxmKiVmagoLcK
         0RbuXKikv1bNmDTdFhE3JxdLX3d6/Yu3SDcN0YOKhBjfKck1D+S4hHrXnEo/yDVGqo3v
         istQ==
X-Gm-Message-State: AOAM532Q+0Nudg69CyZ3oMDy51WFRHnDBLmXHOwRw5D9qy0qkswowzZ5
        Fs+QWWgPJAnbevdldiQmuKWu+Q==
X-Google-Smtp-Source: ABdhPJygn8Trt4FhsEdC6+CrgPKLQYPFisrwJtf18NFu2Rgv3PBFRPJheJ+dCwDpD/J/+cTTNCiS4w==
X-Received: by 2002:a63:af50:: with SMTP id s16mr74141717pgo.448.1609805505588;
        Mon, 04 Jan 2021 16:11:45 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id bf3sm465620pjb.45.2021.01.04.16.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 16:11:45 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hsinyi@chromium.org, hoegsberg@chromium.org, fshao@chromium.org,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
Date:   Tue,  5 Jan 2021 08:11:18 +0800
Message-Id: <20210105081111.v6.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210105001119.2129559-1-drinkcat@chromium.org>
References: <20210105001119.2129559-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPUs with more than a single regulator (e.g. G-57 on MT8183) will
require platform-specific handling, disable devfreq for now.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes in v6:
 - New change

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index f44d28fad085..1f49043aae73 100644
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
+		DRM_DEV_ERROR(dev, "More than 1 supply is not supported yet\n");
+		return 0;
+	}
+
 	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
 					      pfdev->comp->num_supplies);
 	if (IS_ERR(opp_table)) {
-- 
2.29.2.729.g45daf8777d-goog

