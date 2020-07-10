Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2B21B22B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGJJ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgGJJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6BFC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so5374167wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXA70POHCV2GWsHX4CvRyqRrbTFQBlpDYTBkU8Vpd/0=;
        b=S2ig4kvmDSJIPwYoXEgwMT8FZkjfG9AVU443JHmffIUG51/Is4LsPtP5tODmYYaEsc
         auB8gLKNNCaSSTKDeLuP9AHMK8ekbeF3eb2nz2ZLiKUxjW9avc5hIebi+FQ1LkyRpfE9
         1HnrWiQh0UzK+EyDN0LW8bI8ANdBw2aAafYBFf9oCnGTmQ1mIJj5tarTQBvjn6ECNjkL
         brj0s1P/EIxKJShtsZRjCpDx5bewqgdUs1SfYoESwuAkI6ipnjL9vYjLdmZVfzF03Jac
         kyL4fMD+LmzMTVWrea13dQl6Sf91dDhNWSyQcjcrCx90ZO7e9Nhm+6Fz9qJDVXXACAJn
         j8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXA70POHCV2GWsHX4CvRyqRrbTFQBlpDYTBkU8Vpd/0=;
        b=JD0d+vWt7qLkp+9qwA8lc2uLDHMmBH/FfBgFyxxyuGBgGgmvAY+PsxW9P+LFGgajIC
         KZrvozNdviAnfsm/yjcgeBG7XmKxNcW/SScG0RwGuWqaD3zhDSFb7jrSh8cFbm1y5YiK
         qK9SsCv79di/f1WBzQt7AtW3Qz0931C9g0fM3AEGCmLlCpuWmQtT+Z9u3i2TZN4nFmLk
         2xJkk+82VFuW9DtVY/e394ein9n+wq8Fa/c0G6Yk2YNddGEawyrDRo0eWpokwXxWvo7C
         3TR2ImmWBbEcgTjA1YnzyeNGfoajXbqj/wKeVAonR/A3y7qUENW+vpQHY/VZPt53wOHo
         yQDw==
X-Gm-Message-State: AOAM531DrSxzCMPBqTD/KC3ECiJTToNYoH7YAolWr1T4t2dxQL/pOaCB
        DCQlrAaiCwVB9b0pyEzOcf0=
X-Google-Smtp-Source: ABdhPJwf0I1oRgP5F+GFt4RKjJo/KGgOpRV0lTTEpc+BKVvDFwJ4KfE3PAObQkkIVtQDkCgqg4qb5g==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr4487588wmi.83.1594373160910;
        Fri, 10 Jul 2020 02:26:00 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:26:00 -0700 (PDT)
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
Subject: [PATCH v4 07/14] drm/panfrost: rename error labels in device_init
Date:   Fri, 10 Jul 2020 11:25:41 +0200
Message-Id: <20200710092548.316054-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename goto labels in device_init it will be easier to maintain.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index b172087eee6a..9f89984f652a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -216,56 +216,56 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 	err = panfrost_regulator_init(pfdev);
 	if (err)
-		goto err_out0;
+		goto out_clk;
 
 	err = panfrost_reset_init(pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "reset init failed %d\n", err);
-		goto err_out1;
+		goto out_regulator;
 	}
 
 	err = panfrost_pm_domain_init(pfdev);
 	if (err)
-		goto err_out2;
+		goto out_reset;
 
 	res = platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
 	pfdev->iomem = devm_ioremap_resource(pfdev->dev, res);
 	if (IS_ERR(pfdev->iomem)) {
 		dev_err(pfdev->dev, "failed to ioremap iomem\n");
 		err = PTR_ERR(pfdev->iomem);
-		goto err_out3;
+		goto out_pm_domain;
 	}
 
 	err = panfrost_gpu_init(pfdev);
 	if (err)
-		goto err_out3;
+		goto out_pm_domain;
 
 	err = panfrost_mmu_init(pfdev);
 	if (err)
-		goto err_out4;
+		goto out_gpu;
 
 	err = panfrost_job_init(pfdev);
 	if (err)
-		goto err_out5;
+		goto out_mmu;
 
 	err = panfrost_perfcnt_init(pfdev);
 	if (err)
-		goto err_out6;
+		goto out_job;
 
 	return 0;
-err_out6:
+out_job:
 	panfrost_job_fini(pfdev);
-err_out5:
+out_mmu:
 	panfrost_mmu_fini(pfdev);
-err_out4:
+out_gpu:
 	panfrost_gpu_fini(pfdev);
-err_out3:
+out_pm_domain:
 	panfrost_pm_domain_fini(pfdev);
-err_out2:
+out_reset:
 	panfrost_reset_fini(pfdev);
-err_out1:
+out_regulator:
 	panfrost_regulator_fini(pfdev);
-err_out0:
+out_clk:
 	panfrost_clk_fini(pfdev);
 	return err;
 }
-- 
2.25.1

