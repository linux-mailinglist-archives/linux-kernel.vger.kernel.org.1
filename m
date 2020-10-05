Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0602841E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgJEVGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:06:05 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:46410 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgJEVGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:06:04 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095KcRer030504;
        Mon, 5 Oct 2020 20:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=eR0EPBQAyX1moCkF+hVh+L9JPzFtKmi7otLmsNixNT0=;
 b=b8YurVUmOZxkgT22LHsR4y9MYwCniaVXRwvy1zHo9RP4W6HdtpemYRlhaScbPP9PKdWc
 VmTUvzuowCBOroAePTq+39yC9SO4bC1gq29NNyKQLy40cgH+opp/mNJrYv2i+X7xbrpu
 BO9wgW0CUYO5i6bsi075rvu3jHLZOnYTSck3Hkk5yxjwXb9usW3IVNRWe6ypwYIkDtOX
 EyYC1DbWCpTP7YiV7NWRZc+Lvf3NgbUVQgh5qZgVmi7zRlnYo8CUnANTCJR5aiAxQ+eL
 8oZLgvsX81X39rJY+XCAe+K5Fb3yVoI5hJGfvEI/NqfxPPB9aXxmVRnyoiACqL08nCMq 7w== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 33y2pux2r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:40:01 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 555C64E;
        Mon,  5 Oct 2020 20:40:00 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 26C7848;
        Mon,  5 Oct 2020 20:39:59 +0000 (UTC)
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
Subject: [PATCH v4 05/13] x86/platform/uv: Add UV5 direct references
Date:   Mon,  5 Oct 2020 15:39:21 -0500
Message-Id: <20201005203929.148656-6-mike.travis@hpe.com>
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
 mlxlogscore=967 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010050145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new references to UV5 (and UVY class) system MMR addresses and
fields primarily caused by the expansion from 46 to 52 bits of
physical memory address.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h   | 49 ++++++++++-----
 arch/x86/kernel/apic/x2apic_uv_x.c | 97 +++++++++++++++++++++---------
 2 files changed, 103 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 76969be09660..ecf5c93e7ae8 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -160,6 +160,7 @@ struct uv_hub_info_s {
 	unsigned char		gr_table_len;
 	unsigned char		apic_pnode_shift;
 	unsigned char		gpa_shift;
+	unsigned char		nasid_shift;
 	unsigned char		m_shift;
 	unsigned char		n_lshift;
 	unsigned int		gnode_extra;
@@ -226,6 +227,7 @@ static inline __init void uv_hub_type_set(int uvmask)
 #define UV3_HUB_REVISION_BASE		5
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
+#define UV5_HUB_REVISION_BASE		9
 
 static inline int is_uv(int uvmask) { return uv_hub_type() & uvmask; }
 static inline int is_uv1_hub(void) { return 0; }
@@ -233,7 +235,7 @@ static inline int is_uv2_hub(void) { return is_uv(UV2); }
 static inline int is_uv3_hub(void) { return is_uv(UV3); }
 static inline int is_uv4a_hub(void) { return is_uv(UV4A); }
 static inline int is_uv4_hub(void) { return is_uv(UV4); }
-static inline int is_uv5_hub(void) { return 0; }
+static inline int is_uv5_hub(void) { return is_uv(UV5); }
 
 /*
  * UV4A is a revision of UV4.  So on UV4A, both is_uv4_hub() and
@@ -246,7 +248,7 @@ static inline int is_uv5_hub(void) { return 0; }
 static inline int is_uvx_hub(void) { return is_uv(UVX); }
 
 /* UVY class: UV5,..? */
-static inline int is_uvy_hub(void) { return 0; }
+static inline int is_uvy_hub(void) { return is_uv(UVY); }
 
 /* Any UV Hubbed System */
 static inline int is_uv_hub(void) { return is_uv(UV_ANY); }
@@ -271,9 +273,11 @@ union uvh_apicid {
  *		g -  GNODE (full 15-bit global nasid, right shifted 1)
  *		p -  PNODE (local part of nsids, right shifted 1)
  */
-#define UV_NASID_TO_PNODE(n)		(((n) >> 1) & uv_hub_info->pnode_mask)
+#define UV_NASID_TO_PNODE(n)		\
+		(((n) >> uv_hub_info->nasid_shift) & uv_hub_info->pnode_mask)
 #define UV_PNODE_TO_GNODE(p)		((p) |uv_hub_info->gnode_extra)
-#define UV_PNODE_TO_NASID(p)		(UV_PNODE_TO_GNODE(p) << 1)
+#define UV_PNODE_TO_NASID(p)		\
+		(UV_PNODE_TO_GNODE(p) << uv_hub_info->nasid_shift)
 
 #define UV2_LOCAL_MMR_BASE		0xfa000000UL
 #define UV2_GLOBAL_MMR32_BASE		0xfc000000UL
@@ -290,25 +294,38 @@ union uvh_apicid {
 #define UV4_LOCAL_MMR_SIZE		(32UL * 1024 * 1024)
 #define UV4_GLOBAL_MMR32_SIZE		0
 
+#define UV5_LOCAL_MMR_BASE		0xfa000000UL
+#define UV5_GLOBAL_MMR32_BASE		0
+#define UV5_LOCAL_MMR_SIZE		(32UL * 1024 * 1024)
+#define UV5_GLOBAL_MMR32_SIZE		0
+
 #define UV_LOCAL_MMR_BASE		(				\
-					is_uv2_hub() ? UV2_LOCAL_MMR_BASE : \
-					is_uv3_hub() ? UV3_LOCAL_MMR_BASE : \
-					/*is_uv4_hub*/ UV4_LOCAL_MMR_BASE)
+					is_uv(UV2) ? UV2_LOCAL_MMR_BASE : \
+					is_uv(UV3) ? UV3_LOCAL_MMR_BASE : \
+					is_uv(UV4) ? UV4_LOCAL_MMR_BASE : \
+					is_uv(UV5) ? UV5_LOCAL_MMR_BASE : \
+					0)
 
 #define UV_GLOBAL_MMR32_BASE		(				\
-					is_uv2_hub() ? UV2_GLOBAL_MMR32_BASE : \
-					is_uv3_hub() ? UV3_GLOBAL_MMR32_BASE : \
-					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_BASE)
+					is_uv(UV2) ? UV2_GLOBAL_MMR32_BASE : \
+					is_uv(UV3) ? UV3_GLOBAL_MMR32_BASE : \
+					is_uv(UV4) ? UV4_GLOBAL_MMR32_BASE : \
+					is_uv(UV5) ? UV5_GLOBAL_MMR32_BASE : \
+					0)
 
 #define UV_LOCAL_MMR_SIZE		(				\
