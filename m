Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C32E226E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgLWWai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLWWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:30:37 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7321C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:29:56 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q137so552866iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=61D1avpBNAQTrzPUC+V3vNlrIkz1Ho8e0u54ev6p94E=;
        b=v83tm17hJbXD1YD85KCQF9w+wyVDxiP+lP8+ApqT44Fv6bBx7iFtr7ccCmK5kdUYlu
         D7WN2A8OYjBztmOn9jtKbAxkcrgq0tNqr+noMi0sW22XxNftmBIsXzGsC75BGQRPvTCK
         U91xjpkSQwk77RUF6kEW0aivXAz7T0mkqiRkCJ95cjnPw9pUp/gzQGGVS4aOa6IhFJYJ
         g/J0dCArwhHApHEaH1eCDjxKlxcLtj8AjJlYpaDqNXaN8JydilT8fiySksFbOFgQNtZf
         o7I5TeJu3G/RHrlSc0G0F4BCYPmTrV+hSKGU2bc1egvMk//xb23kfiqa8pc/l0vCf3Z8
         rBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=61D1avpBNAQTrzPUC+V3vNlrIkz1Ho8e0u54ev6p94E=;
        b=llmoFKBweA5oceZvzy61U6/UzIygZu1o4JeCUvF9z3iKqv96cwEzJR1E9lsWRdFZvI
         3cgyW5nmaUdCf+rBNimvgHqpX63j0YR9Io1pjR3LslstRCOX1nYNFEv8iUXAdv5mgetO
         2fz3KVME2gBQmHZUclwaNfabPRIUL1MIDo+MmbJctoMzD8p0vyUKDw+XpHgeoYYRrDvD
         SRWYwtpWZis7EzffSxxAJ4JQA4KSU4qYR3WjZ83V6lDlE4e6VLphglVnT42sm6+N14B3
         n2K81QqoYUHUMjQgcUvws8DmhLOiiKpIAi6aoRC8yTafljAXIRtT9we3a0aCcO8PYcca
         oxvw==
X-Gm-Message-State: AOAM531FisTQxksdL+miQ5Yv1DHHMFu0vAypRy14Ig3Eli4N+kd3NJ+V
        +2v/BsxH438dFhphgrGGZPx3JA==
X-Google-Smtp-Source: ABdhPJxOgHitNDbwpl4RFoLQWRW+gwIhTHV1P5RAby/BaeyOl3GQispO1B3AccbMuwC1XhAY+dS3gg==
X-Received: by 2002:a02:7a50:: with SMTP id z16mr24430480jad.87.1608762595879;
        Wed, 23 Dec 2020 14:29:55 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id w3sm18872116ilk.17.2020.12.23.14.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 14:29:55 -0800 (PST)
Date:   Wed, 23 Dec 2020 15:29:51 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
Message-ID: <X+PE38s2Egq4nzKv@google.com>
References: <20201221223041.GL6640@xz-x1>
 <CAHk-=wh-bG4thjXUekLtrCg8FRrdWjtT40ibXXLSm_hzQG8eOw@mail.gmail.com>
 <CALCETrV=8tY7h=aaudWBEn-MJnNkm2wz5qjH49SYqwkjYTpOaA@mail.gmail.com>
 <X+JJqK91plkBVisG@redhat.com>
 <X+JhwVX3s5mU9ZNx@google.com>
 <X+Js/dFbC5P7C3oO@redhat.com>
 <X+KDwu1PRQ93E2LK@google.com>
 <X+Kxy3oBMSLz8Eaq@redhat.com>
 <X+K7JMrTEC9SpVIB@google.com>
 <X+O49HrcK1fBDk0Q@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X+O49HrcK1fBDk0Q@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 04:39:00PM -0500, Andrea Arcangeli wrote:
> On Tue, Dec 22, 2020 at 08:36:04PM -0700, Yu Zhao wrote:
> > Thanks for the details.
> 
> I hope we can find a way put the page_mapcount back where there's a
> page_count right now.
> 
> If you're so worried about having to maintain a all defined well
> documented (or to be documented even better if you ACK it)
> marker/catcher for userfaultfd_writeprotect, I can't see how you could
> consider to maintain the page fault safe against any random code
> leaving too permissive TLB entries out of sync of the more restrictive
> pte permissions as it was happening with clear_refs_write, which
> worked by luck until page_mapcount was changed to page_count.
> 
> page_count is far from optimal, but it is a feature it finally allowed
> us to notice that various code (clear_refs_write included apparently
> even after the fix) leaves stale too permissive TLB entries when it
> shouldn't.
> 
> The question is only which way you prefer to fix clear_refs_write and
> I don't think we can deviate from those 3 methods that already exist
> today. So clear_refs_write will have to pick one of those and
> currently it's not falling in the same category with mprotect even
> after the fix.
> 
> I think if clear_refs_write starts to take the mmap_write_lock and
> really start to operate like mprotect, only then we can consider to
> make userfaultfd_writeprotect also operate like mprotect.
> 
> Even then I'd hope we can at least be allowed to make it operate like
> KSM write_protect_page for len <= HPAGE_PMD_SIZE, something that
> clear_refs_write cannot do since it works in O(N) and tends to scan
> everything at once, so there would be no point to optimize not to
> defer the flush, for a process with a tiny amount of virtual memory
> mapped.
> 
> vm86 also should be fixed to fall in the same category with mprotect,
> since performance there is irrelevant.

I was hesitant to suggest the following because it isn't that straight
forward. But since you seem to be less concerned with the complexity,
I'll just bring it on the table -- it would take care of both ufd and
clear_refs_write, wouldn't it?

diff --git a/mm/memory.c b/mm/memory.c
index 5e9ca612d7d7..af38c5ee327e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4403,8 +4403,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		goto unlock;
 	}
 	if (vmf->flags & FAULT_FLAG_WRITE) {
-		if (!pte_write(entry))
+		if (!pte_write(entry)) {
+			if (mm_tlb_flush_pending(vmf->vma->vm_mm))
+				flush_tlb_page(vmf->vma, vmf->address);
 			return do_wp_page(vmf);
+		}
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
