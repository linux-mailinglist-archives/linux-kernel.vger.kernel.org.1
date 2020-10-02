Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C798280BC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgJBAum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:50:42 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:55562 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733275AbgJBAul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:50:41 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091NwA3M022550;
        Fri, 2 Oct 2020 00:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=m7aeqne0N9SS7fyciZeuZ8/JyjhFwbmuLiftC89UU3c=;
 b=mB1usPNdLBScxOlPxfPa+4ul6FYwPGbOsj1XEJiP+bu+nQKKH9LW5752FLYX46rWgc6M
 5MjhDAxSD120m+q555p4sE1lT8ahsorsSWwe20VSEUIG+2TSz7GRE76GN5hiRYiDihrv
 0frzMNGUXcPAu45U2jB2LUR7TuIGePB0fP25ipmd2H0LUqbsEi60WFHVVyX2ZaeMXnTH
 1/7BJHDDTx1KyyFMeqkqCwi5efQ/Ucd0F0e2VKoyqxoQGroL8GQ1zu7b+WTBUz8KlA3F
 OOPR9dZ6LvsujvpRGzPq0BCQniqAQub7Kn4A+4v4Dj9lMwJEXA0yxEp3za2301DKMmZE BQ== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 33w8mb8jx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 00:06:26 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 09E9DA1;
        Fri,  2 Oct 2020 00:06:26 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id E79FE3A;
        Fri,  2 Oct 2020 00:06:24 +0000 (UTC)
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
Subject: [PATCH v3 06/13] x86/platform/uv: Add and Decode Arch Type in UVsystab
Date:   Thu,  1 Oct 2020 19:05:31 -0500
Message-Id: <20201002000538.94424-7-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201002000538.94424-1-mike.travis@hpe.com>
References: <20201002000538.94424-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch to add and process the UV Arch Type field in the UVsystab passed
from UV BIOS to the kernel.  This allows the system to be recognized
without relying on the OEM_ID which OEMs want to change.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/bios.h     |  16 +++-
 arch/x86/kernel/apic/x2apic_uv_x.c | 135 +++++++++++++++++++++++++----
 arch/x86/platform/uv/bios_uv.c     |  27 ++++--
 3 files changed, 148 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 70050d0136c3..97ac595ebc6a 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -5,8 +5,8 @@
 /*
  * UV BIOS layer definitions.
  *
- *  Copyright (c) 2008-2009 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson <rja@sgi.com>
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Russ Anderson <rja@sgi.com>
  */
 
 #include <linux/rtc.h>
@@ -71,6 +71,11 @@ struct uv_gam_range_entry {
 	u32	limit;		/* PA bits 56:26 (UV_GAM_RANGE_SHFT) */
 };
 
+#define	UV_AT_SIZE	8	/* 7 character arch type + NULL char */
+struct uv_arch_type_entry {
+	char	archtype[UV_AT_SIZE];
+};
+
 #define	UV_SYSTAB_SIG			"UVST"
 #define	UV_SYSTAB_VERSION_1		1	/* UV2/3 BIOS version */
 #define	UV_SYSTAB_VERSION_UV4		0x400	/* UV4 BIOS base version */
@@ -79,10 +84,14 @@ struct uv_gam_range_entry {
 #define	UV_SYSTAB_VERSION_UV4_3		0x403	/* - GAM Range PXM Value */
 #define	UV_SYSTAB_VERSION_UV4_LATEST	UV_SYSTAB_VERSION_UV4_3
 
+#define	UV_SYSTAB_VERSION_UV5		0x500	/* UV5 GAM base version */
+#define	UV_SYSTAB_VERSION_UV5_LATEST	UV_SYSTAB_VERSION_UV5
+
 #define	UV_SYSTAB_TYPE_UNUSED		0	/* End of table (offset == 0) */
 #define	UV_SYSTAB_TYPE_GAM_PARAMS	1	/* GAM PARAM conversions */
 #define	UV_SYSTAB_TYPE_GAM_RNG_TBL	2	/* GAM entry table */
-#define	UV_SYSTAB_TYPE_MAX		3
+#define	UV_SYSTAB_TYPE_ARCH_TYPE	3	/* UV arch type */
+#define	UV_SYSTAB_TYPE_MAX		4
 
 /*
  * The UV system table describes specific firmware
@@ -133,6 +142,7 @@ extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
 extern int uv_bios_init(void);
+extern unsigned long get_uv_systab_phys(bool msg);
 
 extern unsigned long sn_rtc_cycles_per_second;
 extern int uv_type;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 4e055a01cc63..353825a0b327 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -31,7 +31,8 @@ static u64			gru_start_paddr, gru_end_paddr;
 static union uvh_apicid		uvh_apicid;
 static int			uv_node_id;
 
-/* Unpack OEM/TABLE ID's to be NULL terminated strings */
+/* Unpack AT/OEM/TABLE ID's to be NULL terminated strings */
+static u8 uv_archtype[UV_AT_SIZE];
 static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
 static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
@@ -286,20 +287,104 @@ static void __init uv_stringify(int len, char *to, char *from)
 	strncpy(to, from, len-1);
 }
 
