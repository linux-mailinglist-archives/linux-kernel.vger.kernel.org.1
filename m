Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4255B2ECBBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAGI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbhAGI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:28:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF4C0612FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:27:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r4so3100067pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VG/JPHW1nyFJkWn3hxAWpxYTfHmRQhs7/jRSVGbcaCA=;
        b=YIclqMxRK17U0P0NMoxt/Z+WcW8XzzwtBVqX3gpcdgcnk3PTRBRPCTIvlFvzEKpYp5
         Gd43oJi+5M80ZT4X294OjTsmF3bM+v/S1WbhjoM8ymRkIHhlCCuM2uYeBKkrm+0aIYPD
         YKHL4xwlkSOagLE+JAzWlowpI6jgQX1x7aFgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VG/JPHW1nyFJkWn3hxAWpxYTfHmRQhs7/jRSVGbcaCA=;
        b=hk69Tal0nDQG63S/csKO1YB/nlkRsZeeCVZt08hr4h6ODv6Fhe0VCa30YXfsJPfaFf
         Hn459gOx1tnXwS1tDs4D2X3US88B/6RzYufxm7sIOwGA7yA02bBIpeCUWm48xqHIyqci
         FQRQyGIrXJLtnULd3/Ml9L+X9fb+VLz1UdA0B4SzI6y2kZy/r0RUno+sHcyCsJxRRkLP
         HBB7BodnRE/zG2cLxv0N+J4Tkcykxvk5MWs/tOMxfBFSjIDrb4F8BJ2f7y3jcy89Q13X
         WdfEntxCKdkFon41gJizYFkgEL1PHrnDOi1n3+DWjleH6GkCntemkLRjk79UA4Yeg9SS
         SYYg==
X-Gm-Message-State: AOAM530kl+Y5tVJb4qVniQ7ps+RNMkx3sY70SasHZtXx/r7BZXDk6y59
        xKLWJ38Zl4RIiCDjMcRCeN8HxA==
X-Google-Smtp-Source: ABdhPJyxZnXxHUFuIui/rSg6OnuKbTGgDktbellBSXe/r4uAs+7zkOfP9EmPNCE0+2p1EBEit0h7eA==
X-Received: by 2002:a17:902:7e85:b029:da:72a2:de1 with SMTP id z5-20020a1709027e85b02900da72a20de1mr8145955pla.57.1610008032888;
        Thu, 07 Jan 2021 00:27:12 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id o14sm5825580pgr.44.2021.01.07.00.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 00:27:12 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hoegsberg@chromium.org, fshao@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
Date:   Thu,  7 Jan 2021 16:26:52 +0800
Message-Id: <20210107162632.v7.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107082653.3519337-1-drinkcat@chromium.org>
References: <20210107082653.3519337-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPUs with more than a single regulator (e.g. G72 on MT8183) will
require platform-specific handling, disable devfreq for now.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes in v7:
 - Fix GPU ID in commit message

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

