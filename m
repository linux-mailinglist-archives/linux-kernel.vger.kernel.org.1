Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB62925FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgJSKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:41:32 -0400
Received: from z5.mailgun.us ([104.130.96.5]:14739 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgJSKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:41:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603104090; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Qkqt1NTqT3YyTG096XE22aznURqgKsP5d3KKo8LH41w=; b=LmlWDodZLPQDASw17HNKUhAahFz8giV1zUwVCM+E+E/6C3WMZyJ6NElZw23ibJ5RAOmH5fSB
 I9VD/EJSqRlEbe2lPTiwtHsjRl1vJCULbY1Vqg95MEMaHhg1SFR1VS4gomOY3ebxuw8RW37v
 Xyn1nL+zGiw5zFLB9/SKuAAJnzI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f8d6d59d63768e57b5ac75d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Oct 2020 10:41:29
 GMT
Sender: zhenhuah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C8FDC433F1; Mon, 19 Oct 2020 10:41:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zhenhuah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FA08C433FF;
        Mon, 19 Oct 2020 10:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FA08C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zhenhuah@codeaurora.org
Date:   Mon, 19 Oct 2020 18:39:19 +0800
From:   Zhenhua Huang <zhenhuah@codeaurora.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix page_owner initializing issue for arm32
Message-ID: <20201019103919.GA29278@codeaurora.org>
References: <1602839640-13125-1-git-send-email-zhenhuah@codeaurora.org>
 <1a1a80b8-2ce4-9346-f333-68f3bb8b25c0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1a80b8-2ce4-9346-f333-68f3bb8b25c0@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Oct 16, 2020 at 06:41:04PM +0800, Vlastimil Babka wrote:
> On 10/16/20 11:14 AM, Zhenhua Huang wrote:
> >Page owner of pages used by page owner itself used is missing on arm32
> >targets.
> >The reason is dummy_handle and failure_handle is not initialized
> >correctly.
> >Buddy allocator is used to initialize these two handles. However, buddy
> >allocator is not ready when page owner calls it. This change fixed that by
> >initializing page owner after buddy initialization.
> >
> >The working flow before and after this change are:
> >original logic:
> >1. allocated memory for page_ext(using memblock).
> >2. invoke the init callback of page_ext_ops like
> >page_owner(using buddy allocator).
> >3. initialize buddy.
> >
> >after this change:
> >1. allocated memory for page_ext(using memblock).
> >2. initialize buddy.
> >3. invoke the init callback of page_ext_ops like
> >page_owner(using buddy allocator).
> >
> >with the change, failure/dummy_handle can get its correct value and
> >page owner output for example has the one for page owner itself:
> >Page allocated via order 2, mask 0x6202c0(GFP_USER|__GFP_NOWARN), pid
> >1006, ts
> >67278156558 ns
> >PFN 543776 type Unmovable Block 531 type Unmovable Flags 0x0()
> >  init_page_owner+0x28/0x2f8
> >  invoke_init_callbacks_flatmem+0x24/0x34
> >  start_kernel+0x33c/0x5d8
> >    (null)
> 
> register_dummy_stack should also appear in the above. Either one too many is
> skipped in arm32 stack saving, or the noinline is not honoured. Could be
> investigated separately.
> 
yes, it's another issue I need to investigate. Be noted, the printing is from
4.9 kernel and I will look into separately.
> >
> >Signed-off-by: Zhenhua Huang <zhenhuah@codeaurora.org>
> 
> This should be safe, as the sparse variant page_ext_init() runs even later,
> so:
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit below:
> 
> >---
> >  include/linux/page_ext.h | 8 ++++++++
> >  init/main.c              | 2 ++
> >  mm/page_ext.c            | 8 +++++++-
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> >diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> >index cfce186..aff81ba 100644
> >--- a/include/linux/page_ext.h
> >+++ b/include/linux/page_ext.h
> >@@ -44,8 +44,12 @@ static inline void page_ext_init_flatmem(void)
> >  {
> >  }
> >  extern void page_ext_init(void);
> >+static inline void page_ext_init_flatmem_late(void)
> >+{
> >+}
> >  #else
> >  extern void page_ext_init_flatmem(void);
> >+extern void page_ext_init_flatmem_late(void);
> >  static inline void page_ext_init(void)
> >  {
> >  }
> >@@ -76,6 +80,10 @@ static inline void page_ext_init(void)
> >  {
> >  }
> >
> >+static inline void page_ext_init_flatmem_late(void)
> >+{
> >+}
> >+
> >  static inline void page_ext_init_flatmem(void)
> >  {
> >  }
> >diff --git a/init/main.c b/init/main.c
> >index 130376e..b34c475 100644
> >--- a/init/main.c
> >+++ b/init/main.c
> >@@ -818,6 +818,8 @@ static void __init mm_init(void)
> >  	init_debug_pagealloc();
> >  	report_meminit();
> >  	mem_init();
> >+	/* page_owner must be initialized after buddy is ready */
> >+	page_ext_init_flatmem_late();
> >  	kmem_cache_init();
> >  	kmemleak_init();
> >  	pgtable_init();
> >diff --git a/mm/page_ext.c b/mm/page_ext.c
> >index a3616f7..373f7a1 100644
> >--- a/mm/page_ext.c
> >+++ b/mm/page_ext.c
> >@@ -99,6 +99,13 @@ static void __init invoke_init_callbacks(void)
> >  	}
> >  }
> >
> >+#if !defined(CONFIG_SPARSEMEM)
> 
> #ifndef is more common if you don't need boolean ops on multiple configs
> 
Thanks, I'll do the change in patchset v2
> >+void __init page_ext_init_flatmem_late(void)
> >+{
> >+	invoke_init_callbacks();
> >+}
> >+#endif
> >+
> >  static inline struct page_ext *get_entry(void *base, unsigned long
> >index)
> >  {
> >  	return base + page_ext_size * index;
> >@@ -177,7 +184,6 @@ void __init page_ext_init_flatmem(void)
> >  			goto fail;
> >  	}
> >  	pr_info("allocated %ld bytes of page_ext\n", total_usage);
> >-	invoke_init_callbacks();
> >  	return;
> >
> >  fail:
> >
> 
> 