+/* Find UV arch type entry in UVsystab */
+static unsigned long __init early_find_archtype(struct uv_systab *st)
+{
+	int i;
+
+	for (i = 0; st->entry[i].type != UV_SYSTAB_TYPE_UNUSED; i++) {
+		unsigned long ptr = st->entry[i].offset;
+
+		if (!ptr)
+			continue;
+		ptr += (unsigned long)st;
+		if (st->entry[i].type == UV_SYSTAB_TYPE_ARCH_TYPE)
+			return ptr;
+	}
+	return 0;
+}
+
+/* Validate UV arch type field in UVsystab */
+static int __init decode_arch_type(unsigned long ptr)
+{
+	struct uv_arch_type_entry *uv_ate = (struct uv_arch_type_entry *)ptr;
+	int n = strlen(uv_ate->archtype);
+
+	if (n > 0 && n < sizeof(uv_ate->archtype)) {
+		pr_info("UV: UVarchtype received from BIOS\n");
+		uv_stringify(UV_AT_SIZE, uv_archtype, uv_ate->archtype);
+		return 1;
+	}
+	return 0;
+}
+
+/* Determine if UV arch type entry might exist in UVsystab */
+static int __init early_get_arch_type(void)
+{
+	unsigned long uvst_physaddr, uvst_size, ptr;
+	struct uv_systab *st;
+	u32 rev;
+	int ret;
+
+	uvst_physaddr = get_uv_systab_phys(0);
+	if (!uvst_physaddr)
+		return 0;
+
+	st = early_memremap_ro(uvst_physaddr, sizeof(struct uv_systab));
+	if (!st) {
+		pr_err("UV: Cannot access UVsystab, remap failed\n");
+		return 0;
+	}
+
+	rev = st->revision;
+	if (rev < UV_SYSTAB_VERSION_UV5) {
+		early_memunmap(st, sizeof(struct uv_systab));
+		return 0;
+	}
+
+	uvst_size = st->size;
+	early_memunmap(st, sizeof(struct uv_systab));
+	st = early_memremap_ro(uvst_physaddr, uvst_size);
+	if (!st) {
+		pr_err("UV: Cannot access UVarchtype, remap failed\n");
+		return 0;
+	}
+
+	ptr = early_find_archtype(st);
+	if (!ptr) {
+		early_memunmap(st, uvst_size);
+		return 0;
+	}
+
+	ret = decode_arch_type(ptr);
+	early_memunmap(st, uvst_size);
+	return ret;
+}
+
 static int __init uv_set_system_type(char *_oem_id)
 {
 	int pnodeid;
 
-	/* Save OEM ID */
+	/* Save OEM_ID passed from ACPI MADT */
 	uv_stringify(sizeof(oem_id), oem_id, _oem_id);
 
-	/* Set hubless type if true */
-	if (strncmp(oem_id, "SGI", 3) != 0) {
-		if (strncmp(oem_id, "NSGI", 4) != 0)
+	/* Check if BIOS sent us a UVarchtype */
+	if (!early_get_arch_type())
+
+		/* If not use OEM ID for UVarchtype */
+		uv_stringify(UV_AT_SIZE, uv_archtype, _oem_id);
+
+	/* Check if not hubbed */
+	if (strncmp(uv_archtype, "SGI", 3) != 0) {
+
+		/* (Not hubbed), check if not hubless */
+		if (strncmp(uv_archtype, "NSGI", 4) != 0)
+
+			/* (Not hubless), not a UV */
 			return 0;
 
 		/* UV4 Hubless: CH */
-		if (strncmp(oem_id, "NSGI4", 5) == 0)
+		if (strncmp(uv_archtype, "NSGI4", 5) == 0)
 			uv_hubless_system = 0x11;
 
 		/* UV3 Hubless: UV300/MC990X w/o hub */
@@ -318,10 +403,10 @@ static int __init uv_set_system_type(char *_oem_id)
 
 	/* Set hubbed type if true */
 	uv_hub_info->hub_revision =
-		!strncmp(oem_id, "SGI5", 4) ? UV5_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
-		!strcmp(oem_id, "SGI2") ? UV2_HUB_REVISION_BASE : 0;
+		!strncmp(uv_archtype, "SGI5", 4) ? UV5_HUB_REVISION_BASE :
+		!strncmp(uv_archtype, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
+		!strncmp(uv_archtype, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
+		!strcmp(uv_archtype, "SGI2") ? UV2_HUB_REVISION_BASE : 0;
 
 	switch (uv_hub_info->hub_revision) {
 	case UV5_HUB_REVISION_BASE:
@@ -392,8 +477,7 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	return 0;
 
 badbios:
-	pr_err("UV: OEM_ID:%s OEM_TABLE_ID:%s\n", oem_id, oem_table_id);
-	pr_err("UV: Current UV Type or BIOS not supported\n");
+	pr_err("UV: UVarchtype:%s not supported\n", uv_archtype);
 	BUG();
 }
 
@@ -1186,6 +1270,7 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x) pnodes(min:%x,max:%x)\n", index, _min_socket, _max_socket, _min_pnode, _max_pnode);
 }
 
+/* Walk through UVsystab decoding the fields */
 static int __init decode_uv_systab(void)
 {
 	struct uv_systab *st;
@@ -1215,7 +1300,8 @@ static int __init decode_uv_systab(void)
 		if (!ptr)
 			continue;
 
-		ptr = ptr + (unsigned long)st;
+		/* point to payload */
+		ptr += (unsigned long)st;
 
 		switch (st->entry[i].type) {
 		case UV_SYSTAB_TYPE_GAM_PARAMS:
@@ -1225,6 +1311,15 @@ static int __init decode_uv_systab(void)
 		case UV_SYSTAB_TYPE_GAM_RNG_TBL:
 			decode_gam_rng_tbl(ptr);
 			break;
+
+		case UV_SYSTAB_TYPE_ARCH_TYPE:
+			/* already processed in early startup */
+			break;
+
+		default:
+			pr_err("UV:%s:Unrecognized UV_SYSTAB_TYPE:%d, skipped\n",
+				__func__, st->entry[i].type);
+			break;
 		}
 	}
 	return 0;
@@ -1265,7 +1360,7 @@ static void __init build_socket_tables(void)
 			pr_info("UV: No UVsystab socket table, ignoring\n");
 			return;
 		}
-		pr_crit("UV: Error: UVsystab address translations not available!\n");
+		pr_err("UV: Error: UVsystab address translations not available!\n");
 		BUG();
 	}
 
@@ -1391,9 +1486,9 @@ static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int __maybe_unused proc_oemid_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
 {
-	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
+	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
 	return 0;
 }
 
@@ -1402,7 +1497,7 @@ static __init void uv_setup_proc_files(int hubless)
 	struct proc_dir_entry *pde;
 
 	pde = proc_mkdir(UV_PROC_NODE, NULL);
-	proc_create_single("oemid", 0, pde, proc_oemid_show);
+	proc_create_single("archtype", 0, pde, proc_archtype_show);
 	if (hubless)
 		proc_create_single("hubless", 0, pde, proc_hubless_show);
 	else
@@ -1454,12 +1549,14 @@ static void __init uv_system_init_hub(void)
 
 	map_low_mmrs();
 
-	/* Get uv_systab for decoding: */
+	/* Get uv_systab for decoding, setup UV BIOS calls */
 	uv_bios_init();
 
 	/* If there's an UVsystab problem then abort UV init: */
-	if (decode_uv_systab() < 0)
+	if (decode_uv_systab() < 0) {
+		pr_err("UV: Mangled UVsystab format\n");
 		return;
+	}
 
 	build_socket_tables();
 	build_uv_gr_table();
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index a2f447dffea6..b148b4c8c2ec 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -2,8 +2,8 @@
 /*
  * BIOS run time interface routines.
  *
- *  Copyright (c) 2008-2009 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson <rja@sgi.com>
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Russ Anderson <rja@sgi.com>
  */
 
 #include <linux/efi.h>
@@ -170,16 +170,27 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 				(u64)decode, (u64)domain, (u64)bus, 0, 0);
 }
 
