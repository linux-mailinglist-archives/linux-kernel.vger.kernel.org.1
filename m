Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E642AE04C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgKJTzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbgKJTyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:51 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0772C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:50 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r12so15598695iot.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTKuC7gZQNS77KmJ7VNzzgNSnao5Q0E26RN9NxbyMxw=;
        b=VOwVQkMaw/lCmPWCMsWEI6ZADPL6i01TnjtIRlgEZzx94jwj6jsMZOqnw4YuaYilYV
         W31FCYWWgBXL5uMHmEeVzoMckg2AqgGx4qu6aRt5EtBuX/1LWCH0vQyZCiAk1FK0qX1u
         HLt4VyYFTvaGMtrPbtGHqTavsa97UOISZXAHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTKuC7gZQNS77KmJ7VNzzgNSnao5Q0E26RN9NxbyMxw=;
        b=ejyHjq1zr0OusJkNQYanZE+Lg8fBEitdKFEC3EWKITSPlUUQ+I8ktzAJT2LvvRT+F0
         aEIrrAjTbFEMRQ4EwZZekYV0yJ/wNikNnVY50X/dDNol781JujJ/prr5zM3cB8D6IECZ
         Rg1Ymfs+HSO9ZmA6Px54IfUnfLmQI6wc8G1JL5YcQakF9XBHM7HL0CvvBXutBobcOj41
         kaJigC7PNoWHaEbRMiVOyJcUWVKW/j2878znsX9ZFwJVqeQ2FeMQCljZmuhvCugsKrrR
         5QKb5fHvN0H96uL7DA4chqnV12AHUf+XLtW2I678B/2gH3qKx1/v8nqNWjSXY2OqnCVc
         8p9g==
X-Gm-Message-State: AOAM531uOxKqtbpck3I2W2wSCp+yh9v/wMhkWQKe6iC1cWZ4S0kwTZWL
        /RW3EarCTPnob3WSvE6v22fXfw==
X-Google-Smtp-Source: ABdhPJyHNOyow41LnhkXLPULiUgFR9/L/j0V6ZPdNQdqQYkX2JvaR4O3pMIt00+dq2tAHnFxgvU8EQ==
X-Received: by 2002:a6b:7947:: with SMTP id j7mr15464767iop.143.1605038090309;
        Tue, 10 Nov 2020 11:54:50 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:49 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     david.kershner@unisys.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] drivers/staging/unisys/visorhba: convert stats to use seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:38 -0700
Message-Id: <6fb679d23de785bbd1be6a528127e29f8ee6abd7.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used for error_count and ios_threshold are atomic
counters and guarded by max. values. No change to the behavior with
this change.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../staging/unisys/visorhba/visorhba_main.c   | 37 ++++++++++---------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 7ae5306b92fe..3209958b8aaa 100644
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
@@ -41,8 +42,8 @@ MODULE_ALIAS("visorbus:" VISOR_VHBA_CHANNEL_GUID_STR);
 struct visordisk_info {
 	struct scsi_device *sdev;
 	u32 valid;
-	atomic_t ios_threshold;
-	atomic_t error_count;
+	struct seqnum32 ios_threshold;
+	struct seqnum32 error_count;
 	struct visordisk_info *next;
 };
 
@@ -374,10 +375,10 @@ static int visorhba_abort_handler(struct scsi_cmnd *scsicmd)
 
 	scsidev = scsicmd->device;
 	vdisk = scsidev->hostdata;
-	if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
-		atomic_inc(&vdisk->error_count);
+	if (seqnum32_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
+		seqnum32_inc(&vdisk->error_count);
 	else
-		atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
+		seqnum32_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	rtn = forward_taskmgmt_command(TASK_MGMT_ABORT_TASK, scsidev);
 	if (rtn == SUCCESS) {
 		scsicmd->result = DID_ABORT << 16;
@@ -401,10 +402,10 @@ static int visorhba_device_reset_handler(struct scsi_cmnd *scsicmd)
 
 	scsidev = scsicmd->device;
 	vdisk = scsidev->hostdata;
-	if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
-		atomic_inc(&vdisk->error_count);
+	if (seqnum32_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
+		seqnum32_inc(&vdisk->error_count);
 	else
-		atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
+		seqnum32_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	rtn = forward_taskmgmt_command(TASK_MGMT_LUN_RESET, scsidev);
 	if (rtn == SUCCESS) {
 		scsicmd->result = DID_RESET << 16;
@@ -429,10 +430,10 @@ static int visorhba_bus_reset_handler(struct scsi_cmnd *scsicmd)
 	scsidev = scsicmd->device;
 	shost_for_each_device(scsidev, scsidev->host) {
 		vdisk = scsidev->hostdata;
-		if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
-			atomic_inc(&vdisk->error_count);
+		if (seqnum32_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
+			seqnum32_inc(&vdisk->error_count);
 		else
-			atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
+			seqnum32_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	}
 	rtn = forward_taskmgmt_command(TASK_MGMT_BUS_RESET, scsidev);
 	if (rtn == SUCCESS) {
@@ -803,9 +804,9 @@ static void do_scsi_linuxstat(struct uiscmdrsp *cmdrsp,
 		return;
 	/* Okay see what our error_count is here.... */
 	vdisk = scsidev->hostdata;
-	if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT) {
-		atomic_inc(&vdisk->error_count);
-		atomic_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
+	if (seqnum32_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT) {
+		seqnum32_inc(&vdisk->error_count);
+		seqnum32_set(&vdisk->ios_threshold, IOS_ERROR_THRESHOLD);
 	}
 }
 
@@ -881,10 +882,10 @@ static void do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp,
 		kfree(buf);
 	} else {
 		vdisk = scsidev->hostdata;
-		if (atomic_read(&vdisk->ios_threshold) > 0) {
-			atomic_dec(&vdisk->ios_threshold);
-			if (atomic_read(&vdisk->ios_threshold) == 0)
-				atomic_set(&vdisk->error_count, 0);
+		if (seqnum32_read(&vdisk->ios_threshold) > 0) {
+			seqnum32_dec(&vdisk->ios_threshold);
+			if (seqnum32_read(&vdisk->ios_threshold) == 0)
+				seqnum32_set(&vdisk->error_count, 0);
 		}
 	}
 }
-- 
2.27.0

