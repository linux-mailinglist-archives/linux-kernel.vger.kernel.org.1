Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8ED28D6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgJMXLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:11:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgJMXLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:11:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DNAnXd123793;
        Tue, 13 Oct 2020 23:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ocyR4HOoQb93ftTFzkO/TrEL+TOkJdPALBqHk8lypSA=;
 b=RKqzoRIWLDkKvU1mxwKxaBBRRZOduCTKNzpTNqdBTuqn1FEDbvcO+PiS6H2rAX4p2ytn
 xV7lVnrphIHwKvO3gMFJ0nK0cfSiz1zJZ1NI7QHm+YiMlwQivYwojRlm+i9t/uPHcGwT
 Yfb115/p1J44podgcaIXnveWpiUNIhDJ5w+6234V8oRrnUOIdSKbvD89ilorQwzFyNb6
 ks6x9HLOvHTmmuNmOWzNiAig0YACvu5KtfxldKdbI+5N6ZUqqXdvcD0FwGhjROWyOqQG
 ybq7che782AqPXrcJFkU+Pr5iUaS/NjLubNfCnZiJFygXVUxox/3CQfoxb+HxZ0elUm5 Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 343vaeb4sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 23:11:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DN5F3Q023581;
        Tue, 13 Oct 2020 23:11:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 343puykkq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 23:11:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09DNB5fp028202;
        Tue, 13 Oct 2020 23:11:05 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 16:11:05 -0700
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
Subject: [RFC PATCH 0/3] hugetlbfs: introduce hinode_rwsem for pmd sharing synchronization
Date:   Tue, 13 Oct 2020 16:10:57 -0700
Message-Id: <20201013231100.71013-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130161
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

[1] https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2010071833100.2214@eggly.anvils/

Mike Kravetz (3):
  hugetlbfs: revert use of i_mmap_rwsem for pmd sharing and more sync
  hugetlbfs: introduce hinode_rwsem for pmd sharing synchronization
  huegtlbfs: handle page fault/truncate races

 fs/hugetlbfs/inode.c    |  72 ++++++------
 include/linux/fs.h      |  15 ---
 include/linux/hugetlb.h |  72 ++++++++++--
 mm/hugetlb.c            | 243 +++++++++++++++-------------------------
 mm/memory-failure.c     |  34 ++----
 mm/migrate.c            |  34 +++---
 mm/rmap.c               |  17 +--
 mm/userfaultfd.c        |  14 +--
 8 files changed, 220 insertions(+), 281 deletions(-)

-- 
2.25.4

