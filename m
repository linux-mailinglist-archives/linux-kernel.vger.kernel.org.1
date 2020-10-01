Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587E62808A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgJAUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:58716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733101AbgJAUnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:18 -0400
IronPort-SDR: B6B4JcZatYWz/CXxVtNc4N8Vo2X1xsi2lr98AJeH3LwLsoAq5b2p4pocRQMHL4nndluc5jl1yl
 RdpRkLQmkODQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170742"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:53 -0700
IronPort-SDR: pl3uEs3ymVWdyh7Xuc7EmStb9CGPXxU75nUwTZxMdLCue63tIcc65jMgFV5s92zwFEidy8agf9
 GTNZyhGBsXtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297084"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 19/22] x86/fpu/amx: Define AMX state components and have it used for boot-time checks
Date:   Thu,  1 Oct 2020 13:39:10 -0700
Message-Id: <20201001203913.9125-20-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux uses check_xstate_against_struct() to sanity check the size of
XSTATE-enabled features. AMX is the XSAVE-enabled feature, and its size is
not hard-coded but discoverable at run-time via CPUID.

The AMX state is composed of state components 17 and 18, which are all user
state components. The first component is the XTILECFG state of a 64-byte
tile-related control register. The state component 18, called XTILEDATA,
contains the actual tile data, and the state size varies on
implementations. The architectural maximum, as defined in the CPUID(0x1d,
1): EAX[15:0], is a byte less than 64KB. The first implementation supports
8KB.

Check the XTILEDATA state size dynamically. The feature introduces the new
tile register, TMM. Define one register struct only and read the number of
registers from CPUID. Cross-check the overall size with CPUID again.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/types.h  | 27 +++++++++++++
 arch/x86/include/asm/fpu/xstate.h |  2 +
 arch/x86/kernel/fpu/xstate.c      | 65 +++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 4b7756644824..002248dba6dc 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -120,6 +120,9 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_13,
 	XFEATURE_RSRVD_COMP_14,
 	XFEATURE_LBR,
+	XFEATURE_RSRVD_COMP_16,
+	XFEATURE_XTILE_CFG,
+	XFEATURE_XTILE_DATA,
 
 	XFEATURE_MAX,
 };
@@ -135,11 +138,15 @@ enum xfeature {
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
+#define XFEATURE_MASK_XTILE_CFG	(1 << XFEATURE_XTILE_CFG)
+#define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
 					 | XFEATURE_MASK_ZMM_Hi256 \
 					 | XFEATURE_MASK_Hi16_ZMM)
+#define XFEATURE_MASK_XTILE		(XFEATURE_MASK_XTILE_DATA \
+					 | XFEATURE_MASK_XTILE_CFG)
 
 #define FIRST_EXTENDED_XFEATURE	XFEATURE_YMM
 
@@ -152,6 +159,9 @@ struct reg_256_bit {
 struct reg_512_bit {
 	u8	regbytes[512/8];
 };
+struct reg_1024_byte {
+	u8	regbytes[1024];
+};
 
 /*
  * State component 2:
@@ -254,6 +264,23 @@ struct arch_lbr_state {
 	u64 ler_to;
 	u64 ler_info;
 	struct lbr_entry		entries[];
+};
+
+/*
+ * State component 17: 64-byte tile configuration register.
+ */
+struct xtile_cfg {
+	u64				tcfg[8];
+} __packed;
+
+/*
+ * State component 18: 1KB tile data register.
+ * Each register represents 16 64-byte rows of the matrix
+ * data. But the number of registers depends on the actual
+ * implementation.
+ */
+struct xtile_data {
+	struct reg_1024_byte		tmm;
 } __packed;
 
 struct xstate_header {
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index b2125ec90cdb..aadbcf893cc0 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -13,6 +13,8 @@
 
 #define XSTATE_CPUID		0x0000000d
 
+#define TILE_CPUID		0x0000001d
+
 #define FXSAVE_SIZE	512
 
 #define XSAVE_HDR_SIZE	    64
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index eaada4a38153..9d617d6506be 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -39,6 +39,15 @@ static const char *xfeature_names[] =
 	"Processor Trace (unused)"	,
 	"Protection Keys User registers",
 	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"AMX Tile config"		,
+	"AMX Tile data"			,
+	"unknown xstate feature"	,
 };
 
 struct xfeature_capflag_info {
@@ -57,6 +66,8 @@ static struct xfeature_capflag_info xfeature_capflags[] __initdata = {
 	{ XFEATURE_Hi16_ZMM,			X86_FEATURE_AVX512F },
 	{ XFEATURE_PT_UNIMPLEMENTED_SO_FAR,	X86_FEATURE_INTEL_PT },
 	{ XFEATURE_PKRU,			X86_FEATURE_PKU },
+	{ XFEATURE_XTILE_CFG,			X86_FEATURE_AMX_TILE },
+	{ XFEATURE_XTILE_DATA,			X86_FEATURE_AMX_TILE }
 };
 
 /*
@@ -417,6 +428,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
+	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
+	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
 }
 
 /*
@@ -669,6 +682,51 @@ static void __xstate_dump_leaves(void)
 	}								\
 } while (0)
 
+static void check_xtile_data_against_struct(int size)
+{
+	u32 max_palid, palid, state_size;
+	u32 eax, ebx, ecx, edx;
+	u16 max_tile;
+
+	/*
+	 * Check the maximum palette id:
+	 * eax:  Highest numbered palette subleaf.
+	 */
+	cpuid_count(TILE_CPUID, 0, &max_palid, &ebx, &ecx, &edx);
+
+	/*
+	 * Cross-check each tile size and find the maximum
+	 * number of supported tiles.
+	 */
+	for (palid = 1, max_tile = 0; palid <= max_palid; palid++) {
+		u16 tile_size, max;
+
+		/*
+		 * Check the tile size info:
+		 * eax[31:16]:  bytes per title
+		 * ebx[31:16]:  the max names (or max number of tiles)
+		 */
+		cpuid_count(TILE_CPUID, palid, &eax, &ebx, &edx, &edx);
+
+		tile_size = eax >> 16;
+		max = ebx >> 16;
+		if (WARN_ONCE(tile_size != sizeof(struct xtile_data),
+			      "%s: struct is %zu bytes, cpu xtile %d bytes\n",
+			      __stringify(XFEATURE_XTILE_DATA),
+			      sizeof(struct xtile_data), tile_size))
+			__xstate_dump_leaves();
+
+		if (max > max_tile)
+			max_tile = max;
+	}
+
+	state_size = sizeof(struct xtile_data) * max_tile;
+	if (WARN_ONCE(size != state_size,
+		      "%s: calculated size is %u bytes, cpu state %d bytes\n",
+		      __stringify(XFEATURE_XTILE_DATA), state_size, size))
+		__xstate_dump_leaves();
+}
+
 /*
  * We have a C struct for each 'xstate'.  We need to ensure
  * that our software representation matches what the CPU
@@ -691,6 +749,13 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
+	XCHECK_SZ(sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
+	/*
+	 * The tile data size varies between implementations, while the other state
+	 * sizes are constant.
+	 */
+	if (nr == XFEATURE_XTILE_DATA)
+		check_xtile_data_against_struct(sz);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
-- 
2.17.1

