Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F290298D00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775365AbgJZMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:42:55 -0400
Received: from z5.mailgun.us ([104.130.96.5]:44188 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768636AbgJZMmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:42:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603716173; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=pAO6FzkFim7w2227Z74WQRknu64DzjlpQ5jvS3Im4M0=; b=MIFf9/2RXvbvFRdRXnlhEXRLit9HuNlc3+ye7kvmnDDOmYuv8Qf6bKhTLl+svGzj1Mr4eWyf
 VyDPlNarOWNLjuwJ+5diIvZLdJR+7yPZxPVRJ0dYMOLxt/pdWyb0tzh/TsLtQymOf/vO0dpn
 H37Qoodi3HTW2YNn9qTKJQKWv7I=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f96c43c2421c5ebfb57dbd5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 12:42:36
 GMT
Sender: zhenhuah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9358C433FF; Mon, 26 Oct 2020 12:42:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zhenhuah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85A95C433CB;
        Mon, 26 Oct 2020 12:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85A95C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zhenhuah@codeaurora.org
Date:   Mon, 26 Oct 2020 20:42:26 +0800
From:   Zhenhua Huang <zhenhuah@codeaurora.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tingwei@codeaurora.org
Subject: Re: [PATCH] mm: fix page_owner initializing issue for arm32
Message-ID: <20201026124226.GC20612@codeaurora.org>
References: <1602839640-13125-1-git-send-email-zhenhuah@codeaurora.org>
 <20201025154253.GH392079@kernel.org>
 <20201026071255.GA31027@codeaurora.org>
 <20201026093934.GD1154158@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026093934.GD1154158@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:39:34PM +0800, Mike Rapoport wrote:
> On Mon, Oct 26, 2020 at 03:12:55PM +0800, Zhenhua Huang wrote:
> > Hi Mike,
> > 
> > On Sun, Oct 25, 2020 at 11:42:53PM +0800, Mike Rapoport wrote:
> > > On Fri, Oct 16, 2020 at 05:14:00PM +0800, Zhenhua Huang wrote:
> > > > Page owner of pages used by page owner itself used is missing on
> arm32
> > > targets.
> > > > The reason is dummy_handle and failure_handle is not initialized
> > > correctly.
> > > > Buddy allocator is used to initialize these two handles. However,
> buddy
> > > > allocator is not ready when page owner calls it. This change fixed
> that
> > > by
> > > > initializing page owner after buddy initialization.
> > > > 
> > > > The working flow before and after this change are:
> > > > original logic:
> > > > 1. allocated memory for page_ext(using memblock).
> > > 
> > > Is anything that requires a memblock allocation FLATMEM?
> > > Any fundamental reason why wouldn't
> alloc_pages_exact_nid/vzalloc_node()
> > > work in this case?
> > > 
> > > It seems to me that for FLATMEM configuration we can allocate the
> > > page_ext using alloc_pages() with a fallback to vzalloc_node() and
> then
> > > we can unify lot's of page_ext code and entirely drop
> > > page_ext_init_flatmem().
> >
> > From comments in codes: "page_ext requires contiguous pages, bigger than
> > MAX_ORDER unless SPARSEMEM."
> > The size of page_ext for FLATMEM(which used pgdat) should be much larger
> than
> > the size for SPARSEMEM which used section.
> 
> Well, the vzalloc_node() fallback in alloc_page_ext() for SPARSEMEM case
> implies that using pages that are not physically contiguous should be
> fine. So, it seems to me that the comment is stale and vzalloc_node()
> would work just fine for FLATMEM case if the allocation of page_ext
> would exceed MAX_ORDER.
> 

Thanks Mike, got it. I agree with you for this point. I also haven't got why
it needs physical continuous... and haven't found detailed commit message
explained it.

> > > > 2. invoke the init callback of page_ext_ops like
> > > > page_owner(using buddy allocator).
> > > > 3. initialize buddy.
> > > > 
> > > > after this change:
> > > > 1. allocated memory for page_ext(using memblock).
> > > > 2. initialize buddy.
> > > > 3. invoke the init callback of page_ext_ops like
> > > > page_owner(using buddy allocator).
> > > > 
> > > > with the change, failure/dummy_handle can get its correct value and
> > > > page owner output for example has the one for page owner itself:
> > > > Page allocated via order 2, mask 0x6202c0(GFP_USER|__GFP_NOWARN),
> pid
> > > 1006, ts
> > > > 67278156558 ns
> > > > PFN 543776 type Unmovable Block 531 type Unmovable Flags 0x0()
> > > >  init_page_owner+0x28/0x2f8
> > > >  invoke_init_callbacks_flatmem+0x24/0x34
> > > >  start_kernel+0x33c/0x5d8
> > > >    (null)
> > > > 
> > > > Signed-off-by: Zhenhua Huang <zhenhuah@codeaurora.org>
> > > > ---
> > > >  include/linux/page_ext.h | 8 ++++++++
> > > >  init/main.c              | 2 ++
> > > >  mm/page_ext.c            | 8 +++++++-
> > > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> > > > index cfce186..aff81ba 100644
> > > > --- a/include/linux/page_ext.h
> > > > +++ b/include/linux/page_ext.h
> > > > @@ -44,8 +44,12 @@ static inline void page_ext_init_flatmem(void)
> > > >  {
> > > >  }
> > > >  extern void page_ext_init(void);
> > > > +static inline void page_ext_init_flatmem_late(void)
> > > > +{
> > > > +}
> > > >  #else
> > > >  extern void page_ext_init_flatmem(void);
> > > > +extern void page_ext_init_flatmem_late(void);
> > > >  static inline void page_ext_init(void)
> > > >  {
> > > >  }
> > > > @@ -76,6 +80,10 @@ static inline void page_ext_init(void)
> > > >  {
> > > >  }
> > > >  
> > > > +static inline void page_ext_init_flatmem_late(void)
> > > > +{
> > > > +}
> > > > +
> > > >  static inline void page_ext_init_flatmem(void)
> > > >  {
> > > >  }
> > > > diff --git a/init/main.c b/init/main.c
> > > > index 130376e..b34c475 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -818,6 +818,8 @@ static void __init mm_init(void)
> > > >  	init_debug_pagealloc();
> > > >  	report_meminit();
> > > >  	mem_init();
> > > > +	/* page_owner must be initialized after buddy is ready */
> > > > +	page_ext_init_flatmem_late();
> > > >  	kmem_cache_init();
> > > >  	kmemleak_init();
> > > >  	pgtable_init();
> > > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > > index a3616f7..373f7a1 100644
> > > > --- a/mm/page_ext.c
> > > > +++ b/mm/page_ext.c
> > > > @@ -99,6 +99,13 @@ static void __init invoke_init_callbacks(void)
> > > >  	}
> > > >  }
> > > >  
> > > > +#if !defined(CONFIG_SPARSEMEM)
> > > > +void __init page_ext_init_flatmem_late(void)
> > > > +{
> > > > +	invoke_init_callbacks();
> > > > +}
> > > > +#endif
> > > > +
> > > >  static inline struct page_ext *get_entry(void *base, unsigned long
> > > index)
> > > >  {
> > > >  	return base + page_ext_size * index;
> > > > @@ -177,7 +184,6 @@ void __init page_ext_init_flatmem(void)
> > > >  			goto fail;
> > > >  	}
> > > >  	pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > > > -	invoke_init_callbacks();
> > > >  	return;
> > > >  
> > > >  fail:
> > > > -- 
> > > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > > Forum,
> > > > a Linux Foundation Collaborative Project
> > > > 
> > > > 
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> > > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
