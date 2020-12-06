Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1214B2D0285
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLFKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLFKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:17:37 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF4C061A4F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 02:16:51 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2so3127876pfq.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94t92p220d3blDFDgpx+1JH+mQKvnsugZ3wYNVpL5Pc=;
        b=OwCooS6JnoVJtx0PMPgjcjea2S32p4mWIdoGUfK10OCc8UcA/uXphkjEoq3G+vtn0f
         ianhMPygjhbaQE/k3V2OaW1BPCvnRiB7c60kjzCNDiznenvRfo3NRkDbFvzppX7T45bG
         +S/GHPYj8t8D7DyK5Fnez4Lxt+PBYFWYnE5TtDmGXwXhcyG1D4aT8uet+hzDH3Gz2mL1
         M5pqeyrxjAReO81aNkaTykF1LM8ROq5hBYICb/mxcKNOxUw/yj3JRV6zPOVUsbEzFon+
         mk4KW7TwzPPkNKJJC1tN9AE4eFhUEtIOmpEjVxmXWyl4309sOwlCpJCYw4cq/unUV0Gl
         SIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94t92p220d3blDFDgpx+1JH+mQKvnsugZ3wYNVpL5Pc=;
        b=q5DbGAZFHxjgfahzDI491qYIkHfKnl9aWhdX/oEu/rjkocx28JLjnYg+4eHwufFMyK
         ImOycvcSR0ZnB7VeNS48skSVnWyIBu8c4LeniAQBYa+zY1S1myA0m/LoP/w9rg5mnqwo
         uhdJik76LXCzwRF0utKR+cciNs7yaSysK+qlhvEBxzjTqwfVk2fkQ+stCULbJpxQMYJE
         e0+Oe2Y2cs3l35m8fUUvG8SNkmVJJeGuhtpKt9abRDGGNNfgjiKUg6XDeI1iYAdphc1R
         sl/tsr2JXul2iVmXRPJw2Nbpqkry7oX4C4r8EbXIvdTkQsPXJg3SaXlzurFRDak65Zjc
         2A1Q==
X-Gm-Message-State: AOAM530ikbmrcJuKroRH9Po0w7OFTHKaexj++O+0uU2UWd44bOdSijZb
        TPF2PSDdAoP4mshFCURjZ51Wnw==
X-Google-Smtp-Source: ABdhPJygi0JR4oQvLA7NT1ZSMHqOoMM6z5pDKFhQ8bzTpyhVcLfaZ3u1c4zB04B4MWkNDwT3gXvHwQ==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr14380078pgm.169.1607249811143;
        Sun, 06 Dec 2020 02:16:51 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.16.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:16:50 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RESEND PATCH v2 00/12] Convert all vmstat counters to pages or bytes
Date:   Sun,  6 Dec 2020 18:14:39 +0800
Message-Id: <20201206101451.14706-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is aimed to convert all THP vmstat counters to pages
and some KiB vmstat counters to bytes.

The unit of some vmstat counters are pages, some are bytes, some are
HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
counters to the userspace, we have to know the unit of the vmstat counters
is which one. It makes the code complex. Because there are too many choices,
the probability of making a mistake will be greater.

For example, the below is some bug fix:
  - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
  - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")

This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
And make the unit of the vmstat counters are either pages or bytes. Fewer choices
means lower probability of making mistakes :).

This was inspired by Johannes and Roman. Thanks to them.

Changes in v1 -> v2:
  - Change the series subject from "Convert all THP vmstat counters to pages"
    to "Convert all vmstat counters to pages or bytes".
  - Convert NR_KERNEL_SCS_KB account to bytes.
  - Convert vmstat slab counters to bytes.
  - Remove {global_}node_page_state_pages.

Muchun Song (12):
  mm: memcontrol: fix NR_ANON_THPS account
  mm: memcontrol: convert NR_ANON_THPS account to pages
  mm: memcontrol: convert NR_FILE_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
  mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
  mm: memcontrol: convert kernel stack account to bytes
  mm: memcontrol: convert NR_KERNEL_SCS_KB account to bytes
  mm: memcontrol: convert vmstat slab counters to bytes
  mm: memcontrol: scale stat_threshold for byted-sized vmstat
  mm: memcontrol: make the slab calculation consistent
  mm: memcontrol: remove {global_}node_page_state_pages

 drivers/base/node.c     |  25 ++++-----
 fs/proc/meminfo.c       |  22 ++++----
 include/linux/mmzone.h  |  21 +++-----
 include/linux/vmstat.h  |  21 ++------
 kernel/fork.c           |   8 +--
 kernel/power/snapshot.c |   2 +-
 kernel/scs.c            |   4 +-
 mm/filemap.c            |   4 +-
 mm/huge_memory.c        |   9 ++--
 mm/khugepaged.c         |   4 +-
 mm/memcontrol.c         | 131 ++++++++++++++++++++++++------------------------
 mm/oom_kill.c           |   2 +-
 mm/page_alloc.c         |  17 +++----
 mm/rmap.c               |  19 ++++---
 mm/shmem.c              |   3 +-
 mm/vmscan.c             |   2 +-
 mm/vmstat.c             |  54 ++++++++------------
 17 files changed, 161 insertions(+), 187 deletions(-)

-- 
2.11.0

