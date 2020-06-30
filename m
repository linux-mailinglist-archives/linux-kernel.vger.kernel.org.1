Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27920FDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgF3Upf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 16:45:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730142AbgF3Upb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q+9vkARh0QAhoC5rVpcauEcS1HmAJvkVoHtpMHMdH44=;
        b=DiHm4gi9gKbRmg+vVc3HskauaURD1feQOXOwr2uh30bkpQn4FOXlpi04N0aZ2J0I+bFI1Q
        3Qf821OGFH8eydIdDJxeKxXXkms0LawTKE49S2KoqalpkOwy2j9/RkB5S82lmkjbbR5io1
        1BqUufuNBzMtFBSURosWxEYxlz/rOtQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-lr160JaqM-qVkPabBl42NQ-1; Tue, 30 Jun 2020 16:45:28 -0400
X-MC-Unique: lr160JaqM-qVkPabBl42NQ-1
Received: by mail-qt1-f200.google.com with SMTP id c26so15267431qtq.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+9vkARh0QAhoC5rVpcauEcS1HmAJvkVoHtpMHMdH44=;
        b=mFw60iIPpGloYTj//494j+gCp7RfMuKECXBBnVUodpU+wfJtRNDB/SYqO+qgWqZWoc
         5zy709Usty64JHKeK7OUGnM9eY/MDFEBV7DMGfHMOPPEEa2hlUtEwqowIBHr3WaxmTYW
         GzFRSq8piF6sHNwaZhBZkjXd3vwD/h69UJyuv3qLg0Dn9lfjWu1Wgz5LwECSZPY3BNCF
         z9lH8WJxlb7dUKFraCp8zIj5UGG1wJAE2Zz7PX5ChDBUlWfhFz+3CXNbyRt/yHpI0awz
         PM60ue+p/Y95SV1AoUHK4A7mRj2z4pT2VdwT9JD9qcI5GUeft0d6eSA11lmwbHGrYS5H
         zVqg==
X-Gm-Message-State: AOAM531FnBda5bOn4XAo37Mhd8mtz9vhGfn1Q6hUqez2d7s03fLhZ3D8
        m6Q6f5iVKV4cmcs0ogwCtQI6z6uisTRJQmmR6qpA+5TQOMFZHdcWIZl+5vcLy3IT+7GCnvLAJgo
        CjMnj/SN2IGpripRr/8xMMdVn
X-Received: by 2002:a37:af41:: with SMTP id y62mr20874903qke.385.1593549927710;
        Tue, 30 Jun 2020 13:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/9f/7q91pxPuT3m4Vf6AMh7F1XsjTpGX1SRngMV0Mt26KohAGiffe7X1KyPB+Pvn5KcloYw==
X-Received: by 2002:a37:af41:: with SMTP id y62mr20874868qke.385.1593549927383;
        Tue, 30 Jun 2020 13:45:27 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k194sm3755819qke.100.2020.06.30.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v4 09/26] mm/m68k: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:25 -0400
Message-Id: <20200630204525.38906-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-m68k@lists.linux-m68k.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/m68k/mm/fault.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 738fff2a16f4..d9c22e24d585 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
@@ -85,6 +86,8 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 
@@ -135,7 +138,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
 	if (fault_signal_pending(fault, regs))
@@ -151,16 +154,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		BUG();
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

