Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B17284191
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgJEUkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:40:31 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:21928 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729334AbgJEUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:40:29 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095Ka4Xm032757;
        Mon, 5 Oct 2020 20:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=IJ7mroTyNq/ChOcgWwWoqPxgW3LrF+iQHixRmurwxjs=;
 b=HJ4CAel639yxZ+Sl2l+WoV3yXQSDbhkywkgNAxwajSFL/ItRzwaqra5HwRnWptAxciwY
 POoX4c6BVdj0wXxfXfyYTTKUh3c3kyF8NcxDS/pufPSZkS30oImaegXzqaRH4V31TM2y
 9lmA/6mgxjErmD59yAy0T3aGQ2Z9D4Q/cthlD0pdu3oQbOJlfn9OdoRf+hIS1w1sE6kL
 O83wIekCmvwrmMky2SMmiiHXfQnknUl6QUJadRUKmvaLsGtWjf2AGRmQvcc+kgRk4PJP
 bzi37HfVgVezbjNT0bRf6o8IHm8yfTg3YOxdXRt138plM7lYLiR5zAGlOYuYul4U1qBR /Q== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xgdvkarv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:39:58 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 8FACA8D;
        Mon,  5 Oct 2020 20:39:57 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 6041748;
        Mon,  5 Oct 2020 20:39:56 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mike Travis <mike.travis@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 03/13] x86/platform/uv: Adjust references in UV kernel modules
Date:   Mon,  5 Oct 2020 15:39:19 -0500
Message-Id: <20201005203929.148656-4-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201005203929.148656-1-mike.travis@hpe.com>
References: <20201005203929.148656-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a small symbol change (is_uv() ==> is_uv_sys()) to accommodate a
change in the uv_mmrs.h file (is_uv() is the new arch selector function).

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 drivers/misc/sgi-xp/xp.h            | 8 ++++----
 drivers/misc/sgi-xp/xp_main.c       | 4 ++--
 drivers/misc/sgi-xp/xp_uv.c         | 6 ++++--
 drivers/misc/sgi-xp/xpc_main.c      | 6 +++---
 drivers/misc/sgi-xp/xpc_partition.c | 2 +-
 drivers/misc/sgi-xp/xpnet.c         | 2 +-
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
index 06469b12aced..0af267baf031 100644
--- a/drivers/misc/sgi-xp/xp.h
+++ b/drivers/misc/sgi-xp/xp.h
@@ -17,11 +17,11 @@
 
 #if defined CONFIG_X86_UV || defined CONFIG_IA64_SGI_UV
 #include <asm/uv/uv.h>
-#define is_uv()		is_uv_system()
+#define is_uv_sys()		is_uv_system()
 #endif
 
-#ifndef is_uv
-#define is_uv()		0
+#ifndef is_uv_sys
+#define is_uv_sys()		0
 #endif
 
 #ifdef USE_DBUG_ON
@@ -79,7 +79,7 @@
 
 #define XPC_MSG_SIZE(_payload_size) \
 				ALIGN(XPC_MSG_HDR_MAX_SIZE + (_payload_size), \
-				      is_uv() ? 64 : 128)
+				      is_uv_sys() ? 64 : 128)
 
 
 /*
diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 61b03fcefb13..33558555820d 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -233,7 +233,7 @@ xp_init(void)
 	for (ch_number = 0; ch_number < XPC_MAX_NCHANNELS; ch_number++)
 		mutex_init(&xpc_registrations[ch_number].mutex);
 
-	if (is_uv())
+	if (is_uv_sys())
 		ret = xp_init_uv();
 	else
 		ret = 0;
@@ -249,7 +249,7 @@ module_init(xp_init);
 static void __exit
 xp_exit(void)
 {
-	if (is_uv())
+	if (is_uv_sys())
 		xp_exit_uv();
 }
 
diff --git a/drivers/misc/sgi-xp/xp_uv.c b/drivers/misc/sgi-xp/xp_uv.c
index f15a9f2ac1dd..118aef64518d 100644
--- a/drivers/misc/sgi-xp/xp_uv.c
+++ b/drivers/misc/sgi-xp/xp_uv.c
@@ -148,7 +148,9 @@ xp_restrict_memprotect_uv(unsigned long phys_addr, unsigned long size)
 enum xp_retval
 xp_init_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_sys());
+	if (!is_uv_sys())
+		return xpUnsupported;
 
 	xp_max_npartitions = XP_MAX_NPARTITIONS_UV;
 #ifdef CONFIG_X86
@@ -168,5 +170,5 @@ xp_init_uv(void)
 void
 xp_exit_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_sys());
 }
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 8a495dc82f16..f533ded72941 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -1043,7 +1043,7 @@ xpc_do_exit(enum xp_retval reason)
 
 	xpc_teardown_partitions();
 
-	if (is_uv())
+	if (is_uv_sys())
 		xpc_exit_uv();
 }
 
@@ -1226,7 +1226,7 @@ xpc_init(void)
 	dev_set_name(xpc_part, "part");
 	dev_set_name(xpc_chan, "chan");
 
-	if (is_uv()) {
+	if (is_uv_sys()) {
 		ret = xpc_init_uv();
 
 	} else {
@@ -1312,7 +1312,7 @@ xpc_init(void)
 
 	xpc_teardown_partitions();
 out_1:
-	if (is_uv())
+	if (is_uv_sys())
 		xpc_exit_uv();
 	return ret;
 }
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 099a53bdbb7d..c21d48fd65cd 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -433,7 +433,7 @@ xpc_discovery(void)
 	 */
 	region_size = xp_region_size;
 
-	if (is_uv())
+	if (is_uv_sys())
 		max_regions = 256;
 	else {
 		max_regions = 64;
diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 837d6c3fe69c..fc5cd83f21f2 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -515,7 +515,7 @@ xpnet_init(void)
 {
 	int result;
 
-	if (!is_uv())
+	if (!is_uv_sys())
 		return -ENODEV;
 
 	dev_info(xpnet, "registering network device %s\n", XPNET_DEVICE_NAME);
-- 
2.21.0

