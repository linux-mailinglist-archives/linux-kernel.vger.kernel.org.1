Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB182D999C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439925AbgLNOSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:18:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:37890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439156AbgLNOSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:18:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607955437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/aaX1gWpPQn3qcwwnBwjlwFxHCcIQKKOnugT2MXEnQY=;
        b=JnWU55ELyZ1I/pYFi0DUWGkuuIomcSV7Ud/2hlzpn/6AsXg4hGG78gZPiDej8YkJ22gHUY
        P7TILbaB5pfqzoHXn4fAyYz5RrPJvrAI2JZEhQ1IzLCP+N98sgfIWovkV8iNzfmlFQ8PuG
        GOll1wMpJGgvxZ4aSC90SuOe695TgDM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBA21AC10;
        Mon, 14 Dec 2020 14:17:16 +0000 (UTC)
Date:   Mon, 14 Dec 2020 15:17:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mm: honor PF_MEMALLOC_PIN for all movable pages
Message-ID: <20201214141715.GF32193@dhcp22.suse.cz>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211202140.396852-5-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-12-20 15:21:38, Pavel Tatashin wrote:
[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c2dea9ad0e98..4d8e7f801c66 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3802,16 +3802,12 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>  	return alloc_flags;
>  }
>  
> -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> -					unsigned int alloc_flags)
> +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
> +					   unsigned int alloc_flags)

Do you have any strong reason to rename? Even though the current
implementation only does something for cma I do not think this is all
that important. The naming nicely fits with current_gfp_context so I
would stick with it.

Other than that the patch looks reasonable. I would just add a comment
explaining that current_alloc_flags should be called _after_
current_gfp_context because that one might change the gfp_mask.

With that addressed, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
