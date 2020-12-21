Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589122DFFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLUS00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:26:25 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C12C061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:25:45 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id u12so9749391ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=RreyNqsnjscC5R/r4F9+ZP7PLXJJgWh0SrYbZXMQ7Ck=;
        b=UME8HYaKBAOkfsOcODuWSX+ujRpuMpzE9XWcMw58aNCebW/yY3m8eljUcU9oEE31Zx
         0WoWO/H+2/ZvJ1o7LjbmbZFjkE8IjEiYDpEBytn0fvWHn/0zW8kF2iYFGGZnRctUmQGR
         t2TFjj+mdfUKuBhmvmzx670lS5HGr+PwV9B9xx1TMQbTIJBA9asZTpf0ejMa/8YqciZd
         9EhgtrQl5UhChFFSP0EuVG1Itq1luxOtORAZLFAv1xb2L1TZvdNiGD2BxUSCnRNWOVkm
         J2M41dAzLIqUenT/1wT9/bTtLAkjXlKSImMC10uBSLLqA5qQiAstaB99NtMXVV7BafNX
         JXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=RreyNqsnjscC5R/r4F9+ZP7PLXJJgWh0SrYbZXMQ7Ck=;
        b=Wh76DPSUstFZ1z3vopeyPm7Z+ASR473Gk81U5eKXPIYgP3Cgx9cc9QrVu6csjt8iGW
         AqwzsA83ApagzemeKOllpe4LehpfqkEQ4Bo7nopVhZvpS01sxGfM8WnYFqmYH7Ez0bCQ
         Aii2aynv2loY+xZMC0HlhesqFifKh6u6OhhnrgYa6Mq4z0ujRn+yobkSCET+71kQagQz
         xWA1SBdfwXfQns3wX/cNcjiDe0KQusTSjJyPc6pD877265glOYcBNlIGVKKP5AcSOttW
         BhgV0mqjj0yb79raayvak7VQxYC5haW6QEStAngXVuJfMwGSpKHBO+fP+GQW/EqInCnc
         MpIA==
X-Gm-Message-State: AOAM533eVopJpCITrI5P/lmDtYYbMo8SL8xc9aiCmJWkPZrI4bbHC0rk
        OdQaSBe0SoXQXz6V/VvGF0c81c3B6a4=
X-Google-Smtp-Source: ABdhPJxN9YG/duwDt2XXOC+T6qR53zkVFRq6L+FhhHUQwY1KeuaZzuR/KoC2zECjmq5gCfJjwRSucw==
X-Received: by 2002:a63:5014:: with SMTP id e20mr15805755pgb.152.1608567924960;
        Mon, 21 Dec 2020 08:25:24 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id b72sm16608601pfb.129.2020.12.21.08.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:25:24 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliang324@gmail.com>
Date:   Mon, 21 Dec 2020 11:25:22 -0500
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
        Liang Li <liliangleo@didiglobal.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
Message-ID: <20201221162519.GA22504@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first version can be found at: https://lkml.org/lkml/2020/4/12/42

Zero out the page content usually happens when allocating pages with
the flag of __GFP_ZERO, this is a time consuming operation, it makes
the population of a large vma area very slowly. This patch introduce
a new feature for zero out pages before page allocation, it can help
to speed up page allocation with __GFP_ZERO.

My original intention for adding this feature is to shorten VM
creation time when SR-IOV devicde is attached, it works good and the
VM creation time is reduced by about 90%.

Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
=====================================================
QEMU use 4K pages, THP is off
                  round1      round2      round3
w/o this patch:    23.5s       24.7s       24.6s
w/ this patch:     10.2s       10.3s       11.2s

QEMU use 4K pages, THP is on
                  round1      round2      round3
w/o this patch:    17.9s       14.8s       14.9s
w/ this patch:     1.9s        1.8s        1.9s
=====================================================

Obviously, it can do more than this. We can benefit from this feature
in the flowing case:

Interactive sence
=================
Shorten application lunch time on desktop or mobile phone, it can help
to improve the user experience. Test shows on a
server [Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz], zero out 1GB RAM by
the kernel will take about 200ms, while some mainly used application
like Firefox browser, Office will consume 100 ~ 300 MB RAM just after
launch, by pre zero out free pages, it means the application launch
time will be reduced about 20~60ms (can be visual sensed?). May be
we can make use of this feature to speed up the launch of Andorid APP
(I didn't do any test for Android).

Virtulization
=============
Speed up VM creation and shorten guest boot time, especially for PCI
SR-IOV device passthrough scenario. Compared with some of the para
vitalization solutions, it is easy to deploy because it’s transparent
to guest and can handle DMA properly in BIOS stage, while the para
virtualization solution can’t handle it well.

Improve guest performance when use VIRTIO_BALLOON_F_REPORTING for memory
overcommit. The VIRTIO_BALLOON_F_REPORTING feature will report guest page
to the VMM, VMM will unmap the corresponding host page for reclaim,
when guest allocate a page just reclaimed, host will allocate a new page
and zero it out for guest, in this case pre zero out free page will help
to speed up the proccess of fault in and reduce the performance impaction.

Speed up kernel routine
=======================
This can’t be guaranteed because we don’t pre zero out all the free pages,
but is true for most case. It can help to speed up some important system
call just like fork, which will allocate zero pages for building page
table. And speed up the process of page fault, especially for huge page
fault. The POC of Hugetlb free page pre zero out has been done.

Security
========
This is a weak version of "introduce init_on_alloc=1 and init_on_free=1
boot options", which zero out page in a asynchronous way. For users can't
tolerate the impaction of 'init_on_alloc=1' or 'init_on_free=1' brings,
this feauture provide another choice.

For the feedback of the first version, cache pollution is the main concern
of the mm guys, On the other hand, this feature is really helpful for
some use case. May be we should let the user decide wether to use it.
So a switch is added in the /sys files, users who don’t like it can turn
off the switch, or by configuring a large batch size to reduce cache
pollution.

To make the whole function works, support of pre zero out free huge pages
should be added for hugetlbfs, I will send another patch for it.

Liang Li (4):
  mm: let user decide page reporting option
  mm: pre zero out free pages to speed up page allocation for __GFP_ZERO
  mm: make page reporing worker works better for low order page
  mm: Add batch size for free page reporting

 drivers/virtio/virtio_balloon.c |   3 +
 include/linux/highmem.h         |  31 +++-
 include/linux/page-flags.h      |  16 +-
 include/linux/page_reporting.h  |   3 +
 include/trace/events/mmflags.h  |   7 +
 mm/Kconfig                      |  10 ++
 mm/Makefile                     |   1 +
 mm/huge_memory.c                |   3 +-
 mm/page_alloc.c                 |   4 +
 mm/page_prezero.c               | 266 ++++++++++++++++++++++++++++++++
 mm/page_prezero.h               |  13 ++
 mm/page_reporting.c             |  49 +++++-
 mm/page_reporting.h             |  16 +-
 13 files changed, 405 insertions(+), 17 deletions(-)
 create mode 100644 mm/page_prezero.c
 create mode 100644 mm/page_prezero.h

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
Signed-off-by: Liang Li <liliang324@gmail.com>
-- 
2.18.2

