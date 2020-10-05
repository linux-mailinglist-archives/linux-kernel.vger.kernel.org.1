Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD6284190
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgJEUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:40:29 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:61248 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgJEUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:40:25 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095KaCGp000499;
        Mon, 5 Oct 2020 20:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=WDsvPhVJuvNtZem/wOxe3zBiS7XO/hr3T6UjiygXLrw=;
 b=E/+trGlwvRLjdGR3eAB5tSr24sbLVadFNyXPs0yuSqW1YCFZFlA0yqN5pPrjSobHv6I/
 w+FgvjukmKS4+VHkLnHIXAsUbP3EC9c20jviY0H2pWWhzq4rjv1OeDKA2zBpoHfni7V7
 +gJIsJZZbE5JDM5o68ynBK8pp6KYsJwUdTrJd1tNy8fyIYP1OnEBrsUClBe65TM0bsCl
 MNCiXRoKrg6WiJmaB3YuKlGKMGHC8KEzoem6PkxVIw+Aq8Til4sT32v+gygg0Vl3JOd7
 LyOREOuGiWmSTEOFpUlxuWwOlXYZ4o/o+0ErZOfulV0py7bXctsH98+GniKBNA6cQFyi /w== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xgdvkat2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:40:07 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 1275B57;
        Mon,  5 Oct 2020 20:40:07 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id D2AAB48;
        Mon,  5 Oct 2020 20:40:05 +0000 (UTC)
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
Subject: [PATCH v4 10/13] x86/platform/uv: Update Node Present Counting
Date:   Mon,  5 Oct 2020 15:39:26 -0500
Message-Id: <20201005203929.148656-11-mike.travis@hpe.com>
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

The changes in the UV5 arch shrunk the NODE PRESENT table to just 2x64
entries (128 total) so are in to 64 bit MMRs instead of a depth of 64
bits in an array.  Adjust references when counting up the nodes present.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 9208a84d381a..c7f5c1a55552 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1436,20 +1436,32 @@ static int __init decode_uv_systab(void)
 /* Set up physical blade translations from UVH_NODE_PRESENT_TABLE */
 static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 {
+	unsigned long np;
 	int i, uv_pb = 0;
 
-	pr_info("UV: NODE_PRESENT_DEPTH = %d\n", UVH_NODE_PRESENT_TABLE_DEPTH);
-	for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
-		unsigned long np;
-
-		np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
-		if (np)
+	if (UVH_NODE_PRESENT_TABLE) {
+		pr_info("UV: NODE_PRESENT_DEPTH = %d\n",
+			UVH_NODE_PRESENT_TABLE_DEPTH);
+		for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
+			np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
 			pr_info("UV: NODE_PRESENT(%d) = 0x%016lx\n", i, np);
-
+			uv_pb += hweight64(np);
+		}
+	}
+	if (UVH_NODE_PRESENT_0) {
+		np = uv_read_local_mmr(UVH_NODE_PRESENT_0);
+		pr_info("UV: NODE_PRESENT_0 = 0x%016lx\n", np);
+		uv_pb += hweight64(np);
+	}
+	if (UVH_NODE_PRESENT_1) {
+		np = uv_read_local_mmr(UVH_NODE_PRESENT_1);
+		pr_info("UV: NODE_PRESENT_1 = 0x%016lx\n", np);
 		uv_pb += hweight64(np);
 	}
 	if (uv_possible_blades != uv_pb)
 		uv_possible_blades = uv_pb;
+
+	pr_info("UV: number nodes/possible blades %d\n", uv_pb);
 }
 
 static void __init build_socket_tables(void)
-- 
2.21.0

