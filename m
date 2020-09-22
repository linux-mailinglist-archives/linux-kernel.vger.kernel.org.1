Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21693274AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:09:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51378 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgIVVJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:09:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MKZ0SH026677
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=QljWG4BanVKQ0V2dBu1N9GH2r7RFb4sjQmm/Vb841Uo=;
 b=WsGyqtPbJAIr7AJooDZ3CXBsgMdJ2Ph1m5snxMdPAygiYkieZRkNLl14KQqobBnPf3IY
 V6nB3F2BzBj12r+sQoGVCBP6Xc/uQ7Ablv9t54PmIrkjkiPgaJeyVpHTzr0/JNuPL02r
 ai/8dHhuW4Cr95zohiKpY5gdgIgqp1oluK8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33nfqu7th3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:37:25 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 13:37:24 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id BB794864B57; Tue, 22 Sep 2020 13:37:21 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 0/4] mm: allow mapping accounted kernel pages to userspace
Date:   Tue, 22 Sep 2020 13:36:56 -0700
Message-ID: <20200922203700.2879671-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_18:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=465 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a non-slab kernel page which has been charged to a memory
cgroup can't be mapped to userspace. The underlying reason is simple:
PageKmemcg flag is defined as a page type (like buddy, offline, etc),
so it takes a bit from a page->mapped counter. Pages with a type set
can't be mapped to userspace.

But in general the kmemcg flag has nothing to do with mapping to
userspace. It only means that the page has been accounted by the page
allocator, so it has to be properly uncharged on release.

Some bpf maps are mapping the vmalloc-based memory to userspace, and
their memory can't be accounted because of this implementation detail.

This patchset removes this limitation by moving the PageKmemcg flag
into one of the free bits of the page->mem_cgroup pointer. Also it
formalizes all accesses to the page->mem_cgroup and page->obj_cgroups
using new helpers, adds several checks and removes a couple of obsolete
functions. As the result the code became more robust with fewer
open-coded bits tricks.

v1:
  - added and fixed comments, by Shakeel
  - added some VM_BUG_ON() checks
  - fixed the debug output format of page->memcg_data


Roman Gushchin (4):
  mm: memcontrol: use helpers to access page's memcg data
  mm: memcontrol/slab: use helpers to access slab page's memcg_data
  mm: introduce page memcg flags
  mm: convert page kmemcg type to a page memcg flag

 fs/buffer.c                      |   2 +-
 fs/iomap/buffered-io.c           |   2 +-
 include/linux/memcontrol.h       | 244 +++++++++++++++++++++++++++++--
 include/linux/mm.h               |  22 ---
 include/linux/mm_types.h         |   5 +-
 include/linux/page-flags.h       |  11 +-
 include/trace/events/writeback.h |   2 +-
 kernel/fork.c                    |   7 +-
 mm/debug.c                       |   4 +-
 mm/huge_memory.c                 |   4 +-
 mm/memcontrol.c                  | 135 ++++++++---------
 mm/migrate.c                     |   2 +-
 mm/page_alloc.c                  |   6 +-
 mm/page_io.c                     |   4 +-
 mm/slab.h                        |  28 +---
 mm/workingset.c                  |   6 +-
 16 files changed, 318 insertions(+), 166 deletions(-)

--=20
2.26.2

