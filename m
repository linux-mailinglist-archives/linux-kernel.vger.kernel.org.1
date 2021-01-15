Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2162F850A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbhAOTGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733251AbhAOTGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:06:32 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E5C06179F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:19 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id y34so7033023pgk.21
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OiHmip5pShZEM0ZBAU71H+KEdKKSM8se2w8Pb4UEVUI=;
        b=TUlkIxxVvg+NbLyEdgqkaAFxnAFs01VNlKWsfh3GhNA8NsXjhKrFaUkXvV4Zr9JlPu
         z+UEL/4/8qbJIkIOvrHuW8ajVDx5H7EsPfrkYlJqFzph7GP8yf1Ex9J37PQBXLPFXPtu
         vEP4CaUe76NUa5oIaelgWSDdl6FVyXtg4S9mzJ4q3uramJL+1v3c5G7VKfkLPurURi+4
         MkIWx6zxZFDMqyIMy1Irl7i5Y6DP3eoZWqtJGvTB0p5cT/Ogg4f1uxSoP/Idw+iDZl0f
         UMDYOs1wOSsY9M/hMYlGZckdMEndJ22m2r/zFVpMH76XXN64MIlxgy1gnV9eSZHz8bKB
         vtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OiHmip5pShZEM0ZBAU71H+KEdKKSM8se2w8Pb4UEVUI=;
        b=mwn/5THxGvL7O8w3QcFyQCSu6yWmH9COwCAvuIfz0Urb81Hi5T6PAQKv0nmn6HMxPa
         Am8xDsxbnqtJ68N96Dxm3q2NiUCAEZ4mI4g/ooHn9I+nQe5n/S4Q82t+CFIqX3uKY7bK
         RS3CleVgi8NXVlYKhcJ9ENUcaue8byNrRGZr5DSJRs9gvb1xum4nCE1MX/8wiBYOcLeR
         Hk9ar+mDYZaYGM/+znWPEKrYAECR/q0fQ4nXXYoenOorEIlqDXoo9ElG8WxCckJRoW1P
         OG3newDc4Y3Z8fMd/0XAo6cO6ub27zXnGMZn1r9yLWwbj6C+/ZikLZwEcjE1KENmJ9k+
         T88Q==
X-Gm-Message-State: AOAM53079ckOq/IwZBSuqCUfGZW0HatJM9YBSugHOtTyXpdwLwVJgOhK
        x9LHhV7ktcB+kCweS/gE0t0w5um/TFIb54g2KSYF
X-Google-Smtp-Source: ABdhPJx5ZFf+WD9DcKtl3XLJSR7XOnyXjgx1WlJfvxIQaqqkk6YFhDMOONtuyBr3KQM4NxvYJ8VqPx/7/n9aj6k0d8Qo
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a17:902:12c:b029:da:e63c:dc92 with
 SMTP id 41-20020a170902012cb02900dae63cdc92mr14044589plb.71.1610737518850;
 Fri, 15 Jan 2021 11:05:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:04:48 -0800
In-Reply-To: <20210115190451.3135416-1-axelrasmussen@google.com>
Message-Id: <20210115190451.3135416-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210115190451.3135416-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 6/9] userfaultfd: disable huge PMD sharing for MINOR
 registered VMAs
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

As the comment says: for the MINOR fault use case, although the page
might be present and populated in the other (non-UFFD-registered) half
of the shared mapping, it may be out of date, and we explicitly want
userspace to get a minor fault so it can check and potentially update
the page's contents.

Huge PMD sharing would prevent these faults from occurring for
suitably aligned areas, so disable it upon UFFD registration.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 7aa1461e1a8b..ed157804ca02 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -53,12 +53,18 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 }
 
 /*
- * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
- * protect information is per pgtable entry.
+ * Never enable huge pmd sharing on some uffd registered vmas:
+ *
+ * - VM_UFFD_WP VMAs, because write protect information is per pgtable entry.
+ *
+ * - VM_UFFD_MINOR VMAs, because we explicitly want minor faults to occur even
+ *   when the other half of a shared mapping is populated (even though the page
+ *   is there, in our use case it may be out of date, so userspace needs to
+ *   check for this and possibly update it).
  */
 static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_WP;
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

