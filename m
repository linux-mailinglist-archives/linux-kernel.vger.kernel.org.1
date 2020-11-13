Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C962B22F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKMRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgKMRqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:43 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58689C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:42 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y9so9230288ilb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ps/6H7hrK1ATADSAJ/P7uDiDCoe2QlP6mffaF3J5A5c=;
        b=a5dvCRcRRODlvMdlID+NlFVInONNQLGPdNimDwKArKb3vTyMagpLWi7+VrtAPN1dIJ
         7cxgpDFkMwgusrzXnSqokNwl8F4l/eQ7HYWMxpUKbVwqw0mGFWjRkZQpaar480/JHExv
         ZTFYPYKN9PWpNTzRf6Nxeb+fw6FX80B9mKtus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ps/6H7hrK1ATADSAJ/P7uDiDCoe2QlP6mffaF3J5A5c=;
        b=CKinoP5CyE+qYMnl29aje9FDlyB3HgFLFuAXXGEWNrpdUfTIGGVJ0j4ikQ50egkxBE
         bEgLd3avkdWSNIFWEEjT1PzLepljB2N6vklYBE2e7Jqc+l//WHAiTliUcZjuH74C+0/o
         hJjnueEyPRZRwpm4NSGC2BGdStdRxKGEfR9OnYUMXxN8O3IDLQ9SfRRZBpFUI3BgswMD
         LMydQGcRZ4f0CFwFZyO4AOAsqfv6EYcrX00D0Ltl9KC5YyVhtgTSz78arktWLJ32xk3Z
         CXJyUy3wtF//+l0WrbupxNW26HbifEoXiKlmm95Z9CjnHN3OHlnR1CJjG6jKIy4vzckl
         r+ig==
X-Gm-Message-State: AOAM530/6Zj/wSUpi1pr7IAwW8zVGJA8ToBX4kGgtoosYDCFAw8Miftu
        UnBwSXliGbXaUdYnZ51EiX28/w==
X-Google-Smtp-Source: ABdhPJy34jNE7u5FOVq2FNyrhEkY4l6HDPO6T6pMZc40jCWj39E58N9YgjT7bqu+ZrtLZuFjMEOMZg==
X-Received: by 2002:a92:9641:: with SMTP id g62mr785072ilh.166.1605289599323;
        Fri, 13 Nov 2020 09:46:39 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:38 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] drivers/char/ipmi: convert stats to use seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:08 -0700
Message-Id: <dc6bc91f50d3fe5c06b1157810e98b780bd0c737.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

Convert stats to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 9 +++++----
 drivers/char/ipmi/ipmi_si_intf.c    | 9 +++++----
 drivers/char/ipmi/ipmi_ssif.c       | 9 +++++----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 8774a3b8ff95..a21c8e6f391b 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -35,6 +35,7 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
+#include <linux/seqnum_ops.h>
 
 #define IPMI_DRIVER_VERSION "39.2"
 
