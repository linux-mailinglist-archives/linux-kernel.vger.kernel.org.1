Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D295E279508
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgIYXsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgIYXrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:49 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07617C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:49 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id u25so3941573otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmRfoFNjm32MJppIvwnVOxmGu6mVqX/eJrRrmwzrCvU=;
        b=X8P/rYP0Seq/88Ms3vAbLHlroX+VYILiUkHpVrwta2FxId8VjtZGUD1PUEnVQxh+wQ
         agDjDbHEJ/cmHeKEqa+KRhhyOUTjT+S4a4kIgrvY5Hf+zmbVaESgT0n93B1nyPgwvesC
         6mbvUEs7fccXkYUa6jKKhumvHR096Q2VYohcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmRfoFNjm32MJppIvwnVOxmGu6mVqX/eJrRrmwzrCvU=;
        b=UfQ8oyhMVOiVbdY+uY3Sp3Qg3zse25eHv7T5vB0qdmutJgrpPxjSy4kTcDX/Raq4Y7
         EIxwTLYB9B+V8gONrPGbt2ThVQHwaR4JMm5+3WVjf/AkGn5kfIop50cSvuYLOaFNC0NB
         oDsTqjam4IWP9I0GIRJIPFLEvPK2Du2PMAiFYXm+chdbV0yYAWIo1tJrQviy/ieGPlu6
         +nI66cerzIrYlZb8vD55+tUKPol6fo9+8+YxAp/ho4VV2I920sX40iAfaD+xPPsJJ0lV
         jKnh7rAnI838jcaW78Ka3r4/H0BOKrW9l/oDVu8aLONX1CribFqIJIeSwqb4wA3xYkmW
         X7+Q==
X-Gm-Message-State: AOAM531AlaMkfumqIIi8fhq1AItp3TW2bWBgD/uLnp/XWSxZkaOpPZKo
        Z9P17FS7LEZ3eeRdODZj5pr2GA==
X-Google-Smtp-Source: ABdhPJx1xHe2TNTmVPDgBfINwwpJ2fJsRwqjcHZrIcAQEsGcXzWAp6fx8hbz937gkjb7n1G2ovDPZg==
X-Received: by 2002:a05:6830:16d1:: with SMTP id l17mr1956852otr.105.1601077668413;
        Fri, 25 Sep 2020 16:47:48 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:47 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] drivers/char/ipmi: convert stats to use counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:23 -0600
Message-Id: <b742c2637a8b6083c471a6dd829db70071909f83.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used for stats are atomic counters. Overflow will
wrap around and reset the stats and no change with the conversion.

Convert them to use counter_atomic32.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 9 +++++----
 drivers/char/ipmi/ipmi_si_intf.c    | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 737c0b6b24ea..36c0b1be22fb 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -34,6 +34,7 @@
 #include <linux/uuid.h>
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
+#include <linux/counters.h>
 
 #define IPMI_DRIVER_VERSION "39.2"
 
@@ -584,7 +585,7 @@ struct ipmi_smi {
 	struct ipmi_my_addrinfo addrinfo[IPMI_MAX_CHANNELS];
 	bool channels_ready;
 
-	atomic_t stats[IPMI_NUM_STATS];
+	struct counter_atomic32 stats[IPMI_NUM_STATS];
 
 	/*
 	 * run_to_completion duplicate of smb_info, smi_info
@@ -630,9 +631,9 @@ static LIST_HEAD(smi_watchers);
 static DEFINE_MUTEX(smi_watchers_mutex);
 
 #define ipmi_inc_stat(intf, stat) \
-	atomic_inc(&(intf)->stats[IPMI_STAT_ ## stat])
+	counter_atomic32_inc(&(intf)->stats[IPMI_STAT_ ## stat])
 #define ipmi_get_stat(intf, stat) \
-	((unsigned int) atomic_read(&(intf)->stats[IPMI_STAT_ ## stat]))
+	((unsigned int) counter_atomic32_read(&(intf)->stats[IPMI_STAT_ ## stat]))
 
 static const char * const addr_src_to_str[] = {
 	"invalid", "hotmod", "hardcoded", "SPMI", "ACPI", "SMBIOS", "PCI",
@@ -3448,7 +3449,7 @@ int ipmi_add_smi(struct module         *owner,
 	INIT_LIST_HEAD(&intf->cmd_rcvrs);
 	init_waitqueue_head(&intf->waitq);
 	for (i = 0; i < IPMI_NUM_STATS; i++)
-		atomic_set(&intf->stats[i], 0);
+		counter_atomic32_set(&intf->stats[i], 0);
 
 	mutex_lock(&ipmi_interfaces_mutex);
 	/* Look for a hole in the numbers. */
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 77b8d551ae7f..0909a3461f05 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -43,6 +43,7 @@
 #include "ipmi_si_sm.h"
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/counters.h>
 
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
@@ -237,7 +238,7 @@ struct smi_info {
 	bool dev_group_added;
 
 	/* Counters and things for the proc filesystem. */
-	atomic_t stats[SI_NUM_STATS];
+	struct counter_atomic32 stats[SI_NUM_STATS];
 
 	struct task_struct *thread;
 
@@ -245,9 +246,9 @@ struct smi_info {
 };
 
 #define smi_inc_stat(smi, stat) \
-	atomic_inc(&(smi)->stats[SI_STAT_ ## stat])
+	counter_atomic32_inc(&(smi)->stats[SI_STAT_ ## stat])
 #define smi_get_stat(smi, stat) \
-	((unsigned int) atomic_read(&(smi)->stats[SI_STAT_ ## stat]))
+	((unsigned int) counter_atomic32_read(&(smi)->stats[SI_STAT_ ## stat]))
 
 #define IPMI_MAX_INTFS 4
 static int force_kipmid[IPMI_MAX_INTFS];
@@ -2013,7 +2014,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	atomic_set(&new_smi->req_events, 0);
 	new_smi->run_to_completion = false;
 	for (i = 0; i < SI_NUM_STATS; i++)
-		atomic_set(&new_smi->stats[i], 0);
+		counter_atomic32_set(&new_smi->stats[i], 0);
 
 	new_smi->interrupt_disabled = true;
 	atomic_set(&new_smi->need_watch, 0);
-- 
2.25.1

