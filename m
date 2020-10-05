Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1A2841EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgJEVK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:10:57 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45958 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgJEVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:10:55 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095KcSI3030596;
        Mon, 5 Oct 2020 20:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=sOnF2UoAiqg/1bNIyAOc4tSJ3dqUFELMZNSnhbpzfhg=;
 b=LltPiaTAEMl41OK17Wzv/sBOizKyxwSWq60yTslqz5iLvQfGg7Umi6KDzwDMC/xW2rmF
 MjQJw8UH7Nm80Xc4wHGhPBmVB7DkdoFRuHB0o+j/bTbTTP8j4junCWpNLclQLaTuYLXo
 LsPkZtC3UcV10fNHalPTeKrytZs5icnj/tLwkpNeR98t4+mEZD37ObYXkUBaY2Yg546A
 oH4IblS+kSOFXMyxMuA7b7Ic5CPG2NiFJNhhap55s0d8KqGweaaVJIKsDqruixy13ePk
 rGGlcABnlwc8wFZuXbq/3bpoFCHXsxkyHaespW0shxGQ/4M8A3Tvew3BQCfg206v4VJY wA== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 33y2pux2rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:40:03 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id ED54A68;
        Mon,  5 Oct 2020 20:40:02 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id B407F50;
        Mon,  5 Oct 2020 20:40:01 +0000 (UTC)
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
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 07/13] x86/platform/uv: Update MMIOH references based on new UV5 MMRs.
Date:   Mon,  5 Oct 2020 15:39:23 -0500
Message-Id: <20201005203929.148656-8-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201005203929.148656-1-mike.travis@hpe.com>
References: <20201005203929.148656-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010050145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make modifications to the MMIOH mappings to accommodate changes for UV5.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 212 ++++++++++++++++++++---------
 1 file changed, 144 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 9b7a334578e6..f2c5a03b5cf7 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -226,6 +226,13 @@ static void __init uv_tsc_check_sync(void)
 		mark_tsc_unstable("UV BIOS");
 }
 
+/* Selector for (4|4A|5) structs */
+#define uvxy_field(sname, field, undef) (	\
+	is_uv(UV4A) ? sname.s4a.field :		\
+	is_uv(UV4) ? sname.s4.field :		\
+	is_uv(UV3) ? sname.s3.field :		\
+	undef)
+
 /* [Copied from arch/x86/kernel/cpu/topology.c:detect_extended_topology()] */
 
 #define SMT_LEVEL			0	/* Leaf 0xb SMT level */
@@ -878,6 +885,7 @@ static __init void get_lowmem_redirect(unsigned long *base, unsigned long *size)
 }
 
 enum map_type {map_wb, map_uc};
+static const char * const mt[] = { "WB", "UC" };
 
 static __init void map_high(char *id, unsigned long base, int pshift, int bshift, int max_pnode, enum map_type map_type)
 {
@@ -889,11 +897,13 @@ static __init void map_high(char *id, unsigned long base, int pshift, int bshift
 		pr_info("UV: Map %s_HI base address NULL\n", id);
 		return;
 	}
-	pr_debug("UV: Map %s_HI 0x%lx - 0x%lx\n", id, paddr, paddr + bytes);
 	if (map_type == map_uc)
 		init_extra_mapping_uc(paddr, bytes);
 	else
 		init_extra_mapping_wb(paddr, bytes);
+
+	pr_info("UV: Map %s_HI 0x%lx - 0x%lx %s (%d segments)\n",
+		id, paddr, paddr + bytes, mt[map_type], max_pnode + 1);
 }
 
 static __init void map_gru_high(int max_pnode)
@@ -927,52 +937,74 @@ static __init void map_mmr_high(int max_pnode)
 		pr_info("UV: MMR disabled\n");
 }
 
