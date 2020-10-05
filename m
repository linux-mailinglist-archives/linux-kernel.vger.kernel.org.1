Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86F28419D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgJEUle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:41:34 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:17150 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729180AbgJEUld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:41:33 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095KcYN2029250;
        Mon, 5 Oct 2020 20:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=C/+N6ncBmR/t13xz2zLQxWqQbbKe+fG/q2DxNyf9w2Q=;
 b=AG/qSymuMuMgiDp3sbqCDKpepMMcV++zvLbLIa941r2ozv7htgWmIvq6YxPVdhXBdJl8
 u6FKcbP7hcltQiWNR2iqQ47/4u6cE5uSVVzH3mTcpXBML2V2zZT2B05ku2urnEINJwsQ
 Qhqm1Enj0vYIt5hHg0mt6bSBZ0C7aCY5/S+zdsLHUIkHB69k5wm/Tx98RXtC5OPB3W+V
 5tm549Hw6EaIoBKQKiU8tAvk7NTKeSdqej/QFKrpCxUOAmVwoFdKYzHQCoI0rRW2U35j
 AriIRlPCZq+F0DeJIjaMyyKPXgR7VPR+nB8f/X+Ukryrb/aLE/Y8taQR7KDwJEsh+t+K Pw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xhy331yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:40:10 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 9AC3A54;
        Mon,  5 Oct 2020 20:40:09 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 66BBE48;
        Mon,  5 Oct 2020 20:40:08 +0000 (UTC)
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
Subject: [PATCH v4 12/13] x86/platform/uv: Update for UV5 NMI MMR changes
Date:   Mon,  5 Oct 2020 15:39:28 -0500
Message-Id: <20201005203929.148656-13-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201005203929.148656-1-mike.travis@hpe.com>
References: <20201005203929.148656-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050145
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

