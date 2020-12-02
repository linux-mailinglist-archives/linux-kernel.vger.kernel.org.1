Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873052CB47C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgLBFYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgLBFYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:24:15 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B968EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:23:34 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n4so209194iow.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1qM8sn/PNUsKgov3fcts2bNWeaJFWZuYxDyQQdoPaU=;
        b=E+JmodwvLXtS3HzMx5uUUdr9evCBFddX1/mT4cTGtkBDMN4txdrJxo49+sPXZ76eQI
         AMqybXNpmJlYOqeQutvS7qSMwtVmxkcs5Hd2Qt28zG2uQBy5LP6nFPXa6N2fBiOs9KRQ
         U5JZdqFbw3UCCboY2vxXkKkB2ZRyp7yHd5s0HwRXX3EF9N6G+jD5+1GkSD8nR1gUgthV
         9FDEFN5bcOaOZluCZqnFerEQd65Yo9p0L0S1nrXtPL6Ew7uGtFvuvnLwFpQ5hdj/8FuP
         quzeLw+sIdw5N3Whz+7z4LG1RTnW9S+ZNVSv0loBzQBfdE9BSyyeM1ScdJLUXgxlq/+X
         8zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1qM8sn/PNUsKgov3fcts2bNWeaJFWZuYxDyQQdoPaU=;
        b=k9dHc84DoL9GcNfBtjWyaBvf4RX+jYJ/3KKOTCyT5Bg4eMgQxxWLKPO1if6tZeWJJl
         By6TJ1yr+lpDI9++Eakw3iH00hSLKNpq1Z02Pdw7xRJQf/80FLHCE1N+sAX2JAHgz6QT
         +gv6ADQmVxq+QfR506MV+o14va+EdN+jBX/TMZq4p7iTxOZbhh+ubAOJtQmpN0EZReFZ
         BNCKNN1WDNZzGG5JzSGg5E7GAyLofFgx1f3TtOl35MHtca7E26SEa/Kb0nbR4/wSILdV
         4Nvao4iytfbX7aind5VWu5/9LXaxcu9/WjL/7fDZR1fDPpDc1A0zb39RDRVnwhp9tei3
         4Mbw==
X-Gm-Message-State: AOAM530Hs/HrO7QursCNxlCQdxbHvE+IP9p7g4SXj/Xn+6XaLMD2ZYFY
        ePmSnL3F596XqudhGPf9iRJ4jA==
X-Google-Smtp-Source: ABdhPJyTeCJGMPTSatfRIvKFhVE4cfcNJgoEt1DAlqwMczmrxgfiYWBN4c0lqMTlAikPG9fS+lfeVA==
X-Received: by 2002:a02:c7c1:: with SMTP id s1mr715694jao.94.1606886614168;
        Tue, 01 Dec 2020 21:23:34 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m19sm295938ila.81.2020.12.01.21.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:23:33 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
Date:   Wed,  2 Dec 2020 00:23:24 -0500
Message-Id: <20201202052330.474592-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page is pinned it cannot be moved and its physical address stays
the same until pages is unpinned.

This is useful functionality to allows userland to implementation DMA
access. For example, it is used by vfio in vfio_pin_pages().

However, this functionality breaks memory hotplug/hotremove assumptions
that pages in ZONE_MOVABLE can always be migrated.

This patch series fixes this issue by forcing new allocations during
page pinning to omit ZONE_MOVABLE, and also to migrate any existing
pages from ZONE_MOVABLE during pinning.

It uses the same scheme logic that is currently used by CMA, and extends
the functionality for all allocations.

For more information read the discussion [1] about this problem.

[1] https://lore.kernel.org/lkml/CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com/

Pavel Tatashin (6):
  mm/gup: perform check_dax_vmas only when FS_DAX is enabled
  mm/gup: don't pin migrated cma pages in movable zone
  mm/gup: make __gup_longterm_locked common
  mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_NOMOVABLE
  mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
  mm/gup: migrate pinned pages out of movable zone

 include/linux/migrate.h        |  1 +
 include/linux/sched.h          |  2 +-
 include/linux/sched/mm.h       | 21 +++------
 include/trace/events/migrate.h |  3 +-
 mm/gup.c                       | 82 +++++++++++++---------------------
 mm/hugetlb.c                   |  4 +-
 mm/page_alloc.c                | 26 ++++++-----
 7 files changed, 58 insertions(+), 81 deletions(-)

-- 
2.25.1

