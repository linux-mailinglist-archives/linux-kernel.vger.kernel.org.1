Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B302DDF38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 08:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbgLRHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 02:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgLRHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 02:48:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB203C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 23:48:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so964215plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 23:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=oUHJKaEjQz6SHPD5G/0+4SyVkB0IuZj3vdw75htBcd4=;
        b=NGYqkkYoKGyA22LiY2LbS80hRK4pgC9ZvkoxmFJn8KIqLlwQFCVFWvVsY0RVST3mzx
         XmSfwN1skdmR2QtF1JV+zksX0u565GOUo1r2NCvuOru5wwrrq5C7nI3XSLr4YQMOrOzk
         yTDr9gReX1EWjQTMduuTWAZ6U1uK6zJMu3Zf0zQ7YY4L3EW1nen1kVRWtfFa+tPhvsbl
         S7LrvLMPja9zqsc5Vw9joSvXZ6OxfpUGlZUkskvwhPBLnehAV+vJjdG7xNDRpY9RCeVf
         NtFLbarvdqhfsXqgHm83Dlcr7nWGytHgbj3YseqozICqd0aZtdSokA1twTuL68guHHGy
         YEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=oUHJKaEjQz6SHPD5G/0+4SyVkB0IuZj3vdw75htBcd4=;
        b=eWP7YuaN7ssNvHjuvF8ITvUzt5z+foYXpVmwus2fqptZ/+cVmtrnSZqk0MQlzhZxJr
         om9L0ZIuR6OI8Sbqy8P+elMSfxqVQzO4Ca/IjN2NyxBeXunAx/p/VCmKzqjsbUbmUakV
         XjDOPeiIsolI0jcrgHJJV6Cn3Z0VVHY2IRNPUrZ6mCycxT1Bvoq5KHcS1hLEsEwMQMvd
         tRSiTpvjijTnKQzBDHYC7trUN9qZAQgxd7372EAqVSjXJmGJYZO4ysRF5tkZZ82tBz/S
         GaG2cDI1GQlb1mAwtBELuMDLBHHDXEtFJ0aHzTEEGB8x7L/kg5sQ8qx49eT/5w90PeYw
         KuMQ==
X-Gm-Message-State: AOAM530G65kyRfX7R2b//ueIUZa7iOpLfbyZGoG9k20T9ZCQX6RxBctG
        /lWHEXCTEmNk7YT4g3+0DH5ZQ+XOZvU=
X-Google-Smtp-Source: ABdhPJy7FsnGD6grCPgNwroicN2eY9oMa91vWAxOd3Zw5MRs/dhHuweuX6X2ggVggPews1bQ8SFi9w==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr3145138pjt.150.1608277688423;
        Thu, 17 Dec 2020 23:48:08 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d10sm7678114pfn.218.2020.12.17.23.48.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 23:48:07 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver: staging: count ashmem_range into SLAB_RECLAIMBLE
Date:   Fri, 18 Dec 2020 15:47:48 +0800
Message-Id: <1608277668-3740-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Add SLAB_RECLAIM_ACCOUNT to ashmem_range cache since it has registered
shrinker, which make memAvailable more presiced.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 74d497d..b79301f 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -893,7 +893,7 @@ static int __init ashmem_init(void)
 
 	ashmem_range_cachep = kmem_cache_create("ashmem_range_cache",
 						sizeof(struct ashmem_range),
-						0, 0, NULL);
+						0, SLAB_RECLAIM_ACCOUNT, NULL);
 	if (!ashmem_range_cachep) {
 		pr_err("failed to create slab cache\n");
 		goto out_free1;
-- 
1.9.1

