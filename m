Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65C2F850F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbhAOTGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbhAOTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:06:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE6C061796
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:13 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y187so6586081pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oTwVnpEB+dNbI2/GJPfCxLuQafCc92ohApdmsU/sVV8=;
        b=nlsMKU20U2BV9LxuWLugi1r7yb8At2zSQB6VuiiB674F3TvGF/jFaeK/gXr98wOBf8
         DdmgxI6HH+WuNSCVtekTz/CHwiSlRHhlV/0ia8221JkbnLFG1tq9w8B5OoGgxQX3TcMZ
         xrwodHSn6xSWAH332RuxmbA3CegqsFW85nwI3n2AHPCw9igXLO8K1Bmfidh0p8pGJRh6
         s6iuAQ0dmem9IW7DmfQVNvGyg8Cv9eE5+6f4Ah6kfM934NwFgM9FkgHxZRR5eNNEh1/U
         ClxGIyYV+bUnrxixoc3KJb9C1O+U0zlWlaIGeaAark1bVHNVL1axAYQMrMzUlZuCqc6K
         sdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oTwVnpEB+dNbI2/GJPfCxLuQafCc92ohApdmsU/sVV8=;
        b=o+mJoigHLT3UjLqlK5YJhE44UtxgyGmzhnXjgpzzAQcuL5+FFuLZmRLQ52HKURSOia
         a5TsaaNAtxJmRTasqo8koYd+qA74ubiLdw4CeC0ps8JiLwvN7sMxYUcj8on/aBr4erLv
         WAkrt1v//jf2CSGAQTTsMgag83xzBzGEvEj4SGFFfYNcMIZUb5FG4C+Jjx3hVcACHP0s
         MzXkQ5wt7nDLT/aIgN8NBhlOpwJBgv3i6C0LKJLeHP2p29vd/sKzp9bv+jUp4fxHyGyk
         c2sgnv31x652uBtrsq4+hFX/Vl3RGXAAs7vV5LoMmykqH39+YltaJsyas3uS7NQuUAoN
         PBAg==
X-Gm-Message-State: AOAM5337C+rmQviPCsXj6Kj/N8tSNOh5AwoIStA3xSapbjnBkHQK0hvo
        KzlfmOpChGG9wVDEpye5AVD00wgkE1MIppWypgUY
X-Google-Smtp-Source: ABdhPJwd8+2UJUUzuwu53gsQBgAE9tIOtgs7VV6+lAZOwahwvki/HHrFvFrhMis67XqTrhSDJ+ZhcC8+H8iOaZ42//2W
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a17:902:684f:b029:de:3124:d4ee with
 SMTP id f15-20020a170902684fb02900de3124d4eemr14219044pln.13.1610737513037;
 Fri, 15 Jan 2021 11:05:13 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:04:45 -0800
In-Reply-To: <20210115190451.3135416-1-axelrasmussen@google.com>
Message-Id: <20210115190451.3135416-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210115190451.3135416-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 3/9] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
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
index 4959e94e78b1..4c8e3447ae6a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -959,4 +959,12 @@ static inline bool want_pmd_share(struct vm_area_struct *vma)
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
index 1ad91d94cbe2..61d6346ed009 100644
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
2.30.0.284.gd98b1dd5eaa7-goog

