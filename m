Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CE2DB48E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgLOThi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:37:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15690 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727352AbgLOThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:37:06 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BFJXcaP015429
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 11:36:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=XiyLS6boex6NduO3Y3HlXsJcjGSnFa1JrSnocOQadMg=;
 b=UgOwBbqxibA3GU5iadoMx1tYi3LO/XUT4tVj5ZOKe6XVk9NxlroegagZFsBrMfYzhhAW
 4xdYhf9yJOePsPc4+wwhCV7M+SKP6ly189HFhGM8UISbmVycDipdpVy/wcwxk5k3UqoE
 e/sO6MoYQhR9+na3fJ0d6kLh8XWtHfUrnXw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 35ctdv87yw-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 11:36:23 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 11:36:20 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id AC6701FE954D; Tue, 15 Dec 2020 11:36:16 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] mm: cma: allocate cma areas bottom-up
Date:   Tue, 15 Dec 2020 11:36:15 -0800
Message-ID: <20201215193615.1867115-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently cma areas without a fixed base address are allocated
close to the end of the node. This placement is sub-optimal because
of how the compaction works: it effectively moves pages into
the cma area. In particular, it often brings in hot executable pages,
even if there is a plenty of free memory on the machine.
This results in more cma allocation failures.

Instead let's place cma areas close to the beginning of a node.
Cma first tries to start with highmem_start, so we shouldn't mess
up with DMA32. In this case the compaction will help to free cma
areas, resulting in better cma allocation success rates.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memblock.h |  5 +++--
 mm/cma.c                 |  4 ++--
 mm/memblock.c            | 26 +++++++++++++++-----------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9c5cc95c7cee..698188066450 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -384,8 +384,9 @@ static inline int memblock_get_region_node(const stru=
ct memblock_region *r)
 phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t alig=
n,
 				      phys_addr_t start, phys_addr_t end);
 phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
-				      phys_addr_t align, phys_addr_t start,
-				      phys_addr_t end, int nid, bool exact_nid);
+				     phys_addr_t align, phys_addr_t start,
+				     phys_addr_t end, int nid, bool exact_nid,
+				     bool bottom_up);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t al=
ign, int nid);
=20
 static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
diff --git a/mm/cma.c b/mm/cma.c
index 20c4f6f40037..1b42be6d059b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -332,13 +332,13 @@ int __init cma_declare_contiguous_nid(phys_addr_t b=
ase,
 		 */
 		if (base < highmem_start && limit > highmem_start) {
 			addr =3D memblock_alloc_range_nid(size, alignment,
-					highmem_start, limit, nid, true);
+					highmem_start, limit, nid, true, true);
 			limit =3D highmem_start;
 		}
=20
 		if (!addr) {
 			addr =3D memblock_alloc_range_nid(size, alignment, base,
-					limit, nid, true);
+					limit, nid, true, true);
 			if (!addr) {
 				ret =3D -ENOMEM;
 				goto err;
diff --git a/mm/memblock.c b/mm/memblock.c
index b8b7be0561c4..c334b401fe16 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -272,6 +272,7 @@ __memblock_find_range_top_down(phys_addr_t start, phy=
s_addr_t end,
  *       %MEMBLOCK_ALLOC_ACCESSIBLE
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  * @flags: pick from blocks based on memory attributes
+ * @bottom_up: force bottom-up allocation
  *
  * Find @size free area aligned to @align in the specified range and nod=
e.
  *
@@ -289,7 +290,8 @@ __memblock_find_range_top_down(phys_addr_t start, phy=
s_addr_t end,
 static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr=
_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
-					enum memblock_flags flags)
+					enum memblock_flags flags,
+					bool bottom_up)
 {
 	phys_addr_t kernel_end, ret;
=20
@@ -305,9 +307,10 @@ static phys_addr_t __init_memblock memblock_find_in_=
range_node(phys_addr_t size,
=20
 	/*
 	 * try bottom-up allocation only when bottom-up mode
-	 * is set and @end is above the kernel image.
+	 * is set and @end is above the kernel image or
+	 * the bottom-up mode is enforced.
 	 */
-	if (memblock_bottom_up() && end > kernel_end) {
+	if ((memblock_bottom_up() && end > kernel_end) || bottom_up) {
 		phys_addr_t bottom_up_start;
=20
 		/* make sure we will allocate above the kernel */
@@ -359,7 +362,7 @@ phys_addr_t __init_memblock memblock_find_in_range(ph=
ys_addr_t start,
=20
 again:
 	ret =3D memblock_find_in_range_node(size, align, start, end,
-					    NUMA_NO_NODE, flags);
+					  NUMA_NO_NODE, flags, false);
=20
 	if (!ret && (flags & MEMBLOCK_MIRROR)) {
 		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
@@ -1331,6 +1334,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone =
*zone,
  * @end: the upper bound of the memory region to allocate (phys address)
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  * @exact_nid: control the allocation fall back to other nodes
+ * @bottom_up: force bottom-up allocation
  *
  * The allocation is performed from memory region limited by
  * memblock.current_limit if @end =3D=3D %MEMBLOCK_ALLOC_ACCESSIBLE.
@@ -1351,7 +1355,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone =
*zone,
 phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
-					bool exact_nid)
+					bool exact_nid, bool bottom_up)
 {
 	enum memblock_flags flags =3D choose_memblock_flags();
 	phys_addr_t found;
@@ -1367,14 +1371,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_=
addr_t size,
=20
 again:
 	found =3D memblock_find_in_range_node(size, align, start, end, nid,
-					    flags);
+					    flags, bottom_up);
 	if (found && !memblock_reserve(found, size))
 		goto done;
=20
 	if (nid !=3D NUMA_NO_NODE && !exact_nid) {
 		found =3D memblock_find_in_range_node(size, align, start,
 						    end, NUMA_NO_NODE,
-						    flags);
+						    flags, bottom_up);
 		if (found && !memblock_reserve(found, size))
 			goto done;
 	}
@@ -1423,7 +1427,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_a=
ddr_t size,
 		     __func__, (u64)size, (u64)align, &start, &end,
 		     (void *)_RET_IP_);
 	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
-					false);
+					false, false);
 }
=20
 /**
@@ -1442,7 +1446,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_a=
ddr_t size,
 phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_ad=
dr_t align, int nid)
 {
 	return memblock_alloc_range_nid(size, align, 0,
-					MEMBLOCK_ALLOC_ACCESSIBLE, nid, false);
+					MEMBLOCK_ALLOC_ACCESSIBLE, nid, false, false);
 }
=20
 /**
@@ -1484,12 +1488,12 @@ static void * __init memblock_alloc_internal(
 		max_addr =3D memblock.current_limit;
=20
 	alloc =3D memblock_alloc_range_nid(size, align, min_addr, max_addr, nid=
,
-					exact_nid);
+					exact_nid, false);
=20
 	/* retry allocation without lower limit */
 	if (!alloc && min_addr)
 		alloc =3D memblock_alloc_range_nid(size, align, 0, max_addr, nid,
-						exact_nid);
+						exact_nid, false);
=20
 	if (!alloc)
 		return NULL;
--=20
2.26.2

