Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323A12E0976
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 12:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgLVLTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 06:19:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9468 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLVLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 06:19:42 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D0Yjq0MC7zhvVg;
        Tue, 22 Dec 2020 19:18:23 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Tue, 22 Dec 2020
 19:18:47 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <nivedita@alum.mit.edu>,
        <keescook@chromium.org>, <jroedel@suse.de>
CC:     <zhangpan26@huawei.com>, <hushiyuan@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/kaslr: support separate multiple memmaps parameter parsing
Date:   Tue, 22 Dec 2020 19:31:24 +0800
Message-ID: <20201222113124.35367-1-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is loading,
the load address of the kernel needs to be calculated firstly.

If the kernel address space layout randomization(`kaslr`) is enabled,
the memory range reserved by the memmap parameter will be excluded
to avoid loading the kernel address into the memmap reserved area.

Currently, this is what the manual says:
	`memmap = nn [KMG] @ss [KMG]
		[KNL] Force usage of a specific region of memory.
    	Region of memory to be used is from ss to ss + nn.
   		If @ss [KMG] is omitted, it is equivalent to mem = nn [KMG],
    	which limits max address to nn [KMG].
		Multiple different regions can be specified,
		comma delimited.
		Example:
		memmap=100M@2G, 100M#3G, 1G!1024G
	`

Can we relax the use of memmap?
In our production environment we see many people who use it like this:
Separate multiple memmaps parameters to reserve memory,
memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx

If this format is used, and the reserved memory segment is greater than 4,
there is no way to parse the 5th and subsequent memmaps and the kaslr cannot be disabled by `memmap_too_large`
so the kernel loading address may fall within the memmap range
(reserved memory area from memmap after fourth segment),
which will have bad consequences for use of reserved memory.

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 arch/x86/boot/compressed/kaslr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af..24a2778 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -203,9 +203,6 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 {
 	static int i;
 
-	if (i >= MAX_MEMMAP_REGIONS)
-		return;
-
 	while (str && (i < MAX_MEMMAP_REGIONS)) {
 		int rc;
 		unsigned long long start, size;
@@ -233,7 +230,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 	}
 
 	/* More than 4 memmaps, fail kaslr */
-	if ((i >= MAX_MEMMAP_REGIONS) && str)
+	if ((i >= MAX_MEMMAP_REGIONS) && !memmap_too_large)
 		memmap_too_large = true;
 }
 
-- 
2.7.4

