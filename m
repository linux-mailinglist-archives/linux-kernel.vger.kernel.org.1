Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8555A2AE052
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgKJTzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgKJTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:41 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:40 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id j12so15617741iow.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTh8wJz4qmx3CYWsrkecuCGXFUxr3+6Ltanw9weKYx4=;
        b=Uf1RujPLXXPVFLp5wjwLg1WsL++/OzJMdj3PLvk8+XchtewL/soIC/HUA+f8hedI/7
         45+te7QQ58VHov/x+NknT9Bbwb2CWiJqvMZ4olXEFH5FqPpvv0OXGPgwA/OspTJdRlcu
         ipfoLJiypyFlMt815A7OsVrc12fUOe2vp1Jog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTh8wJz4qmx3CYWsrkecuCGXFUxr3+6Ltanw9weKYx4=;
        b=oKfCF2NTeEgx4uzGJL7DLTME6XjOE2LWP9sgeyiOtd+CKTB+d/05psAllLD/ETIaqq
         JF7TfNandAajQlUGPwlb7joIBB0slXYZa5XjF/0m/EufaRZAIC5LXczcgT+CCuMeQ1M9
         hYNFabRw9P9eWD8ipnPSW7BEi8wDsQ8B92+LSmurNm1Bfj4+Mcve9+VY9P5afcyXgWYG
         cHxrVF53CQsDYvvpr0IqMGl/Z349o048fFER09wesufgkPslpHDTpTKYzqXyrFAIC1MX
         yPAzdKOhmCGAUS7arfO7aBUEHqIHbBRQQndGX0V1gfSnB8OFfzAB43Iq0NZRwA/JQXty
         qLfg==
X-Gm-Message-State: AOAM531BLaoIu6J1EObjQOSTxhzVPJ8xPX+v6YVej/MUn6XvXZml2S8S
        UnQfALmdkbajyC4ZPsdylFuMJw==
X-Google-Smtp-Source: ABdhPJwuhFy0zz6nJFugRrggDyBt4Yjp6uHFMgJd5Ho5vS6eDVq0OrbTu+MvHqiM1PWDFbsk9dHxQQ==
X-Received: by 2002:a05:6638:618:: with SMTP id g24mr17102192jar.53.1605038080314;
        Tue, 10 Nov 2020 11:54:40 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:39 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] drivers/char/ipmi: convert stats to use seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:32 -0700
Message-Id: <e383f5e0b72ecd524e65b5d4931f85db2b374ea0.1605027593.git.skhan@linuxfoundation.org>
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

atomic_t variables used for stats are atomic counters. Overflow will
wrap around and reset the stats and no change with the conversion.

Convert them to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 9 +++++----
 drivers/char/ipmi/ipmi_si_intf.c    | 9 +++++----
 drivers/char/ipmi/ipmi_ssif.c       | 9 +++++----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 8774a3b8ff95..a8f03b4dade9 100644
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
+	seqnum32_inc(&(intf)->stats[IPMI_STAT_ ## stat])
 #define ipmi_get_stat(intf, stat) \
-	((unsigned int) atomic_read(&(intf)->stats[IPMI_STAT_ ## stat]))
+	((unsigned int) seqnum32_read(&(intf)->stats[IPMI_STAT_ ## stat]))
 
 static const char * const addr_src_to_str[] = {
 	"invalid", "hotmod", "hardcoded", "SPMI", "ACPI", "SMBIOS", "PCI",
@@ -3468,7 +3469,7 @@ int ipmi_add_smi(struct module         *owner,
 	INIT_LIST_HEAD(&intf->cmd_rcvrs);
 	init_waitqueue_head(&intf->waitq);
 	for (i = 0; i < IPMI_NUM_STATS; i++)
-		atomic_set(&intf->stats[i], 0);
+		seqnum32_set(&intf->stats[i], 0);
 
 	mutex_lock(&ipmi_interfaces_mutex);
 	/* Look for a hole in the numbers. */
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 5eac94cf4ff8..e1354076a58a 100644
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
+	seqnum32_inc(&(smi)->stats[SI_STAT_ ## stat])
 #define smi_get_stat(smi, stat) \
-	((unsigned int) atomic_read(&(smi)->stats[SI_STAT_ ## stat]))
+	((unsigned int) seqnum32_read(&(smi)->stats[SI_STAT_ ## stat]))
 
 #define IPMI_MAX_INTFS 4
 static int force_kipmid[IPMI_MAX_INTFS];
@@ -2030,7 +2031,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	atomic_set(&new_smi->req_events, 0);
 	new_smi->run_to_completion = false;
 	for (i = 0; i < SI_NUM_STATS; i++)
-		atomic_set(&new_smi->stats[i], 0);
+		seqnum32_set(&new_smi->stats[i], 0);
 
 	new_smi->interrupt_disabled = true;
 	atomic_set(&new_smi->need_watch, 0);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 0416b9c9d410..0e61e072b213 100644
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
+	seqnum32_inc(&(ssif)->stats[SSIF_STAT_ ## stat])
 #define ssif_get_stat(ssif, stat) \
-	((unsigned int) atomic_read(&(ssif)->stats[SSIF_STAT_ ## stat]))
+	((unsigned int) seqnum32_read(&(ssif)->stats[SSIF_STAT_ ## stat]))
 
 static bool initialized;
 static bool platform_registered;
@@ -1864,7 +1865,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	timer_setup(&ssif_info->watch_timer, watch_timeout, 0);
 
 	for (i = 0; i < SSIF_NUM_STATS; i++)
-		atomic_set(&ssif_info->stats[i], 0);
+		seqnum32_set(&ssif_info->stats[i], 0);
 
 	if (ssif_info->supports_pec)
 		ssif_info->client->flags |= I2C_CLIENT_PEC;
-- 
2.27.0

