Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D9F2DBBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgLPHUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLPHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:20:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED1C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:19:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 11so16029988pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzt16Xi0FHR8n70/x4G7HQRoohpjQkqkV6KKbVOY9gM=;
        b=EIU7gzne4KxL4fpAUFiuf7HWWZLhuWCwys2lakpMNCu8yUGCPLPPyWas/Jz2M/oUhx
         F2gRZxhXQr0bKgZGkejVV+JW0DHrOXGrMXuzr9AIcNM30FPr7ra9Gxhswxzl7mlbaTru
         75RJpZWn2sEdX9H+rsQ8EoQh9Wqg0rph48vj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzt16Xi0FHR8n70/x4G7HQRoohpjQkqkV6KKbVOY9gM=;
        b=qSrwMflhgs8aWpa+roJVnTENA76AZzJ/tYeWznVpQG1aNxzhVxcwzkO/x5BCYhx5ej
         ynfD/eOA90YYzd8+yveBcBjKJXMBFRCh5+pEC1SkwNBEBDajSOMgq7Ho+9TnKFmhkU4H
         6Cu3K7WxR6/fZAAPC+aEPi198A3iE3J0Cr2JoKf1euh5c8LKJmx+A6d63iwu4yKSf6Wt
         jG4pM2i9/W5Tj/U8HjjHikDRDkoMNkMSqXTvIeGWZuZrfhjgDJNqZwU6yyQ4K4041z05
         8RnDI3/mgB+X0xrmvN4P2Q43oCMEoVuwF556jozrMNMQ54LZnwuI28RV+NLpxH0Pj+ay
         tcvQ==
X-Gm-Message-State: AOAM530j1wBIlAAkzKk1b4xGE1whuhh76FRd0Sr1cTk59RkogBc7NnX/
        etM2Y6oyYpryX/vU90jVQzo72g==
X-Google-Smtp-Source: ABdhPJzUS3IYQaKMA+7Nff6vG17WGeJqNNq88L1/ujAD2Vlx2OaosGEQo0Kpz2snyvKsC/mqFOj6qg==
X-Received: by 2002:a63:3d8:: with SMTP id 207mr26330776pgd.215.1608103168718;
        Tue, 15 Dec 2020 23:19:28 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a26sm1288968pgd.64.2020.12.15.23.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 23:19:28 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] soc: qcom: socinfo: Open read access to all for debugfs
Date:   Tue, 15 Dec 2020 23:19:26 -0800
Message-Id: <20201216071926.3147108-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There doesn't seem to be any reason to limit this to only root user
readable. Let's make it readable by all so that random programs can
read the debugfs files in here instead of just root. The information is
just that, informational, so this is fine.

Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/socinfo.c | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index b44ede48decc..4e4946d9e4ab 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -258,7 +258,7 @@ static const struct file_operations qcom_ ##name## _ops = {		\
 }
 
 #define DEBUGFS_ADD(info, name)						\