-int uv_bios_init(void)
+unsigned long get_uv_systab_phys(bool msg)
 {
-	uv_systab = NULL;
 	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
 	    !uv_systab_phys || efi_runtime_disabled()) {
-		pr_crit("UV: UVsystab: missing\n");
-		return -EEXIST;
+		if (msg)
+			pr_crit("UV: UVsystab: missing\n");
+		return 0;
 	}
+	return uv_systab_phys;
+}
+
+int uv_bios_init(void)
+{
+	unsigned long uv_systab_phys_addr;
+
+	uv_systab = NULL;
+	uv_systab_phys_addr = get_uv_systab_phys(1);
+	if (!uv_systab_phys_addr)
+		return -EEXIST;
 
-	uv_systab = ioremap(uv_systab_phys, sizeof(struct uv_systab));
+	uv_systab = ioremap(uv_systab_phys_addr, sizeof(struct uv_systab));
 	if (!uv_systab || strncmp(uv_systab->signature, UV_SYSTAB_SIG, 4)) {
 		pr_err("UV: UVsystab: bad signature!\n");
 		iounmap(uv_systab);
@@ -191,7 +202,7 @@ int uv_bios_init(void)
 		int size = uv_systab->size;
 
 		iounmap(uv_systab);
-		uv_systab = ioremap(uv_systab_phys, size);
+		uv_systab = ioremap(uv_systab_phys_addr, size);
 		if (!uv_systab) {
 			pr_err("UV: UVsystab: ioremap(%d) failed!\n", size);
 			return -EFAULT;
-- 
2.21.0

