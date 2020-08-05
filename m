Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8A23D3AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 23:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHEVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHEVt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:49:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A80C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:49:58 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id df16so17294983edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJ9PmFgHy+mjnk3jwf45tHLYYDcmg6ohwuwx1D1TvHM=;
        b=CJwQDpWVKAL+0tGtjAO+XWAFvRzU9QTjUClssnaocAIa6TcBKK4/vVSgBeczWa/SCD
         MO3rI4WJu20SYZnOcfyTwBjk8ngCL+Ku8SYOGfAxaMbIW5zzqgqyUFGhLVdRfaJWZjxZ
         6EHN4yMaXHLR3ehvhbVqeqF3zZWEBFkopyGUXz8ks0I0t5wMTjLFEs2q1eFVvcmw/qB+
         zrD/75c9AwmuO40JCASBKEDw9TARMy5GsbgzoDMX/AZun95JK+QWcjRZ9JOzE0610dPn
         qBGvqwU5Hmp5M7LktaNOjhJSUaCYvvZPRGC375QEUCTa9okEtjggNmv3ODGqHfT/CoVL
         fsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJ9PmFgHy+mjnk3jwf45tHLYYDcmg6ohwuwx1D1TvHM=;
        b=qBpujILTeIjFN3NW9kLrAkTStVrQAHLDoVhorivsfwXdBQaArsigayL+gQ6Eocjf3j
         mlISuYSUvs/r9GBUnf1RBNqYmsE4bFrvyhr/MTecIEAoemXe3yY+v/B4QopV6aLxsY24
         QbWcirxskLu0hgkz3VxLkQRdCpZMRO3guVZEiYcblcXNyvRF79tZX96AKWdStxun55nw
         HgwM8v6PTPjnrAlk0zWUxTHDC8f2Tvlnfg6F3CrG8aqYWMbf668NVYqBSCS1z8GxdpYt
         6Vc9ilCWDwWw8gHHC38rvc1ToPVrhd7CIK3CDzC0MKWmZRk2hzcpn+C2jG59gI/EzxCD
         h92w==
X-Gm-Message-State: AOAM533LlcoXtKevYG9cP5BKbfTzmXsiCwr2GW7Tq8fMCvE/K5j7XIBx
        laRfgoDRFufc1Bw436sxYC+c0jbf
X-Google-Smtp-Source: ABdhPJz5r8QPoURKmAsVxCLJTnRnz1Ap5frEF0F7Vnx3oFTkXmayzOykaYWbVMWiacVt4lI2dYI0yg==
X-Received: by 2002:a50:a2e6:: with SMTP id 93mr1198873edm.147.1596664196721;
        Wed, 05 Aug 2020 14:49:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gl20sm2345174ejb.86.2020.08.05.14.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 14:49:56 -0700 (PDT)
Date:   Wed, 5 Aug 2020 21:49:55 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [Patch v2] mm/sparse: only sub-section aligned range would be
 populated
Message-ID: <20200805214955.ds7y3nwjoz2ms37h@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200703031828.14645-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703031828.14645-1-richard.weiyang@linux.alibaba.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:18:28AM +0800, Wei Yang wrote:
>There are two code path which invoke __populate_section_memmap()
>
>  * sparse_init_nid()
>  * sparse_add_section()
>
>For both case, we are sure the memory range is sub-section aligned.
>
>  * we pass PAGES_PER_SECTION to sparse_init_nid()
>  * we check range by check_pfn_span() before calling
>    sparse_add_section()
>
>Also, the counterpart of __populate_section_memmap(), we don't do such
>calculation and check since the range is checked by check_pfn_span() in
>__remove_pages().
>
>Clear the calculation and check to keep it simple and comply with its
>counterpart.
>
>Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>

Hi, Andrew,

Is this one picked up?

>---
>v2:
>  * add a warn on once for unaligned range, suggested by David
>---
> mm/sparse-vmemmap.c | 20 ++++++--------------
> 1 file changed, 6 insertions(+), 14 deletions(-)
>
>diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>index 0db7738d76e9..8d3a1b6287c5 100644
>--- a/mm/sparse-vmemmap.c
>+++ b/mm/sparse-vmemmap.c
>@@ -247,20 +247,12 @@ int __meminit vmemmap_populate_basepages(unsigned long start,
> struct page * __meminit __populate_section_memmap(unsigned long pfn,
> 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> {
>-	unsigned long start;
>-	unsigned long end;
>-
>-	/*
>-	 * The minimum granularity of memmap extensions is
>-	 * PAGES_PER_SUBSECTION as allocations are tracked in the
>-	 * 'subsection_map' bitmap of the section.
>-	 */
>-	end = ALIGN(pfn + nr_pages, PAGES_PER_SUBSECTION);
>-	pfn &= PAGE_SUBSECTION_MASK;
>-	nr_pages = end - pfn;
>-
>-	start = (unsigned long) pfn_to_page(pfn);
>-	end = start + nr_pages * sizeof(struct page);
>+	unsigned long start = (unsigned long) pfn_to_page(pfn);
>+	unsigned long end = start + nr_pages * sizeof(struct page);
>+
>+	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
>+		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
>+		return NULL;
> 
> 	if (vmemmap_populate(start, end, nid, altmap))
> 		return NULL;
>-- 
>2.20.1 (Apple Git-117)

-- 
Wei Yang
Help you, Help me
