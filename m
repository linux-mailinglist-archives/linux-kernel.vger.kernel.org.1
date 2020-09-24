Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDF27715A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgIXMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgIXMpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5FC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so3405286wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6W9E8qN6DxNYH9h0PRSxLy9Xd7ta7u+vF8y/L8tvpA=;
        b=yEcGDKq5tSMNsVvMcEp7ED4s+txp5++nzkRhHtx3xr9k7hH6xT8TZ+BM2noaYRI4Vw
         O3DiG+MWyFiFOActix2x6jglV/SOdK1iKholPoNpG3OvvbgmUEW0Xkvq77Guu4asGQDi
         2NTuX7QA+KklRyaPzMFdUgyDtt7Ef05rxIPu+P7L527Ky2QDPQI6Ltg/KL9XJlTv2uGk
         g5a3H5XEQ/JySbwfbu+qSjFxLvKq70p7uIYu+RyoFstSmHLtSaqmXS3jCrJPctX06lhT
         sCFSB9/BeauT4kf5nNG35Nis2oi/WJKMiEeCtAKECYORbVFN2/6Iha0BhqB9PQLmCNri
         2kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6W9E8qN6DxNYH9h0PRSxLy9Xd7ta7u+vF8y/L8tvpA=;
        b=gDP6wt5r0fRLGngHTEmtGR9aDN0onhzwrOv7yW9Z244LNuBMd0p0YZRnmdHz0f4HSL
         eP+cP8+mnaDc1E3COCh5SnJL286Ob3fuCBvVe6oX498dMYqXQWKdcK35X+vRxcs1Q5Ua
         rnRSs+vbvBW7QWDmGr9G1RHDF53CDMq9nfv9Yc9CZLGEPelHQLREX1kBgkJ5H9vHWFXB
         5M5KIzCXXrRKzsN6frUyZXBF7IP0gqeE5bAG/Fi1+WtWLHHl5vLEXAX/4h2+hlw5Yr6h
         C9bq8YntMyQ6WiTRbAHZZEatRAZBfbEFl3HWdLli5IIskB73ysw27jEOlwLxxjQ2Yqk1
         ygYA==
X-Gm-Message-State: AOAM530jIulA/8mENNfMPxzAg9cqJR6R/GzOiosEYDy4v24OTZlVE3CN
        nvEooR1IGN/4BOxZe/c3HW7Dtw==
X-Google-Smtp-Source: ABdhPJzkNx2iVcWqdYVwKH3h4/LBIvTPA/JRjZNrFshr8n+HWfK/DwsAxHQRG5yrNop8N8Zopp8RDg==
X-Received: by 2002:a1c:2d94:: with SMTP id t142mr4567680wmt.74.1600951548758;
        Thu, 24 Sep 2020 05:45:48 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/12] samples: configfs: prefer pr_err() over bare printk(KERN_ERR
Date:   Thu, 24 Sep 2020 14:45:26 +0200
Message-Id: <20200924124526.17365-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

pr_*() printing helpers are preferred over using bare printk().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index da4e0f4ec20a..2f3b26d1d45e 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -340,9 +340,8 @@ static int __init configfs_example_init(void)
 		mutex_init(&subsys->su_mutex);
 		ret = configfs_register_subsystem(subsys);
 		if (ret) {
-			printk(KERN_ERR "Error %d while registering subsystem %s\n",
-			       ret,
-			       subsys->su_group.cg_item.ci_namebuf);
+			pr_err("Error %d while registering subsystem %s\n",
+			       ret, subsys->su_group.cg_item.ci_namebuf);
 			goto out_unregister;
 		}
 	}
-- 
2.17.1

