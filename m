Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FF22B765E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 07:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKRGhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 01:37:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7948 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKRGhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 01:37:34 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CbY5F68njzhc9Z;
        Wed, 18 Nov 2020 14:37:21 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.14) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Nov 2020 14:37:23 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <anshuman.khandual@arm.com>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] arm64: mm: add support for memmap kernel parameters
Date:   Wed, 18 Nov 2020 19:33:14 +1300
Message-ID: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.14]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap should be an useful kernel parameter which has been supported by
x86, mips and xtensa. This patch adds support for ARM64. At this stage,
the below two modes are supported only:
memmap=nn[KMG]@ss[KMG]
Force usage of a specific region of memory

memmap=nn[KMG]$ss[KMG]
Region of memory to be reserved is from ss to ss+nn

If users set memmap=exactmap before memmap=nn[KMG]@ss[KMG], they will
get the exact memory specified by memmap=nn[KMG]@ss[KMG]. For example,
on one machine with 4GB memory, "memmap=exactmap memmap=1G@1G" will
make kernel use the memory from 1GB to 2GB only.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/mm/init.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 095540667f0f..f1c6bfdbc953 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -235,6 +235,65 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static int need_remove_real_memblock __initdata;
+
+static void __init parse_memmap_one(char *p)
+{
+	char *oldp;
+	unsigned long start_at, mem_size;
+
+	if (!p)
+		return;
+
+	if (!strncmp(p, "exactmap", 8)) {
+		need_remove_real_memblock = 1;
+		return;
+	}
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return;
+
+	switch (*p) {
+	case '@':
+		start_at = memparse(p + 1, &p);
+		/*
+		 * use the exactmap defined by nn[KMG]@ss[KMG], remove
+		 * memblock populated by DT etc.
+		 */
+		if (need_remove_real_memblock) {
+			need_remove_real_memblock = 0;
+			memblock_remove(0, ULLONG_MAX);
+		}
+		memblock_add(start_at, mem_size);
+		break;
+	case '$':
+		start_at = memparse(p + 1, &p);
+		memblock_reserve(start_at, mem_size);
+		break;
+	default:
+		pr_warn("Unrecognized memmap syntax: %s\n", p);
+		break;
+	}
+}
+
+static int __init parse_memmap_opt(char *str)
+{
+	while (str) {
+		char *k = strchr(str, ',');
+
+		if (k)
+			*k++ = 0;
+
+		parse_memmap_one(str);
+		str = k;
+	}
+
+	return 0;
+}
+early_param("memmap", parse_memmap_opt);
+
 static int __init early_init_dt_scan_usablemem(unsigned long node,
 		const char *uname, int depth, void *data)
 {
-- 
2.25.1

