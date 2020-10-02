Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72D3280BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbgJBA1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:27:44 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:62046 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgJBA1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:27:44 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09204A0L032583;
        Fri, 2 Oct 2020 00:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=Zi3pvKO5WMyuVnzDj4ZMIOjDXY+rNdRI9fROJ36TT0E=;
 b=I00Qi77MexXuDQyzbg6crhnLfdZm/7EEDn2roWkU1Wuz7uhbHB96HUgXO2/xDxyjGOQs
 SHwutCz39Ftx5G5YdyqQcEr6Xx+5v/RDgsBgFvKa1vYYo3tqN1jNZo4RdWrcVU3VhUCr
 /vG8CVmhnRGmPHqozo7hbVT6GNBwhMOtJjdKnYb+3ymZbjO1zKIeT/S5DCPJtHsP5qa+
 mx/lTTX90PmNmitB9Zir7xoZLBCXMcQms/j/velMplgwXtU+YrluA/TS7ed+7UJ6N5oJ
 avf653Moq9+rWj7zPQlSwAPxgg7i6SP8YYN3C9at5yLjY+jCEj5lWeHBpiT2PrdgYZpD Lg== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 33wbdvf288-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 00:06:30 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 82AB39D;
        Fri,  2 Oct 2020 00:06:29 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 66B943F;
        Fri,  2 Oct 2020 00:06:28 +0000 (UTC)
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
Subject: [PATCH v3 09/13] x86/platform/uv: Update UV5 MMR references in UV GRU
Date:   Thu,  1 Oct 2020 19:05:34 -0500
Message-Id: <20201002000538.94424-10-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201002000538.94424-1-mike.travis@hpe.com>
References: <20201002000538.94424-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010195
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
index 9f89c1e82df0..678001ff789d 100644
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
 
@@ -913,13 +916,24 @@ static __init void map_high(char *id, unsigned long base, int pshift, int bshift
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
 
@@ -1293,7 +1307,11 @@ static void __init uv_init_hub_info(struct uv_hub_info_s *hi)
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

