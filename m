Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A179299ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440791AbgJ0ARb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:17:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7138 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439249AbgJ0ARR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:17:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09R0CrgJ002883
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:17:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=41NXwfOK69YLdJBmqXAfvRcowfw7CrS/L8kIz565Jvg=;
 b=hfO9HlAsFioDdoA2P1f8QfIHhJJlVlAhYPIvjhmVw0qZusMykNZsgXM/cc7Tij5Gwi5h
 kQCslzPEF2KshEqYxKpLzNESdiNrzmA9KZixMq2dh3JTAO2uqtCWTlCHX1EHkjnRJ1TA
 wjREkZIby3p/Cve5JSSlOvYKZms9tA8FL3E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34cfxn3tkw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:17:16 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 17:17:14 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 710721C56453; Mon, 26 Oct 2020 17:17:04 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 0/4] mm: allow mapping accounted kernel pages to userspace
Date:   Mon, 26 Oct 2020 17:16:53 -0700
Message-ID: <20201027001657.3398190-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_17:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=742
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270000
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
formalizes accesses to the page->mem_cgroup and page->obj_cgroups
using new helpers, adds several checks and removes a couple of obsolete
functions. As the result the code became more robust with fewer
open-coded bit tricks.

v6:
  - removed a bogus change in the last commit
  - rebased to the current head with a minor fix

v5:
  - added ~MEMCG_DATA_FLAGS_MASK to page_memcg_rcu(), by Michal
  - more cosmetic changes, by Johannes

v4:
  - more cosmetic changes, by Johannes

v3:
  - READ_ONCE() in page_memcg_rcu() and page_objcgs*(), by Johannes
  - many cosmetic changes and renamings, by Johannes

v2:
  - fixed a bug in page_obj_cgroups_check()
  - moved some definitions between patches, by Shakeel
  - dropped the memcg flags mutual exclusion requirement, by Shakeel

v1:
  - added and fixed comments, by Shakeel
  - added some VM_BUG_ON() checks
  - fixed the debug output format of page->memcg_data


Roman Gushchin (4):
  mm: memcontrol: use helpers to read page's memcg data
  mm: memcontrol/slab: use helpers to access slab page's memcg_data
  mm: introduce page memcg flags
  mm: convert page kmemcg type to a page memcg flag

 fs/buffer.c                      |   2 +-
 fs/iomap/buffered-io.c           |   2 +-
 include/linux/memcontrol.h       | 215 +++++++++++++++++++++++++++++--
 include/linux/mm.h               |  22 ----
 include/linux/mm_types.h         |   5 +-
 include/linux/page-flags.h       |  11 +-
 include/trace/events/writeback.h |   2 +-
 kernel/fork.c                    |   7 +-
 mm/debug.c                       |   4 +-
 mm/huge_memory.c                 |   4 +-
 mm/memcontrol.c                  | 139 +++++++++-----------
 mm/page_alloc.c                  |   8 +-
 mm/page_io.c                     |   6 +-
 mm/slab.h                        |  38 ++----
 mm/workingset.c                  |   2 +-
 15 files changed, 300 insertions(+), 167 deletions(-)

--=20
2.26.2

