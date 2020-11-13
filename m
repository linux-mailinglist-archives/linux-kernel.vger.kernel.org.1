Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05932B22F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgKMRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgKMRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:49 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CAC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:48 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id y18so1945106ilp.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEtz35TwaMOmtP7wZDty93xaU0e4wII3qI7ntzR/4WQ=;
        b=MBLRtdNVXvb371vssRTTQIGlMBWRZWFOky+eOrsFPSWIyGwIFrbO3WCfYTXFCxtesk
         BQ3sUk+dJLBKLpYxajlh97iZOUIZiE3EWWVA4Ux2agGHurqQDjaq0+bm/exeIrN+GlhP
         YkxXbuynzH+IpN0i116JxOb+1sDrgFHgO6W2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEtz35TwaMOmtP7wZDty93xaU0e4wII3qI7ntzR/4WQ=;
        b=n2RQ/SAy9c/asMXC6VRCbcO5Y/dLQRvuLSny1TQsUSCOiUMETVRY2x2Dj9/y08B26k
         y1a1DoJyEaDbUzWvVYBi0KmJq65UeGymXMn9EJhQp/PocO/zDcEwAHndaQBywZEnTuNM
         zqZ4seoH6E6fYkR9shwnw1c5Duen/tLbEG8KjCHQ2y2hNNEHiVMGVnuU20I/t0TZXRDh
         ElU1DbHNZbQhvVdAxXkIWKwde+TA3/WxCBN7zEQ3tf13SOTLAByo0xBN/Ajmqz9uLt7g
         LpCSyjIhP+qHa8ATu75fkOCUmyg+DntJcNAUkVWIkSXd3zeOYDluRTCo6ONQfpx8mao6
         xECw==
X-Gm-Message-State: AOAM532hsoJWTKxQ7evixB7Mbb2UHsrH6HTYL7Q92t4BwMLdRBks4fmH
        OhRR1M21ROw+u/k8g9Jtx4KJXaxKN3+TxA==
X-Google-Smtp-Source: ABdhPJzOuUC15iLMQufTNIo7HdP2XkphHFvteCLyXwmLRGJvWU3Jror9urZyYDx8rK37OJlqrdLoAA==
X-Received: by 2002:a05:6e02:1313:: with SMTP id g19mr748344ilr.177.1605289607715;
        Fri, 13 Nov 2020 09:46:47 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:47 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     david.kershner@unisys.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] drivers/staging/unisys/visorhba: convert stats to use seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:14 -0700
Message-Id: <948df30739a497922bafa4637f63218e9ec44e61.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath. Convert it to use
seqnum_ops.

atomic_t variable used for error_count are atomic counters. Convert it to
use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../staging/unisys/visorhba/visorhba_main.c   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 7ae5306b92fe..7837eca83758 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/visorbus.h>
+#include <linux/seqnum_ops.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
@@ -42,7 +43,7 @@ struct visordisk_info {
 	struct scsi_device *sdev;
 	u32 valid;
 	atomic_t ios_threshold;
-	atomic_t error_count;
+	struct seqnum32 error_count;
 	struct visordisk_info *next;
 };
 
@@ -374,8 +375,8 @@ static int visorhba_abort_handler(struct scsi_cmnd *scsicmd)
 
 	scsidev = scsicmd->device;
 	vdisk = scsidev->hostdata;
-	if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
-		atomic_inc(&vdisk->error_count);
+	if (seqnum32_fetch(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
+		seqnum32_inc_return(&vdisk->error_count);
 	else
 		atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	rtn = forward_taskmgmt_command(TASK_MGMT_ABORT_TASK, scsidev);
@@ -401,8 +402,8 @@ static int visorhba_device_reset_handler(struct scsi_cmnd *scsicmd)
 
 	scsidev = scsicmd->device;
 	vdisk = scsidev->hostdata;
-	if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
-		atomic_inc(&vdisk->error_count);
+	if (seqnum32_fetch(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
+		seqnum32_inc_return(&vdisk->error_count);
 	else
 		atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	rtn = forward_taskmgmt_command(TASK_MGMT_LUN_RESET, scsidev);
@@ -429,8 +430,8 @@ static int visorhba_bus_reset_handler(struct scsi_cmnd *scsicmd)
 	scsidev = scsicmd->device;
 	shost_for_each_device(scsidev, scsidev->host) {
 		vdisk = scsidev->hostdata;
-		if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
-			atomic_inc(&vdisk->error_count);
+		if (seqnum32_fetch(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
+			seqnum32_inc_return(&vdisk->error_count);
 		else
 			atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	}
@@ -803,8 +804,8 @@ static void do_scsi_linuxstat(struct uiscmdrsp *cmdrsp,
 		return;
 	/* Okay see what our error_count is here.... */
 	vdisk = scsidev->hostdata;
-	if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT) {
-		atomic_inc(&vdisk->error_count);
+	if (seqnum32_fetch(&vdisk->error_count) < VISORHBA_ERROR_COUNT) {
+		seqnum32_inc_return(&vdisk->error_count);
 		atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	}
 }
@@ -884,7 +885,7 @@ static void do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp,
 		if (atomic_read(&vdisk->ios_threshold) > 0) {
 			atomic_dec(&vdisk->ios_threshold);
 			if (atomic_read(&vdisk->ios_threshold) == 0)
-				atomic_set(&vdisk->error_count, 0);
+				seqnum32_init(&vdisk->error_count);
 		}
 	}
 }
-- 
2.27.0

