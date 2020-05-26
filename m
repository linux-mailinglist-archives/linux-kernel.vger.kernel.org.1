Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E178B1D595C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEOSo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 14:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgEOSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:44:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF2C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r22so1380052pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wn6ypjkzPzOI51JfpPytAe9W9LrByQzRJgbhdTJgJLY=;
        b=fLAOas8UytEMEuOHkSD/MTWxAdKKDcCSojUkeKD5B8LYOU7Zv4l+8u5B4JVyPSP6C4
         8ipGsg5hox73FNmq6seEXxSer2lcYMaEyxjcUSVNkubdCfw1DYQwN8WsmS6+FWZjHOyL
         cu7betXEgRol3XnVliAs2nmOCHAowSagOq/Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wn6ypjkzPzOI51JfpPytAe9W9LrByQzRJgbhdTJgJLY=;
        b=GoTBYqyM3NGnBwz+nud7KqIeiYalPt6gY8Wz95mAy1NuT7am6hkcrpkIgD/Driq+zd
         kApzqLnpUua6kFLqjYpAaIuMpe0zUirWJM1BkhubZBjyhX26wJhYDP6iFXTwZQYzvjOt
         EEbeLLnYP3mMy65V+5QMrHiVZPoG3/AUeHSt2/KtSUZvv+QoCk6HBuxYSNOiuH1nBNno
         q9U4Sfs2ltOiAFAAjix08k31jfZy/Cdj1vNRx2t4uef5KdBieqlGnqbYHlJX3F2+u/t4
         Ez48Ekp/p7Ib6a1IjVXkTVAVc0Ncsh08VRxBOx5C0pocw01Grkzug9zleHsSSZyONzAV
         yD0A==
X-Gm-Message-State: AOAM533+WgKUUdo7ZTa0kmfLZayhMzdFxF65bnN8UGhc298tB8okz009
        avLpgHcxd/xC3WUpCfGwG9gvMyMLO0w=
X-Google-Smtp-Source: ABdhPJy3Nobyh0/im9VH2ko3bhn3BAuyum2n6M4bUWEZCUn6dqVoyHqGHbrFgX+H0y8MoVT57t8H2w==
X-Received: by 2002:a62:5289:: with SMTP id g131mr5469021pfb.318.1589568284713;
        Fri, 15 May 2020 11:44:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p190sm2596759pfp.207.2020.05.15.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:44:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 5/6] pstore/ram: Introduce max_reason and convert dump_oops
Date:   Fri, 15 May 2020 11:44:33 -0700
Message-Id: <20200515184434.8470-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515184434.8470-1-keescook@chromium.org>
References: <20200515184434.8470-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that pstore_register() can correctly pass max_reason to the kmesg
dump facility, introduce a new "max_reason" module parameter and
"max-reason" Device Tree field.

The "dump_oops" module parameter and "dump-oops" Device
Tree field are now considered deprecated, but are now automatically
converted to their corresponding max_reason values when present, though
the new max_reason setting has precedence.

For struct ramoops_platform_data, the "dump_oops" member is entirely
replaced by a new "max_reason" member, with the only existing user
updated in place.

Additionally remove the "reason" filter logic from ramoops_pstore_write(),
as that is not specifically needed anymore, though technically
this is a change in behavior for any ramoops users also setting the
printk.always_kmsg_dump boot param, which will cause ramoops to behave as
if max_reason was set to KMSG_DUMP_MAX.

Co-developed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/lkml/20200506211523.15077-5-keescook@chromium.org/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/ramoops.rst     | 14 ++++--
 drivers/platform/chrome/chromeos_pstore.c |  2 +-
 fs/pstore/ram.c                           | 58 +++++++++++++++--------
 include/linux/pstore_ram.h                |  2 +-
 4 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index 6dbcc5481000..a60a96218ba9 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -32,11 +32,17 @@ memory to be mapped strongly ordered, and atomic operations on strongly ordered
 memory are implementation defined, and won't work on many ARMs such as omaps.
 
 The memory area is divided into ``record_size`` chunks (also rounded down to
-power of two) and each oops/panic writes a ``record_size`` chunk of
+power of two) and each kmesg dump writes a ``record_size`` chunk of
 information.
 
-Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
-variable while setting 0 in that variable dumps only the panics.
+Limiting which kinds of kmsg dumps are stored can be controlled via
+the ``max_reason`` value, as defined in include/linux/kmsg_dump.h's
+``enum kmsg_dump_reason``. For example, to store both Oopses and Panics,
+``max_reason`` should be set to 2 (KMSG_DUMP_OOPS), to store only Panics
+``max_reason`` should be set to 1 (KMSG_DUMP_PANIC). Setting this to 0
+(KMSG_DUMP_UNDEF), means the reason filtering will be controlled by the
+``printk.always_kmsg_dump`` boot param: if unset, it'll be KMSG_DUMP_OOPS,
+otherwise KMSG_DUMP_MAX.
 
 The module uses a counter to record multiple dumps but the counter gets reset
 on restart (i.e. new dumps after the restart will overwrite old ones).
@@ -90,7 +96,7 @@ Setting the ramoops parameters can be done in several different manners:
         .mem_address            = <...>,
         .mem_type               = <...>,
         .record_size            = <...>,
-        .dump_oops              = <...>,
+        .max_reason             = <...>,
         .ecc                    = <...>,
   };
 
diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index d13770785fb5..fa51153688b4 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -57,7 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
 	.record_size	= 0x40000,
 	.console_size	= 0x20000,
 	.ftrace_size	= 0x20000,
