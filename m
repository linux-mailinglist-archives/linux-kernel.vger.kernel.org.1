Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420EE217B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgGGWu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 18:50:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28917 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729639AbgGGWuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntPp8bHOPIXhq64ZYjMBP9tKw1Ahb/2+VdQMPS01kXM=;
        b=W4GwxcG09o7S3azMQ+65AJ78xC6oIs6WBYXdriRNLEATeoln/6cHn/nWDUFFVLHkbXCgVg
        rIK+x/CZ1a6zL21DLxr/ihqlktWsg6i8ti/8Qz/Y/7pduiCYHiAFd7JBR+I11M84mSgJSL
        QNYrQvjYgPkhR/Fmlvxt1SgU3SWxykU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-u5NbY1yQMmeRT0mMDvaJdw-1; Tue, 07 Jul 2020 18:50:41 -0400
X-MC-Unique: u5NbY1yQMmeRT0mMDvaJdw-1
Received: by mail-qt1-f198.google.com with SMTP id t36so13852687qtc.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntPp8bHOPIXhq64ZYjMBP9tKw1Ahb/2+VdQMPS01kXM=;
        b=E8wHGPY6wwfqODp/44b98cT2sHHwmIIEhh8rfGQYCnKXfOCoBcyZPpp9UIKZ2s4U8c
         Axc7vaM/oJW/a4cS/SvszirAVDrvNpbxdshUZj+KRrh9kwper7n6Te/lXIwGzq49j4cg
         0pGIJ3s7oEglhYasW1WJrnKvqQf8dn7IqSfIy619EXhxtOi5a4wHAAMoliNPPO4+HGmT
         uLMnZicNw/GuZXcKnV8pjQ82Eh8He+AOlVSQEmJLyMb85/nOEFoinczdceUwQY59wzRw
         Xp02oSXAfXjpMskhZeB49yF6awBd0xeK3ccRirHp7ESL7trmzRUv2nU4jt+sDcZVJlIl
         J87w==
X-Gm-Message-State: AOAM532wRyVhX7SpZUqhP53iRBcWWD04cGn8y+7GWYA3Q+ktpz4EYTYu
        83mKy+L769tdHX0XXZ+gpIyQ9OdmNIpI0dXCrI9y9hcAD01SaQwt+i7n9vYV5fYJOjsT41cKNNY
        9xBQe62TLTvi8exuESF6l3RNd
X-Received: by 2002:a0c:e847:: with SMTP id l7mr56120980qvo.232.1594162240774;
        Tue, 07 Jul 2020 15:50:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgovnWtiF+oysXYM9UD0AGaq7GBiLXSMQKB1qC50sXyGAmTr2SdnjgqnzmgDoXm4SpeSq8Kg==
X-Received: by 2002:a0c:e847:: with SMTP id l7mr56120955qvo.232.1594162240518;
        Tue, 07 Jul 2020 15:50:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v5 10/25] mm/microblaze: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:06 -0400
Message-Id: <20200707225021.200906-11-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
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

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/microblaze/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 1a3d4c4ca28b..b3fed2cecf84 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -28,6 +28,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/perf_event.h>
 
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -121,6 +122,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -214,7 +217,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -230,10 +233,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (unlikely(fault & VM_FAULT_MAJOR))
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

