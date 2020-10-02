Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD7280BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgJBAc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:32:58 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:4638 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgJBAc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:32:58 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09203Yd3007410;
        Fri, 2 Oct 2020 00:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=IJ7mroTyNq/ChOcgWwWoqPxgW3LrF+iQHixRmurwxjs=;
 b=PzYBD3H4dSHpcg7Gtrd/6Fcvw+Y8musn3l2EuR+X1caF7XQ/xWDz9drdS96baVF0qGaZ
 llh5f2RibOAforMnYTXY0DsT6Lo+r6PG0tpsqvSIuHnWqjeA3L9GsjWgehitZSfarj1a
 q059k/FYlbDkncGv+jo2uV3YYd8sX61BMMxkBXAI1O8v7iZD5j5P+KlbLfkUzRdiwypu
 eHFeTKdd+YRBFgohxeLvy2xDEuIHE78HMeUzxQpvmRIJaJKcwDQdjXFvyLk/1U5w7K5/
 r+6K2r0tdD+gqLVjvECUDobqqbpz6eZKCNZqFhndLlHlyXWrzpMyWHTe+BZkiYU+olwL Zg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 33wjxx2u4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 00:06:23 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 6BD6A8C;
        Fri,  2 Oct 2020 00:06:22 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 559453D;
        Fri,  2 Oct 2020 00:06:21 +0000 (UTC)
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
Subject: [PATCH v3 03/13] x86/platform/uv: Adjust references in UV kernel modules
Date:   Thu,  1 Oct 2020 19:05:28 -0500
Message-Id: <20201002000538.94424-4-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201002000538.94424-1-mike.travis@hpe.com>
References: <20201002000538.94424-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=929
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010195
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