-	debugfs_create_file(__stringify(name), 0400,			\
+	debugfs_create_file(__stringify(name), 0444,			\
 			    qcom_socinfo->dbg_root,			\
 			    info, &qcom_ ##name## _ops)
 
@@ -349,14 +349,14 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 
 	qcom_socinfo->info.fmt = __le32_to_cpu(info->fmt);
 
-	debugfs_create_x32("info_fmt", 0400, qcom_socinfo->dbg_root,
+	debugfs_create_x32("info_fmt", 0444, qcom_socinfo->dbg_root,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
 	case SOCINFO_VERSION(0, 15):
 		qcom_socinfo->info.nmodem_supported = __le32_to_cpu(info->nmodem_supported);
 
-		debugfs_create_u32("nmodem_supported", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("nmodem_supported", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.nmodem_supported);
 		fallthrough;
 	case SOCINFO_VERSION(0, 14):
@@ -365,19 +365,19 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		qcom_socinfo->info.num_defective_parts = __le32_to_cpu(info->num_defective_parts);
 		qcom_socinfo->info.ndefective_parts_array_offset = __le32_to_cpu(info->ndefective_parts_array_offset);
 
-		debugfs_create_u32("num_clusters", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("num_clusters", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.num_clusters);
-		debugfs_create_u32("ncluster_array_offset", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("ncluster_array_offset", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.ncluster_array_offset);
-		debugfs_create_u32("num_defective_parts", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("num_defective_parts", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.num_defective_parts);
-		debugfs_create_u32("ndefective_parts_array_offset", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("ndefective_parts_array_offset", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.ndefective_parts_array_offset);
 		fallthrough;
 	case SOCINFO_VERSION(0, 13):
 		qcom_socinfo->info.nproduct_id = __le32_to_cpu(info->nproduct_id);
 
-		debugfs_create_u32("nproduct_id", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("nproduct_id", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.nproduct_id);
 		DEBUGFS_ADD(info, chip_id);
 		fallthrough;
@@ -389,12 +389,12 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		qcom_socinfo->info.raw_device_num =
 			__le32_to_cpu(info->raw_device_num);
 
-		debugfs_create_x32("chip_family", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_x32("chip_family", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.chip_family);
-		debugfs_create_x32("raw_device_family", 0400,
+		debugfs_create_x32("raw_device_family", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_device_family);
-		debugfs_create_x32("raw_device_number", 0400,
+		debugfs_create_x32("raw_device_number", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_device_num);
 		fallthrough;
@@ -403,7 +403,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 	case SOCINFO_VERSION(0, 9):
 		qcom_socinfo->info.foundry_id = __le32_to_cpu(info->foundry_id);
 
-		debugfs_create_u32("foundry_id", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("foundry_id", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.foundry_id);
 		fallthrough;
 	case SOCINFO_VERSION(0, 8):
@@ -415,7 +415,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		qcom_socinfo->info.hw_plat_subtype =
 			__le32_to_cpu(info->hw_plat_subtype);
 
-		debugfs_create_u32("hardware_platform_subtype", 0400,
+		debugfs_create_u32("hardware_platform_subtype", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.hw_plat_subtype);
 		fallthrough;
@@ -423,28 +423,28 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		qcom_socinfo->info.accessory_chip =
 			__le32_to_cpu(info->accessory_chip);
 
-		debugfs_create_u32("accessory_chip", 0400,
+		debugfs_create_u32("accessory_chip", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.accessory_chip);
 		fallthrough;
 	case SOCINFO_VERSION(0, 4):
 		qcom_socinfo->info.plat_ver = __le32_to_cpu(info->plat_ver);
 
-		debugfs_create_u32("platform_version", 0400,
+		debugfs_create_u32("platform_version", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.plat_ver);
 		fallthrough;
 	case SOCINFO_VERSION(0, 3):
 		qcom_socinfo->info.hw_plat = __le32_to_cpu(info->hw_plat);
 
-		debugfs_create_u32("hardware_platform", 0400,
+		debugfs_create_u32("hardware_platform", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.hw_plat);
 		fallthrough;
 	case SOCINFO_VERSION(0, 2):
 		qcom_socinfo->info.raw_ver  = __le32_to_cpu(info->raw_ver);
 
-		debugfs_create_u32("raw_version", 0400, qcom_socinfo->dbg_root,
+		debugfs_create_u32("raw_version", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_ver);
 		fallthrough;
 	case SOCINFO_VERSION(0, 1):
@@ -461,11 +461,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 
 		dentry = debugfs_create_dir(socinfo_image_names[i],
 					    qcom_socinfo->dbg_root);
-		debugfs_create_file("name", 0400, dentry, &versions[i],
+		debugfs_create_file("name", 0444, dentry, &versions[i],
 				    &qcom_image_name_ops);
-		debugfs_create_file("variant", 0400, dentry, &versions[i],
+		debugfs_create_file("variant", 0444, dentry, &versions[i],
 				    &qcom_image_variant_ops);
-		debugfs_create_file("oem", 0400, dentry, &versions[i],
+		debugfs_create_file("oem", 0444, dentry, &versions[i],
 				    &qcom_image_oem_ops);
 	}
 }

base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
https://chromeos.dev

