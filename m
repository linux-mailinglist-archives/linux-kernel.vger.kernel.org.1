Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A92B7064
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgKQUne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:43:34 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:39338 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgKQUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:43:25 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKeTU7018862;
        Tue, 17 Nov 2020 20:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=SIPUboJthxIyv0LQ1q7fH+5nl1O/Uhd4UKiXx0MZDSc=;
 b=H7YEUAj2RSC/aS+TbwYYNCSq3ZqEjqcRF5CkOZqtEeD6jtsGVy+bdcYa/vL1FLpyRn5V
 SpJ1yzxoq0GLeqLGPcg+9yFb0cRkNmSDs9NAqBNK3VcKB42xKYUYFjf4TprSUrDl35Ez
 3S4/Lop5UQ4hR81egfGGjOQ/Q4332R2aqVnFjT/d1PGo8W7fT6EftzXS9C2DqCwc6wfh
 U5FtfVx1lINLKC9DMV1uh8KQiwukZWznVMOKsoQ6XweNmHmWmt6G6Ysa4paX2aEOyhpj
 lriWi/7Ebtxnh/aL/FipAQxUb7LDGIJcViKEE/xFXdMRNil8wD5X10wxy6KrKGHsxkug iQ== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 34vm4vgs28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 20:42:47 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id BE828AF;
        Tue, 17 Nov 2020 20:42:46 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E68AC4E;
        Tue, 17 Nov 2020 20:42:45 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 7435E3003D74B; Tue, 17 Nov 2020 14:42:45 -0600 (CST)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH 2/5] x86/platform/uv: Add and export uv_bios_* functions
Date:   Tue, 17 Nov 2020 14:42:21 -0600
Message-Id: <20201117204224.51230-3-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201117204224.51230-1-justin.ernst@hpe.com>
References: <20201117204224.51230-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_09:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional uv_bios_call variant functions to expose information
needed by the new uv_sysfs driver. This includes the addition of several
new data types defined by UV BIOS and used in the new functions.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/bios.h   |  49 +++++++++++++++
 arch/x86/include/asm/uv/uv_geo.h | 103 +++++++++++++++++++++++++++++++
 arch/x86/platform/uv/bios_uv.c   |  54 ++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 arch/x86/include/asm/uv/uv_geo.h

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 08b3d810dfba..01ba080887b3 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -28,6 +28,20 @@ enum uv_bios_cmd {
 	UV_BIOS_SET_LEGACY_VGA_TARGET
 };
 
+#define UV_BIOS_EXTRA			    0x10000
+#define UV_BIOS_GET_PCI_TOPOLOGY	    0x10001
+#define UV_BIOS_GET_GEOINFO		    0x10003
+
+#define UV_BIOS_EXTRA_OP_MEM_COPYIN	    0x1000
+#define UV_BIOS_EXTRA_OP_MEM_COPYOUT	    0x2000
+#define UV_BIOS_EXTRA_OP_MASK		    0x0fff
+#define UV_BIOS_EXTRA_GET_HEAPSIZE	    1
+#define UV_BIOS_EXTRA_INSTALL_HEAP	    2
+#define UV_BIOS_EXTRA_MASTER_NASID	    3
+#define UV_BIOS_EXTRA_OBJECT_COUNT	    (10|UV_BIOS_EXTRA_OP_MEM_COPYOUT)
+#define UV_BIOS_EXTRA_ENUM_OBJECTS	    (12|UV_BIOS_EXTRA_OP_MEM_COPYOUT)
+#define UV_BIOS_EXTRA_ENUM_PORTS	    (13|UV_BIOS_EXTRA_OP_MEM_COPYOUT)
+
 /*
  * Status values returned from a BIOS call.
  */
@@ -109,6 +123,32 @@ struct uv_systab {
 	} entry[1];		/* additional entries follow */
 };
 extern struct uv_systab *uv_systab;
+
+#define UV_BIOS_MAXSTRING	      128
+struct uv_bios_hub_info {
+	unsigned int id;
+	union {
+		struct {
+			unsigned long long this_part:1;
+			unsigned long long is_shared:1;
+			unsigned long long is_disabled:1;
+		} fields;
+		struct {
+			unsigned long long flags;
+			unsigned long long reserved;
+		} b;
+	} f;
+	char name[UV_BIOS_MAXSTRING];
+	char location[UV_BIOS_MAXSTRING];
+	unsigned int ports;
+};
+
+struct uv_bios_port_info {
+	unsigned int port;
+	unsigned int conn_id;
+	unsigned int conn_port;
+};
+
 /* (... end of definitions from UV BIOS ...) */
 
 enum {
@@ -142,6 +182,15 @@ extern s64 uv_bios_change_memprotect(u64, u64, enum uv_memprotect);
 extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
+extern s64 uv_bios_get_master_nasid(u64 sz, u64 *nasid);
+extern s64 uv_bios_get_heapsize(u64 nasid, u64 sz, u64 *heap_sz);
+extern s64 uv_bios_install_heap(u64 nasid, u64 sz, u64 *heap);
+extern s64 uv_bios_obj_count(u64 nasid, u64 sz, u64 *objcnt);
+extern s64 uv_bios_enum_objs(u64 nasid, u64 sz, u64 *objbuf);
+extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 sz, u64 *portbuf);
+extern s64 uv_bios_get_geoinfo(u64 nasid, u64 sz, u64 *geo);
+extern s64 uv_bios_get_pci_topology(u64 sz, u64 *buf);
+
 extern int uv_bios_init(void);
 extern unsigned long get_uv_systab_phys(bool msg);
 
