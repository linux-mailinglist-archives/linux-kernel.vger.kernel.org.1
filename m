Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAA2F43CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbhAMF0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbhAMF0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:26:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD5CC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y12so416530pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29017Imny4RA8XIngcwyWbDxuQg3R7iFq2JrClv6FPA=;
        b=yX8sYo9koIVE87mJ3FG0kE3DJ5zS6yvPRy/U8SvXbVFMnmZxagOx5v5sSXwpIapsV+
         6zx9C5A/ZKFkJxuMn6aSw5VOUITqR3DCpmqll5TfsxcuHOiV7Kar292ldyukcagoS5o+
         AdGQE5u5JklYexs5UeSjPu9XwAxnDWanKk69PTudk1WMvTgFEToZXWbdUNNsEZ8pQFug
         2Can8kKF1meFVkCoFuHMWeXZy9DLfEOpHiukDHGZa9gqBdDxKInBGIphzxjilIJiPIes
         zTuFpOkwkR8f51LJbodlD3LkHzmLYOXzTXEcQa4k98RzEGuRe4JKMfNWL93EkmAumszr
         roJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29017Imny4RA8XIngcwyWbDxuQg3R7iFq2JrClv6FPA=;
        b=ndupr8gUVNryll9aicc/iVu8BWf1jw8HFgtu2LVhgSJqh8Gp32xKSGnmtsKJ/09pC4
         qJaNQfTO240rsT74De5roXoTfURQp5zBwc2hlpxt3KVCr+ID5tbgWBCRJdkLG2vHgz34
         toUurODggsG41q9UAX/s1PSkOqSq2yCFNYCQa7eo+/bIwgTgtBJotf9wZNIj7qIPBTn7
         Y8X7EGS9kLTsPwiuYcjQZify0Qy33zwYZ7j/lQLcxToGF51P3n0jsAgYaPq/XFnRAFN8
         OPv9+DhPQpYYUu6ocJiPhZiMKrTJTnL7rElzMBgjjOcADIAGTsKHYKSTFGEN+bxD8/IS
         H+UQ==
X-Gm-Message-State: AOAM533LlNOavbXjAuu036SrjuqKJd4xqHzXfLekN0PUdOan3vMG3yEQ
        hWVKCFG+O/Pwf6Fx+Fqo5X9D4K5DHGv3R8MWvXA=
X-Google-Smtp-Source: ABdhPJwJaESneQy7ApflfsmLCgfFSITQRI5+f/UZqAUKxWrcmkwEqYzTxt6uigIszmNJdfa8B+WWeA==
X-Received: by 2002:a17:902:7592:b029:dc:3c87:1c63 with SMTP id j18-20020a1709027592b02900dc3c871c63mr389854pll.47.1610515531113;
        Tue, 12 Jan 2021 21:25:31 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id x15sm893081pfa.80.2021.01.12.21.25.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 21:25:30 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 0/6] Fix some bugs about HugeTLB code
Date:   Wed, 13 Jan 2021 13:22:03 +0800
Message-Id: <20210113052209.75531-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to fix some bugs and add some improvements.

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

Muchun Song (6):
  mm: migrate: do not migrate HugeTLB page whose refcount is one
  mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
  mm: hugetlb: fix a race between freeing and dissolving the page
  mm: hugetlb: retry dissolve page when hitting race
  mm: hugetlb: fix a race between isolating and freeing page
  mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active

 fs/hugetlbfs/inode.c    |  3 ++-
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 51 ++++++++++++++++++++++++++++++++++++++++++++-----
 mm/migrate.c            |  6 ++++++
 4 files changed, 56 insertions(+), 6 deletions(-)

-- 
2.11.0

