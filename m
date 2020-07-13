Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADB21A1B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGIODl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGIODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7CEC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so1954640wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BOFwyA/KeHpSrdpEHkJSq/OdhfI9WWMw9P1g3AHQGKw=;
        b=T4Czs3C6f6XNS5I7SnWmY+8UswejwqxgdF8WGbwSzdU9C3od4s11THuBNl6q7ToVBt
         qKIUWBOc1tZgJIGcWAzD+CPggtiFlXrSg/hTeC4q7NUixjIVyLvRaRH92yMSxhIeU0mU
         en/A+FAHqulAQoOyqdCJSrwrYWxb1X6gNVDWfljZDBVZe34iMixa4B8FHS7UszV81fJI
         Pf78p/EQTKyyssjgtVuAZZg5Xyf2YKJVvblYO+PwxQEpC9qC892uYSPs4VaStTf1yRcj
         lybHYCpSXL36dKMcKiV01EKsq6NqfpKfunp865yFxsRACkJSkZ0z3QyoGClwLadzSoAN
         3I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BOFwyA/KeHpSrdpEHkJSq/OdhfI9WWMw9P1g3AHQGKw=;
        b=IJfgdCH2GIGLEc4hVGVuzct+4k8nRPXNCYI/Z5SpInXoRc2zNZ5IipxRz0IAaFPsxx
         iKElsbDyefD8dUzBjkbj0lppIlTZTma66GeruhrbL0CXsOcNiTxu4gNx8ZT4xtMaarY+
         ftc48GqScJHwitFVzuPmuhgVU5ht4jtqMfkyOe0OunzLlmjhCiuhJPrAfv0Qkfs0oEeD
         pCf0m1XaFGsAjRmiO/LQxR9l3axHpHIiuue08O/VgXvdDC3gkdMpgjaCifJDT9eJ3Hzn
         MeFu5BgR+Q31vLvX6XS52VbTPrdjBZfx3nFA3mhRTAuAL9WDtS4XmAXw+T2dxe9LWCn7
         977g==
X-Gm-Message-State: AOAM531VzNyAoicMxr8hetKWzee4GT/jSAwVRmgYDFrxrXceeJI9cegA
        qO18Ur2sfVMYv4thRl9xAsc=
X-Google-Smtp-Source: ABdhPJyvaIRwfYI3tdberZprFXUuYfO1fIWqAYdaMWC4jYWrQqCTVnhzxV1LgDMR1AE+B8tzK3c64g==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr140330wmj.71.1594303417600;
        Thu, 09 Jul 2020 07:03:37 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:36 -0700 (PDT)
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
Subject: [PATCH v3 09/14] drm/panfrost: dynamically alloc regulators
Date:   Thu,  9 Jul 2020 16:03:17 +0200
Message-Id: <20200709140322.131320-10-peron.clem@gmail.com>
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

We will later introduce regulators managed by OPP.

Only alloc regulators when it's needed. This also help use
to release the regulators only when they are allocated.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++++++-----
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 464da1646398..0b0fb45aee82 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -90,9 +90,11 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 {
 	int ret, i;
 
-	if (WARN(pfdev->comp->num_supplies > ARRAY_SIZE(pfdev->regulators),
-			"Too many supplies in compatible structure.\n"))
-		return -EINVAL;
+	pfdev->regulators = devm_kcalloc(pfdev->dev, pfdev->comp->num_supplies,
+					 sizeof(*pfdev->regulators),
+					 GFP_KERNEL);
+	if (!pfdev->regulators)
+		return -ENOMEM;
 
 	for (i = 0; i < pfdev->comp->num_supplies; i++)
 		pfdev->regulators[i].supply = pfdev->comp->supply_names[i];
@@ -117,8 +119,10 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 
 static void panfrost_regulator_fini(struct panfrost_device *pfdev)
 {
-	regulator_bulk_disable(pfdev->comp->num_supplies,
-			pfdev->regulators);
+	if (!pfdev->regulators)
+		return;
+
+	regulator_bulk_disable(pfdev->comp->num_supplies, pfdev->regulators);
 }
 
 static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 2efa59c9d1c5..953f7536a773 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -22,7 +22,6 @@ struct panfrost_job;
 struct panfrost_perfcnt;
 
 #define NUM_JOB_SLOTS 3
-#define MAX_REGULATORS 2
 #define MAX_PM_DOMAINS 3
 
 struct panfrost_features {
@@ -81,7 +80,7 @@ struct panfrost_device {
 	void __iomem *iomem;
 	struct clk *clock;
 	struct clk *bus_clock;
-	struct regulator_bulk_data regulators[MAX_REGULATORS];
+	struct regulator_bulk_data *regulators;
 	struct reset_control *rstc;
 	/* pm_domains for devices with more than one. */
 	struct device *pm_domain_devs[MAX_PM_DOMAINS];
-- 
2.25.1

