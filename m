Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77612280BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbgJBAeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:34:20 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:60400 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728090AbgJBAeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:34:19 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09201Sdi001898;
        Fri, 2 Oct 2020 00:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=C/+N6ncBmR/t13xz2zLQxWqQbbKe+fG/q2DxNyf9w2Q=;
 b=egHMuaiOmIjTyzHu5NOBeOhGFPALvU6mydWPbXZ1QW02RGf2dCntAG9iFD2nSLPbXs1t
 F375U3JR10kMp7YWvke8mkbK8PyXOHj9XsakjBvgPaaghpC2UeCAD15MImsDoV878xAH
 U4L3gVclZ7RynpoZHvzfLJ0U4kR8ot0rUBrM334HM69nc1fuKEwGDVmNCFrDymr0J2i8
 D6cpTsFduLc5EnOckn2UrF+Fi7MyxLpFdPBEruEWNQ+D9Llw6zHv8NckjyEsKnvEXK44
 g+fqvGhE3Wb2GsctSJ6VqrOnH7Gz6v1FGuxHdCMdOZmTVZGcxJpJO8DWhy1L+Ikjv7Qn IQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 33vrk3qsxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 00:06:33 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 0BE339D;
        Fri,  2 Oct 2020 00:06:33 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id E480B3A;
        Fri,  2 Oct 2020 00:06:31 +0000 (UTC)
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
Subject: [PATCH v3 12/13] x86/platform/uv: Update for UV5 NMI MMR changes
Date:   Thu,  1 Oct 2020 19:05:37 -0500
Message-Id: <20201002000538.94424-13-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201002000538.94424-1-mike.travis@hpe.com>
References: <20201002000538.94424-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UV NMI MMR addresses and fields moved between UV4 and UV5
necessitating a rewrite of the UV NMI handler.  Adjust references
to accommodate those changes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h | 13 -------
 arch/x86/platform/uv/uv_nmi.c    | 64 +++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 07079b59824d..610bda21a8d9 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -734,19 +734,6 @@ extern void uv_nmi_setup_hubless(void);
 #define UVH_NMI_MMR_SHIFT	63
 #define UVH_NMI_MMR_TYPE	"SCRATCH5"
 
-/* Newer SMM NMI handler, not present in all systems */
-#define UVH_NMI_MMRX		UVH_EVENT_OCCURRED0
-#define UVH_NMI_MMRX_CLEAR	UVH_EVENT_OCCURRED0_ALIAS
-#define UVH_NMI_MMRX_SHIFT	UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT
-#define UVH_NMI_MMRX_TYPE	"EXTIO_INT0"
-
-/* Non-zero indicates newer SMM NMI handler present */
-#define UVH_NMI_MMRX_SUPPORTED	UVH_EXTIO_INT0_BROADCAST
-
-/* Indicates to BIOS that we want to use the newer SMM NMI handler */
-#define UVH_NMI_MMRX_REQ	UVH_BIOS_KERNEL_MMR_ALIAS_2
-#define UVH_NMI_MMRX_REQ_SHIFT	62
-
 struct uv_hub_nmi_s {
 	raw_spinlock_t	nmi_lock;
 	atomic_t	in_nmi;		/* flag this node in UV NMI IRQ */
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 9d08ff5a755e..eac26feb0461 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -2,8 +2,8 @@
 /*
  * SGI NMI support routines
  *
- *  Copyright (c) 2009-2013 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Mike Travis
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Mike Travis
  */
 
 #include <linux/cpu.h>
@@ -54,6 +54,20 @@ static struct uv_hub_nmi_s **uv_hub_nmi_list;
 
 DEFINE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
 
+/* Newer SMM NMI handler, not present in all systems */
+static unsigned long uvh_nmi_mmrx;		/* UVH_EVENT_OCCURRED0/1 */
+static unsigned long uvh_nmi_mmrx_clear;	/* UVH_EVENT_OCCURRED0/1_ALIAS */
+static int uvh_nmi_mmrx_shift;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
+static int uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
+static char *uvh_nmi_mmrx_type;			/* "EXTIO_INT0" */
+
+/* Non-zero indicates newer SMM NMI handler present */
+static unsigned long uvh_nmi_mmrx_supported;	/* UVH_EXTIO_INT0_BROADCAST */
+
+/* Indicates to BIOS that we want to use the newer SMM NMI handler */
+static unsigned long uvh_nmi_mmrx_req;		/* UVH_BIOS_KERNEL_MMR_ALIAS_2 */
+static int uvh_nmi_mmrx_req_shift;		/* 62 */
+
 /* UV hubless values */
 #define NMI_CONTROL_PORT	0x70
 #define NMI_DUMMY_PORT		0x71
@@ -227,13 +241,43 @@ static inline bool uv_nmi_action_is(const char *action)
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
-	if (uv_read_local_mmr(UVH_NMI_MMRX_SUPPORTED)) {
-		uv_write_local_mmr(UVH_NMI_MMRX_REQ,
-					1UL << UVH_NMI_MMRX_REQ_SHIFT);
-		nmi_mmr = UVH_NMI_MMRX;
-		nmi_mmr_clear = UVH_NMI_MMRX_CLEAR;
-		nmi_mmr_pending = 1UL << UVH_NMI_MMRX_SHIFT;
-		pr_info("UV: SMI NMI support: %s\n", UVH_NMI_MMRX_TYPE);
+	/* First determine arch specific MMRs to handshake with BIOS */
+	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
+		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
+		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
+		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
+		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
+		uvh_nmi_mmrx_type = "OCRD0-EXTIO_INT0";
+
+		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
+		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
+		uvh_nmi_mmrx_req_shift = 62;
+
+	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) {
+		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
+		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
+		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
+		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK;
+		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
+
+		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
+		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
+		uvh_nmi_mmrx_req_shift = 62;
+
+	} else {
+		pr_err("UV:%s:cannot find EVENT_OCCURRED*_EXTIO_INT0\n",
+			__func__);
+		return;
+	}
+
+	/* Then find out if new NMI is supported */
+	if (likely(uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
+		uv_write_local_mmr(uvh_nmi_mmrx_req,
+					1UL << uvh_nmi_mmrx_req_shift);
+		nmi_mmr = uvh_nmi_mmrx;
+		nmi_mmr_clear = uvh_nmi_mmrx_clear;
+		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
+		pr_info("UV: SMI NMI support: %s\n", uvh_nmi_mmrx_type);
 	} else {
 		nmi_mmr = UVH_NMI_MMR;
 		nmi_mmr_clear = UVH_NMI_MMR_CLEAR;
@@ -1049,5 +1093,5 @@ void __init uv_nmi_setup_hubless(void)
 	/* Ensure NMI enabled in Processor Interface Reg: */
 	uv_reassert_nmi();
 	uv_register_nmi_notifier();
-	pr_info("UV: Hubless NMI enabled\n");
+	pr_info("UV: PCH NMI enabled\n");
 }
-- 
2.21.0

