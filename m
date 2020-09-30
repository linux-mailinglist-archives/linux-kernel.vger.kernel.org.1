Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A91427F174
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgI3Sje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:39:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54050 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgI3Sj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:39:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200930183925euoutp01ff31d8bb418b016f5cbb21450bcab965~5o7r8MrTo2669126691euoutp01n
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200930183925euoutp01ff31d8bb418b016f5cbb21450bcab965~5o7r8MrTo2669126691euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601491166;
        bh=DEzENPvTzIj7n5HipV9UGgMD2am2karJlQJEh31H+LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjZpMEaisjAmfNcmBOu74tchVEjynlB7dzd5n+cqcXe1bpOEABi0QTxtWj/HAGvbg
         vwlioxBZLiQoQLowp+sywwJAvLlcvywi2VFwm2Z9v2TpMjKZY1KIEMHkGQ5TZ+8CmH
         HN7qDKUHcjVHKm0ujLChA2hhyYFzmbyn19RLV+oQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200930183925eucas1p250bf18c8799f50a93d8495f722068afd~5o7rSHAac0658306583eucas1p2v;
        Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.A1.06456.DD0D47F5; Wed, 30
        Sep 2020 19:39:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200930183924eucas1p281730f3d651fc2c78d6a95e47a2c5220~5o7q_epOQ0657106571eucas1p2-;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200930183924eusmtrp2c72d8659d0d5c71bd05236561ff2f419~5o7q9xwoi3109431094eusmtrp2E;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-65-5f74d0dddcd7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.F8.06314.CD0D47F5; Wed, 30
        Sep 2020 19:39:24 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200930183924eusmtip118188b92986ebbbf676216b0b1ce10b6~5o7qxhqgL2620826208eusmtip1R;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 4/4] arm: kexec_file: load zImage or uImage, initrd and
 dtb
