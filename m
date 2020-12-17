Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514582DD9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgLQUNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:13:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgLQUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:13:04 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHK03JR007435
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:12:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=x+1bBWoRtA7jaN/eZbsz/1VkT8RY6ZUu2R87beO4aCs=;
 b=kWemv5b+9gOsHzix2xHvLVEJP2KlZy+hrlVX2BI8IlrRqyDdOD5fS+oZNTXNsRQLEFEJ
 5ZnlD3/RDd7GIV/Tfv17saRHy62k3PJzYxyjGtyDyLGko7zRfk3YDZ3Bht1xTlSt0i5P
 djHxbu8Yx/B0LR5/apjhvOR9oeEQRzcXXO8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35g80u29pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:12:23 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Dec 2020 12:12:23 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 30DEB20F4781; Thu, 17 Dec 2020 12:12:15 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 2/2] memblock: do not start bottom-up allocations with kernel_end
Date:   Thu, 17 Dec 2020 12:12:14 -0800
Message-ID: <20201217201214.3414100-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201217201214.3414100-1-guro@fb.com>
References: <20201217201214.3414100-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_14:2020-12-17,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012170134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With kaslr the kernel image is placed at a random place, so starting
the bottom-up allocation with the kernel_end can result in an
allocation failure and a warning like this one:

[    0.002920] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
[    0.002921] ------------[ cut here ]------------
[    0.002922] memblock: bottom-up allocation failed, memory hotremove ma=
y be affected
[    0.002937] WARNING: CPU: 0 PID: 0 at mm/memblock.c:332 memblock_find_=
in_range_node+0x178/0x25a
[    0.002937] Modules linked in:
[    0.002939] CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #1169
[    0.002940] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.14.0-1.fc33 04/01/2014
[    0.002942] RIP: 0010:memblock_find_in_range_node+0x178/0x25a
[    0.002944] Code: e9 6d ff ff ff 48 85 c0 0f 85 da 00 00 00 80 3d 9b 3=
5 df 00 00 75 15 48 c7 c7 c0 75 59 88 c6 05 8b 35 df 00 01 e8 25 8a fa ff=
 <0f> 0b 48 c7 44 24 20 ff ff ff ff 44 89 e6 44 89 ea 48 c7 c1 70 5c
[    0.002945] RSP: 0000:ffffffff88803d18 EFLAGS: 00010086 ORIG_RAX: 0000=
000000000000
[    0.002947] RAX: 0000000000000000 RBX: 0000000240000000 RCX: 00000000f=
fffdfff
[    0.002948] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 000000000=
0000046
[    0.002948] RBP: 0000000100000000 R08: ffffffff88922788 R09: 000000000=
0009ffb
[    0.002949] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 000000000=
0000000
[    0.002950] R13: 0000000000000000 R14: 0000000080000000 R15: 00000001f=
b42c000
[    0.002952] FS:  0000000000000000(0000) GS:ffffffff88f71000(0000) knlG=
S:0000000000000000
[    0.002953] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.002954] CR2: ffffa080fb401000 CR3: 00000001fa80a000 CR4: 000000000=
00406b0
[    0.002956] Call Trace:
[    0.002961]  ? memblock_alloc_range_nid+0x8d/0x11e
[    0.002963]  ? cma_declare_contiguous_nid+0x2c4/0x38c
[    0.002964]  ? hugetlb_cma_reserve+0xdc/0x128
[    0.002968]  ? flush_tlb_one_kernel+0xc/0x20
[    0.002969]  ? native_set_fixmap+0x82/0xd0
[    0.002971]  ? flat_get_apic_id+0x5/0x10
[    0.002973]  ? register_lapic_address+0x8e/0x97
[    0.002975]  ? setup_arch+0x8a5/0xc3f
[    0.002978]  ? start_kernel+0x66/0x547
[    0.002980]  ? load_ucode_bsp+0x4c/0xcd
[    0.002982]  ? secondary_startup_64_no_verify+0xb0/0xbb
[    0.002986] random: get_random_bytes called from __warn+0xab/0x110 wit=
h crng_init=3D0
[    0.002988] ---[ end trace f151227d0b39be70 ]---

At the same time, the kernel image is protected with memblock_reserve(),
so we can just start searching at PAGE_SIZE. In this case the
bottom-up allocation has the same chances to success as a top-down
allocation, so there is no reason to fallback in the case of a
failure. All together it simplifies the logic.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memblock.c | 49 ++++++-------------------------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index b68ee86788af..10bd7d1ef0f4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -275,14 +275,6 @@ __memblock_find_range_top_down(phys_addr_t start, ph=
ys_addr_t end,
  *
  * Find @size free area aligned to @align in the specified range and nod=
e.
  *
- * When allocation direction is bottom-up, the @start should be greater
- * than the end of the kernel image. Otherwise, it will be trimmed. The
- * reason is that we want the bottom-up allocation just near the kernel
- * image so it is highly likely that the allocated memory and the kernel
- * will reside in the same node.
- *
- * If bottom-up allocation failed, will try to allocate memory top-down.
- *
  * Return:
  * Found address on success, 0 on failure.
  */
@@ -291,8 +283,6 @@ static phys_addr_t __init_memblock memblock_find_in_r=
ange_node(phys_addr_t size,
 					phys_addr_t end, int nid,
 					enum memblock_flags flags)
 {
-	phys_addr_t kernel_end, ret;
-
 	/* pump up @end */
 	if (end =3D=3D MEMBLOCK_ALLOC_ACCESSIBLE ||
 	    end =3D=3D MEMBLOCK_ALLOC_KASAN)
@@ -301,40 +291,13 @@ static phys_addr_t __init_memblock memblock_find_in=
_range_node(phys_addr_t size,
 	/* avoid allocating the first page */
 	start =3D max_t(phys_addr_t, start, PAGE_SIZE);
 	end =3D max(start, end);
-	kernel_end =3D __pa_symbol(_end);
-
-	/*
-	 * try bottom-up allocation only when bottom-up mode
-	 * is set and @end is above the kernel image.
-	 */
-	if (memblock_bottom_up() && end > kernel_end) {
-		phys_addr_t bottom_up_start;
-
-		/* make sure we will allocate above the kernel */
-		bottom_up_start =3D max(start, kernel_end);
=20
-		/* ok, try bottom-up allocation first */
-		ret =3D __memblock_find_range_bottom_up(bottom_up_start, end,
-						      size, align, nid, flags);
-		if (ret)
-			return ret;
-
-		/*
-		 * we always limit bottom-up allocation above the kernel,
-		 * but top-down allocation doesn't have the limit, so
-		 * retrying top-down allocation may succeed when bottom-up
-		 * allocation failed.
-		 *
-		 * bottom-up allocation is expected to be fail very rarely,
-		 * so we use WARN_ONCE() here to see the stack trace if
-		 * fail happens.
-		 */
-		WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
-			  "memblock: bottom-up allocation failed, memory hotremove may be aff=
ected\n");
-	}
-
-	return __memblock_find_range_top_down(start, end, size, align, nid,
-					      flags);
+	if (memblock_bottom_up())
+		return __memblock_find_range_bottom_up(start, end, size, align,
+						       nid, flags);
+	else
+		return __memblock_find_range_top_down(start, end, size, align,
+						      nid, flags);
 }
=20
 /**
--=20
2.26.2

