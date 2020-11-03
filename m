Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F177E2A37B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKCA3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:29:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46398 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKCA3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:29:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A30SuRv088116;
        Tue, 3 Nov 2020 00:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=JHofU+j7Q/FCLvUv+Zct486JBQ+tNstG+85LG+dMAt4=;
 b=hpiRpUCGsszL6112m2dsO/9V7EZ0layEQGUQ8ehCg3xLXJ7MIaG7tbDNovh8UUHwtXGa
 CsSlLYVIUoocW7S+E/Lr7FbU/qn4EsLCjoBmKyeOdVE4DXcVWqT2pIYJQFZoLVwGyg7T
 4kfiiKcDrSpJUC4omq/EB7zLH4vfRyIAjkDGrGfv3OIRKx6lb+J7JJ8YbXwzKhgl+4UC
 hLUUkD2qQnT8flwOQB3YBWWoQzi/Cuwitzb5yoMllHZZpFVvxGNATCV7Nmm23+dD47Md
 TY1Jlhqvbh70j49bJgqUFNePt2UPxxfJoutPbRvMdqnDU73/XKCexbXuOi0cgL0xJb+Z mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34hhb1xt6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 00:28:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A30AkEd045791;
        Tue, 3 Nov 2020 00:28:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34jf47f62b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 00:28:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A30SjcJ028850;
        Tue, 3 Nov 2020 00:28:45 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 16:28:45 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/4] hugetlbfs: use hinode_rwsem for pmd sharing synchronization
Date:   Mon,  2 Nov 2020 16:28:37 -0800
Message-Id: <20201103002841.273161-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026233150.371577-1-mike.kravetz@oracle.com>
References: <20201026233150.371577-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=875 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=902 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RFC series reverted all patches where i_mmap_rwsem was used for
pmd sharing synchronization, and then added code to use hinode_rwsem.
This series ends up with the same code in the end, but is structured
as follows:

- Revert the page fault/truncation race patch which depends on i_mmap_rwsem
  always being taken in page fault path.
- Add hinode_rwsem to hugetlbfs specific inode and supporting routines.
- Convert code from using i_mmap_rwsem for pmd sharing synchronization
  to using hinode_rwsem.
- Add code to more robustly deal with page fault/truncation races.

My hope is that this will be easier to review.

Mike Kravetz (4):
  Revert hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race
  hugetlbfs: add hinode_rwsem to hugetlb specific inode
  hugetlbfs: use hinode_rwsem for pmd sharing synchronization
  huegtlbfs: handle page fault/truncate races

 fs/hugetlbfs/inode.c    | 105 +++++++++-------
 include/linux/fs.h      |  15 ---
 include/linux/hugetlb.h | 129 ++++++++++++++++++--
 mm/hugetlb.c            | 262 ++++++++++++++++------------------------
 mm/memory-failure.c     |  34 ++----
 mm/memory.c             |   5 +
 mm/migrate.c            |  34 +++---
 mm/rmap.c               |  21 ++--
 mm/userfaultfd.c        |  17 ++-
 9 files changed, 334 insertions(+), 288 deletions(-)

-- 
2.28.0

