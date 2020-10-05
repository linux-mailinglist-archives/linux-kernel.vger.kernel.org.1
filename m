Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354E22841AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJEUwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:52:01 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:9220 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgJEUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:52:01 -0400
X-Greylist: delayed 698 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 16:52:00 EDT
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095KcrRS023022;
        Mon, 5 Oct 2020 20:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=K6X5XgmuYzGCpD+Dl3WC7lSayG0Sbn+uYju7HVN4Rx0=;
 b=HYxbuWPU8rZuQi9UW5jOTb4zEIP2JttrlVA/w8hRAZGSYtYSdS+J8l53tp4kfPuQmr4N
 c3IkYiO+r1dGgEqdKGt0IboHeyjJyZwaVmxLfus94nvM0pU98VjlJ9/tUdq3oKGnrza4
 nuMcU2GtlkOADlId7kzmvZInh6iIPEnAetGOEc3XloTLC22wK+6w3GGySIlWcZRfsxME
 G1uRu8HYiJJcCkhL6FyK8AGft0UpLeEpN7tsCHHnSJB4a8Pb3ZPkDBx/P/dsycggA3jr
 NpBZgp97Tjtqasr7kTOxRmLDEBchM+CZt25ofSUhKjRpKhRtynGmSt45FFCeLHVmGIqU Wg== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 33y3cex1by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:40:06 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id C224162;
        Mon,  5 Oct 2020 20:40:05 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 539A74D;
        Mon,  5 Oct 2020 20:40:04 +0000 (UTC)
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
Subject: [PATCH v4 09/13] x86/platform/uv: Update UV5 MMR references in UV GRU
Date:   Mon,  5 Oct 2020 15:39:25 -0500
Message-Id: <20201005203929.148656-10-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201005203929.148656-1-mike.travis@hpe.com>
References: <20201005203929.148656-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make modifications to the GRU mappings to accommodate changes for UV5.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 948029576441..9208a84d381a 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -82,6 +82,9 @@ static unsigned long __init uv_early_read_mmr(unsigned long addr)
 
 static inline bool is_GRU_range(u64 start, u64 end)
 {
+	if (!gru_start_paddr)
+		return false;
+
 	return start >= gru_start_paddr && end <= gru_end_paddr;
 }
 
@@ -909,13 +912,24 @@ static __init void map_high(char *id, unsigned long base, int pshift, int bshift
 static __init void map_gru_high(int max_pnode)
 {
 	union uvh_rh_gam_gru_overlay_config_u gru;
-	int shift = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
-	unsigned long mask = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
-	unsigned long base;
+	unsigned long mask, base;
+	int shift;
+
+	if (UVH_RH_GAM_GRU_OVERLAY_CONFIG) {
+		gru.v = uv_read_local_mmr(UVH_RH_GAM_GRU_OVERLAY_CONFIG);
+		shift = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
+		mask = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
+	} else if (UVH_RH10_GAM_GRU_OVERLAY_CONFIG) {
+		gru.v = uv_read_local_mmr(UVH_RH10_GAM_GRU_OVERLAY_CONFIG);
+		shift = UVH_RH10_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
+		mask = UVH_RH10_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
+	} else {
+		pr_err("UV: GRU unavailable (no MMR)\n");
+		return;
+	}
 
-	gru.v = uv_read_local_mmr(UVH_RH_GAM_GRU_OVERLAY_CONFIG);
 	if (!gru.s.enable) {
-		pr_info("UV: GRU disabled\n");
+		pr_info("UV: GRU disabled (by BIOS)\n");
 		return;
 	}
 
@@ -1288,7 +1302,11 @@ static void __init uv_init_hub_info(struct uv_hub_info_s *hi)
 	/* Show system specific info: */
 	pr_info("UV: N:%d M:%d m_shift:%d n_lshift:%d\n", hi->n_val, hi->m_val, hi->m_shift, hi->n_lshift);
 	pr_info("UV: gpa_mask/shift:0x%lx/%d pnode_mask:0x%x apic_pns:%d\n", hi->gpa_mask, hi->gpa_shift, hi->pnode_mask, hi->apic_pnode_shift);
-	pr_info("UV: mmr_base/shift:0x%lx/%ld gru_base/shift:0x%lx/%ld\n", hi->global_mmr_base, hi->global_mmr_shift, hi->global_gru_base, hi->global_gru_shift);
+	pr_info("UV: mmr_base/shift:0x%lx/%ld\n", hi->global_mmr_base, hi->global_mmr_shift);
+	if (hi->global_gru_base)
+		pr_info("UV: gru_base/shift:0x%lx/%ld\n",
+			hi->global_gru_base, hi->global_gru_shift);
+
 	pr_info("UV: gnode_upper:0x%lx gnode_extra:0x%x\n", hi->gnode_upper, hi->gnode_extra);
 }
 
-- 
2.21.0