-					is_uv2_hub() ? UV2_LOCAL_MMR_SIZE : \
-					is_uv3_hub() ? UV3_LOCAL_MMR_SIZE : \
-					/*is_uv4_hub*/ UV4_LOCAL_MMR_SIZE)
+					is_uv(UV2) ? UV2_LOCAL_MMR_SIZE : \
+					is_uv(UV3) ? UV3_LOCAL_MMR_SIZE : \
+					is_uv(UV4) ? UV4_LOCAL_MMR_SIZE : \
+					is_uv(UV5) ? UV5_LOCAL_MMR_SIZE : \
+					0)
 
 #define UV_GLOBAL_MMR32_SIZE		(				\
-					is_uv2_hub() ? UV2_GLOBAL_MMR32_SIZE : \
-					is_uv3_hub() ? UV3_GLOBAL_MMR32_SIZE : \
-					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_SIZE)
+					is_uv(UV2) ? UV2_GLOBAL_MMR32_SIZE : \
+					is_uv(UV3) ? UV3_GLOBAL_MMR32_SIZE : \
+					is_uv(UV4) ? UV4_GLOBAL_MMR32_SIZE : \
+					is_uv(UV5) ? UV5_GLOBAL_MMR32_SIZE : \
+					0)
 
 #define UV_GLOBAL_MMR64_BASE		(uv_hub_info->global_mmr_base)
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d357711072a1..fca5f94d055e 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -35,14 +35,17 @@ static int			uv_node_id;
 static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
 static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
-/* Information derived from CPUID: */
+/* Information derived from CPUID and some UV MMRs */
 static struct {
 	unsigned int apicid_shift;
 	unsigned int apicid_mask;
 	unsigned int socketid_shift;	/* aka pnode_shift for UV2/3 */
 	unsigned int pnode_mask;
+	unsigned int nasid_shift;
 	unsigned int gpa_shift;
 	unsigned int gnode_shift;
+	unsigned int m_skt;
+	unsigned int n_skt;
 } uv_cpuid;
 
 static int uv_min_hub_revision_id;
