Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC7217B46
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 00:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgGGWul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 18:50:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28016 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728747AbgGGWui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jxvjf7Q+v/mOPCYZqZl27IogKSwgytmGoijHqe+1Kyo=;
        b=P1GHIVX5tnRGecOQlWrsq9Q3ScUaoZXQIfYEkK/B9GeC04SIQNGi02tJwD6QJTLKywG9ge
        8MkehkXJxlixptsJSWpDDQXApEtw4AJbgP5KLWsq7cgF1NyCxPwZc/2BdrJYfIShaNcV+G
        EbmYHFWmNmpXFdV0wM9fmJvm6jkWt7U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-XTSgt7b6NWGFrykU34Jzgg-1; Tue, 07 Jul 2020 18:50:35 -0400
X-MC-Unique: XTSgt7b6NWGFrykU34Jzgg-1
Received: by mail-qv1-f69.google.com with SMTP id j6so28101581qvl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jxvjf7Q+v/mOPCYZqZl27IogKSwgytmGoijHqe+1Kyo=;
        b=ltAT7LuAoZGUTw81c/DTZZQi6kiVbvtD0s/iXZwnWF3ZMTZbtlmCph+5TtGw7KvsHJ
         09oFxJLSIJf8KhoNlqeF/ertR2CAYu8aqpGUDo2l9LNlwRrt4gQNiO/D41QXkMeEFVlc
         tZmuJmB9JXtcpo+fOUGoV7jjpVjineHbYiQpvYMUIZX5WkO+B1GfMxIFDNIQCnqAkuih
         RDDCrULozwJarMVTOCdlWM79a87YXuYhnaBiCvLvCUQNGyANi8Y+QPa1xeSlNz7rFML6
         8QghKOpWq7KPuUsPSNMtvxIEfa6K/RiwcNV/RsYQYu96Xr/K2hCrhTw3O4dnPjndcQat
         5W6Q==
X-Gm-Message-State: AOAM530S0Rat4CCXBj2ITJdwlZ1hnaWRXJ3w+An/Qr+X+Wji6fY/2doL
        WyzV/cucLqQ/T5TQ4whnyNdvBbFWJQUsvGB38pfkatpX1XgpOcczYRhpjtYzB+001RehcYAEV4g
        5xbJ1ekzp3V3OGtIvxZ6XPWXq
X-Received: by 2002:ac8:16b2:: with SMTP id r47mr57607217qtj.273.1594162234489;
        Tue, 07 Jul 2020 15:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEUX4FOONaw2ZO8mmmd3zmBYLqC03cLLhe3ytu7deLkE6Bv0g/Xef2K2OGzTk+bX724w5ibw==
X-Received: by 2002:ac8:16b2:: with SMTP id r47mr57607196qtj.273.1594162234214;
        Tue, 07 Jul 2020 15:50:34 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:33 -0700 (PDT)
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
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH v5 06/25] mm/csky: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:02 -0400
Message-Id: <20200707225021.200906-7-peterx@redhat.com>
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

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/csky/mm/fault.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 7137e2e8dc57..c3f580714ee4 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
-				NULL);
+				regs);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -161,16 +161,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto bad_area;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-			      address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-			      address);
-	}
-
 	mmap_read_unlock(mm);
 	return;
 
-- 
2.26.2

