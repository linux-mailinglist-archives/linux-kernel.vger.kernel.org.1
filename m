Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BEA2858E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgJGG50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGG5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:57:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A06C061755;
        Tue,  6 Oct 2020 23:57:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09100038f1dcf76f93be60.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1000:38f1:dcf7:6f93:be60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4A021EC0179;
        Wed,  7 Oct 2020 08:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602053844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zq3rr1Y+59gBPTEZDGzl8NbNlqp1qw3el1OyOvpvc/k=;
        b=kwvaL7HWKeL8hMvSdio5A8z8yuQVDcHe1dwVI6OTd6m7Mh0jF7Sargn7+wS67h5hsH0Wzs
        4mjwfjPF+koQ7Z5RuWDy1JGo3RpMCjQXg1dpJ0yd+M65UHU9U9IyyBHkCpk6rr9AqCBk7h
        dXfX/7tLhj5gOLsfulg/A7P8LHNG4c4=
Date:   Wed, 7 Oct 2020 08:57:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 03/13] x86/platform/uv: Adjust references in UV kernel
 modules
Message-ID: <20201007065715.GB5607@zn.tnic>
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-4-mike.travis@hpe.com>
 <20201005211611.GK21151@zn.tnic>
 <7598f508-6c4a-f1df-f83f-2f68bc99578f@hpe.com>
 <20201006131054.GD27700@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201006131054.GD27700@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending the updated version to the lists too so that it gets archived
properly.

---
From: Mike Travis <mike.travis@hpe.com>
Date: Tue, 6 Oct 2020 16:34:27 -0500
Subject: [PATCH] drivers/misc/sgi-xp: Adjust references in UV kernel modules

Remove the define is_uv() is_uv_system and just use the latter as is.
This removes a conflict with a new symbol in the generated uv_mmrs.h
file (is_uv()).

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-4-mike.travis@hpe.com
---
 drivers/misc/sgi-xp/xp.h            | 7 +------
 drivers/misc/sgi-xp/xp_main.c       | 4 ++--
 drivers/misc/sgi-xp/xp_uv.c         | 6 ++++--
 drivers/misc/sgi-xp/xpc_main.c      | 6 +++---
 drivers/misc/sgi-xp/xpc_partition.c | 2 +-
 drivers/misc/sgi-xp/xpnet.c         | 2 +-
 6 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
index 06469b12aced..2b6aabc61c6a 100644
--- a/drivers/misc/sgi-xp/xp.h
+++ b/drivers/misc/sgi-xp/xp.h
@@ -17,11 +17,6 @@
 
 #if defined CONFIG_X86_UV || defined CONFIG_IA64_SGI_UV
 #include <asm/uv/uv.h>
-#define is_uv()		is_uv_system()
-#endif
-
-#ifndef is_uv
-#define is_uv()		0
 #endif
 
 #ifdef USE_DBUG_ON
@@ -79,7 +74,7 @@
 
 #define XPC_MSG_SIZE(_payload_size) \
 				ALIGN(XPC_MSG_HDR_MAX_SIZE + (_payload_size), \
-				      is_uv() ? 64 : 128)
+				      is_uv_system() ? 64 : 128)
 
 
 /*
diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 61b03fcefb13..0eea2f518967 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -233,7 +233,7 @@ xp_init(void)
 	for (ch_number = 0; ch_number < XPC_MAX_NCHANNELS; ch_number++)
 		mutex_init(&xpc_registrations[ch_number].mutex);
 
-	if (is_uv())
+	if (is_uv_system())
 		ret = xp_init_uv();
 	else
 		ret = 0;
@@ -249,7 +249,7 @@ module_init(xp_init);
 static void __exit
 xp_exit(void)
 {
-	if (is_uv())
+	if (is_uv_system())
 		xp_exit_uv();
 }
 
diff --git a/drivers/misc/sgi-xp/xp_uv.c b/drivers/misc/sgi-xp/xp_uv.c
index f15a9f2ac1dd..5dcca03b26cb 100644
--- a/drivers/misc/sgi-xp/xp_uv.c
+++ b/drivers/misc/sgi-xp/xp_uv.c
@@ -148,7 +148,9 @@ xp_restrict_memprotect_uv(unsigned long phys_addr, unsigned long size)
 enum xp_retval
 xp_init_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_system());
+	if (!is_uv_system())
+		return xpUnsupported;
 
 	xp_max_npartitions = XP_MAX_NPARTITIONS_UV;
 #ifdef CONFIG_X86
@@ -168,5 +170,5 @@ xp_init_uv(void)
 void
 xp_exit_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_system());
 }
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 8a495dc82f16..e3261e63d1f6 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -1043,7 +1043,7 @@ xpc_do_exit(enum xp_retval reason)
 
 	xpc_teardown_partitions();
 
-	if (is_uv())
+	if (is_uv_system())
 		xpc_exit_uv();
 }
 
@@ -1226,7 +1226,7 @@ xpc_init(void)
 	dev_set_name(xpc_part, "part");
 	dev_set_name(xpc_chan, "chan");
 
-	if (is_uv()) {
+	if (is_uv_system()) {
 		ret = xpc_init_uv();
 
 	} else {
@@ -1312,7 +1312,7 @@ xpc_init(void)
 
 	xpc_teardown_partitions();
 out_1:
-	if (is_uv())
+	if (is_uv_system())
 		xpc_exit_uv();
 	return ret;
 }
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 099a53bdbb7d..a47b3bd75c08 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -433,7 +433,7 @@ xpc_discovery(void)
 	 */
 	region_size = xp_region_size;
 
-	if (is_uv())
+	if (is_uv_system())
 		max_regions = 256;
 	else {
 		max_regions = 64;
diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 837d6c3fe69c..8ee39910b309 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -515,7 +515,7 @@ xpnet_init(void)
 {
 	int result;
 
-	if (!is_uv())
+	if (!is_uv_system())
 		return -ENODEV;
 
 	dev_info(xpnet, "registering network device %s\n", XPNET_DEVICE_NAME);
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
