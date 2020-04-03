Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0227619D5DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbgDCL3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 07:29:35 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34113 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCL3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:29:35 -0400
Received: by mail-lj1-f173.google.com with SMTP id p10so6611610ljn.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ivrfh7z+5XsuRxl0JPRhZnQ37vhg7rSvfqWMZmGEcXs=;
        b=ElPWX9FbdM6JPGRFIhhPZkGVO5q7IJ1VgQALnpLlFSnI9ZJMC3+AvZ3qYMpPvMuW7P
         yQfRGnrF240fVWbn+OlPwFypuWdv1zc3muz+A/l1iSU2i6Xwjb8DnyVWJFC+aOo7svHx
         RnAA5e8Qv11UmdY0qYR8/m1wG+1Ac9SqjaaFzlZlnxbLr9YQgqGBH9OigINjT2wwqD+K
         Q887i99gVLiASa8scRXEZ4blo3XrR8kF7SUYms1UCGTC1BrTVSB4RlieRWPBztg1pCqn
         wbwK0NtOWWBUnImOz3CevhQGKXWO9n/4PJhEI2pPcDFguxrkVZPFscvrrtpu4FnGYxaD
         YCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ivrfh7z+5XsuRxl0JPRhZnQ37vhg7rSvfqWMZmGEcXs=;
        b=hrG8/JYDN5mkD+oSIIKwYHT3XQZ7n51hlVbfLR4D09XC3N2SoADbhBr9/U4TBUCrYM
         Qn6fAryQbcIVMm9AEYTgRvrn4cQ12eP5x5LiVfVBr/XtiY5rkp/RBh8GVX/3QuPTQ5m3
         nAM9zkQ+JNYSRvhQjRd+IHe4AUoRM4FYfpdedew1ha3yeRFYpbVEdfy0AbUnLMYrWqCY
         BdOhQfqK/hUoSIr8JyNEtEfc3yck9TLuMXvZ2vUClMmxUPiNBa4q0EhG3bDu/sYOu/33
         rEh8kXacBZe0Kyd/0HyW1J27CmDe+ofeLkfR1agvixfnovypu4VjY4jg8Xcfni0ds9lt
         PZew==
X-Gm-Message-State: AGi0PuYet8w1HohCI+xfxELQjQ6+Y5HB3CSdB8cq5VorAtCODajbEiCA
        3wMcfzuut+VUZFJX45n4Uml3Ig==
X-Google-Smtp-Source: APiQypKIsAU7hf9BDVG0hZw+U8GteBcrKYt9kbqLTPjGC/HdKoijoAe0wnebTjPQfo1qKqZ+NTrbEg==
X-Received: by 2002:a2e:9652:: with SMTP id z18mr110590ljh.79.1585913372734;
        Fri, 03 Apr 2020 04:29:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v9sm4914153ljv.82.2020.04.03.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:29:32 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 5F04E10132C; Fri,  3 Apr 2020 14:29:31 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/8] thp/khugepaged improvements and CoW semantics
Date:   Fri,  3 Apr 2020 14:29:20 +0300
Message-Id: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds khugepaged selftest (anon-THP only for now), expands
cases khugepaged can handle and switches anon-THP copy-on-write handling
to 4k.

Please review and consider applying.

v2:
 - Fix race in compound page handling;
 - Add one more test-case for compound page case;
 - Rework LRU add cache draining;
 - Typos;

Kirill A. Shutemov (8):
  khugepaged: Add self test
  khugepaged: Do not stop collapse if less than half PTEs are referenced
  khugepaged: Drain all LRU caches before scanning pages
  khugepaged: Drain LRU add pagevec after swapin
  khugepaged: Allow to callapse a page shared across fork
  khugepaged: Allow to collapse PTE-mapped compound pages
  thp: Change CoW semantics for anon-THP
  khugepaged: Introduce 'max_ptes_shared' tunable

 Documentation/admin-guide/mm/transhuge.rst |   7 +
 include/trace/events/huge_memory.h         |   3 +-
 mm/huge_memory.c                           | 249 +-----
 mm/khugepaged.c                            | 184 +++-
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/khugepaged.c    | 982 +++++++++++++++++++++
 6 files changed, 1153 insertions(+), 273 deletions(-)
 create mode 100644 tools/testing/selftests/vm/khugepaged.c

-- 
2.26.0