diff --git a/arch/x86/include/asm/uv/uv_geo.h b/arch/x86/include/asm/uv/uv_geo.h
new file mode 100644
index 000000000000..f241451035fb
--- /dev/null
+++ b/arch/x86/include/asm/uv/uv_geo.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2020 Hewlett Packard Enterprise Development LP. All rights reserved.
+ */
+
+#ifndef _ASM_UV_GEO_H
+#define _ASM_UV_GEO_H
+
+/* Type declaractions */
+
+/* Size of a geoid_s structure (must be before decl. of geoid_u) */
+#define GEOID_SIZE	8
+
+/* Fields common to all substructures */
+struct geo_common_s {
+	unsigned char type;		/* What type of h/w is named by this geoid_s */
+	unsigned char blade;
+	unsigned char slot;		/* slot is IRU */
+	unsigned char upos;
+	unsigned char rack;
+};
+
+/* Additional fields for particular types of hardware */
+struct geo_node_s {
+	struct geo_common_s common;		/* No additional fields needed */
+};
+
+struct geo_rtr_s {
+	struct geo_common_s common;		/* No additional fields needed */
+};
+
+struct geo_iocntl_s {
+	struct geo_common_s common;		/* No additional fields needed */
+};
+
+struct geo_pcicard_s {
+	struct geo_iocntl_s common;
+	char bus;				/* Bus/widget number */
+	char slot;				/* PCI slot number */
+};
+
+/* Subcomponents of a node */
+struct geo_cpu_s {
+	struct geo_node_s node;
+	unsigned char	socket:4,	/* Which CPU on the node */
+			thread:4;
+	unsigned char	core;
+};
+
+struct geo_mem_s {
+	struct geo_node_s node;
+	char membus;			/* The memory bus on the node */
+	char memslot;			/* The memory slot on the bus */
+};
+
+union geoid_u {
+	struct geo_common_s common;
+	struct geo_node_s node;
+	struct geo_iocntl_s iocntl;
+	struct geo_pcicard_s pcicard;
+	struct geo_rtr_s rtr;
+	struct geo_cpu_s cpu;
+	struct geo_mem_s mem;
+	char padsize[GEOID_SIZE];
+};
+
+/* Defined constants */
+
+#define GEO_MAX_LEN	48
+
+#define GEO_TYPE_INVALID	0
+#define GEO_TYPE_MODULE		1
+#define GEO_TYPE_NODE		2
+#define GEO_TYPE_RTR		3
+#define GEO_TYPE_IOCNTL		4
+#define GEO_TYPE_IOCARD		5
+#define GEO_TYPE_CPU		6
+#define GEO_TYPE_MEM		7
+#define GEO_TYPE_MAX		(GEO_TYPE_MEM+1)
+
+static inline int geo_rack(union geoid_u g)
+{
+	return (g.common.type == GEO_TYPE_INVALID) ?
+		-1 : g.common.rack;
+}
+
+static inline int geo_slot(union geoid_u g)
+{
+	return (g.common.type == GEO_TYPE_INVALID) ?
+		-1 : g.common.upos;
+}
+
+static inline int geo_blade(union geoid_u g)
+{
+	return (g.common.type == GEO_TYPE_INVALID) ?
+		-1 : g.common.blade * 2 + g.common.slot;
+}
+
+#endif /* _ASM_UV_GEO_H */
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 54511eaccf4d..7f4c5e32c1ca 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -171,6 +171,60 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 				(u64)decode, (u64)domain, (u64)bus, 0, 0);
 }
 
+extern s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, 0, UV_BIOS_EXTRA_MASTER_NASID, 0,
+				size, (u64)master_nasid);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_master_nasid);
+
+extern s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_GET_HEAPSIZE,
+				0, size, (u64)heap_size);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_heapsize);
+
+extern s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_INSTALL_HEAP,
+				0, heap_size, (u64)bios_heap);
+}
+EXPORT_SYMBOL_GPL(uv_bios_install_heap);
+
+extern s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_OBJECT_COUNT,
+				0, size, (u64)objcnt);
+}
+EXPORT_SYMBOL_GPL(uv_bios_obj_count);
+
+extern s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_OBJECTS,
+				0, size, (u64)objbuf);
+}
+EXPORT_SYMBOL_GPL(uv_bios_enum_objs);
+
+extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_PORTS,
+				obj_id, size, (u64)portbuf);
+}
+EXPORT_SYMBOL_GPL(uv_bios_enum_ports);
+
+extern s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
+{
+	return uv_bios_call(UV_BIOS_GET_GEOINFO, nasid, (u64)buf, size, 0, 0);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_geoinfo);
+
+extern s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
+{
+	return uv_bios_call(UV_BIOS_GET_PCI_TOPOLOGY, (u64)buf, size, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_pci_topology);
+
 unsigned long get_uv_systab_phys(bool msg)
 {
 	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
-- 
2.26.2

