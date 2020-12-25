Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD12E2A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgLYJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgLYJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 04:30:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 01:29:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c79so2370607pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVMAYD4gVjDuu2L1m2emovg27Ao1LXtta+hv61YwtE4=;
        b=Xqcmvrzjf0v3Om3qY3vkNlJvkYs8uthcOLi/yiwi1S3kLGQ6pAV4LqeFEEy1IZA9CG
         mNewlnd9/uRZH0kIhcLOFsvUntL+EKsG7b1WlC2vtU09eHH1Lwe6b1V3111ZKCeU+itm
         7eZwXpAK9UaajQkU9DtHTOZBLsYSAUClXnEg6o9EJ3V2bryDgZYpU2Kiw3Rl3WRqGLDG
         RL8qHu52h5JYiOKr7j5RACyyLEC7nEi8LjE18p8ZaDp5qjNCo7AtYu/RPP1aVRqdQ0Y+
         4AqEpCmprMFT4QaRS4zbzXbYd0rkzWRYENoJ8d4fyY//dtujo00UT/LajJ+pe44TMEVx
         nYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVMAYD4gVjDuu2L1m2emovg27Ao1LXtta+hv61YwtE4=;
        b=PxBmWiiSQABUh9WlX7Lulwgf4d4WO+SbkJvWotedx6GfEF3YA8fiVApcVmHTANQFWr
         bwSu5SQEIWI+sS1+QgrSgmTSMSQ8bRznljbuM7dCqVTlwk4hkgp4iHML9UF0BApw1OT4
         F6QwrPQ4eWH4d9T+fN4NyU6sLkXLdIhvwPhLKBhjtQpxqM1Zq3U/UW6WOE94iRSuthqc
         uSrmkNlAXaRkEuQ8GIBdxqGohy8zX71grLfTc85xk9BC/kLYuz4p3dd8ng5ZsZHdk3Eh
         XRpc/oPnTUdc+WcDobitWaH64YhApz8grPTVDJ95gQICuk5+2BrI7HwKheR4uvVMj+QU
         dBdA==
X-Gm-Message-State: AOAM530iIeHKHIXANbnlz4Z6vQZyRvhrocaPVEMHpu1PT1tzwdaWWzyc
        sxCOD12Q2iDWSLmSvzWvUMI=
X-Google-Smtp-Source: ABdhPJx9/ExfuFhgPf0/W7sU90LeypmQV2CkuLRYiCOv0K2mDGnExIf8WCm0G/rjjtYOy9sK5dD5UQ==
X-Received: by 2002:a62:e818:0:b029:19e:31e6:e639 with SMTP id c24-20020a62e8180000b029019e31e6e639mr30578284pfi.81.1608888576176;
        Fri, 25 Dec 2020 01:29:36 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s13sm28966659pfd.99.2020.12.25.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 01:29:35 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH v2 0/2] mm: fix races due to deferred TLB flushes
Date:   Fri, 25 Dec 2020 01:25:27 -0800
Message-Id: <20201225092529.3228466-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

This patch-set went from v1 to RFCv2, as there is still an ongoing
discussion regarding the way of solving the recently found races due to
deferred TLB flushes. These patches are only sent for reference for now,
and can be applied later if no better solution is taken.

In a nutshell, write-protecting PTEs with deferred TLB flushes was mostly
performed while holding mmap_lock for write. This prevented concurrent
page-fault handler invocations from mistakenly assuming that a page is
write-protected when in fact, due to the deferred TLB flush, other CPU
could still write to the page. Such a write can cause a memory
corruption if it takes place after the page was copied (in
cow_user_page()), and before the PTE was flushed (by wp_page_copy()).

However, the userfaultfd and soft-dirty mechanisms did not take
mmap_lock for write, but only for read, which made such races possible.
Since commit 09854ba94c6a ("mm: do_wp_page() simplification") these
races became more likely to take place as non-COW'd pages are more
likely to be COW'd instead of being reused. Both of the races that
these patches are intended to resolve were produced on v5.10.

To avoid the performance overhead some alternative solutions that do not
require to acquire mmap_lock for write were proposed, specifically for
userfaultfd. So far no better solution that can be backported was
proposed for the soft-dirty case.

v1->RFCv2:
- Better (i.e., correct) description of the userfaultfd buggy case [Yu]
- Patch for the soft-dirty case

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>

Nadav Amit (2):
  mm/userfaultfd: fix memory corruption due to writeprotect
  fs/task_mmu: acquire mmap_lock for write on soft-dirty cleanup

 fs/proc/task_mmu.c | 27 +++++++++++++--------------
 mm/mprotect.c      |  3 ++-
 mm/userfaultfd.c   | 15 +++++++++++++--
 3 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.25.1