-/* UV3/4 have identical MMIOH overlay configs, UV4A is slightly different */
-static __init void map_mmioh_high_uv34(int index, int min_pnode, int max_pnode)
-{
-	unsigned long overlay;
-	unsigned long mmr;
-	unsigned long base;
-	unsigned long nasid_mask;
-	unsigned long m_overlay;
-	int i, n, shift, m_io, max_io;
-	int nasid, lnasid, fi, li;
-	char *id;
-
-	if (index == 0) {
-		id = "MMIOH0";
-		m_overlay = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0;
-		overlay = uv_read_local_mmr(m_overlay);
-		base = overlay & UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
+/* Arch specific ENUM cases */
+enum mmioh_arch {
+	UV2_MMIOH = -1,
+	UVY_MMIOH0, UVY_MMIOH1,
+	UVX_MMIOH0, UVX_MMIOH1,
+};
+
+/* Calculate and Map MMIOH Regions */
+static void __init calc_mmioh_map(enum mmioh_arch index,
+	int min_pnode, int max_pnode,
+	int shift, unsigned long base, int m_io, int n_io)
+{
+	unsigned long mmr, nasid_mask;
+	int nasid, min_nasid, max_nasid, lnasid, mapped;
+	int i, fi, li, n, max_io;
+	char id[8];
+
+	/* One (UV2) mapping */
+	if (index == UV2_MMIOH) {
+		strncpy(id, "MMIOH", sizeof(id));
+		max_io = max_pnode;
+		mapped = 0;
+		goto map_exit;
+	}
+
+	/* small and large MMIOH mappings */
+	switch (index) {
+	case UVY_MMIOH0:
+		mmr = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG0;
+		nasid_mask = UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
+		n = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
+		min_nasid = min_pnode;
+		max_nasid = max_pnode;
+		mapped = 1;
+		break;
+	case UVY_MMIOH1:
+		mmr = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG1;
+		nasid_mask = UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
+		n = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG1_DEPTH;
+		min_nasid = min_pnode;
+		max_nasid = max_pnode;
+		mapped = 1;
+		break;
+	case UVX_MMIOH0:
 		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0;
-		m_io = (overlay & UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG0_M_IO_MASK)
-			>> UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG0_M_IO_SHFT;
-		shift = UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG0_M_IO_SHFT;
+		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
 		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
-		nasid_mask = UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK;
-	} else {
-		id = "MMIOH1";
-		m_overlay = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1;
-		overlay = uv_read_local_mmr(m_overlay);
-		base = overlay & UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
+		min_nasid = min_pnode * 2;
+		max_nasid = max_pnode * 2;
+		mapped = 1;
+		break;
+	case UVX_MMIOH1:
 		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1;
-		m_io = (overlay & UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_M_IO_MASK)
-			>> UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_M_IO_SHFT;
-		shift = UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_M_IO_SHFT;
+		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
 		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_DEPTH;
-		nasid_mask = UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK;
-	}
-	pr_info("UV: %s overlay 0x%lx base:0x%lx m_io:%d\n", id, overlay, base, m_io);
-	if (!(overlay & UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG0_ENABLE_MASK)) {
-		pr_info("UV: %s disabled\n", id);
+		min_nasid = min_pnode * 2;
+		max_nasid = max_pnode * 2;
+		mapped = 1;
+		break;
+	default:
+		pr_err("UV:%s:Invalid mapping type:%d\n", __func__, index);
 		return;
 	}
 
-	/* Convert to NASID: */
-	min_pnode *= 2;
-	max_pnode *= 2;
-	max_io = lnasid = fi = li = -1;
+	/* enum values chosen so (index mod 2) is MMIOH 0/1 (low/high) */
+	snprintf(id, sizeof(id), "MMIOH%d", index%2);
 
+	max_io = lnasid = fi = li = -1;
 	for (i = 0; i < n; i++) {
 		unsigned long m_redirect = mmr + i * 8;
 		unsigned long redirect = uv_read_local_mmr(m_redirect);
@@ -982,9 +1014,12 @@ static __init void map_mmioh_high_uv34(int index, int min_pnode, int max_pnode)
 			pr_info("UV: %s redirect base 0x%lx(@0x%lx) 0x%04x\n",
 				id, redirect, m_redirect, nasid);
 
-		/* Invalid NASID: */
-		if (nasid < min_pnode || max_pnode < nasid)
+		/* Invalid NASID check */
+		if (nasid < min_nasid || max_nasid < nasid) {
+			pr_err("UV:%s:Invalid NASID:%x (range:%x..%x)\n",
+				__func__, index, min_nasid, max_nasid );
 			nasid = -1;
+		}
 
 		if (nasid == lnasid) {
 			li = i;
@@ -1007,7 +1042,8 @@ static __init void map_mmioh_high_uv34(int index, int min_pnode, int max_pnode)
 			}
 			addr1 = (base << shift) + f * (1ULL << m_io);
 			addr2 = (base << shift) + (l + 1) * (1ULL << m_io);
-			pr_info("UV: %s[%03d..%03d] NASID 0x%04x ADDR 0x%016lx - 0x%016lx\n", id, fi, li, lnasid, addr1, addr2);
+			pr_info("UV: %s[%03d..%03d] NASID 0x%04x ADDR 0x%016lx - 0x%016lx\n",
+				id, fi, li, lnasid, addr1, addr2);
 			if (max_io < l)
 				max_io = l;
 		}
@@ -1015,43 +1051,83 @@ static __init void map_mmioh_high_uv34(int index, int min_pnode, int max_pnode)
 		lnasid = nasid;
 	}
 
-	pr_info("UV: %s base:0x%lx shift:%d M_IO:%d MAX_IO:%d\n", id, base, shift, m_io, max_io);
+map_exit:
+	pr_info("UV: %s base:0x%lx shift:%d m_io:%d max_io:%d max_pnode:0x%x\n",
+		id, base, shift, m_io, max_io, max_pnode);
 
-	if (max_io >= 0)
+	if (max_io >= 0 && !mapped)
 		map_high(id, base, shift, m_io, max_io, map_uc);
 }
 
 static __init void map_mmioh_high(int min_pnode, int max_pnode)
 {
-	union uvh_rh_gam_mmioh_overlay_config_u mmioh;
-	unsigned long mmr, base;
-	int shift, enable, m_io, n_io;
+	/* UVY flavor */
+	if (UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG0) {
+		union uvh_rh10_gam_mmioh_overlay_config0_u mmioh0;
+		union uvh_rh10_gam_mmioh_overlay_config1_u mmioh1;
+
+		mmioh0.v = uv_read_local_mmr(UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG0);
+		if (unlikely(mmioh0.s.enable == 0))
+			pr_info("UV: MMIOH0 disabled\n");
+		else
+			calc_mmioh_map(UVY_MMIOH0, min_pnode, max_pnode,
+				UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG0_BASE_SHFT,
+				mmioh0.s.base, mmioh0.s.m_io, mmioh0.s.n_io);
 
-	if (is_uv3_hub() || is_uv4_hub()) {
-		/* Map both MMIOH regions: */
-		map_mmioh_high_uv34(0, min_pnode, max_pnode);
-		map_mmioh_high_uv34(1, min_pnode, max_pnode);
+		mmioh1.v = uv_read_local_mmr(UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG1);
+		if (unlikely(mmioh1.s.enable == 0))
+			pr_info("UV: MMIOH1 disabled\n");
+		else
+			calc_mmioh_map(UVY_MMIOH1, min_pnode, max_pnode,
+				UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG1_BASE_SHFT,
+				mmioh1.s.base, mmioh1.s.m_io, mmioh1.s.n_io);
 		return;
 	}
+	/* UVX flavor */
+	if (UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0) {
+		union uvh_rh_gam_mmioh_overlay_config0_u mmioh0;
+		union uvh_rh_gam_mmioh_overlay_config1_u mmioh1;
+
+		mmioh0.v = uv_read_local_mmr(UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0);
+		if (unlikely(mmioh0.s.enable == 0))
+			pr_info("UV: MMIOH0 disabled\n");
+		else {
+			unsigned long base = uvxy_field(mmioh0, base, 0);
+			int m_io = uvxy_field(mmioh0, m_io, 0);
+			int n_io = uvxy_field(mmioh0, n_io, 0);
+
+			calc_mmioh_map(UVX_MMIOH0, min_pnode, max_pnode,
+				UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_BASE_SHFT,
+				base, m_io, n_io);
+		}
 
-	if (is_uv2_hub()) {
-		mmr	= UVH_RH_GAM_MMIOH_OVERLAY_CONFIG;
-		shift	= UVH_RH_GAM_MMIOH_OVERLAY_CONFIG_BASE_SHFT;
-		mmioh.v	= uv_read_local_mmr(mmr);
-		enable	= !!mmioh.s2.enable;
-		base	= mmioh.s2.base;
-		m_io	= mmioh.s2.m_io;
-		n_io	= mmioh.s2.n_io;
-
-		if (enable) {
-			max_pnode &= (1 << n_io) - 1;
-			pr_info(
-			"UV: base:0x%lx shift:%d N_IO:%d M_IO:%d max_pnode:0x%x\n",
-				base, shift, m_io, n_io, max_pnode);
-			map_high("MMIOH", base, shift, m_io, max_pnode, map_uc);
-		} else {
-			pr_info("UV: MMIOH disabled\n");
+		mmioh1.v = uv_read_local_mmr(UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1);
+		if (unlikely(mmioh1.s.enable == 0))
+			pr_info("UV: MMIOH1 disabled\n");
+		else {
+			unsigned long base = uvxy_field(mmioh1, base, 0);
+			int m_io = uvxy_field(mmioh1, m_io, 0);
+			int n_io = uvxy_field(mmioh1, n_io, 0);
+
+			calc_mmioh_map(UVX_MMIOH1, min_pnode, max_pnode,
+				UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_BASE_SHFT,
+				base, m_io, n_io);
 		}
+		return;
+	}
+
+	/* UV2 flavor */
+	if (UVH_RH_GAM_MMIOH_OVERLAY_CONFIG) {
+		union uvh_rh_gam_mmioh_overlay_config_u mmioh;
+
+		mmioh.v	= uv_read_local_mmr(UVH_RH_GAM_MMIOH_OVERLAY_CONFIG);
+		if (unlikely(mmioh.s2.enable == 0))
+			pr_info("UV: MMIOH disabled\n");
+		else
+			calc_mmioh_map(UV2_MMIOH, min_pnode, max_pnode,
+				UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_BASE_SHFT,
+				mmioh.s2.base, mmioh.s2.m_io, mmioh.s2.n_io);
+		return;
 	}
 }
 
-- 
2.21.0