@@ -88,20 +91,43 @@ static bool uv_is_untracked_pat_range(u64 start, u64 end)
 
 static void __init early_get_pnodeid(void)
 {
-	union uvh_rh_gam_addr_map_config_u  m_n_config;
 	int pnode;
 
+	uv_cpuid.m_skt = 0;
+	if (UVH_RH10_GAM_ADDR_MAP_CONFIG) {
+		union uvh_rh10_gam_addr_map_config_u  m_n_config;
+
+		m_n_config.v = uv_early_read_mmr(UVH_RH10_GAM_ADDR_MAP_CONFIG);
+		uv_cpuid.n_skt = m_n_config.s.n_skt;
+		uv_cpuid.nasid_shift = 0;
+	} else if (UVH_RH_GAM_ADDR_MAP_CONFIG) {
+		union uvh_rh_gam_addr_map_config_u  m_n_config;
+
 	m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
+		uv_cpuid.n_skt = m_n_config.s.n_skt;
+		if (is_uv(UV3))
+			uv_cpuid.m_skt = m_n_config.s3.m_skt;
+		if (is_uv(UV2))
+			uv_cpuid.m_skt = m_n_config.s2.m_skt;
+		uv_cpuid.nasid_shift = 1;
+	} else {
+		unsigned long GAM_ADDR_MAP_CONFIG = 0;
+
+		WARN(GAM_ADDR_MAP_CONFIG == 0,
+			"UV: WARN: GAM_ADDR_MAP_CONFIG is not available\n");
+		uv_cpuid.n_skt = 0;
+		uv_cpuid.nasid_shift = 0;
+	}
 
-	if (is_uv4_hub())
+	if (is_uv(UV4|UVY))
 		uv_cpuid.gnode_shift = 2; /* min partition is 4 sockets */
 
-	uv_cpuid.pnode_mask = (1 << m_n_config.s.n_skt) - 1;
-	pnode = (uv_node_id >> 1) & uv_cpuid.pnode_mask;
+	uv_cpuid.pnode_mask = (1 << uv_cpuid.n_skt) - 1;
+	pnode = (uv_node_id >> uv_cpuid.nasid_shift) & uv_cpuid.pnode_mask;
 	uv_cpuid.gpa_shift = 46;	/* Default unless changed */
 
 	pr_info("UV: n_skt:%d pnmsk:%x pn:%x\n",
-		m_n_config.s.n_skt, uv_cpuid.pnode_mask, pnode);
+		uv_cpuid.n_skt, uv_cpuid.pnode_mask, pnode);
 }
 
 /* Running on a UV Hubbed system, determine which UV Hub Type it is */
