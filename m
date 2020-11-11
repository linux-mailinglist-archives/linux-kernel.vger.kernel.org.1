Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F752AEC46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKKIrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:47:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:58386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKIrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:47:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605084459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TbUcoHl5z9AxdFqijGPjTFtzVgBuvmu8IH2Bj4tg8Xk=;
        b=WebGNYwmHHaNeLjCPTRxNq9r9xLrGsTbQp490G6s8FsRx6Hb/vyLAQDuXFA1B1IFSt/tNJ
        8Niq9M1L0IzP0tdzACdYCFWzgvGKoPnhsRzCEQJIdvEZBxrgjzJ1YLB0O7DaQHz/0dsFpR
        uoY9W6aT+RzNpVgQAUrNKO63m2SdS10=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7F8FABD6;
        Wed, 11 Nov 2020 08:47:39 +0000 (UTC)
Date:   Wed, 11 Nov 2020 09:47:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages()
 with init_on_alloc=1 or __GFP_ZERO
Message-ID: <20201111084738.GT12240@dhcp22.suse.cz>
References: <20201110193240.25401-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110193240.25401-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-11-20 20:32:40, David Hildenbrand wrote:
> commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
> leaving the buddy via alloc_pages() and friends to be
> initialized/cleared/zeroed on allocation.
> 
> However, the same logic is currently not applied to
> alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
> with init_on_alloc=1 and init_on_free=0. Let's also properly clear
> pages on that allocation path and add support for __GFP_ZERO.

AFAIR we do not have any user for __GFP_ZERO right? Not that this is
harmful but it is better to call that explicitly because a missing
implementation would be a real problem and as such a bug fix.

I am also not sure handling init_on_free at the higher level is good.
As we have discussed recently the primary point of this feature is to
add clearing at very few well defined entry points rather than spill it over
many places. In this case the entry point for the allocator is
__isolate_free_page which removes pages from the page allocator. I
haven't checked how much this is used elsewhere but I would expect
init_on_alloc to be handled there.
-- 
Michal Hocko
SUSE Labs
