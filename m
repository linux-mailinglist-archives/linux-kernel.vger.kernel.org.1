Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3208284195
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgJEUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:40:36 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:20576 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729231AbgJEUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:40:28 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095KcXLj032740;
        Mon, 5 Oct 2020 20:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=8tXuHsFYOscQjEHJuQ/+IoKsYKRgYcZxtzj8inCTg2w=;
 b=Ca6UV5dmN1ZQ+lBrGbJMyxEJX/xfnutHjW1ZePqMRRW6qfVfdekznxuUwj2JNOsbsTfZ
 oasC+1a6vK1yZ6S4y5cwlFdytq8qplcWwaJOHo1+egwHhe6jmHzK4vsDoRor57hgaItH
 GuuXY2Hsl0LJO0bYUFoqaL9fdUlKp+dYRf+bl6Hrs0Zjxxg8z5ieudLFaNUKckoLsk9u
 eIgiFSmLjDzt3ZL8J62zaxKueV3rnQErDUmziRP/6kGOKgbCqkQ6Brv6EH74EQ1I8hBx
 kXoWkkAm7lBZE5n6UaWuSne2RVdsjqPN13WH4V2LibwHo5oe8gZs6hcCnkzMNIzHATMv uQ== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xjgdtu60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:40:09 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 56A026F;
        Mon,  5 Oct 2020 20:40:08 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 205994B;
        Mon,  5 Oct 2020 20:40:07 +0000 (UTC)
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
Subject: [PATCH v4 11/13] x86/platform/uv: Update UV5 TSC Checking
Date:   Mon,  5 Oct 2020 15:39:27 -0500
Message-Id: <20201005203929.148656-12-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201005203929.148656-1-mike.travis@hpe.com>
References: <20201005203929.148656-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update check of BIOS TSC sync status to include both possible "invalid"
states provided by newer UV5 BIOS.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h   |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c | 24 ++++++++++--------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index ecf5c93e7ae8..07079b59824d 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -726,7 +726,7 @@ extern void uv_nmi_setup_hubless(void);
 #define UVH_TSC_SYNC_SHIFT_UV2K	16	/* UV2/3k have different bits */
 #define UVH_TSC_SYNC_MASK	3	/* 0011 */
 #define UVH_TSC_SYNC_VALID	3	/* 0011 */
-#define UVH_TSC_SYNC_INVALID	2	/* 0010 */
+#define UVH_TSC_SYNC_UNKNOWN	0	/* 0000 */
 
 /* BMC sets a bit this MMR non-zero before sending an NMI */
 #define UVH_NMI_MMR		UVH_BIOS_KERNEL_MMR
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index c7f5c1a55552..9ab4ac4d3ec0 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -197,36 +197,32 @@ static void __init uv_tsc_check_sync(void)
 	int sync_state;
 	int mmr_shift;
 	char *state;
-	bool valid;
 
-	/* Accommodate different UV arch BIOSes */
+	/* Different returns from different UV BIOS versions */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
 	mmr_shift =
 		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
 	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
+	/* Check if TSC is valid for all sockets */
 	switch (sync_state) {
 	case UVH_TSC_SYNC_VALID:
 		state = "in sync";
-		valid = true;
+		mark_tsc_async_resets("UV BIOS");
 		break;
 
-	case UVH_TSC_SYNC_INVALID:
-		state = "unstable";
-		valid = false;
+	/* If BIOS state unknown, don't do anything */
+	case UVH_TSC_SYNC_UNKNOWN:
+		state = "unknown";
 		break;
+
+	/* Otherwise, BIOS indicates problem with TSC */
 	default:
-		state = "unknown: assuming valid";
-		valid = true;
+		state = "unstable";
+		mark_tsc_unstable("UV BIOS");
 		break;
 	}
 	pr_info("UV: TSC sync state from BIOS:0%d(%s)\n", sync_state, state);
-
-	/* Mark flag that says TSC != 0 is valid for socket 0 */
-	if (valid)
-		mark_tsc_async_resets("UV BIOS");
-	else
-		mark_tsc_unstable("UV BIOS");
 }
 
 /* Selector for (4|4A|5) structs */
-- 
2.21.0

