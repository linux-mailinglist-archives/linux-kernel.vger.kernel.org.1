Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9681D2F5EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbhANKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbhANKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:39:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x12so2691220plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QrOmhB7i9+qkZva086G38OQVxrszXWzF+P/Di/GDiCE=;
        b=L410lzPHvZaCyW4bsco326t4nOEdvJLl5jouDYXX71Q/wyRaQ6Em0pVPCRu/d2j5x+
         vS7Kz09FAKCZZglke1R9bqbjTDDHXe5BYJus31D+5vSjKkyYVGRF4ax5eIBm0+fLYsfJ
         vo5FnjUSpzVfUZp7qCSfYGgjp8i/e+sL0JNyi3aH/JrEk8Y11oqvV3Se8ZiMO74phNa2
         HLZtwhfsgYcfYvTe3RafSLm58e9yi6Jm7HqLkDygeKozkTv23NkFVwHYmrUEDaF+oo+U
         ob2AovK3ncshwm+d0OzXsFJrxtlg2cYraSxSR3th5X04n+RfcrnoFehU/1cAgO2EqRUa
         KdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QrOmhB7i9+qkZva086G38OQVxrszXWzF+P/Di/GDiCE=;
        b=Hf6AyhqvnEo+PHNjCbNuAaOSUESePUiumOgoJeQEqht/PhK0I5NF1Jgsx8z4m7f3ZC
         Nq0etzaszqgiML5ZuEcuZymW32uMH9BcpmOOdLn8aYKDs/i6XiU8PMJpRLpG3kPfSRBw
         1xnVH2W+QJvncvqucHgHqLNZekoIi1nZB0ojxaZjZSwhsPcIR2LWO1e1wjWBeZkq2Oci
         xdSnC4jmeLSi9n9gb61SHchZ40WikhOgD/jXGSmP23whLUma1LRqfWPTgpv39LnGxUM1
         hWJ8ZczTtCnFNVbQOmwK0p/nzO8sttC/ghv6SFTq5HvujF+/XSvI2Hm/QhlWTTt/zSI2
         P/Pw==
X-Gm-Message-State: AOAM5312BhxOvg27GS94zoL7U3Srerdp2dC2jwThbThBD9GLiI4lyw/Y
        h6uThjtps4f+lfeKSL0++BToeA==
X-Google-Smtp-Source: ABdhPJxR+p09qkrkTFcEQjlE3vqR/ZNUisEOOfH/zoSyoCUeCFjBe5tqJE8JFlCq9MbnJuKJsp8CAA==
X-Received: by 2002:a17:90a:4b0a:: with SMTP id g10mr4318834pjh.78.1610620704710;
        Thu, 14 Jan 2021 02:38:24 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id l12sm4970112pjq.7.2021.01.14.02.38.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:38:23 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 0/5] Fix some bugs about HugeTLB code
Date:   Thu, 14 Jan 2021 18:35:10 +0800
Message-Id: <20210114103515.12955-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to fix some bugs and add some improvements.

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
 mm/hugetlb.c            | 50 ++++++++++++++++++++++++++++++++++++++++++++-----
 mm/migrate.c            |  6 ++++++
 4 files changed, 55 insertions(+), 6 deletions(-)

-- 
2.11.0

