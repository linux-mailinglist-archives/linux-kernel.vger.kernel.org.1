Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E522E2C46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgLYUVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgLYUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:42 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EDAC06179E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:27 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id i18so4585008ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bz88LgYTNDla8UtDCkcXntb0SNk5qMglUOtDnk35ofk=;
        b=mOWRzKde/TkcGbx0RKiqKQ6LUw+v5oAf2jGLkOnccYxcJv2cyLHY2jxo6qz1hhC4F3
         WtrQDE4VR3trkFSBxzPZ2VH3BdKCbD0u/LiKmPvPwcfjcgc6wXNxZwr1AqThTAxmv2BC
         OLrYtvxy6W1elSGSsaWsP5QW9v776E0kWjZvL+sj4T+ZlzDec/Gj7GY5HaoagfdaltOY
         p0QrtbBii6LjFhiCTsuY3ldxj0wh8mMZJas8Zk558QhlBbCRtjOTEphZcVjB61BsQmX9
         em8OJixuW5LtW267If8f6K4k2rLPulyXhiyZUjRAYyP9YDsaLYOfOaqrySGUu/x9d/rJ
         uiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bz88LgYTNDla8UtDCkcXntb0SNk5qMglUOtDnk35ofk=;
        b=XMYNS6dyU4kuMD9zs5tOKBmsiQ+n95RoeDp1zJTkT6Qla0lReJY16+nly8fnXHS2PO
         SARSV+8uGZeOskwm3N89Qqr08iTQ5Hm7Y/Yw/w73j9oyn/nvJ3VUvZHtqMAbb8ouNIpM
         UPwYTBH9LPgGonJRivqSCTIIOO9lvGra9dtataMt0NED/Q7lk9/g4rAHdDQrx7yUKKmB
         l3WfI1Q4DkBRpPoQrUkgTszkwn2alCiWxnUSuuw4n4ZIR/Xb20vksuGsb+OI2g6K1aOQ
         KeSuDAQ+YSunQd8hezPfuindlTirkGOc27W3Y6ZFWSGZFt27bmzi5t9JA0dJX4y4JX3w
         +JpQ==
X-Gm-Message-State: AOAM532Ud2MX2bhwhatjDPK6gijqQ0TNaxCoOIKyOgYLm8rj3kKaqvEy
        XgNRZmXgjLhNF9QODfLTPhc=
X-Google-Smtp-Source: ABdhPJzql7VgBYjjnYC0FtY6g6ktuL8vgVaqjxNjt2jKwBMCGKz/Sg5TTuvu1Sp2+7vpUaGg/3JC0w==
X-Received: by 2002:a02:ac03:: with SMTP id a3mr30729097jao.71.1608927626895;
        Fri, 25 Dec 2020 12:20:26 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:26 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 13/19] dyndbg: verify __dyndbg & __dyndbg_callsite invariant
Date:   Fri, 25 Dec 2020 13:19:38 -0700
Message-Id: <20201225201944.3701590-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prove that linker + DECLARE_DYNAMIC_DEBUG_METADATA reliably place the
2 related struct _ddebug* initializations into parallel/ordered slots
in the __dyndbg_* sections.

This is a step towards dropping the pointer between the 2 structs;
maybe the 2 vectors stay ordered, and we can deduce and use N.  Of
course this test won't survive, since it needs the pointer we seek to
drop, but its a start.

0- iterate over __dyndbg_callsite in parallel with __dyndbg
   rename var: s/iter_start/iter_mod_start/ for clarity, consistency.

I disregarded a checkpatch warning about externs in c-files, staying
consistent with long-standing code seemed better.

1- prove that iter->site == site_iter.
   DECLARE_DYNAMIC_DEBUG_METADATA + linker insure this now
   Maybe we can drop pointer, still get order.

WRT the debug-printing, its noisy, but only with verbose=3.
It warrants trimming later.

The offset grows smoothly, because it is N * sizeof(structs), which
differ.  It looks reliable.  Amend later to do math, converge on
truth.  If numbers are stable after stripping pointer, we have N.

   	       	       rec   	      ptr      	       mod-ptr N (void*)p
[    1.929072] dyndbg: 2828: ffffffff82b32f28 ffffffff82b32f10 1 24 40
[    1.929326] dyndbg: 2829: ffffffff82b32f40 ffffffff82b32f10 2 48 80
[    1.930209] dyndbg:   2 debug prints in module i386

We have N (col 4), and N * structsize (col 5).  I feel like it still
needs more staring at.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2d10fc1e16cd..c1a113460637 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -41,6 +41,8 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
+extern struct _ddebug_callsite __start___dyndbg_callsites[];
+extern struct _ddebug_callsite __stop___dyndbg_callsites[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -119,6 +121,7 @@ do {								\
 
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
+#define v3pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -1147,7 +1150,8 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
-	struct _ddebug *iter, *iter_start;
+	struct _ddebug *iter, *iter_mod_start;
+	struct _ddebug_callsite *site, *site_mod_start;
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
@@ -1162,23 +1166,33 @@ static int __init dynamic_debug_init(void)
 		ddebug_init_success = 1;
 		return 0;
 	}
-	iter = __start___dyndbg;
+
+	iter = iter_mod_start = __start___dyndbg;
+	site = site_mod_start = __start___dyndbg_callsites;
 	modname = iter->site->modname;
-	iter_start = iter;
-	for (; iter < __stop___dyndbg; iter++) {
+
+	for (; iter < __stop___dyndbg; iter++, site++) {
+
+		BUG_ON(site != iter->site);
+		v3pr_info("%u: %px %ld %ld %ld\n", entries, site,
+			  site - site_mod_start,
+			  ((void *)site - (void *)site_mod_start),
+			  ((void *)iter - (void *)iter_mod_start));
 		entries++;
+
 		if (strcmp(modname, iter->site->modname)) {
 			modct++;
-			ret = ddebug_add_module(iter_start, n, modname);
+			ret = ddebug_add_module(iter_mod_start, n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
 			modname = iter->site->modname;
-			iter_start = iter;
+			iter_mod_start = iter;
+			site_mod_start = site;
 		}
 		n++;
 	}
-	ret = ddebug_add_module(iter_start, n, modname);
+	ret = ddebug_add_module(iter_mod_start, n, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.29.2