Date:   Wed, 30 Sep 2020 20:34:13 +0200
Message-Id: <20200930183413.17023-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930183413.17023-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH973nueee0vF0tfURilsxoTTkoZjM5tmwNf4z5OjZ+dFd7X5E
        LN1hUYmcpVytQrpcKS5CP7BjRdH0U1mtIxUpWj/oyKXrOdN/n+/n/Xp/3p/P9iUx0SDfkzws
        V7EKuSRSTDjjZdXW+hWdb1XhK29rXOh7GSV8Wlf8jEdrLmtwul1bwaNfJ8voiroxHt1uLkC0
        qbuVTzeVZxG0Oa0K0XdedAroD5Y2Pl1oq0X0UOokj554asXpUlMatolimlobMCZT04Azf4yf
        MSbXpGZMxkSC6WitJJhv9fUCpjQvnkkdGiSY709aCObifSNiRkxeYS67nUMi2MjDMawiYON+
        50Ndxtf8aFM2Ov7jYTqmQfnxSciJBGo1dFtKiSTkTIqoAgTa3494dkFEjSIY/rqUE0YQ6IrK
        8X+O6wmvBJxgQHC29qPD3oegeSgb2SmCCoVLt17y7YI7ZcGgP82A2x8YlY9gMmOAb6fcqDBI
        emuZDsQpX2gZ75rOEFLB0D1mRVyeN5wzPCTstRMVAo1vXhAc4wqvrn2a5udQflB0+t10jU3x
        Zx5kYvYwoG6T0POtheAGbQHt8wLHEW7QX3NfwNXzYfJxztQS5FQdD1d0QZz3AoKyrHEHHwwd
        9b8IO4NRS6GkPIBrh0JLfrPDOhvaBl25FWaDriwd49pCOJ8g4mgfKL5U6RjoCSn9BSgVifUz
        jtHPOED/PysXYUbkwaqVMimrDJSzx/yVEplSLZf6H4ySmdDUJ6yz1Qw/QmONB8yIIpHYRZgq
        V4WL+JIYZazMjIDExO7CzW/q9omEEZLYE6wiKlyhjmSVZjSPxMUewlU3vuwVUVKJij3KstGs
        4p/KI508NehqtTozbp7v1mWGm3u2//TV7SxZuFgrkActsrkvsCyLqDqVNlHrdfJr/tq5s5Zc
        GQ/UBy5hbLuk+tH3OXd83fryVIWjdyuKe7B2w5pt2AbP5b9u1BwJifzZGxZdvW58vY/FvSJg
        R+KAtdZP3t/71Lp7T3nvOVtr3OiC5JQs4Q5XrfcuMa48JAn0wxRKyV8UKpq4gAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURzGObt3d1Mc3a6GJ7GUgQRS0+s0j/lC9iHup4jKL/m69KKW22R3
        MxXCZaA5QbdA0pliplZLE2dpZGYNcTp1+LqSFA1N/NCLWYqCaXsh8tvDeX7Pc/5/zhFi1B4e
        IMxVqFmVQpYnJrzx0T3rwqn5CXV6+O5kFOqq7eSje8/f8ZDWoMXR3O0+HhqrlKO+0U0emrM8
        Aci87OCj6dcPCGSp6QeoY3BBgD4vfeSjZ3s2gNb1+zy0O7CDo25zDXaWZKYdkxhTr53EmT+m
        NYxpMmsYs6mCYOYdbwjmu90uYLpbShj9+jeC+fF2lmCqXpgA88t8/KLPVUmcSqlRs8E5Sk4d
        L06mUYSEjkGSiMgYCS2NTj0TESUOS4jLYvNyC1hVWEKGJGfRNMbPNzeCwq3e+5gWtJXogJcQ
        kpHwYdmIQAe8hRTZCqB+sgvXAaHTCIBPG7I9jC/cdegID/MFwEWLQeAyCDIRVrcO812GH/kV
        g+WGVTeFkW0APtqv5rsoX/ICtE2tYC6NkyFwdnsRd2kRGQuXN3eA54ogWP64l3BpLzIOTo0P
        ujVFymGvYYPn4Q/DkboV93QYeQJ2NlKu40NkKGwv/eCuxJw1d17WY3pAGQ8kjP8TxgNUE8BM
        wI/VcPJsOUdLOJmc0yiyJZlKuRk4375naKf7FZjqumwBpBCIfUR6hTqd4ssKuCK5BUAhJvYT
        nRsfTaNEWbKiYlalTFdp8ljOAqKcaxqwgCOZSudPcmboKDoaxdDR0mjpaST2F90l36dQZLZM
        zd5g2XxW9S/HE3oFaMHJ2PagGd+WqhnrTKIthLYlOkrltR03t2OTzmfMrHWFC34vTT8e3G4w
        2ptTTWX9yRX2QG3w1sKnS0cDHde6Nfn+Q9PNgCiUDvMHV7O2h5LEx0Troh7qimxgROqrHh4J
        /LkXcb2vcgLPid9IDEsZWym9ZRWMmo1Il1ZUXGdNE+NcjowOxVSc7C8VP7ccEQMAAA==
X-CMS-MailID: 20200930183924eucas1p281730f3d651fc2c78d6a95e47a2c5220
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200930183924eucas1p281730f3d651fc2c78d6a95e47a2c5220
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200930183924eucas1p281730f3d651fc2c78d6a95e47a2c5220
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200930183413.17023-1-l.stelmach@samsung.com>
        <CGME20200930183924eucas1p281730f3d651fc2c78d6a95e47a2c5220@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is kexec_file_load implementation for ARM. It loads zImage and
initrd from file descripters and resuses DTB.

Most code is derived from arm64 kexec_file_load implementation
and from kexec-tools.

Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/Kconfig                     |  26 ++++
 arch/arm/include/asm/image.h         |  26 ++++
 arch/arm/include/asm/kexec.h         |  16 +-
 arch/arm/kernel/Makefile             |   5 +-
 arch/arm/kernel/kexec_uimage.c       |  80 ++++++++++
 arch/arm/kernel/kexec_zimage.c       | 197 +++++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c      |  11 +-
 arch/arm/kernel/machine_kexec_file.c | 211 +++++++++++++++++++++++++++
 8 files changed, 566 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/kernel/kexec_uimage.c
 create mode 100644 arch/arm/kernel/kexec_zimage.c
 create mode 100644 arch/arm/kernel/machine_kexec_file.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17eb2b50..65e5540f3ed1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1873,6 +1873,32 @@ config KEXEC
 	  is properly shutdown, so do not be surprised if this code does not
 	  initially work for you.
 
