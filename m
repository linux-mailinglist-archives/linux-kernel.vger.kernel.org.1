Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBD2F7AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbhAOMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388464AbhAOMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:52:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF2C0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:51:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y12so5012065pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPCzXvOwrnZkqLvyZVOoqWzerct2EqEDkQMCnuc7Cu8=;
        b=0x7cx/5dC8pxmoxDsnIUUf+gNFBkMpJdkaTqyfYvreAwfVxnXYgd9JdJzP/sHvAq1L
         rYlCgzbbOUMCfL56+z/cA8dR6hPsj9dNJW4hhQPdRZ4Uj8Mg8pFQx9K1wL4xNzcyDReD
         ziXP3lMegKhcoawHbff5j7bg/HKBeKSy85x2kDwxrZ7s7tl3Z/srzjCv207p2Q5F/+k4
         0cVoCzVXdkcJzy1BO5cSPv4NqEwrc4qUwWyOvwTQG83m1cthhwt8FfNgghSCEz38gFhp
         w+vPkJ9uD8UKuhCyLliR1FADPvZqXe+SCZ+xSW/JrL2dZcR6H0BNr8SeCk9SfN1d7YV8
         QknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPCzXvOwrnZkqLvyZVOoqWzerct2EqEDkQMCnuc7Cu8=;
        b=bEEiys2v5Wc4OBD8T1KAKlzgYUpIykEoFKEtuyHA05hPHLLwkS2DVCD+st/+b1r3NR
         kTn2Ykf7sy+4VhzZcAvGrgWpOlLhx8PszTgGiYrsN84LgQ7AeSVt4APl+zvmYUAxEZf+
         1EvEmAAV+ccSay+gvQPp6/hyFkGI67hmeMVmI4BG5C7/EPtPeK277N5PqmHWpN+c1SM4
         o9JBUBGO7jWgFRkLHNSBIqd5l8bpsLzgjU3tjFrQwdUtOv5H6JPLBwMg2aUjXhGtU/nK
         7lLn9eqjcHNPZPLvkWyJsWKART4GQE7K3KFZToOAvBHGnGCO33myeBw+zF29w8qgqFhl
         w4UQ==
X-Gm-Message-State: AOAM531LTca8kFTYIP5NfDVZrya4BnyV8MqpkY9XGbdOTxU3QKsSUq3D
        WuTXe0p7YYpVrApvkSwaBTJPzQ==
X-Google-Smtp-Source: ABdhPJy9y+rHRzFwuqeeRQZ7KcDvmHYHqAhEJk4exk+lxWw0lhRz9aav80LU7wYxEk8u9XgAVwRCCg==
X-Received: by 2002:a17:902:8c89:b029:dc:1e79:e74b with SMTP id t9-20020a1709028c89b02900dc1e79e74bmr12378937plo.58.1610715070775;
        Fri, 15 Jan 2021 04:51:10 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id c5sm8193600pjo.4.2021.01.15.04.51.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 04:51:09 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 0/5] Fix some bugs about HugeTLB code
Date:   Fri, 15 Jan 2021 20:49:37 +0800
Message-Id: <20210115124942.46403-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to fix some bugs and add some improvements.

Changelog since v5 -> v6:
 - Simplify patch #3 and update commit changelog.

Changelog since v4 -> v5:
 - Squash "mm: hugetlb: retry dissolve page when hitting race"
   to "mm: hugetlb: fix a race between freeing and dissolving the page"

Changelog since v3 -> v4:
  - Update commit log of patch #1.
  - Drop "mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page"
  - Add "mm: hugetlb: retry dissolve page when hitting race"

Changelog since v2 -> v3:
  - Update commit log.
  - Using head[3].private to indicate the page is freed in patch #3.

Changelog since v1 -> v2:
  - Export set_page_huge_active() in patch #2 to fix.
  - Using head[3].mapping to indicate the page is freed in patch #3.
  - Flush @free_hpage_work in patch #4.

Muchun Song (5):
  mm: migrate: do not migrate HugeTLB page whose refcount is one
  mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
  mm: hugetlb: fix a race between freeing and dissolving the page
  mm: hugetlb: fix a race between isolating and freeing page
  mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active

 fs/hugetlbfs/inode.c    |  3 ++-
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 mm/migrate.c            |  6 ++++++
 4 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.11.0

