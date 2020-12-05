Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585702CFC3D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 18:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgLEREt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 12:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLEQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:44:50 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0584C061A53
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 05:02:43 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 4so4658521plk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 05:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rn/xJo/gyofLtl+hMU5/+p5RPWpj2PYm655A9wivV4I=;
        b=uba4FH2KhW8Vj9ZYwLUzGFQb0rHgkyFMDpdk3RQHbve17Sp28OLnmrjvqmSb7sYkVZ
         GM2sEhv8//q4hMDDw9bSK+KF1xViMm8tK+G62u/ihXhQtDR6S3MrhvCimce8xo/v1yJc
         bg3/PyxdoGBF2fi20Nbuv+ATPqryNxDZ9soMAkuMxesk34ZbmkQaPxkCzT1BRg3imlEF
         kHEnEc6Y3U3Yo7Oz6xkqjTlFZivTKMRGE7SfVIN3QNGkJTujq9fRG70Z4Kun2RCad9XO
         X4JErJiw7JPjNFWAM6zaHsdGTbDzc6tcn0DKBJmA+DptSICQMiH/IjugkoJWDToHLNgH
         pnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rn/xJo/gyofLtl+hMU5/+p5RPWpj2PYm655A9wivV4I=;
        b=XpulQGdJSTI3t+nt7Q8C/tnViJGrIw5RJkEA7taFDLp/Qp58PbjdXZDZd2/l82iCbD
         rW8OJeRhR/uP4F262BJJ7xMFJhwtOh8YyskoagEmaQxO2w346SdAx6F7IFbr7EvIxglT
         tCW7TOVGAdCJ1C4CM5OdTrFMPKpmNIQeWCK2SwrDQ4TKSK6c/uWh9NbUzPwKDz/MXVJu
         gOnvUNIuoDWE9ODahlGW9wQ9t8Nqefi1bgb1c/4fzHVj7LsHfWfw5dTTXs79pLtq2KIr
         HzinQ63lLzh6iZDkiyrRh6cHNMC+JcEIyqyVD62uXLBHA82toGcleGGDBeTirDCbiOX/
         wOhA==
X-Gm-Message-State: AOAM533ZOrZPkbQ3758UBHFA+Kmf4b4Ous2BvDLfpIlZXO0Fk6KB3WHP
        CpVsI+H4cTtMqcjXRcbHNZhbYQ==
X-Google-Smtp-Source: ABdhPJzesxeGGDvJ6298vhkaq+apmgQA98LkQl9wETTVy6v3xPgS/qblIYX2OypmegrKOQWCvLnThg==
X-Received: by 2002:a17:902:a504:b029:d8:ebc7:a864 with SMTP id s4-20020a170902a504b02900d8ebc7a864mr8059651plq.60.1607173363065;
        Sat, 05 Dec 2020 05:02:43 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:02:42 -0800 (PST)
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
Subject: [PATCH 0/9] Convert all THP vmstat counters to pages
Date:   Sat,  5 Dec 2020 21:02:15 +0800
Message-Id: <20201205130224.81607-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is aimed to convert all THP vmstat counters to pages
and the kernel stack vmstat counter to bytes.

The unit of some vmstat counters are pages, the unit of some vmstat counters
are bytes, the unit of some vmstat counters are HPAGE_PMD_NR, and the unit
of some vmstat counters are KiB. When we want to expose these vmstat counters
to the userspace, we have to know the unit of the vmstat counters is which
one. It makes the code complex.

This patch series can make the code simple. And the unit of the vmstat
counters are either pages or bytes.

This was inspired by Johannes and Roman. Thanks to them.

Muchun Song (9):
  mm: vmstat: fix stat_threshold for NR_KERNEL_STACK_KB
  mm: memcontrol: fix NR_ANON_THPS account
  mm: memcontrol: convert kernel stack account to byte-sized
  mm: memcontrol: convert NR_ANON_THPS account to pages
  mm: memcontrol: convert NR_FILE_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
  mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
  mm: memcontrol: make the slab calculation consistent

 drivers/base/node.c    |  17 +++---
 fs/proc/meminfo.c      |  12 ++---
 include/linux/mmzone.h |   2 +-
 kernel/fork.c          |   8 +--
 mm/filemap.c           |   4 +-
 mm/huge_memory.c       |   9 ++--
 mm/khugepaged.c        |   4 +-
 mm/memcontrol.c        | 139 +++++++++++++++++++++++++------------------------
 mm/page_alloc.c        |   9 ++--
 mm/rmap.c              |  19 ++++---
 mm/shmem.c             |   3 +-
 mm/vmstat.c            |   4 ++
 12 files changed, 120 insertions(+), 110 deletions(-)

-- 
2.11.0

