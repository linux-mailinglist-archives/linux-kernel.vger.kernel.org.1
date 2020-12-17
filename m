Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77C02DD9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgLQUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:13:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgLQUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:13:01 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHK1g8w006408
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:12:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=VllgsmBXuK9Oj/Ef6T/0gFnqNS7dtriJ2KUq0haRwMg=;
 b=XccuLc79IsMi9O7OyY9PPfhmcCwHElOQHTUx22axJOY1Eyo5epVE9cTA8pgdqBDrNyPN
 0yaIQ0eV/FGDuqXO3kxJMHVo6GexVHByf/ooDvhWSBqg8kUPEr8Inwxu4S/9/DX+I6+F
 xZAdiL424Wk0F8E8RAF05jmmjWEZe1yLp04= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35f9ykjatq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:12:20 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Dec 2020 12:12:19 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 2E3C320F477F; Thu, 17 Dec 2020 12:12:15 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 1/2] mm: cma: allocate cma areas bottom-up
Date:   Thu, 17 Dec 2020 12:12:13 -0800
Message-ID: <20201217201214.3414100-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_14:2020-12-17,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently cma areas without a fixed base are allocated close to the
end of the node. This placement is sub-optimal because of compaction:
it brings pages into the cma area. In particular, it can bring in hot
executable pages, even if there is a plenty of free memory on the
machine. This results in cma allocation failures.

Instead let's place cma areas close to the beginning of a node.
In this case the compaction will help to free cma areas, resulting
in better cma allocation success rates.

If there is enough memory let's try to allocate bottom-up starting
with 4GB to exclude any possible interference with DMA32. On smaller
machines or in a case of a failure, stick with the old behavior.

16GB vm, 2GB cma area:
With this patch:
[    0.000000] Command line: root=3D/dev/vda3 rootflags=3Dsubvol=3D/root =
systemd.unified_cgroup_hierarchy=3D1 enforcing=3D0 console=3DttyS0,115200=
 hugetlb_cma=3D2G
[    0.002928] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
[    0.002930] cma: Reserved 2048 MiB at 0x0000000100000000
[    0.002931] hugetlb_cma: reserved 2048 MiB on node 0

Without this patch:
[    0.000000] Command line: root=3D/dev/vda3 rootflags=3Dsubvol=3D/root =
systemd.unified_cgroup_hierarchy=3D1 enforcing=3D0 console=3DttyS0,115200=
 hugetlb_cma=3D2G
[    0.002930] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
[    0.002933] cma: Reserved 2048 MiB at 0x00000003c0000000
[    0.002934] hugetlb_cma: reserved 2048 MiB on node 0

v2:
  - switched to memblock_set_bottom_up(true), by Mike
  - start with 4GB, by Mike

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/cma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7cda9f..21fd40c092f0 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -337,6 +337,22 @@ int __init cma_declare_contiguous_nid(phys_addr_t ba=
se,
 			limit =3D highmem_start;
 		}
=20
+		/*
+		 * If there is enough memory, try a bottom-up allocation first.
+		 * It will place the new cma area close to the start of the node
+		 * and guarantee that the compaction is moving pages out of the
+		 * cma area and not into it.
+		 * Avoid using first 4GB to not interfere with constrained zones
+		 * like DMA/DMA32.
+		 */
+		if (!memblock_bottom_up() &&
+		    memblock_end >=3D SZ_4G + size) {
+			memblock_set_bottom_up(true);
+			addr =3D memblock_alloc_range_nid(size, alignment, SZ_4G,
+							limit, nid, true);
+			memblock_set_bottom_up(false);
+		}
+
 		if (!addr) {
 			addr =3D memblock_alloc_range_nid(size, alignment, base,
 					limit, nid, true);
--=20
2.26.2

