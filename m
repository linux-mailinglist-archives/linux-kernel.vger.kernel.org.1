Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB53E21A1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGIODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgGIODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23662C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so1945833wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKW/GFXJRvXHBJ7nA8bjC5XW9nj30bx6DuRlEB0HNtQ=;
        b=NMgaLp5jU8o/Dd3Jp7/66haZtao+33lbMBXYdUVDYGLT7KlbSQWZRSh+T67gWuTkft
         sHofRUKjWfYOkUir0htLzyVeGAL+qTCnf73DqSZSeJh0UOzmEGAoSS9hijBO93aZswti
         hsW5ItgZlpUkt9Uae5JBxyrL6OszGvaG3dPKYkJh+6wYoHqGcSmqyhy0hFUQJLvO7TNJ
         5oZHfxKoC0L3OMQNOmdovrK5BI6QTsX6G7aP2b38vpphpFfP1M1o6pQxbvA3OPWUWylA
         a/iUnP/O5arGTq/U8govaQBY0l6afrlrdLtvo9rccYca9bp9ZaKvv4M4iLSAhAMBLNap
         gcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKW/GFXJRvXHBJ7nA8bjC5XW9nj30bx6DuRlEB0HNtQ=;
        b=OjEeg6c6gTf9gHE3b3/U5XTXnzoURiFEiTE0EuxQWdD7C1OfbEUwajLOIZ6sbLC5ay
         oMN4n6sphl1gZsPQClRLonBf1mv2pzirf5Wz+BcFPj588HyAE95WN/F4eV0PRUCVe+ju
         M0SYzSGnug8Fbv7nZBS7lsOvXo74pWTWBPdWvUr9opcfMu79m3+VNZpbWz+bLRLfzS7c
         vScr0LM/aK+zBn5/xEWflx10NZ4QlXEZUXjFNqXR+l6ItVDfzelfYy4W2vGeDYnygDCH
         bB8oC6PwKPqpG0VQKzoIw53QTHviR/l7Pw1i39onuVYuUmU/cSPSs0r5zSdXHfNlXVym
         Noug==
X-Gm-Message-State: AOAM530tuwLM8GSPLJFjkPfiIK72JjVkwIt3btc9FSl8KxJ4qz0MsG3w
        kKY/68bTnpazqP11FJLicjc=
X-Google-Smtp-Source: ABdhPJxILflVyu8Lm0seStqnwju2jYItTgeZ7W0SCCrBRXZTDmDCDL7zzPjGyEeU/IQ2UoSUomR6rA==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr127812wmk.143.1594303414757;
        Thu, 09 Jul 2020 07:03:34 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:34 -0700 (PDT)
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
Subject: [PATCH v3 07/14] drm/panfrost: rename error labels in device_init
Date:   Thu,  9 Jul 2020 16:03:15 +0200
Message-Id: <20200709140322.131320-8-peron.clem@gmail.com>
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

Rename goto labels in device_init it will be easier to maintain.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 8136babd3ba9..cc16d102b275 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -215,57 +215,57 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	err = panfrost_regulator_init(pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto err_out0;
+		goto out_clk;
 	}
 
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