@@ -587,7 +588,7 @@ struct ipmi_smi {
 	struct ipmi_my_addrinfo addrinfo[IPMI_MAX_CHANNELS];
 	bool channels_ready;
 
-	atomic_t stats[IPMI_NUM_STATS];
+	struct seqnum32 stats[IPMI_NUM_STATS];
 
 	/*
 	 * run_to_completion duplicate of smb_info, smi_info
@@ -633,9 +634,9 @@ static LIST_HEAD(smi_watchers);
 static DEFINE_MUTEX(smi_watchers_mutex);
 
 #define ipmi_inc_stat(intf, stat) \
-	atomic_inc(&(intf)->stats[IPMI_STAT_ ## stat])
+	seqnum32_inc_return(&(intf)->stats[IPMI_STAT_ ## stat])
 #define ipmi_get_stat(intf, stat) \
-	((unsigned int) atomic_read(&(intf)->stats[IPMI_STAT_ ## stat]))
+	(seqnum32_fetch(&(intf)->stats[IPMI_STAT_ ## stat]))
 
 static const char * const addr_src_to_str[] = {
 	"invalid", "hotmod", "hardcoded", "SPMI", "ACPI", "SMBIOS", "PCI",
@@ -3468,7 +3469,7 @@ int ipmi_add_smi(struct module         *owner,
 	INIT_LIST_HEAD(&intf->cmd_rcvrs);
 	init_waitqueue_head(&intf->waitq);
 	for (i = 0; i < IPMI_NUM_STATS; i++)
-		atomic_set(&intf->stats[i], 0);
+		seqnum32_init(&intf->stats[i]);
 
 	mutex_lock(&ipmi_interfaces_mutex);
 	/* Look for a hole in the numbers. */
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 5eac94cf4ff8..584742b51c22 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -43,6 +43,7 @@
 #include "ipmi_si_sm.h"
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/seqnum_ops.h>
 
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
@@ -237,7 +238,7 @@ struct smi_info {
 	bool dev_group_added;
 
 	/* Counters and things for the proc filesystem. */
-	atomic_t stats[SI_NUM_STATS];
+	struct seqnum32 stats[SI_NUM_STATS];
 
 	struct task_struct *thread;
 
@@ -245,9 +246,9 @@ struct smi_info {
 };
 
 #define smi_inc_stat(smi, stat) \
-	atomic_inc(&(smi)->stats[SI_STAT_ ## stat])
+	seqnum32_inc_return(&(smi)->stats[SI_STAT_ ## stat])
 #define smi_get_stat(smi, stat) \
-	((unsigned int) atomic_read(&(smi)->stats[SI_STAT_ ## stat]))
+	(seqnum32_fetch(&(smi)->stats[SI_STAT_ ## stat]))
 
 #define IPMI_MAX_INTFS 4
 static int force_kipmid[IPMI_MAX_INTFS];
@@ -2030,7 +2031,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	atomic_set(&new_smi->req_events, 0);
 	new_smi->run_to_completion = false;
 	for (i = 0; i < SI_NUM_STATS; i++)
-		atomic_set(&new_smi->stats[i], 0);
+		seqnum32_init(&new_smi->stats[i]);
 
 	new_smi->interrupt_disabled = true;
 	atomic_set(&new_smi->need_watch, 0);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 0416b9c9d410..d793286a635f 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -47,6 +47,7 @@
 #include <linux/acpi.h>
 #include <linux/ctype.h>
 #include <linux/time64.h>
+#include <linux/seqnum_ops.h>
 #include "ipmi_dmi.h"
 
 #define DEVICE_NAME "ipmi_ssif"
@@ -286,13 +287,13 @@ struct ssif_info {
 	unsigned int  multi_len;
 	unsigned int  multi_pos;
 
-	atomic_t stats[SSIF_NUM_STATS];
+	struct seqnum32 stats[SSIF_NUM_STATS];
 };
 
 #define ssif_inc_stat(ssif, stat) \
-	atomic_inc(&(ssif)->stats[SSIF_STAT_ ## stat])
+	seqnum32_inc_return(&(ssif)->stats[SSIF_STAT_ ## stat])
 #define ssif_get_stat(ssif, stat) \
-	((unsigned int) atomic_read(&(ssif)->stats[SSIF_STAT_ ## stat]))
+	(seqnum32_fetch(&(ssif)->stats[SSIF_STAT_ ## stat]))
 
 static bool initialized;
 static bool platform_registered;
@@ -1864,7 +1865,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	timer_setup(&ssif_info->watch_timer, watch_timeout, 0);
 
 	for (i = 0; i < SSIF_NUM_STATS; i++)
-		atomic_set(&ssif_info->stats[i], 0);
+		seqnum32_init(&ssif_info->stats[i]);
 
 	if (ssif_info->supports_pec)
 		ssif_info->client->flags |= I2C_CLIENT_PEC;
-- 
2.27.0

