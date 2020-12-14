Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A352D99B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440061AbgLNOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:21:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:40690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440043AbgLNOUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:20:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607955588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFr8Ms8n+yMf7TCzVCFHWfW+5sl9l5Yvwxnekv/jl7Y=;
        b=WnpWdyxmNE4MGmYVbWl7dKtXCjSK0mK70qY9mJLamnHb+5QT/+TYnnXvZnI2Av4IXZt4cu
        E81FE2DyBCKbCtfh+wy8TxCwWtqjF4nA10rhncFEWiwlFFB7TbBjQOuYiCooK0mQWt5AfN
        7tfZBVX/MKPmmpsIFZHcMpx3e7AuFE8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4570AC10;
        Mon, 14 Dec 2020 14:19:47 +0000 (UTC)
Date:   Mon, 14 Dec 2020 15:19:46 +0100
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
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201214141946.GG32193@dhcp22.suse.cz>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211202140.396852-6-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-12-20 15:21:39, Pavel Tatashin wrote:
[...]
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b593316bff3d..25c0c13ba4b1 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -386,9 +386,14 @@ enum zone_type {
>  	 * likely to succeed, and to locally limit unmovable allocations - e.g.,
>  	 * to increase the number of THP/huge pages. Notable special cases are:
>  	 *
> -	 * 1. Pinned pages: (long-term) pinning of movable pages might
> -	 *    essentially turn such pages unmovable. Memory offlining might
> -	 *    retry a long time.
> +	 * 1. Pinned pages: (long-term) pinning of movable pages is avoided
> +	 *    when pages are pinned and faulted, but it is still possible that
> +	 *    address space already has pages in ZONE_MOVABLE at the time when
> +	 *    pages are pinned (i.e. user has touches that memory before
> +	 *    pinning). In such case we try to migrate them to a different zone,
> +	 *    but if migration fails the pages can still end-up pinned in
> +	 *    ZONE_MOVABLE. In such case, memory offlining might retry a long
> +	 *    time and will only succeed once user application unpins pages.

I do agree with others in the thread. This is not really helping out the
current situation much. You should simply fail the pin rather than
pretend all is just fine.
-- 
Michal Hocko
SUSE Labs