@@ -121,6 +147,12 @@ static int __init early_set_hub_type(void)
 
 	switch (node_id.s.part_number) {
 
+	case UV5_HUB_PART_NUMBER:
+		uv_min_hub_revision_id = node_id.s.revision
+					 + UV5_HUB_REVISION_BASE;
+		uv_hub_type_set(UV5);
+		break;
+
 	/* UV4/4A only have a revision difference */
 	case UV4_HUB_PART_NUMBER:
 		uv_min_hub_revision_id = node_id.s.revision
@@ -282,11 +314,17 @@ static int __init uv_set_system_type(char *_oem_id)
 
 	/* Set hubbed type if true */
 	uv_hub_info->hub_revision =
+		!strncmp(oem_id, "SGI5", 4) ? UV5_HUB_REVISION_BASE :
 		!strncmp(oem_id, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
 		!strncmp(oem_id, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
 		!strcmp(oem_id, "SGI2") ? UV2_HUB_REVISION_BASE : 0;
 
 	switch (uv_hub_info->hub_revision) {
+	case UV5_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x21;
+		uv_hub_type_set(UV5);
+		break;
+
 	case UV4_HUB_REVISION_BASE:
 		uv_hubbed_system = 0x11;
 		uv_hub_type_set(UV4);
@@ -923,7 +961,8 @@ static __init void map_mmioh_high(int min_pnode, int max_pnode)
 
 		if (enable) {
 			max_pnode &= (1 << n_io) - 1;
-			pr_info("UV: base:0x%lx shift:%d N_IO:%d M_IO:%d max_pnode:0x%x\n",
+			pr_info(
+			"UV: base:0x%lx shift:%d N_IO:%d M_IO:%d max_pnode:0x%x\n",
 				base, shift, m_io, n_io, max_pnode);
 			map_high("MMIOH", base, shift, m_io, max_pnode, map_uc);
 		} else {
@@ -934,8 +973,11 @@ static __init void map_mmioh_high(int min_pnode, int max_pnode)
 
 static __init void map_low_mmrs(void)
 {
-	init_extra_mapping_uc(UV_GLOBAL_MMR32_BASE, UV_GLOBAL_MMR32_SIZE);
-	init_extra_mapping_uc(UV_LOCAL_MMR_BASE, UV_LOCAL_MMR_SIZE);
+	if (UV_GLOBAL_MMR32_BASE)
+		init_extra_mapping_uc(UV_GLOBAL_MMR32_BASE, UV_GLOBAL_MMR32_SIZE);
+
+	if (UV_LOCAL_MMR_BASE)
+		init_extra_mapping_uc(UV_LOCAL_MMR_BASE, UV_LOCAL_MMR_SIZE);
 }
 
 static __init void uv_rtc_init(void)
@@ -994,26 +1036,22 @@ struct mn {
 	unsigned char	n_lshift;
 };
 
+/* Initialize caller's MN struct and fill in values */
 static void get_mn(struct mn *mnp)
 {
-	union uvh_rh_gam_addr_map_config_u m_n_config;
-	union uvyh_gr0_gam_gr_config_u m_gr_config;
-
-	/* Make sure the whole structure is well initialized: */
 	memset(mnp, 0, sizeof(*mnp));
-
-	m_n_config.v	= uv_read_local_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
-	mnp->n_val	= m_n_config.s.n_skt;
-
-	if (is_uv4_hub()) {
+	mnp->n_val	= uv_cpuid.n_skt;
+	if (is_uv(UV4|UVY)) {
 		mnp->m_val	= 0;
 		mnp->n_lshift	= 0;
 	} else if (is_uv3_hub()) {
-		mnp->m_val	= m_n_config.s3.m_skt;
+		union uvyh_gr0_gam_gr_config_u m_gr_config;
+
+		mnp->m_val	= uv_cpuid.m_skt;
 		m_gr_config.v	= uv_read_local_mmr(UVH_GR0_GAM_GR_CONFIG);
 		mnp->n_lshift	= m_gr_config.s3.m_skt;
 	} else if (is_uv2_hub()) {
-		mnp->m_val	= m_n_config.s2.m_skt;
+		mnp->m_val	= uv_cpuid.m_skt;
 		mnp->n_lshift	= mnp->m_val == 40 ? 40 : 39;
 	}
 	mnp->m_shift = mnp->m_val ? 64 - mnp->m_val : 0;
@@ -1035,6 +1073,7 @@ static void __init uv_init_hub_info(struct uv_hub_info_s *hi)
 	hi->hub_revision	= uv_hub_info->hub_revision;
 	hi->hub_type		= uv_hub_info->hub_type;
 	hi->pnode_mask		= uv_cpuid.pnode_mask;
+	hi->nasid_shift		= uv_cpuid.nasid_shift;
 	hi->min_pnode		= _min_pnode;
 	hi->min_socket		= _min_socket;
 	hi->pnode_to_socket	= _pnode_to_socket;
@@ -1146,16 +1185,19 @@ static int __init decode_uv_systab(void)
 	struct uv_systab *st;
 	int i;
 
-	/* If system is uv3 or lower, there is no extended UVsystab */
-	if (is_uv_hubbed(0xfffffe) < uv(4) && is_uv_hubless(0xfffffe) < uv(4))
-		return 0;	/* No extended UVsystab required */
-
+	/* Get mapped UVsystab pointer */
 	st = uv_systab;
+
+	/* If UVsystab is version 1, there is no extended UVsystab */
+	if (st && st->revision == UV_SYSTAB_VERSION_1)
+		return 0;
+
 	if ((!st) || (st->revision < UV_SYSTAB_VERSION_UV4_LATEST)) {
 		int rev = st ? st->revision : 0;
 
-		pr_err("UV: BIOS UVsystab version(%x) mismatch, expecting(%x)\n", rev, UV_SYSTAB_VERSION_UV4_LATEST);
-		pr_err("UV: Cannot support UV operations, switching to generic PC\n");
+		pr_err("UV: BIOS UVsystab mismatch, (%x < %x)\n",
+			rev, UV_SYSTAB_VERSION_UV4_LATEST);
+		pr_err("UV: Does not support UV, switch to non-UV x86_64\n");
 		uv_system_type = UV_NONE;
 
 		return -EINVAL;
@@ -1393,7 +1435,8 @@ static void __init uv_system_init_hub(void)
 	struct uv_hub_info_s hub_info = {0};
 	int bytes, cpu, nodeid;
 	unsigned short min_pnode = 9999, max_pnode = 0;
-	char *hub = is_uv4_hub() ? "UV400" :
+	char *hub = is_uv5_hub() ? "UV500" :
+		    is_uv4_hub() ? "UV400" :
 		    is_uv3_hub() ? "UV300" :
 		    is_uv2_hub() ? "UV2000/3000" : NULL;
 
-- 
2.21.0

