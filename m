Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9A521A1AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGIODa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgGIOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5736C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so1931330wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WimOihJEoGFrQflh5MG/QpMyDue9zSaiyBZVUVInhdA=;
        b=IFuRYrT9MaZwOKEyAiA8UmCjLbteJEHlXzsg6EmBXUBXYZdYR4TCSFCIiwFoDLwW4V
         kKN4JyGC4Y/LUEDf3R8qoxR80n6dYuHWy2QDiIvTQlw/el77Qyk6/Q0A7GqlllsGRcuM
         yrvEfFfa2SQTDfTcGXnn/sAo4DSrDmeVP4JXO9oHoQ2KTGo4LrPBge9+4ODXfN+9G+IO
         udYNxGREOwpxc+cTZn2/hduYfr902zz0cQPIDeL1OPLcXc1QFpYSEBkJGv+GbzczMhmG
         tp1l6fn2ALtuqpfgAa9hYZb/LU96+7ty4dGEARmjAlgWDS6+Vmn47g6jKf55SqQzFkFN
         eR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WimOihJEoGFrQflh5MG/QpMyDue9zSaiyBZVUVInhdA=;
        b=qVxP5zkFu3fm2tZevLDRHeiL/scnBamnoO1vEWRwfoa7fxOW+/N139VlRc2lIQrXwC
         NsyYHXV8pINTU9gpEqIY2gH7fBMsja0nhKCCu1fB1/0eK1vITm+JPMXhErT+oUSZcDzP
         KgDFIuBGCymDfo0dkmqBxQZn+0NywioTH2i20kSpOXF3ZcR2eLXLUcryF35hwpbfNNJs
         XSixzmHPacIfniH8OVeJVVJck3yomjjyEwoTF/NWQiltgUxe72lqZdzxb6T4w/XabIa1
         mBMOYD1yZpd60UYopTKaibrMvxQ8AH4hDiFQgVW9Gn27gBYKEGVOgQ03//E70YYoVl1c
         3Y9Q==
X-Gm-Message-State: AOAM531CNXXA5BwNoPZAqeDlW43m9IokCZDH/GjHJqWP81MGfrj/LbjM
        QQrSgF8GXwjCQwPg1hvN+OQ=
X-Google-Smtp-Source: ABdhPJzAoqdWs8PVIGAYlZoJA4xOiECwNNPPLMh9DfIAcPbQvgFdx8vtLOY0r9qTioxzqki623ZYMg==
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr114893wmb.169.1594303407170;
        Thu, 09 Jul 2020 07:03:27 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:26 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 01/14] drm/panfrost: avoid static declaration
Date:   Thu,  9 Jul 2020 16:03:09 +0200
Message-Id: <20200709140322.131320-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This declaration can be avoided so change it.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 38 ++++++++++-----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..1b560b903ea6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -14,7 +14,24 @@
 #include "panfrost_gpu.h"
 #include "panfrost_regs.h"
 
-static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev);
+static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
+{
+	ktime_t now;
+	ktime_t last;
+
+	if (!pfdev->devfreq.devfreq)
+		return;
+
+	now = ktime_get();
+	last = pfdev->devfreq.time_last_update;
+
+	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
+		pfdev->devfreq.busy_time += ktime_sub(now, last);
+	else
+		pfdev->devfreq.idle_time += ktime_sub(now, last);
+
+	pfdev->devfreq.time_last_update = now;
+}
 
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 				   u32 flags)
@@ -139,25 +156,6 @@ void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
 	devfreq_suspend_device(pfdev->devfreq.devfreq);
 }
 
-static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
-{
-	ktime_t now;
-	ktime_t last;
-
-	if (!pfdev->devfreq.devfreq)
-		return;
-
-	now = ktime_get();
-	last = pfdev->devfreq.time_last_update;
-
-	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
-		pfdev->devfreq.busy_time += ktime_sub(now, last);
-	else
-		pfdev->devfreq.idle_time += ktime_sub(now, last);
-
-	pfdev->devfreq.time_last_update = now;
-}
-
 void panfrost_devfreq_record_busy(struct panfrost_device *pfdev)
 {
 	panfrost_devfreq_update_utilization(pfdev);
-- 
2.25.1

