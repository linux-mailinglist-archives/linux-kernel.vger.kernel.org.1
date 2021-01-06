Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE62EB8A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbhAFDrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAFDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:47:10 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13A0C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:46:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id s21so929739pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=ia3T9lH51tu7y+R0EYaTdraFolxNyFOaXfE+wHbQ90s=;
        b=gQmFYIszyna+5NCm4w9LI2ODYXjcW82FwgKp6ng8xujM/+XLy2i3dS2SACI81X3n5B
         eVfRL4iR9vNEH0QZFEv4DVobtoNc9KIRgir0o1crKn9kakcHL9tsBQf4zihh8Cz23Eg/
         qniEfqf+PbYvQxOUsMw9Gmcd0HSkm74cMSDYpgX7KOypT8VlJ11ch2jW8FzSsw3k5WZB
         2JIWm2+d99nWVBtt4OiAlhu6dxlVY861kKdj5jmH8XbXc+pqf7dl8rYEKDogWYuQ0PC5
         xy7YKaRtfhtNkURBncmAEcQIkTznj/kt91wrG7vBj0ZzT2gxeNJlHCwfODq2KZAt0JJB
         FIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=ia3T9lH51tu7y+R0EYaTdraFolxNyFOaXfE+wHbQ90s=;
        b=W2wayCR3oTIKSY8rCPcE7W1LpT2i/hqSleD+JffUsslzcFbgeuhuiiwFKtBSVYZBvw
         FUdP2Pwh+6qlnxufGg3RaG74jpdY0J4jqTkh8F25SiknGQH8U/F30hrjzwm56g8CpxRr
         tHciTlXz8Z+IQKaG2nMLmZBeSd6WYilB+tQuLJuhSBPJa4mVZUk5IcsDiCuxE02FFFrb
         gDUx5gd05We5sAqSLOAQbAKkao3zn8OgN5iMictDVodrw5ELaQJjrGj99yrP9C6wZC2E
         NB4oeqowjIwjYh540LYeLBZ41MDuN8m7hA7hoAo2dNNK3TnOuOQYQBkuqHuPat+h5zit
         QaJQ==
X-Gm-Message-State: AOAM530r+8PpRQAIYiClxNaVjRiZPrU7XjHpVVQfpc6jkred2dTE6rTj
        DA/iBuaAc+h7N0hRxyLvdcE=
X-Google-Smtp-Source: ABdhPJzCH5bHYLdF/Qz96oCkl7pVnmQk98BbAJueSL8kyPltTtjeSYox/eN6Atoa0UgQ2EfsiItJ5Q==
X-Received: by 2002:a63:f404:: with SMTP id g4mr2358027pgi.114.1609904790221;
        Tue, 05 Jan 2021 19:46:30 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id gk4sm561632pjb.57.2021.01.05.19.46.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:46:29 -0800 (PST)
From:   Liang Li <liliang324@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 5 Jan 2021 22:46:26 -0500
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
        Liang Li <liliang324@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 0/6] hugetlbfs: support free page reporting
Message-ID: <20210106034623.GA1128@open-light-1.localdomain>
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
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A typical usage of hugetlbfs it's to reserve amount of memory
during the kernel booting stage, and the reserved pages are
unlikely to return to the buddy system. When application need
hugepages, kernel will allocate them from the reserved pool.
when application terminates, huge pages will return to the
reserved pool and are kept in the free list for hugetlbfs,
these free pages will not return to buddy freelist unless the
size of reserved pool is changed. 
Free page reporting only supports buddy pages, it can't report
the free pages reserved for hugetlbfs. On the other hand,
hugetlbfs is a good choice for system with a huge amount of RAM,
because it can help to reduce the memory management overhead and
improve system performance.
This patch add the support for reporting hugepages in the free
list of hugetlbfs, it can be used by virtio_balloon driver for
memory overcommit and pre zero out free pages for speeding up
memory population and page fault handling.

Most of the code are 'copied' from free page reporting because
they are working in the same way. So the code can be refined to
remove duplication. It can be done later.

Since some guys have some concern about side effect of the 'buddy
free page pre zero out' feature brings, I remove it from this
serier.

Liang Li (6):
  mm: Add batch size for free page reporting
  mm: let user decide page reporting option
  hugetlb: add free page reporting support
  hugetlb: avoid allocation failed when page reporting is on going
  virtio-balloon: reporting hugetlb free page to host
  hugetlb: support free hugepage pre zero out

 drivers/virtio/virtio_balloon.c |  58 +++++-
 include/linux/hugetlb.h         |   5 +
 include/linux/page-flags.h      |  12 ++
 include/linux/page_reporting.h  |   7 +
 mm/Kconfig                      |  11 ++
 mm/huge_memory.c                |   3 +-
 mm/hugetlb.c                    | 271 +++++++++++++++++++++++++++
 mm/memory.c                     |   4 +
 mm/page_reporting.c             | 315 +++++++++++++++++++++++++++++++-
 mm/page_reporting.h             |  50 ++++-
 10 files changed, 725 insertions(+), 11 deletions(-)

-- 
2.18.2