-	.dump_oops	= 1,
+	.max_reason	= KMSG_DUMP_OOPS,
 };
 
 static struct platform_device chromeos_ramoops = {
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 31f277633beb..f6eace1dbf7e 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -58,10 +58,10 @@ module_param(mem_type, uint, 0400);
 MODULE_PARM_DESC(mem_type,
 		"set to 1 to try to use unbuffered memory (default 0)");
 
-static int dump_oops = 1;
-module_param(dump_oops, int, 0400);
-MODULE_PARM_DESC(dump_oops,
-		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
+static int ramoops_max_reason = -1;
+module_param_named(max_reason, ramoops_max_reason, int, 0400);
+MODULE_PARM_DESC(max_reason,
+		 "maximum reason for kmsg dump (default 2: Oops and Panic) ");
 
 static int ramoops_ecc;
 module_param_named(ecc, ramoops_ecc, int, 0400);
@@ -70,6 +70,11 @@ MODULE_PARM_DESC(ramoops_ecc,
 		"ECC buffer size in bytes (1 is a special value, means 16 "
 		"bytes ECC)");
 
+static int ramoops_dump_oops = -1;
+module_param_named(dump_oops, ramoops_dump_oops, int, 0400);
+MODULE_PARM_DESC(dump_oops,
+		 "(deprecated: use max_reason instead) set to 1 to dump oopses & panics, 0 to only dump panics");
+
 struct ramoops_context {
 	struct persistent_ram_zone **dprzs;	/* Oops dump zones */
 	struct persistent_ram_zone *cprz;	/* Console zone */
@@ -82,7 +87,6 @@ struct ramoops_context {
 	size_t console_size;
 	size_t ftrace_size;
 	size_t pmsg_size;
-	int dump_oops;
 	u32 flags;
 	struct persistent_ram_ecc_info ecc_info;
 	unsigned int max_dump_cnt;
@@ -336,16 +340,14 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
 		return -EINVAL;
 
 	/*
-	 * Out of the various dmesg dump types, ramoops is currently designed
-	 * to only store crash logs, rather than storing general kernel logs.
+	 * We could filter on record->reason here if we wanted to (which
+	 * would duplicate what happened before the "max_reason" setting
+	 * was added), but that would defeat the purpose of a system
+	 * changing printk.always_kmsg_dump, so instead log everything that
+	 * the kmsg dumper sends us, since it should be doing the filtering
+	 * based on the combination of printk.always_kmsg_dump and our
+	 * requested "max_reason".
 	 */
-	if (record->reason != KMSG_DUMP_OOPS &&
-	    record->reason != KMSG_DUMP_PANIC)
-		return -EINVAL;
-
-	/* Skip Oopes when configured to do so. */
-	if (record->reason == KMSG_DUMP_OOPS && !cxt->dump_oops)
-		return -EINVAL;
 
 	/*
 	 * Explicitly only take the first part of any new crash.
@@ -647,7 +649,14 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	pdata->mem_size = resource_size(res);
 	pdata->mem_address = res->start;
 	pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
-	pdata->dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
+	/*
+	 * Setting "no-dump-oops" is deprecated and will be ignored if
+	 * "max_reason" is also specified.
+	 */
+	if (of_property_read_bool(of_node, "no-dump-oops"))
+		pdata->max_reason = KMSG_DUMP_PANIC;
+	else
+		pdata->max_reason = KMSG_DUMP_OOPS;
 
 #define parse_u32(name, field, default_value) {				\
 		ret = ramoops_parse_dt_u32(pdev, name, default_value,	\
@@ -663,6 +672,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	parse_u32("pmsg-size", pdata->pmsg_size, 0);
 	parse_u32("ecc-size", pdata->ecc_info.ecc_size, 0);
 	parse_u32("flags", pdata->flags, 0);
+	parse_u32("max-reason", pdata->max_reason, pdata->max_reason);
 
 #undef parse_size
 
@@ -746,7 +756,6 @@ static int ramoops_probe(struct platform_device *pdev)
 	cxt->console_size = pdata->console_size;
 	cxt->ftrace_size = pdata->ftrace_size;
 	cxt->pmsg_size = pdata->pmsg_size;
-	cxt->dump_oops = pdata->dump_oops;
 	cxt->flags = pdata->flags;
 	cxt->ecc_info = pdata->ecc_info;
 
@@ -789,8 +798,10 @@ static int ramoops_probe(struct platform_device *pdev)
 	 * the single region size is how to check.
 	 */
 	cxt->pstore.flags = 0;
-	if (cxt->max_dump_cnt)
+	if (cxt->max_dump_cnt) {
 		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
+		cxt->pstore.max_reason = pdata->max_reason;
+	}
 	if (cxt->console_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
 	if (cxt->max_ftrace_cnt)
@@ -826,7 +837,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	mem_size = pdata->mem_size;
 	mem_address = pdata->mem_address;
 	record_size = pdata->record_size;
-	dump_oops = pdata->dump_oops;
+	ramoops_max_reason = pdata->max_reason;
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
@@ -909,7 +920,16 @@ static void __init ramoops_register_dummy(void)
 	pdata.console_size = ramoops_console_size;
 	pdata.ftrace_size = ramoops_ftrace_size;
 	pdata.pmsg_size = ramoops_pmsg_size;
-	pdata.dump_oops = dump_oops;
+	/* If "max_reason" is set, its value has priority over "dump_oops". */
+	if (ramoops_max_reason != -1)
+		pdata.max_reason = ramoops_max_reason;
+	/* Otherwise, if "dump_oops" is set, parse it into "max_reason". */
+	else if (ramoops_dump_oops != -1)
+		pdata.max_reason = ramoops_dump_oops ? KMSG_DUMP_OOPS
+						     : KMSG_DUMP_PANIC;
+	/* And if neither are explicitly set, use the default. */
+	else
+		pdata.max_reason = KMSG_DUMP_OOPS;
 	pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
 
 	/*
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9cb9b9067298..9f16afec7290 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -133,7 +133,7 @@ struct ramoops_platform_data {
 	unsigned long	console_size;
 	unsigned long	ftrace_size;
 	unsigned long	pmsg_size;
-	int		dump_oops;
+	int		max_reason;
 	u32		flags;
 	struct persistent_ram_ecc_info ecc_info;
 };
-- 
2.20.1