+config KEXEC_FILE
+	bool "Kexec file based system call (EXPERIMENTAL)"
+	depends on (!SMP || PM_SLEEP_SMP)
+	depends on MMU
+	depends on USE_OF
+	select KEXEC_CORE
+	select CRC32
+	help
+	  This is a new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
+	  The kernel to be loaded MUST support Flattened Device Tree
+	  (selected with CONFIG_USE_OF).
+
+config KEXEC_FILE_UIMAGE
+	bool "Load legacy uImage files with kexec_file_load() (EXPERIMENTAL)"
+	depends on KEXEC_FILE
+	default n
+	help
+	  This options enables support for the legacy uImage files as
+	  created by mkimage. These are not the new FIT files.
+
+	  If unsure say N.
+
 config ATAGS_PROC
 	bool "Export atags in procfs"
 	depends on ATAGS && KEXEC
diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
index 8be6dbc69fbb..15c4fe031d90 100644
--- a/arch/arm/include/asm/image.h
+++ b/arch/arm/include/asm/image.h
@@ -8,8 +8,13 @@
 			 (((x) >>  8) & 0x0000ff00) |  \
 			 (((x) <<  8) & 0x00ff0000) |  \
 			 (((x) << 24) & 0xff000000))
+#define UIMAGE_MAGIC(x) (x)
 #else
 #define ZIMAGE_MAGIC(x) (x)
+#define UIMAGE_MAGIC(x) ((((x) >> 24) & 0x000000ff) | \
+			 (((x) >>  8) & 0x0000ff00) |  \
+			 (((x) <<  8) & 0x00ff0000) |  \
+			 (((x) << 24) & 0xff000000))
 #endif
 
 #define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
@@ -17,6 +22,12 @@
 #define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
 #define ARM_ZIMAGE_MAGIC4 ZIMAGE_MAGIC(0x5a534344)
 
+#define ARM_UIMAGE_MAGIC UIMAGE_MAGIC(0x27051956)
+#define ARM_UIMAGE_NAME_LEN		32
+#define ARM_UIMAGE_TYPE_KERNEL		2
+#define ARM_UIMAGE_TYPE_KERNEL_NOLOAD	14
+#define ARM_UIMAGE_ARCH_ARM		2
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -33,6 +44,21 @@ struct arm_zimage_header {
 	__le32 extension_tag_offset;
 };
 
+struct arm_uimage_header {
+	__be32 magic;
+	__be32 hdr_crc;
+	__be32 time;
+	__be32 size;
+	__be32 load;
+	__be32 entry;
+	__be32 crc;
+	__u8   os;
+	__u8   arch;
+	__u8   type;
+	__u8   comp;
+	__u8   name[ARM_UIMAGE_NAME_LEN];
+};
+
 struct arm_zimage_tag {
 	struct tag_header hdr;
 	union {
diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index 22751b5b5735..8e4d0d92269b 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -2,7 +2,7 @@
 #ifndef _ARM_KEXEC_H
 #define _ARM_KEXEC_H
 
-#ifdef CONFIG_KEXEC
+#if defined(CONFIG_KEXEC) || defined(CONFIG_KEXEC_FILE)
 
 /* Maximum physical address we can use pages from */
 #define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
@@ -83,6 +83,20 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
 }
 #define boot_pfn_to_page boot_pfn_to_page
 
+#ifdef CONFIG_KEXEC_FILE
+
+extern const struct kexec_file_ops kexec_zimage_ops;
+extern const struct kexec_file_ops kexec_uimage_ops;
+
+struct kimage;
+
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr, unsigned long kernel_size,
+		char *initrd, unsigned long initrd_len,
+		unsigned long initrd_offset, char *cmdline);
+
+#endif /* CONFIG_KEXEC_FILE */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* CONFIG_KEXEC */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 89e5d864e923..453ecf7305e2 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the linux kernel.
 #
 
+CFLAGS_kexec_zimage.o := -DTEXT_OFFSET=$(TEXT_OFFSET)
 CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
 
