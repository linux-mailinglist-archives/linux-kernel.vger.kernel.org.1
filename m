Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29622EBB4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAFIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAFIuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:50:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C9C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:49:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hk16so1241796pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJ7EXnrnjhy7+uYeV34kijGi9OXt4E2hNZBzDKNjCfU=;
        b=asObGoSIMPvAwU5SHqpDMotcGC0UjYsXRcsgmrKMTgKJ1dNK/O5ouxREgMZDHIDIyE
         TctjLAYpcLcS/+PctbvaJv5wJGj2ajWaEH9r5896EeRNTvdv68aT23SBy0yXSxvS/vVW
         HLgWpwELnYK0FnYyLMZ71ET0u0m5UiqcWNeITKd5BeqLfOuJTm4HZ2HyxVl7NQkNSXeT
         PqZ7opAzPZiFmjvsXW4nRxQdsiajL5Q5A0jiy2W53M3laLFVyvzUR4b3XJHgGrPrZHhb
         qDr5HL+X8TZd8PDjmsng90OzUQ6bX9cNEM7x/vwQ/nblg/dJqFtgrI33Az7Ou36+3lWM
         R+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJ7EXnrnjhy7+uYeV34kijGi9OXt4E2hNZBzDKNjCfU=;
        b=PwET+m/rdbR2BdntZB8ex0FiXRYnOgfAVfCAlF6l1+jGUsGjxAkMaT3fchaB76FIoa
         q+tpU0nvTuf6jypu34eDVN5+2zqNOIAsn8R36KKXbw9k5GeuIoWCZrhOSuHQ2N9MSpuL
         w8IoIpjl2iGOd0DTjqh5in0aUatOktvplmRr7FPopNR1OM+DjHBoFM+rJxv04icHejvN
         /6xxxJvjNlZTuKPxUTNrIoIbcQP30meWNip1S9EPnpK6jF2YW7xCmkMN59OonBddyZI4
         RCQLqFMiQt+fs+4W2ZG/wI3ioZY/4bgW3YBPsY/Wh/wVXUMkiq0ZETgG2l3hcx560xDq
         Kf4A==
X-Gm-Message-State: AOAM531n0a+539oCEZxexOBo7fKcKr5UdcJgaDcyuZOWI2oG/SW8vbsz
        CF0ZVSE88RAaxss67ns7y5zWQ29J/pZh2VyeRhg=
X-Google-Smtp-Source: ABdhPJyPVD0EI/kuz45CeSBqtJJ2E0++1zedCl9qsb+hROtQBU2JorcSzunxBILZ7c4GNzUPeDM9Fg==
X-Received: by 2002:a17:902:b943:b029:dc:6bd:5562 with SMTP id h3-20020a170902b943b02900dc06bd5562mr3563335pls.59.1609922979261;
        Wed, 06 Jan 2021 00:49:39 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id h8sm1851806pjc.2.2021.01.06.00.49.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:49:38 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/6] Fix some bugs about HugeTLB code
Date:   Wed,  6 Jan 2021 16:47:33 +0800
Message-Id: <20210106084739.63318-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to fix some bugs and add some improvements.

Changelog since v1 -> v2:
  - Export set_page_huge_active() in patch #2 to fix.
  - Using head[3].mapping to indicate the page is freed in patch #3.
  - Flush @free_hpage_work in patch #4.

Muchun Song (6):
  mm: migrate: do not migrate HugeTLB page whose refcount is one
  mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
  mm: hugetlb: fix a race between freeing and dissolving the page
  mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
  mm: hugetlb: fix a race between isolating and freeing page
  mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active

 fs/hugetlbfs/inode.c    |  3 ++-
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++++------
 mm/migrate.c            |  6 +++++
 4 files changed, 71 insertions(+), 9 deletions(-)

-- 
2.11.0

