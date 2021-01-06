Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B32EC39B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbhAFTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbhAFTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:00:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B38C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 10:59:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q22so2224858pfj.20
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dDiuE/L+TEOVkofWeADZyQOWx+prBVUG+hG/zE7qjqw=;
        b=sxBZ/PNfezx3O5EO5q8uIXj23Iiuw2N5oK1j8hRxd93uewJtpVeV1h4vS1cObRAiPf
         9c9/eilpVtkkzOH+lKQriRvEm5l4a1+HhItCQJm81G6gc91KjUpcOyyqj5Xcbrgkq1S8
         Xtc2riJFLYE/c+yMu0gaIZNV+hZA2SvuWgrrxivZJrsGil1fHPbdzPMbyydDm2oLYYFi
         GXTfnwLBdzEPFex/ZpP3xhpJ8pSInWKT91K4DIiofyjy5DKAAzYvIeUw/E/zbTgWjW+6
         zUPZJVBR8av0PrGwMPj7NS+VO69Y1X44GSQGvx1+Dp/J8DanZW7+jWLBwBcynyzgyyg+
         3ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dDiuE/L+TEOVkofWeADZyQOWx+prBVUG+hG/zE7qjqw=;
        b=YXcxE/fKJR0wi3pHwXI+0rlfWf5zj7wqHvPTXlWA/V6m61CNAjIvndv6bw0vY8yPwy
         g0i9iDIu3yxp/oc2IzMn8bMtFTCw5IDs1eFHg5fzoOhpyprc/epPa6wLoU2CCFOwG6a2
         StXjqCJRg2q/Hv7Tw4Q4FW6xSgVdwmZWV3DYUdBYjB/Rjs59Z0BM53FVKNtK2pxuM/Bk
         4nsPtWqkqBINeBHCgMEbzdm7h7keINFqmp6UJJVRjBn+ghDZVLRdIPINMAz3qS/BtnDQ
         mKWYXjqnXQPcyr1y6FkX2tXftGxx6vSDQ6aMbkizLgtsI/gu48PEXZQUUDm9F7ICaZHY
         H1iw==
X-Gm-Message-State: AOAM5309qmDXWilIPXVDVjQaHlasd0OcdolWpywB3YFlXZSw4nUFVYJ5
        bIgDcZWkby532mpM7QHqkQbJS6G8vXVlTWWeBuV22uICZHr4/L1R5YEVuQ5ZSIk58MNy8pgvSNs
        j5gkd8b0vT6WPAjXUCBHv14kULzgNQShcR6RE8MEAbzHhbp83et0fph4wY+FHV5lY35FFEw2i
X-Google-Smtp-Source: ABdhPJxPsRsQny1NjyuL9Xk4FVKrWFkNuPbaAv7cxHnPpj8wguRj/YIUx8EXUWlThlt7mr71VYCm+zyYL1Ap
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90a:4096:: with SMTP id
 l22mr5523604pjg.114.1609959596956; Wed, 06 Jan 2021 10:59:56 -0800 (PST)
Date:   Wed,  6 Jan 2021 10:59:51 -0800
In-Reply-To: <20210106185951.2966575-1-bgardon@google.com>
Message-Id: <20210106185951.2966575-2-bgardon@google.com>
Mime-Version: 1.0
References: <20210106185951.2966575-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v2 2/2] KVM: x86/mmu: Clarify TDP MMU page list invariants
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Leo Hou <leohou1402@gmail.com>, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tdp_mmu_roots and tdp_mmu_pages in struct kvm_arch should only contain
pages with tdp_mmu_page set to true. tdp_mmu_pages should not contain any
pages with a non-zero root_count and tdp_mmu_roots should only contain
pages with a positive root_count, unless a thread holds the MMU lock and
is in the process of modifying the list. Various functions expect these
invariants to be maintained, but they are not explictily documented. Add
to the comments on both fields to document the above invariants.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/include/asm/kvm_host.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 39707e72b062..2389735a29f3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1010,9 +1010,21 @@ struct kvm_arch {
 	 */
 	bool tdp_mmu_enabled;
 
-	/* List of struct tdp_mmu_pages being used as roots */
+	/*
+	 * List of struct tdp_mmu_pages being used as roots.
+	 * All struct kvm_mmu_pages in the list should have
+	 * tdp_mmu_page set.
+	 * All struct kvm_mmu_pages in the list should have a positive
+	 * root_count except when a thread holds the MMU lock and is removing
+	 * an entry from the list.
+	 */
 	struct list_head tdp_mmu_roots;
-	/* List of struct tdp_mmu_pages not being used as roots */
+
+	/*
+	 * List of struct tdp_mmu_pages not being used as roots.
+	 * All struct kvm_mmu_pages in the list should have
+	 * tdp_mmu_page set and a root_count of 0.
+	 */
 	struct list_head tdp_mmu_pages;
 };
 
-- 
2.29.2.729.g45daf8777d-goog