@@ -56,7 +57,9 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_zimage.o
+obj-$(CONFIG_KEXEC_FILE_UIMAGE)	+= kexec_uimage.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
 obj-$(CONFIG_KPROBES)		+= patch.o insn.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
diff --git a/arch/arm/kernel/kexec_uimage.c b/arch/arm/kernel/kexec_uimage.c
new file mode 100644
index 000000000000..47033574e24e
--- /dev/null
+++ b/arch/arm/kernel/kexec_uimage.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec uImage loader
+ *
+ * Copyright (C) 2020 Samsung Electronics
+ * Author: Łukasz Stelmach <l.stelmach@samsung.com>
+ */
+
+#define pr_fmt(fmt)	"kexec_file(uImage): " fmt
+
+#include <asm/image.h>
+#include <linux/crc32.h>
+#include <linux/err.h>
+#include <linux/kexec.h>
+
+#define crc32_ones(crc, buf, len) \
+	(crc32(crc ^ 0xffffffff, buf, len) ^ 0xffffffff)
+
+static int uimage_probe(const char *uimage_buf, unsigned long uimage_len)
+{
+	const struct arm_uimage_header *h =
+		(struct arm_uimage_header *) uimage_buf;
+	struct arm_uimage_header uhdr;
+	unsigned long zoff = sizeof(struct arm_uimage_header);
+	uint32_t crc;
+
+	if (h->magic != ARM_UIMAGE_MAGIC)
+		return -EINVAL;
+
+	if (h->type != ARM_UIMAGE_TYPE_KERNEL &&
+	    h->type != ARM_UIMAGE_TYPE_KERNEL_NOLOAD){
+		pr_debug("Invalid image type: %d\n", h->type);
+		return -EINVAL;
+	}
+
+	if (h->arch != ARM_UIMAGE_ARCH_ARM) {
+		pr_debug("Invalidy image arch: %d\n", h->arch);
+		return -EINVAL;
+	}
+
+	memcpy((char *)&uhdr, h, sizeof(uhdr));
+	crc = be32_to_cpu(uhdr.hdr_crc);
+	uhdr.hdr_crc = 0;
+
+	if (crc32_ones(0, (char *)&uhdr, sizeof(uhdr)) != crc) {
+		pr_debug("Corrupt header, CRC do not match\n");
+		return -EINVAL;
+	}
+
+	crc = be32_to_cpu(uhdr.crc);
+	if (crc32_ones(0, uimage_buf + zoff, uimage_len - zoff) != crc) {
+		pr_debug("Corrupt zImage, CRC do not match\n");
+		return -EINVAL;
+	}
+
+	return kexec_zimage_ops.probe(uimage_buf + zoff,
+				      uimage_len - zoff);
+}
+
+static void *uimage_load(struct kimage *image,
+				char *uimage, unsigned long uimage_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	const struct arm_uimage_header *h =
+		(struct arm_uimage_header *) uimage;
+	unsigned long zimage_offset = sizeof(struct arm_uimage_header);
+
+	pr_debug("Loading uImage");
+	return kexec_zimage_ops.load(image,
+				     uimage + zimage_offset,
+				     uimage_len - zimage_offset,
+				     initrd, initrd_len,
+				     cmdline, cmdline_len);
+}
+
+const struct kexec_file_ops kexec_uimage_ops = {
+	.probe = uimage_probe,
+	.load = uimage_load,
+};
diff --git a/arch/arm/kernel/kexec_zimage.c b/arch/arm/kernel/kexec_zimage.c
new file mode 100644
index 000000000000..543229a42793
--- /dev/null
+++ b/arch/arm/kernel/kexec_zimage.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec zImage loader
+ *
+ * Copyright (C) 2020 Samsung Electronics
+ * Authors:
+ *     Łukasz Stelmach <l.stelmach@samsung.com>
+ *
+ * Based on earlier works for kexec-tools by
+ *     Russell King <rmk+kernel@armlinux.org.uk>
+ *
+ */
+
+#define pr_fmt(fmt)	"kexec_file(zImage): " fmt
+
+#include <asm/image.h>
+#include <asm/unaligned.h>
+#include <linux/err.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+
+#define byte_size(t)    ((t)->hdr.size << 2)
+
+/*
+ * This function and several pieces below have been taken from
+ * kexec-tools/kexec/arch/arm/kexec-zImage-arm.c
+ */
+static const void *find_extension_tag(const char *buf,
+						       unsigned long len,
+						       uint32_t tag_id)
+{
+	const struct arm_zimage_header *h = (const struct arm_zimage_header *)buf;
+	const struct arm_zimage_tag *tag;
+	uint32_t offset, size;
+	uint32_t max = len - sizeof(struct tag_header);
+
+	if (len < sizeof(*h) ||
+	    h->magic != ARM_ZIMAGE_MAGIC1 ||
+	    h->magic2 != ARM_ZIMAGE_MAGIC2)
+		return NULL;
+
+	for (offset = h->extension_tag_offset;
+	     (tag = (void *)(buf + offset)) != NULL &&
+		     offset < max &&
+		     (size = le32_to_cpu(byte_size(tag))) != 0 &&
+		     offset + size < len;
+	     offset += size) {
+		pr_debug("  offset 0x%08x tag 0x%08x size %u\n",
+			  offset, le32_to_cpu(tag->hdr.tag), size);
+		if (tag->hdr.tag == tag_id)
+			return tag;
+	}
+
+	return NULL;
+}
+
+static int zimage_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm_zimage_header *h =
+		(struct arm_zimage_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h)))
+		return -EINVAL;
+
+	if ((h->magic != ARM_ZIMAGE_MAGIC1) ||
+	    (h->magic2 != ARM_ZIMAGE_MAGIC2))
+		return -EINVAL;
+
+	return 0;
+}
+
+
+#if defined(DEBUG)
+#define debug_offsets() ({			\
+	pr_debug("Image offsets:\n");		\
+	pr_debug("  kernel 0x%08lx 0x%08lx\n", kernel_offset, kernel_len); \
+	pr_debug("  zimage 0x%08lx 0x%08lx\n", zimage_offset, zimage_len); \
+	pr_debug("  initrd 0x%08lx 0x%08lx\n", initrd_offset, initrd_len); \
+})
+#else
+#define debug_offsets()
+#endif
+
+static void *zimage_load(struct kimage *image,
+				char *zimage, unsigned long zimage_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	struct arm_zimage_header *h;
+	struct kexec_buf kbuf;
+	struct kexec_segment *zimage_segment;
+	const struct arm_zimage_tag *tag;
+	int ret = -EINVAL;
+
+	unsigned long zimage_mem = 0x20000; /* malloc 64kB + stack 4 kB + some bss */
+	unsigned long kernel_len = zimage_len * 5; /* 5:1 compression */
+	unsigned long kernel_offset = memblock_start_of_DRAM();
+	unsigned long zimage_offset = kernel_offset +
+		ALIGN(kernel_len, PAGE_SIZE);
+	unsigned long initrd_offset = zimage_offset +
+		ALIGN(zimage_len + zimage_mem, PAGE_SIZE);
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kernel_offset += crashk_res.start;
+		zimage_offset += crashk_res.start;
+		initrd_offset += crashk_res.start;
+	}
+	debug_offsets();
+
+	h = (struct arm_zimage_header *)zimage;
+
+	tag = find_extension_tag(zimage, zimage_len, ZIMAGE_TAG_KRNL_SIZE);
+	if (tag) {
+		uint32_t *p = (void *)zimage +
+			le32_to_cpu(tag->u.krnl_size.size_ptr);
+		uint32_t edata_size = le32_to_cpu(get_unaligned(p));
+		uint32_t bss_size = le32_to_cpu(tag->u.krnl_size.bss_size);
+		uint32_t text_offset = le32_to_cpu(tag->u.krnl_size.text_offset);
+
+		kernel_offset += ALIGN(text_offset, PAGE_SIZE);
+		kernel_len = edata_size + bss_size;
+
+		pr_debug("Decompressed kernel sizes:\n");
+		pr_debug(" text+data 0x%08lx bss 0x%08lx total 0x%08lx\n",
+			 (unsigned long)edata_size,
+			 (unsigned long)bss_size,
+			 (unsigned long)kernel_len);
+
+		zimage_offset = kernel_offset + ALIGN(edata_size, PAGE_SIZE);
+		initrd_offset = zimage_offset +
+			max(ALIGN(zimage_len + 0x20000, PAGE_SIZE),
+			    ALIGN((unsigned long)bss_size, PAGE_SIZE));
+		debug_offsets();
+	}
+
+	tag = find_extension_tag(zimage, zimage_len,
+				 ZIMAGE_TAG_ZIMAGE_MEM);
+	if (tag) {
+		uint32_t zimage_mem = le32_to_cpu(tag->u.zimage_mem);
+
+		pr_debug("Decompressor requires %d bytes of memory\n", zimage_mem);
+
+		initrd_offset = max(ALIGN(zimage_offset + zimage_len + zimage_mem, PAGE_SIZE),
+				    ALIGN(kernel_offset + kernel_len, PAGE_SIZE));
+		debug_offsets();
+	}
+
+	/*
+	 * zImage MUST be loaded into the first 128 MiB of physical
+	 * memory for proper memory detection. Should the uncompressed
+	 * kernel be larger than 128 MiB, zImage relocation becomes
+	 * unavoidable and it is best to rely on the relocation code.
+	 */
+	if (((zimage_offset - kernel_offset) + PAGE_SIZE + 0x8000) >= SZ_128M) {
+		pr_debug("The kernel is too big (%ld MiB) to avoid "
+			 "zImage relocation. Loading zimage at 0x%08lx\n",
+			 ((zimage_offset - kernel_offset) >> 20),
+			 kernel_offset);
+		zimage_offset = kernel_offset;
+	}
+
+	kbuf.image = image;
+	kbuf.top_down = false;
+
+	kbuf.buf_min = zimage_offset;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.buffer = zimage;
+	kbuf.bufsz = zimage_len;
+	kbuf.buf_align = PAGE_SIZE;
+
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = zimage_len;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pr_debug("Loaded zImage at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 kbuf.mem, kbuf.bufsz, kbuf.memsz);
+
+	initrd_offset += kbuf.mem - zimage_offset;
+	debug_offsets();
+
+	zimage_segment = &image->segment[image->nr_segments - 1];
+	image->start = zimage_segment->mem;
+
+	ret = load_other_segments(image,
+				  zimage_segment->mem, zimage_segment->memsz,
+				  initrd, initrd_len, initrd_offset,
+				  cmdline);
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_zimage_ops = {
+	.probe = zimage_probe,
+	.load = zimage_load,
+};
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index a0c229eec0b2..b349d6b8d18c 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -91,10 +91,13 @@ int machine_kexec_prepare(struct kimage *image)
 					       current_segment->memsz))
 			return -EINVAL;
 
