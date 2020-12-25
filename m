Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE32E2C49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgLYUV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgLYUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:39 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3EC06179C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:26 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m23so4591457ioy.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aoRtjGGmDkoPVRZQqU2F8ks+JZ5/f7iUPdclmyg7810=;
        b=Pm/wRh9Nzgjv2yyaCJeWJEfoRYyA+Rit0C75+VKw68jPFmel6odSR8txI73Yc3VmYc
         JLv6mctAg3sNw/p+bqowIds86ClphIaYfqMBIsvNDCgfEv9BGTxB8L/I2qZPvZnqp0Pa
         g/xtfPjRDlHNPX+c3OM+qo4nodi4vaFdAzKcWIZG3UIyZobVNT6vfFPepiGwKGOcL9SD
         cWv3jocYS8kZf/yShoNfpjUzNKaEtyD2Sz6LXxhsKk0UdPhipqjihCYgeyNk47GiIkME
         FXC4JVq1RoKBMweC4UPyMfHtncJ8tpJMvcCY6l24hrWpn0+xbRYH60/bTLXx9G56UHqT
         cODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aoRtjGGmDkoPVRZQqU2F8ks+JZ5/f7iUPdclmyg7810=;
        b=bnriTmiCdmKBNA84aHHqJShMZvj7KH92Wr2AsJdoQ2MNz0u2HTaKk2Q3MD63VcZ3Yv
         RvUSHWh56JwNRFjY7cE2chKKWDMRa0CJK3v9mfEzOEnO01DsuGc830iyOs9rx7wZ3yo3
         tXmB5UcpH7bFzlE9N7XevnB8fVIGbUTALMW6jvuC172nggD1aiFMx5UZnrrpGQm5TWBW
         sEUHnHSJNCGPM9Wl4xOtvThdMSHYoPYjT4c+EJZlchTbWic9HF0MSUCMJsoWYNSBDxzN
         MRbXl3w75DbeIF7Jq0oC/Mf2I1zZS+Q9FjVPSvkUJPlrhBnIbNCbTdC0sMqj/KDkAUSU
         OamA==
X-Gm-Message-State: AOAM531UK4oImfWAkWAt0UkExLyV/fqAxdRWr9cwNZAakNp7YbDbYGVU
        55uqq6i5H++jmv0fFDubQiE65DgkM21GBA==
X-Google-Smtp-Source: ABdhPJzbWDKBSToS98Kl13BFbHHdyxZuTwXxrG/K9hzViQcdF8FH4lEx9QERZ0wWVXoASqP0PQCuzw==
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr29633367jaq.102.1608927625991;
        Fri, 25 Dec 2020 12:20:25 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:25 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 12/19] dyndbg: allow deleting site info via control interface
Date:   Fri, 25 Dec 2020 13:19:37 -0700
Message-Id: <20201225201944.3701590-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users & subsystems to selectively delete callsite info for
individual pr-debug callsites, or groups of them.

Its purpose is for subsystems such as DRM which:

- use distinct categories for logging, and can map them over to a
  format prefix, like: "drm:core:", "drm:kms:", etc.

- are happy with group control of all the callsites in a class/cateory.
  individual control is still possible using queries including line numbers

- don't need dynamic "module:function:line:" prefixes in log messages

- don't care about loss of context in /proc/dynamic_debug/control

before:

init/initramfs.c:485 [initramfs]unpack_to_rootfs =_ "Detected %s compressed data\012"
init/main.c:1337 [main]run_init_process =pm "    %s\012"
init/main.c:1335 [main]run_init_process =pm "  with environment:\012"
init/main.c:1334 [main]run_init_process =pm "    %s\012"
init/main.c:1332 [main]run_init_process =pm "  with arguments:\012"
init/main.c:1121 [main]initcall_blacklisted =pm "initcall %s blacklisted\012"
init/main.c:1082 [main]initcall_blacklist =pm "blacklisting initcall %s\012"

then:
  bash-5.0# echo file init/main.c +D > /proc/dynamic_debug/control

after:

init/initramfs.c:485 [initramfs]unpack_to_rootfs =_ "Detected %s compressed data\012"
[main]:1337 =pmD "    %s\012"
[main]:1335 =pmD "  with environment:\012"
[main]:1334 =pmD "    %s\012"
[main]:1332 =pmD "  with arguments:\012"
[main]:1121 =pmD "initcall %s blacklisted\012"
[main]:1082 =pmD "blacklisting initcall %s\012"

Notes:

If Drm adopted dyndbg, i915 + drm* would add ~1600 prdebugs, amdgpu +
drm* would add ~3200 callsites, so the additional memory costs are
substantial.  In trade, drm and drivers would avoid lots of calls to
drm_debug_enabled().  This patch should reduce the costs.

Using this interface, drm could drop site info for all categories /
prefixes controlled by bits in drm.debug, while preserving site info
and individual selectivity for any uncategorized prdebugs.

Lastly, because lineno field was not moved into _ddebug_callsite, it
can be used to modify a single[*] callsite even if drm has dropped all
the callsite data:

  echo module $mod format ^$prefix line $line +p >control

Dropping a _callsite a one-way, information losing operation, so minor
misuse is possible.  Worst case is maybe (depending upon previous
settings) some loss of logging context/decorations.

  echo +D > /proc/dynamic_debug/control

[*] amdgpu has some macros invoking clusters of pr_debugs; each use of
them creates a cluster of pr-debugs with the same line number.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 1 +
 lib/dynamic_debug.c           | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ea07a91a43bc..49fa1390d1f8 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,6 +40,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_DELETE_SITE	(1<<7) /* drop site info to save ram */
 
 #define _DPRINTK_FLAGS_INCL_ANYSITE		\
 	(_DPRINTK_FLAGS_INCL_MODNAME		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6203a6ad1706..2d10fc1e16cd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -90,6 +90,7 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
+	{ _DPRINTK_FLAGS_DELETE_SITE, 'D' },
 };
 
 struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
@@ -198,6 +199,14 @@ static inline void ddebug_alter_site(struct _ddebug *dp,
 	} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
 		static_branch_enable(&dp->key.dd_key_true);
 #endif
+	/* delete site info for this callsite */
+	if (modifiers->flags & _DPRINTK_FLAGS_DELETE_SITE) {
+		if (dp->site) {
+			vpr_info("dropping site info %s.%s.%d\n", dp->site->filename,
+				dp->site->function, dp->lineno);
+			dp->site = NULL;
+		}
+	}
 }
 
 /*
-- 
2.29.2

