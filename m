Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A23299A81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406378AbgJZXcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:32:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41364 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406297AbgJZXcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:32:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNPOPo177120;
        Mon, 26 Oct 2020 23:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=MyL1BahZYcF6/d/WNrx9XcOyzYfxWXCeMOuOydYn6ZM=;
 b=cRXQbcRsOrqeE1eucBBXMi6W9s/vW75J0Vy+gND4MNk5LUFE7gV2qZpBiIC8LXqmr/wH
 8o5j0FKq+gw2l9ELzmT1rI/Nn+uGb1mF2+AeZMb9RIpBQ0RksPBYmSmvo2EJmkQtBloQ
 XoG8nNn+8HgS9QsKFsfcvxY9366ZyxFQTvEe74xq4GVuFSOg8sDsSLMq+hPW35LSpGFT
 s/yXMUeTjxnzbSQ6R+iIR2pGbIID72s2RKJiUjYF29o6CVOHR9qvgYU+pkL5AMICKV+X
 kijZ3MKelzJXsEyKWevLFIYw01zzWky8MUfQf7fBZJrsTa9IXcC8sP7HhRyh/IHLlq8d pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9saqct9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 23:32:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNPGJO120976;
        Mon, 26 Oct 2020 23:32:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34cx6va465-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 23:32:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QNW3bN006438;
        Mon, 26 Oct 2020 23:32:03 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:31:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v2 0/4] hugetlbfs: introduce hinode_rwsem for pmd sharing synchronization
Date:   Mon, 26 Oct 2020 16:31:46 -0700
Message-Id: <20201026233150.371577-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c0d0381ade79, changes were made to use i_mmap_rwsem for pmd
sharing synchronization.  This required changes to mm locking order that
are hugetlb specific.  Specifically, i_mmap_rwsem must be taken before
the page lock.  This is not not a huge issue in hugetlb specific code,
but becomes more problematic in the areas of page migration and memory
failure where generic mm code had to deal with this change to lock
ordering.  An ugly routine 'hugetlb_page_mapping_lock_write' was added
to help with these issues.

Recently, Hugh Dickins diagnosed a migration BUG as caused by code
introduced with hugetlb i_mmap_rwsem synchronization [1].  Subsequent
discussion in that thread pointed out additional problems in the code.

Adding a rw_semaphore to the hugetlbfs inode for this type of synchronization
was mentioned.  Such an approach is actually 'cleaner' as it can be
inserted in the lock hierarchy where needed.  And, there is no issue
with other parts of the mm using this rw_semaphore.

This series adds a rw_semaphore (hinode_rwsem) to the hugetlbfs inode.

The first patch reverts all commits having to deal with the current use
of i_mmap_rwsem for pmd sharing and fault/truncate synchronization.  The
revert of 5 commits was combined into a single patch.  I am looking for
feedback on this approach.  I considered:
- 5 Patches to revert the 5 commits
- Reverting patches depending on c0d0381ade79, then having a patch to
  change from i_mmap_rwsem to hinode_rwsem.
To me, a 'clean slate' approach seemed best but I am open to whatever
would be easiest to review.

Changes in RFC v2
  - Added missing locking pointed out by Naoya Horiguchi
  - Cleaned up some comments as suggested by Naoya Horiguchi
  - Cleaned up and documented hinode_lock_read() helper and added
    hinode_lock_write() helper.
  - Split out addition of hinode_rwsem and helper routines to a separate
    patch.

[1] https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2010071833100.2214@eggly.anvils/

Mike Kravetz (4):
  hugetlbfs: revert use of i_mmap_rwsem for pmd sharing and more sync
  hugetlbfs: add hinode_rwsem to hugetlb specific inode
  hugetlbfs: use hinode_rwsem for pmd sharing synchronization
  huegtlbfs: handle page fault/truncate races

 fs/hugetlbfs/inode.c    |  87 +++++++------
 include/linux/fs.h      |  15 ---
 include/linux/hugetlb.h | 135 ++++++++++++++++++--
 mm/hugetlb.c            | 267 ++++++++++++++++------------------------
 mm/memory-failure.c     |  34 ++---
 mm/memory.c             |   5 +
 mm/migrate.c            |  34 +++--
 mm/rmap.c               |  17 +--
 mm/userfaultfd.c        |  19 +--
 9 files changed, 322 insertions(+), 291 deletions(-)

-- 
2.25.4