-		err = get_user(header, (__be32*)current_segment->buf);
-		if (err)
-			return err;
-
+		if (image->file_mode) {
+			header = *(__be32 *)current_segment->buf;
+		} else {
+			err = get_user(header, (__be32 *)current_segment->buf);
+			if (err)
+				return err;
+		}
 		if (header == cpu_to_be32(OF_DT_HEADER))
 			image->arch.kernel_r2 = current_segment->mem;
 	}
diff --git a/arch/arm/kernel/machine_kexec_file.c b/arch/arm/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..a632d351602c
--- /dev/null
+++ b/arch/arm/kernel/machine_kexec_file.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kexec_file for arm
+ *
+ * Copyright (C) 2018 Linaro Limited
+ * Copyright (C) 2020 Samsung Electronics
+ * Authors:
+ *     AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *     Łukasz Stelmach <l.stelmach@samsung.com>
+ *
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
+#include <linux/random.h>
+
+/* relevant device tree properties */
+#define FDT_PROP_INITRD_START	"linux,initrd-start"
+#define FDT_PROP_INITRD_END	"linux,initrd-end"
+#define FDT_PROP_BOOTARGS	"bootargs"
+#define FDT_PROP_RNG_SEED	"rng-seed"
+
+static int setup_dtb(struct kimage *image,
+		     unsigned long initrd_load_addr, unsigned long initrd_len,
+		     char *cmdline, void *dtb)
+{
+	int off, ret;
+
+	ret = fdt_path_offset(dtb, "/chosen");
+	if (ret < 0)
+		goto out;
+
+	off = ret;
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop_string(dtb, off, FDT_PROP_BOOTARGS, cmdline);
+		if (ret)
+			goto out;
+	} else {
+		ret = fdt_delprop(dtb, off, FDT_PROP_BOOTARGS);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_START,
+				      initrd_load_addr);
+		if (ret)
+			goto out;
+
+		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_END,
+				      initrd_load_addr + initrd_len);
+		if (ret)
+			goto out;
+	} else {
+		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_START);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+
+		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_END);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+	}
+
+	/* add rng-seed */
+	if (rng_is_initialized()) {
+		char seed[128];
+		get_random_bytes(seed, sizeof(seed));
+
+		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED,
+				  seed, sizeof(seed));
+		if (ret)
+			goto out;
+	} else {
+		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
+				FDT_PROP_RNG_SEED);
+		ret = 0;
+	}
+
+out:
+	if (ret)
+		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
+
+	return 0;
+}
+/*
+ * More space needed so that we can add initrd, bootargs and kaslr-seed.
+ */
+#define DTB_EXTRA_SPACE 0x1000
+
+static int create_dtb(struct kimage *image,
+		      unsigned long initrd_load_addr, unsigned long initrd_len,
+		      char *cmdline, void **dtb)
+{
+	void *buf;
+	size_t buf_size;
+	size_t cmdline_len;
+	int ret;
+
+	cmdline_len = cmdline ? strlen(cmdline) : 0;
+	buf_size = fdt_totalsize(initial_boot_params)
+			+ cmdline_len + DTB_EXTRA_SPACE;
+
+	for (;;) {
+		buf = vmalloc(buf_size);
+		if (!buf)
+			return -ENOMEM;
+
+		/* duplicate a device tree blob */
+		ret = fdt_open_into(initial_boot_params, buf, buf_size);
+		if (ret)
+			return -EINVAL;
+
+		ret = setup_dtb(image, initrd_load_addr, initrd_len,
+				cmdline, buf);
+		if (ret) {
+			vfree(buf);
+			if (ret == -ENOMEM) {
+				/* unlikely, but just in case */
+				buf_size += DTB_EXTRA_SPACE;
+				continue;
+			} else {
+				return ret;
+			}
+		}
+
+		/* trim it */
+		fdt_pack(buf);
+		*dtb = buf;
+
+		return 0;
+	}
+}
+
+int load_other_segments(struct kimage *image,
+			unsigned long zimage_load_addr,
+			unsigned long zimage_len,
+			char *initrd,
+			unsigned long initrd_len,
+			unsigned long initrd_offset,
+			char *cmdline)
+{
+	struct kexec_buf kbuf;
+	void *dtb = NULL;
+	unsigned long initrd_load_addr = 0;
+	unsigned long dtb_len;
+	int ret = 0;
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = initrd_offset;
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = PAGE_SIZE;
+		kbuf.buf_max = ULONG_MAX;
+		kbuf.top_down = false;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out_err;
+
+		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				kbuf.mem, kbuf.bufsz, kbuf.memsz);
+
+		initrd_load_addr = kbuf.mem;
+		kbuf.buf_min = initrd_load_addr + kbuf.memsz;
+	}
+
+	/* load dtb */
+	ret = create_dtb(image, initrd_load_addr, initrd_len, cmdline, &dtb);
+	if (ret) {
+		pr_err("Preparing for new dtb failed\n");
+		goto out_err;
+	}
+
+	dtb_len = fdt_totalsize(dtb);
+	kbuf.buffer = dtb;
+	kbuf.bufsz = dtb_len;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = dtb_len;
+	kbuf.buf_align = PAGE_SIZE;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out_err;
+
+	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 kbuf.mem, kbuf.bufsz, kbuf.memsz);
+	return 0;
+out_err:
+	vfree(dtb);
+	return ret;
+}
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+#ifdef CONFIG_KEXEC_FILE_UIMAGE
+	&kexec_uimage_ops,
+#endif
+	&kexec_zimage_ops,
+	NULL
+};
-- 
2.26.2

