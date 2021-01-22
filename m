Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD2300EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbhAVVet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbhAVVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:31:20 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67159C061794
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:29:36 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id i82so5056852qke.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OYrPoV3fYQ8WDakv98owhD+ljPpsL42VYOxvmhLHcYg=;
        b=kUzsor1Pm3Mgn8ZxMLrofWfTqQiPvG/90LXq+jSwELmpUS1Sfl5+eWSzdsb9iWRIEy
         40KRghuc2ukseAMkHUzebpIVndXMKR/1p+MTMUFE0tvuQgUbLNFevKRoVgKRV56qwX8O
         YAxPe5fnyMQ7CdBHCLQAdKcZWdZaMLf5vE+xqiAZTPMHbvWamjfXhdnNiXPScwKC9wOH
         NmXQiDpPwtKGuvoAVDFyJcbbLhdlhZC+8SLftcPp8m9JpB8GkKUFWaJAXRIt2EBMJ3Cx
         UnVkyXcMKuXqdp1K8aNj33h9ICRBsRpfH5YmaKFTGyoOo3NBp3dcgrAK5HAQUVXKJLJw
         0Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OYrPoV3fYQ8WDakv98owhD+ljPpsL42VYOxvmhLHcYg=;
        b=qN/SvqItzfx7xykKAYm8g5So3mZQNOdAAw7Ni6kMBL2kx7zM2KaBukbqJW/DnneuGL
         cyDeKyEGzldjDhWGrlvAXeTeDFKUOaaeH12Woi36i2Rsiurnk5OJjeCvtto9mICl1D1b
         B5oWYzcWBPWz9POEJn/KFOu8P9Wnr3cSjr7BlG9cJvwFpTFiQd9rR5OkpVQhYR0dvg/T
         lpVJ2Anb8yvrjBmnbgExr63Wgk1cDmOT9m9XYNGCd/2CrOFhC6OjDYN0SVHz+2NAUmCi
         DEFj50gPU2UAwEjMrlfNgJ/9lL0zwBhAULjy/g6Ef2HYMe5TVxnxkaas5os65kOjLelw
         4wqQ==
X-Gm-Message-State: AOAM532Ek/XornSda8kBwjoqV39rx0ARrCTgvM+jbczjKkIcRHmfJ6PH
        iz0eKuEAcuiRXCVIEZHpHT//LL/bR2jOL75tM0mq
X-Google-Smtp-Source: ABdhPJwJhAUfP+pfuxpquEI/D/OlazsYWIwPmxul8In0Z3P8YxKxC+jbkPF9CW06C4W0GAaPQg439JotJdt4FkTROktt
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:a03:: with SMTP id
 dw3mr1414980qvb.24.1611350975439; Fri, 22 Jan 2021 13:29:35 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:29:20 -0800
In-Reply-To: <20210122212926.3457593-1-axelrasmussen@google.com>
Message-Id: <20210122212926.3457593-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210122212926.3457593-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 3/9] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Prepare for it to be called outside of mm/hugetlb.c.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 8 ++++++++
 mm/hugetlb.c            | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4508136c8376..f94a35296618 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -962,4 +962,12 @@ static inline bool want_pmd_share(struct vm_area_struct *vma)
 #endif
 }
 
+#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+/*
+ * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
+ * implement this.
+ */
+#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d46f50a99ff1..30a087dda57d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4924,14 +4924,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-/*
- * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
- * implement this.
- */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#endif
-
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
-- 
2.30.0.280.ga3ce27912f-goog

