Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE092E06E3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgLVHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:46:25 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:45:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so7974292pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=VRDkYo9thmerq4KdUChRDJwyIpvZR7iVG1d7W9YK664=;
        b=kSA3yBOVbsQCzaPAuQH6tStOIQ/E8baYqDX1AfdkZa5M1+5DBspeYmZULpbRqxXD+U
         fQaVv9kv+Mtf/igPfGPa7XawbyxVGxVKz//jFSXO9yeb8NJT8f8hmL7701bLv8J3eIxq
         7nV38OJW1hpytEGlibXvXB5dUA8m0RLzNnynboN8stOQYjTUBCqNr6BtyeMCWd192ljP
         rYcz2rqJlq8mB4D8jvuIInvBY8QVwyqd3o8dxktbz+SRltqqKld/55PyUgV0A9CHAfGH
         TscoLv12DE8n1IVSDpXqUWoVvTqCapkRn50yVPRV2wCy5FfilnYL3JK2a2Iy21dCVGE6
         +glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=VRDkYo9thmerq4KdUChRDJwyIpvZR7iVG1d7W9YK664=;
        b=QBjQVL0Geyw0qbUT4aC/DQDizbLPIXI0OpeWn9+7yYeIk+ERdowddhMLyS9LfD9tbO
         ZFYDB9uLB1D/LFKnwpRiRbSb3fySNrh9VoP3TNKXjrRS46bQF5xYGdaxC9aYG5jPDxZ7
         xkvVjJz9JnBGLe+OmT1kowh56VUTzpo7zBATzsalVKX1Oy2PbYoZHbvjOaoQ2HYzMD0m
         nQVqbrWwVd1PvRxindglXOCWpCNAPfyH8ZRFRVJEQRhUxzhlQROb/fJI5hUDrvM0xvkw
         fTB7ZDWXS8MXn6Bipf9PQYR0G2OZWzzGsO+IGal/q05E/DeySg2zvPWfmKCWax9QZNMq
         2zIA==
X-Gm-Message-State: AOAM530x85Mkr8pP1SuIQQLZ6gliJV9Ab2FP7/99pU8NsOqaAEbILfbz
        l2GKxydKZYB9tATvEIKr0QI=
X-Google-Smtp-Source: ABdhPJwnYhUGB++74vbn5Y7LHAg9vDYkiZvJGTA7VuCwD2GqRVWfe30wNWf3GCWk4V3zvNw0Ev2joA==
X-Received: by 2002:a63:f745:: with SMTP id f5mr18596744pgk.119.1608623144989;
        Mon, 21 Dec 2020 23:45:44 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id mj5sm18247451pjb.20.2020.12.21.23.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 23:45:44 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 22 Dec 2020 02:45:41 -0500
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] add support for free hugepage reporting
Message-ID: <20201222074538.GA30029@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A typical usage of hugetlbfs it's to reserve amount of memory when
the during kernel booting stage, and the reserved pages are unlikely
to return to the buddy system. When application need hugepages, kernel
will allocate them from the reserved pool. when application terminates,
huge pages will return to the reserved pool and are kept in the free
list for hugetlb, these free pages will not return to buddy freelist
unless the size fo reserved pool is changed. 
Free page reporting only supports buddy pages, it can't report the
free pages reserved for hugetlbfs. On the other hand, hugetlbfs
is a good choice for system with a huge amount of RAM, because it
can help to reduce the memory management overhead and improve system
performance.
This patch add the support for reporting hugepages in the free list
of hugetlb, it can be used by virtio_balloon driver for memory
overcommit and pre zero out free pages for speeding up memory
population and page fault handling.

Most of the code are 'copied' from free page reporting because they
are working in the same way. So the code can be refined to remove
the duplication code. Since this is an RFC, I didn't do that.

For the virtio_balloon driver, changes for the virtio spec are needed.
Before that, I need the feedback of the comunity about this new feature.

Liang Li (3):
  mm: support hugetlb free page reporting
  virtio-balloon: add support for providing free huge page reports to
    host
  mm: support free hugepage pre zero out

 drivers/virtio/virtio_balloon.c     |  61 ++++++
 include/linux/hugetlb.h             |   3 +
 include/linux/page_reporting.h      |   5 +
 include/uapi/linux/virtio_balloon.h |   1 +
 mm/hugetlb.c                        |  29 +++
 mm/page_prezero.c                   |  17 ++
 mm/page_reporting.c                 | 287 ++++++++++++++++++++++++++++
 mm/page_reporting.h                 |  34 ++++
 8 files changed, 437 insertions(+)

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>  
Cc: Michal Hocko <mhocko@suse.com> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Liang Li <liliang324@gmail.com>
-- 
2.18.2

