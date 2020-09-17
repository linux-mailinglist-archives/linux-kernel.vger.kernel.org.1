Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86F26DA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIQL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgIQLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:25:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:25:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w186so1806437qkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TmuOAuPqFkLEUVE/VOD7wN6NrUglI5pWEI0/RzoOeAM=;
        b=amcXrLuQydF5s2mbCGVXNJVE5jL/3upTVVlK/vaqWWqAAWxHo4fWaelHnE4tELsn0B
         iduI7ukYFh+mfEbYMMDH4FWyOT3yjlOjenKlY9QMCqvvM5nToAops7w513DcVJuI89re
         VUd+0tjKCbJln+UdJLB96z1IHgmBu8p/+autHL/H/j94cb/i1lCNIw7BcQIB9K2rPTeb
         GH1fFt7IJuJbztqAk8wj1UmC8gqcGb9QosOSc8M/ezYkBP80R3kJ1JfrZkX8CFYAJbWa
         xwpz+Lqx2918BxcobFmZQdrR1MZxzfF44xk0Sb3ozAl+J9jze3ptUMaQCYUfoBcJbdbG
         3mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TmuOAuPqFkLEUVE/VOD7wN6NrUglI5pWEI0/RzoOeAM=;
        b=E3v5QQmWcq+Zp61/Vf8DYUfff32B81mCPzWoK6w8M0l3QsWEdc9adQP2rQdtkMaC44
         9juIj95dnfQVcgqs5H2lIkfI1ZDxpExY/AeH01h1hXcntis6EMzFA1a31UuEDbI4uAS9
         1EA4z5ZEWbXTpqGEBJEqcF4w1aEtgk1t8dFXECboVrfhi9EhligTDEaHM8VgjN676umM
         8A/+WwfYwkySmY/xmMJ/7XPC8WI9KSdSo8U5jNMoTGJXJbVPO0U/RawMGzA3Ee+e3Sdn
         b8dL/Yn/x4O+BOqSuKDpu+IU1c/emWYgZB+qK0ot+OGNmcF4YcMG+U0vCdVzoWgEq/QF
         JbPg==
X-Gm-Message-State: AOAM532A/2xPhVueUoKriswg2SWJPFivAonc2R/TbJvH8UzcN5N+c0IL
        ozwM6UfMcv7IUwKpv4ZdHJuw8g==
X-Google-Smtp-Source: ABdhPJyw+KpoZK0nQOrMdZBZkFTnHb1J6OElAkAlLCNP/cbsBRptilj/xyi8WRz+n/QZKtCz+oUbFQ==
X-Received: by 2002:a05:620a:20db:: with SMTP id f27mr28964306qka.11.1600341940464;
        Thu, 17 Sep 2020 04:25:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n1sm1367610qte.91.2020.09.17.04.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:25:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIs2k-000Q09-QL; Thu, 17 Sep 2020 08:25:38 -0300
Date:   Thu, 17 Sep 2020 08:25:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200917112538.GD8409@ziepe.ca>
References: <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916184619.GB40154@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:46:19PM -0400, Peter Xu wrote:

> My understanding is this may only work for the case when the fork()ed child
> quitted before we reach here (so we still have mapcount==1 for the
> page).  

Yes

> What if not?  Then mapcount will be greater than 1, and cow will
> still trigger.  Is that what we want?

That doesn't work today anyhow, so it is fine continuing to be broken.

> Another problem is that, aiui, one of the major change previous patch proposed
> is to avoid using lock_page() so that we never block in this path.

I saw you mention this before, but it looks like the change was to
lift some of the atomc_reads out of the lock and avoid the lock if
they indicate failure, checking also for page_maybe_dma_pinned()
outside the lock just means the rare case of FOLL_PIN we will take the
lock again.

> Maybe even more complicated, because "correctness" should be even harder
> than "best effort reuse" since it can cause data corruption if we didn't do it
> right...

The only correct way is for the application to avoid write protect on
FOLL_PIN pages. The purpose here is to allow applications that hadn't
hit "bad luck" and failed to keep working.

Another thought is to insert a warning print here as well that the
program is working improperly? At least it would give a transition
period to evaluate the extent of the problem.

We are thinking it is going to be a notable regression.

I botched the last version of the patch, here is something a bit
better.

Does it seem like it could be OK? I know very little about this part
of the kernel

Thanks,
Jason

diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76e1..332de777854f8b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2889,6 +2889,24 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	return ret;
 }
 
+static bool cow_needed(struct vm_fault *vmf)
+{
+	int total_map_swapcount;
+
+	if (!reuse_swap_page(vmf->page, &total_map_swapcount))
+		return true;
+
+	if (total_map_swapcount == 1) {
+		/*
+		 * The page is all ours. Move it to our anon_vma so the rmap
+		 * code will not search our parent or siblings.  Protected
+		 * against the rmap code by the page lock.
+		 */
+		page_move_anon_rmap(vmf->page, vmf->vma);
+	}
+	return false;
+}
+
 /*
  * This routine handles present pages, when users try to write
  * to a shared page. It is done by copying the page to a new address
@@ -2942,13 +2960,27 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		struct page *page = vmf->page;
 
 		/* PageKsm() doesn't necessarily raise the page refcount */
-		if (PageKsm(page) || page_count(page) != 1)
+		if (PageKsm(page))
 			goto copy;
+		if (page_count(page) != 1) {
+			/*
+			 * If the page is DMA pinned we can't rely on the
+			 * above to know if there are other CPU references as
+			 * page_count() will be elevated by the
+			 * pin. Needlessly copying the page will cause the DMA
+			 * pin to break, try harder to avoid that.
+			 */
+			if (!page_maybe_dma_pinned(page))
+				goto copy;
+		}
+
 		if (!trylock_page(page))
 			goto copy;
 		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
-			unlock_page(page);
-			goto copy;
+			if (cow_needed(vmf)) {
+				unlock_page(page);
+				goto copy;
+			}
 		}
 		/*
 		 * Ok, we've got the only map reference, and the only
