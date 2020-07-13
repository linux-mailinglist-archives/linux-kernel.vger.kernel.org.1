Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1922121A1B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgGIOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGIODi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FBC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so6347819wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l36lxSRuzC4M5+GyPXFxDj/EhvfNIEQcQmOpcVgl7wo=;
        b=RWd6xeQaKkXBDcqaUA/vXcv9CsRqjpa1gLy87640mOge+kKSxYZka0L+8EC2/siJ+q
         7hI528ObcBzT3vpDQ3t1YTwExWlLqYzelTdhfRY6kbwcQwhiZB48cGHmrsoHfrL/b3+z
         GJSV9+MXXxU+8BI4nXWt2H2cw2j+UgDAwSwU/gOIH/wjjGdw0JipkSzveBKhfsnqYPpq
         md3JGAjHvuE99SU7q0iU+5w/PLqUQTWfwu5Ife5JtJJtN0uq2p1FBCVy9ko32W5nmn32
         npoM+x1zAiXRV1hWLL0QQ7lAkTFqhaUU5xsVN/ognjsXHL9JW0wOTrdk5eme+xICLWql
         EcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l36lxSRuzC4M5+GyPXFxDj/EhvfNIEQcQmOpcVgl7wo=;
        b=dHlud4VPbQlJurmazSL7LRqnojUYt6z9irWPb3+TW7NqVT4e4DeVNsb64Zh76feZtj
         nK+7Cmj/TfzJSr93MMEQz18rrVf8LsxAppcCXY6VTnOQNXHywjeNpmtVVErU0UK7O41W
         +sJMomn6r2OOkVGsXMuR2RfmO5uULdblavwGp+1hJUS3Jezm3eDVr+n6Nfeeq3QZ5lLJ
         L3fD0XXx5YZAJCSWj3j8cRzsRi/lWxqHPB5rJqg7aFPRz8hGog4tNgO6oSM1Y8CwVn+d
         a+TOLdP3lQJeLrSvyqXo8GdrHJfB410j+MfqNS0uJGe48PfbiZigXgYqadl6ej+VNbXI
         FxrQ==
X-Gm-Message-State: AOAM5302PaD2wUlIH7lh9nlOBDpMpFkfol3C6lGXZ52FfqoaZR/vDDft
        pD6kFBlvc8cz+7UhKmSw8W0=
X-Google-Smtp-Source: ABdhPJzQSsS3ZPutPIRqkj3+0gwoeFRJt699I4f8i1gp/1FAi0eILeOJ9Za1ciNteC/ZwKxiovGPGA==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr196656wmg.14.1594303416312;
        Thu, 09 Jul 2020 07:03:36 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:35 -0700 (PDT)
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
Subject: [PATCH v3 08/14] drm/panfrost: move devfreq_init()/fini() in device
Date:   Thu,  9 Jul 2020 16:03:16 +0200
Message-Id: <20200709140322.131320-9-peron.clem@gmail.com>
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

Later we will introduce devfreq probing regulator if they
are present. As regulator should be probe only one time we
need to get this logic in the device_init().

panfrost_device is already taking care of devfreq_resume()
and devfreq_suspend(), so it's not totally illogic to move
the devfreq_init() and devfreq_fini() here.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 12 +++++++++++-
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 15 ++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index cc16d102b275..464da1646398 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -212,10 +212,17 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
+	err = panfrost_devfreq_init(pfdev);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "devfreq init failed %d\n", err);
+		goto out_clk;
+	}
+
 	err = panfrost_regulator_init(pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto out_clk;
+		goto out_devfreq;
 	}
 
 	err = panfrost_reset_init(pfdev);
@@ -265,6 +272,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	panfrost_reset_fini(pfdev);
 out_regulator:
 	panfrost_regulator_fini(pfdev);
+out_devfreq:
+	panfrost_devfreq_fini(pfdev);
 out_clk:
 	panfrost_clk_fini(pfdev);
 	return err;
@@ -278,6 +287,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_gpu_fini(pfdev);
 	panfrost_pm_domain_fini(pfdev);
 	panfrost_reset_fini(pfdev);
+	panfrost_devfreq_fini(pfdev);
 	panfrost_regulator_fini(pfdev);
 	panfrost_clk_fini(pfdev);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 882fecc33fdb..4dda68689015 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -14,7 +14,6 @@
 #include <drm/drm_utils.h>
 
 #include "panfrost_device.h"
-#include "panfrost_devfreq.h"
 #include "panfrost_gem.h"
 #include "panfrost_mmu.h"
 #include "panfrost_job.h"
@@ -606,13 +605,6 @@ static int panfrost_probe(struct platform_device *pdev)
 		goto err_out0;
 	}
 
-	err = panfrost_devfreq_init(pfdev);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Fatal error during devfreq init\n");
-		goto err_out1;
-	}
-
 	pm_runtime_set_active(pfdev->dev);
 	pm_runtime_mark_last_busy(pfdev->dev);
 	pm_runtime_enable(pfdev->dev);
@@ -625,16 +617,14 @@ static int panfrost_probe(struct platform_device *pdev)
 	 */
 	err = drm_dev_register(ddev, 0);
 	if (err < 0)
-		goto err_out2;
+		goto err_out1;
 
 	panfrost_gem_shrinker_init(ddev);
 
 	return 0;
 
-err_out2:
-	pm_runtime_disable(pfdev->dev);
-	panfrost_devfreq_fini(pfdev);
 err_out1:
+	pm_runtime_disable(pfdev->dev);
 	panfrost_device_fini(pfdev);
 err_out0:
 	drm_dev_put(ddev);
@@ -650,7 +640,6 @@ static int panfrost_remove(struct platform_device *pdev)
 	panfrost_gem_shrinker_cleanup(ddev);
 
 	pm_runtime_get_sync(pfdev->dev);
-	panfrost_devfreq_fini(pfdev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_put_sync_suspend(pfdev->dev);
 	pm_runtime_disable(pfdev->dev);
-- 
2.25.1

