Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78EC274237
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIVMkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgIVMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600778430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCwb20Zryd5MlARC7p8Jh2egknNY4Ft0sPtKupQI2Kc=;
        b=OkPILA0sVY85d1ffNIcOBVhTlvsXrPbpNG26GeIrZd/COCmJJVCaC/eDmgefvXardeZGWI
        wiGy900S+mgCL9zQPWkYi9xxGlLeOxMSr9m9SFVB7UZ64knrD9surGmjgiJI4fg7lmBdum
        V7513tLRecacKEUcxEfoWGVDxkei/Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-pGtAWvL0PgqF7h8gbtnUGw-1; Tue, 22 Sep 2020 08:40:26 -0400
X-MC-Unique: pGtAWvL0PgqF7h8gbtnUGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C36AA1084D6D;
        Tue, 22 Sep 2020 12:40:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id EF5DB5DD99;
        Tue, 22 Sep 2020 12:40:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Sep 2020 14:40:24 +0200 (CEST)
Date:   Tue, 22 Sep 2020 14:40:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
Message-ID: <20200922124013.GD11679@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922114839.GC11679@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22, Oleg Nesterov wrote:
>
> On 09/21, Peter Xu wrote:
> >
> > @@ -859,6 +989,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> >  				break;
> >  		}
> > +
> > +		if (unlikely(data.cow_new_page)) {
> > +			/*
> > +			 * If cow_new_page set, we must be at the 2nd round of
> > +			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> > +			 * page now.  Note that in all cases page_break_cow()
> > +			 * will properly release the objects in copy_mm_data.
> > +			 */
> > +			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> > +			if (pte_install_copied_page(dst_mm, new, src_pte,
> > +						    dst_pte, addr, rss,
> > +						    &data)) {
> > +				/* We installed the pte successfully; move on */
> > +				progress++;
> > +				continue;
>
> I'm afraid I misread this patch too ;)
>
> But it seems to me in this case the main loop can really "leak"
> COPY_MM_BREAK_COW. Suppose the the next 31 pte's are pte_none() and
> need_resched() is true.
>
> No?

If yes, perhaps we can simplify the copy_ret/cow_new_page logic and make
it more explicit?

Something like below, on top of this patch...

Oleg.


--- x/mm/memory.c
+++ x/mm/memory.c
@@ -704,17 +704,6 @@
 	};
 };
 
-static inline void page_release_cow(struct copy_mm_data *data)
-{
-	/* The old page should only be released in page_duplicate() */
-	WARN_ON_ONCE(data->cow_old_page);
-
-	if (data->cow_new_page) {
-		put_page(data->cow_new_page);
-		data->cow_new_page = NULL;
-	}
-}
-
 /*
  * Duplicate the page for this PTE.  Returns zero if page copied (so we need to
  * retry on the same PTE again to arm the copied page very soon), or negative
@@ -925,7 +914,7 @@
 
 	if (!pte_same(*src_pte, data->cow_oldpte)) {
 		/* PTE has changed under us.  Release the page and retry */
-		page_release_cow(data);
+		put_page(data->cow_new_page);
 		return false;
 	}
 
@@ -936,12 +925,6 @@
 	set_pte_at(dst_mm, addr, dst_pte, entry);
 	rss[mm_counter(new_page)]++;
 
-	/*
-	 * Manually clear the new page pointer since we've moved ownership to
-	 * the newly armed PTE.
-	 */
-	data->cow_new_page = NULL;
-
 	return true;
 }
 
@@ -958,16 +941,12 @@
 	struct copy_mm_data data;
 
 again:
-	/* We don't reset this for COPY_MM_BREAK_COW */
-	memset(&data, 0, sizeof(data));
-
-again_break_cow:
 	init_rss_vec(rss);
 
 	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
 	if (!dst_pte) {
-		/* Guarantee that the new page is released if there is */
-		page_release_cow(&data);
+		if (unlikely(copy_ret == COPY_MM_BREAK_COW))
+			put_page(data.cow_new_page);
 		return -ENOMEM;
 	}
 	src_pte = pte_offset_map(src_pmd, addr);
@@ -978,6 +957,22 @@
 	arch_enter_lazy_mmu_mode();
 
 	progress = 0;
+	if (unlikely(copy_ret == COPY_MM_BREAK_COW)) {
+		/*
+		 * Note that in all cases pte_install_copied_page()
+		 * will properly release the objects in copy_mm_data.
+		 */
+		copy_ret = COPY_MM_DONE;
+		if (pte_install_copied_page(dst_mm, new, src_pte,
+					    dst_pte, addr, rss,
+					    &data)) {
+			/* We installed the pte successfully; move on */
+			progress++;
+			goto next;
+		}
+		/* PTE changed.  Retry this pte (falls through) */
+	}
+
 	do {
 		/*
 		 * We are holding two locks at this point - either of them
@@ -990,24 +985,6 @@
 				break;
 		}
 
-		if (unlikely(data.cow_new_page)) {
-			/*
-			 * If cow_new_page set, we must be at the 2nd round of
-			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
-			 * page now.  Note that in all cases page_break_cow()
-			 * will properly release the objects in copy_mm_data.
-			 */
-			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
-			if (pte_install_copied_page(dst_mm, new, src_pte,
-						    dst_pte, addr, rss,
-						    &data)) {
-				/* We installed the pte successfully; move on */
-				progress++;
-				continue;
-			}
-			/* PTE changed.  Retry this pte (falls through) */
-		}
-
 		if (pte_none(*src_pte)) {
 			progress++;
 			continue;
@@ -1017,6 +994,7 @@
 		if (copy_ret != COPY_MM_DONE)
 			break;
 		progress += 8;
+next:
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
 	arch_leave_lazy_mmu_mode();
@@ -1030,13 +1008,14 @@
 	case COPY_MM_SWAP_CONT:
 		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
 			return -ENOMEM;
-		break;
+		copy_ret = COPY_MM_DONE;
+		goto again;
 	case COPY_MM_BREAK_COW:
 		/* Do accounting onto parent mm directly */
 		ret = page_duplicate(src_mm, vma, addr, &data);
 		if (ret)
 			return ret;
-		goto again_break_cow;
+		goto again;
 	case COPY_MM_DONE:
 		/* This means we're all good. */
 		break;

