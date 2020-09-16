Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4226C8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIPTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgIPRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:54 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:48:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p15so3980943qvk.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+L39r6ejDyySARnpWF+ib/JBQg6eJuBB3G7VcL1C+mo=;
        b=muOiPYDceaxT7/vx4pl1sTEW1BluFOl76J4QSzOzK+JCRCNmEV2tX/Jiex+0zzFt+a
         X6vT6P7we60Ly/yxCXCRNUHX71sSPdfQRMAr7aKo0oTn8GzkpR5gprF2VmK4mx0V/oL3
         l21Yejte/8+5kAtuRZbvuOQf1mR/FiTFEorB+xh/ev+rXB4/D0QjhpLxbv4qvSgjuAnh
         Bs1pQGPbfi+8+P6caNvxWrwYlca6+6jDs9Par1gScZeu9sd00RLJiuPJ8FvWsZrVqih2
         T7rdmPwefAn3V7AX1jh2YBnKtammzvKn+l7JcCeZdSkRONzApN0KD4rx7gmfxJ7BwV5y
         Ynrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+L39r6ejDyySARnpWF+ib/JBQg6eJuBB3G7VcL1C+mo=;
        b=k5I/LfQzO+/HXPthCAObZPo15iIzvIL1a2xZMslB7olXZdtccG+e7XOISYRiySKmh/
         /AxAd1HBk0iEnxV6MmMaSl4W+JxVSTkB5py1WCkLm/HHCCWg74wuSP9zbadDhIHrM+UC
         ebyn5uMR31lLMTSHmHKNNGZWYjw3uABmIc6ZBEA+496Lhmu5EBqb1ewahqN69zjjE3ID
         TQIxg/TL+N3IYAYQ5KsvtDxaDed8uxbR3NDh9+4eUUqqDBc9imYEDD5OCG96Vp5a9HQP
         j04rthadcdYZeOkwHDdsO39IO+DB5mZfLKsjfhsoNy6vVOkcrh02z+jBkvXQZeybhak1
         HbBA==
X-Gm-Message-State: AOAM533Zt59osaV4g4DBLTpb6yoglQlq4GNYU0GsUzQlpaT30qkVbnGm
        UNWHk0tSx4GBpAVWYYRKna4IHw==
X-Google-Smtp-Source: ABdhPJy4BGwzITw0CZlaZiow9SX1MOVFbkSfKL6nYwhmUtNfg9HcPuRPb8UJzZN4QIFQfwvSMNHMvw==
X-Received: by 2002:a0c:b396:: with SMTP id t22mr11497898qve.13.1600278486067;
        Wed, 16 Sep 2020 10:48:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a52sm20058340qtc.22.2020.09.16.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:48:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIbXI-000An2-D4; Wed, 16 Sep 2020 14:48:04 -0300
Date:   Wed, 16 Sep 2020 14:48:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>,
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
Message-ID: <20200916174804.GC8409@ziepe.ca>
References: <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:50:46PM -0700, John Hubbard wrote:
> > 
> > It seems very strange that a physical page exclusively owned by a
> > process can become copied if pin_user_pages() is active and the
> > process did fork() at some point.
> > 
> > Could the new pin_user_pages() logic help here? eg the
> > GUP_PIN_COUNTING_BIAS stuff?
> > 
> > Could the COW code consider a refcount of GUP_PIN_COUNTING_BIAS + 1 as
> > being owned by the current mm and not needing COW? The DMA pin would
> > be 'invisible' for COW purposes?
> 
> 
> Please do be careful to use the API, rather than the implementation. The
> FOLL_PIN refcounting system results in being able to get a "maybe
> DMA-pinned", or a "definitely not DMA-pinned", via this API call:

So, what I'm thinking is something like (untested):

diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76e1..77f63183667e52 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2889,6 +2889,26 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	return ret;
 }
 
+static bool cow_needed(struct vm_fault *vmf)
+{
+	int total_map_swapcount;
+
+	if (!reuse_swap_page(vmf->page, &total_map_swapcount)) {
+		unlock_page(vmf->page);
+		return true;
+	}
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
@@ -2947,8 +2967,21 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		if (!trylock_page(page))
 			goto copy;
 		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
+			bool cow = true;
+
+			/*
+			 * If the page is DMA pinned we can't rely on the
+			 * above to know if there are other CPU references as
+			 * page_count() will be elevated by the
+			 * pin. Needlessly copying the page will cause the DMA
+			 * pin to break, try harder to avoid that.
+			 */
+			if (page_maybe_dma_pinned(page))
+				cow = cow_needed(vmf);
+
 			unlock_page(page);
-			goto copy;
+			if (cow)
+				goto copy;
 		}
 		/*
 		 * Ok, we've got the only map reference, and the only

What do you think Peter? Is this remotely close?

Seems like it preserves the fast path in most cases, the page_count &
page_maybe_dma_pinned could be further optimized down to one atomic in
non huge page cases.

Jason
