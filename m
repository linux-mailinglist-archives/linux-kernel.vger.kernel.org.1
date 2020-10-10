Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ACD289DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 05:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgJJD0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgJJDIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 23:08:19 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 20:08:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w141so12337858oia.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=fZ9ooXmn2GQKpm0k8FtJCZVXBPaGul3wh0cIHpiIF2U=;
        b=oG4sK3F6KhXNCzBLglOUojErBNiB00LZjENdEH/udSgzvBUZ3hDhcJayWMBVGnL5uS
         duPcpjpimRgSfhPKLGaiPZ5zEAwED8Ct4SOo4ozv3TwUQj0dZXZv7aMjyTvHfBJp8JET
         RKrLpdZgtxNkPG2UxGyhrT0cZ0CiNaGZp3gEzvXsN4zoxM/j6H2Rho3WWKSBFYmRs0cJ
         sZAST+Nkcxv8GlOYB6DsdDTZG+kB1qz3BoET++tVraZkT8xqIi6jTlYeXYrE7obko2ew
         mgGevB8NqsdjiEusXPr9upxJM7b5gdUhs+GqEMhx3agPlvFZRDgmxeXHyfMYPTf6/IuG
         AppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=fZ9ooXmn2GQKpm0k8FtJCZVXBPaGul3wh0cIHpiIF2U=;
        b=P59Q8EJ9FPqf7I/QES1ePfxZdl3PDOvo/eNSzgstKGwzTI5/6x2U0XzK+KjYTradZu
         lV6AVrjDuMsUYPaalR9snOs+CAB2x+AAhKzkvYBON+jzC6n90Qkl5D39Pr15EV2BB1ln
         4mJxgwnd7rwJBZIro+aBmridF42zZZxKxTYsRnLcnmR9lkI3NiZZBMjqxyZM04pSxhNE
         gQSX5ayzvDGw5p0RuldB5q5UUROJgU7jxdR551cB7jDM4y+EuCVggiEFwq4bFww5I7rk
         BjeMJS0L4QYqEhVGpyaRN+WypzL80ImOg3YAhtl5q6EozYN00BhuNVIpaZf9jXjEC+RG
         EF9A==
X-Gm-Message-State: AOAM530Uc4FCEFNmEqKWOrhFFlUZ1s+YeILDoYv8q3VfC63ai0Aac2aH
        6ECfTljzGGBAHmzQkgg2nAIN/w==
X-Google-Smtp-Source: ABdhPJzctLhVCjZFt53I0JGs7dx8LueATe7Ud2mcJyLwvDuyDQMHnGK1okhRXwWmiHh71l7M4InFIg==
X-Received: by 2002:aca:ea44:: with SMTP id i65mr4213710oih.117.1602299296924;
        Fri, 09 Oct 2020 20:08:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j83sm7979078oia.19.2020.10.09.20.08.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 09 Oct 2020 20:08:15 -0700 (PDT)
Date:   Fri, 9 Oct 2020 20:07:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Denis Lisov <dennis.lissov@gmail.com>, Qian Cai <cai@lca.pw>,
        Suren Baghdasaryan <surenb@google.com>,
        David Rientjes <rientjes@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/khugepaged: fix filemap page_to_pgoff(page) != offset
Message-ID: <alpine.LSU.2.11.2010091943300.13335@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been elusive reports of filemap_fault() hitting its
VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page) on kernels built
with CONFIG_READ_ONLY_THP_FOR_FS=y.

Suren has hit it on a kernel with CONFIG_READ_ONLY_THP_FOR_FS=y and
CONFIG_NUMA is not set: and he has analyzed it down to how khugepaged
without NUMA reuses the same huge page after collapse_file() failed
(whereas NUMA targets its allocation to the respective node each time).
And most of us were usually testing with CONFIG_NUMA=y kernels.

collapse_file(old start)
  new_page = khugepaged_alloc_page(hpage)
  __SetPageLocked(new_page)
  new_page->index = start // hpage->index=old offset
  new_page->mapping = mapping
  xas_store(&xas, new_page)

                          filemap_fault
                            page = find_get_page(mapping, offset)
                            // if offset falls inside hpage then
                            // compound_head(page) == hpage
                            lock_page_maybe_drop_mmap()
                              __lock_page(page)

  // collapse fails
  xas_store(&xas, old page)
  new_page->mapping = NULL
  unlock_page(new_page)

collapse_file(new start)
  new_page = khugepaged_alloc_page(hpage)
  __SetPageLocked(new_page)
  new_page->index = start // hpage->index=new offset
  new_page->mapping = mapping // mapping becomes valid again

                            // since compound_head(page) == hpage
                            // page_to_pgoff(page) got changed
                            VM_BUG_ON_PAGE(page_to_pgoff(page) != offset)

An initial patch replaced __SetPageLocked() by lock_page(), which did
fix the race which Suren illustrates above.  But testing showed that it's
not good enough: if the racing task's __lock_page() gets delayed long
after its find_get_page(), then it may follow collapse_file(new start)'s
successful final unlock_page(), and crash on the same VM_BUG_ON_PAGE.

It could be fixed by relaxing filemap_fault()'s VM_BUG_ON_PAGE to a
check and retry (as is done for mapping), with similar relaxations in
find_lock_entry() and pagecache_get_page(): but it's not obvious what
else might get caught out; and khugepaged non-NUMA appears to be unique
in exposing a page to page cache, then revoking, without going through
a full cycle of freeing before reuse.

Instead, non-NUMA khugepaged_prealloc_page() release the old page
if anyone else has a reference to it (1% of cases when I tested).

Although never reported on huge tmpfs, I believe its find_lock_entry()
has been at similar risk; but huge tmpfs does not rely on khugepaged
for its normal working nearly so much as READ_ONLY_THP_FOR_FS does.

Reported-by: Denis Lisov <dennis.lissov@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206569
Link: https://lore.kernel.org/linux-mm/?q=20200219144635.3b7417145de19b65f258c943%40linux-foundation.org
Reported-by: Qian Cai <cai@lca.pw>
Link: https://lore.kernel.org/linux-xfs/?q=20200616013309.GB815%40lca.pw
Reported-and-analyzed-by: Suren Baghdasaryan <surenb@google.com>
Fixes: 87c460a0bded ("mm/khugepaged: collapse_shmem() without freezing new_page")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v4.9+
---

 mm/khugepaged.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 5.9-rc8/mm/khugepaged.c	2020-09-06 17:34:46.939306972 -0700
+++ linux/mm/khugepaged.c	2020-10-08 16:19:42.999765534 -0700
@@ -914,6 +914,18 @@ static struct page *khugepaged_alloc_hug
 
 static bool khugepaged_prealloc_page(struct page **hpage, bool *wait)
 {
+	/*
+	 * If the hpage allocated earlier was briefly exposed in page cache
+	 * before collapse_file() failed, it is possible that racing lookups
+	 * have not yet completed, and would then be unpleasantly surprised by
+	 * finding the hpage reused for the same mapping at a different offset.
+	 * Just release the previous allocation if there is any danger of that.
+	 */
+	if (*hpage && page_count(*hpage) > 1) {
+		put_page(*hpage);
+		*hpage = NULL;
+	}
+
 	if (!*hpage)
 		*hpage = khugepaged_alloc_hugepage(wait);
 
