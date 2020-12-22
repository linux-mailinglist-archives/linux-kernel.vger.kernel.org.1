Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202872E0710
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgLVIKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLVIKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:10:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14797C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 00:09:28 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 15so7894178pgx.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 00:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=vZw5nI+kCEEx1ompDMl4HBZSoNTPvUzGrnmedcFZpg8=;
        b=vLBLjFXhc52zVGGaPxpIaxjR0vZSpL4RJWvs/u4ZFgQIPhGnSO8vUxUyOcQJDcwroz
         C+CTv3VfTYEwuZT78zrciQhiqjjm9XFc64y7aLEnzHkfKaU6BF6++zXrtUq+Z46GXtOB
         83tycbWqXdmhMnIMeVoOtsIEzFSxkjVYZx5+qQyKUWt2KfgiAQ5bcxBoqDXLrfG4/5qR
         yDH+Z6StmiHIPJOs9WVqVp6OjWoM0TD8ZuWL6g8zF2FM8B2otSpqjFND+l1OZECDxkc/
         p4UBrcQV0WZZuJuQJ/ENRZJpMKr2E2AH94CsEQKR0vjN4J3Oc2XTyrm7eO0i9y+gwghf
         1eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=vZw5nI+kCEEx1ompDMl4HBZSoNTPvUzGrnmedcFZpg8=;
        b=eWBWDLHJhl+B/0x5cramagBFL7rW803EKViE4+GjjfudqUDc+a1RXfyJGwub8aPouU
         LZOxW7TGhCdC63G0yv5odXHy09OP+diMwBnq+8TDXed9Y1TWD1FMtbFx2YrqnRUzbh2R
         QyFTgGAw2E0jOtuo3fRakBJka11J8urFNgKzL5XgMEsHEQq3om+fD7PJ9lUIBC+y5uar
         LWCAcdCyhIf1cefSNFB9brm8vVRwVcKjldK9VKBkk9vd/lrLM3wqWr8YAJUyzW58AXE5
         PLMV8Qy/EQazhy9oGEFKP3GnDE350TqxrZkIht2FfWR3zyS3CeHQEfkWNEdP59T0P2G3
         GxSA==
X-Gm-Message-State: AOAM530TGPXZOcgmS3nujjeATCYRBgXYHsOfVwq/Qg7c4rV22s4mjWcK
        pWeMlsYxncuDRcVEpAidxjI=
X-Google-Smtp-Source: ABdhPJyU6Wz5lVMCuCgUGh0+zuFDW8nZczDSmN1Y/AkdDSy8vvTKk3wCl/eNGH6+B3nfb09my9dzuQ==
X-Received: by 2002:a63:1e1a:: with SMTP id e26mr4591379pge.66.1608624567657;
        Tue, 22 Dec 2020 00:09:27 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id r14sm13345752pgi.27.2020.12.22.00.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 00:09:27 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 22 Dec 2020 03:09:24 -0500
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
Subject: [RFC PATCH 0/3 updated] add support for free hugepage reporting
Message-ID: <20201222080921.GA30259@open-light-1.localdomain>
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

A typical usage of hugetlbfs it's to reserve amount of memory during 
kernel booting, and the reserved pages are unlikely to return to the
buddy system. When application need hugepages, kernel will allocate 
them from the reserved pool. when application terminates, huge pages
will return to the reserved pool and are kept in the free list for
hugetlb, these free pages will not return to buddy freelist unless
the size fo reserved pool is changed. 
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
the duplicated code. Since this is an RFC, I didn't do that.

For the virtio_balloon driver, changes for the virtio spec are needed.
Before that, I need the feedback of the comunity about this new feature.

This RFC is baed on my previous series:
  '[RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO' 

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

