Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F6F2781DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgIYHmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgIYHmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:42:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601019738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BQlMTVpid3w3QPZKwJATozfaaStywpOD0hUm7BMi7w=;
        b=nhIX67r5/rELApLrXgmEzDHEE31IeqwoSpkckAIEk8UEIEr6ZMIX49fwkQ48IylFc9z9TK
        EZpC7jRUOSEpLammLacEIukHOVSyxHQMkuNsY6JpMhwUjaBbot/vspagWFuzViKybVSPnH
        cVbLQ9pouPs/lsMrnmS3fbYnMVrMSkU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4C46ABC4;
        Fri, 25 Sep 2020 07:42:17 +0000 (UTC)
Date:   Fri, 25 Sep 2020 09:42:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v3 1/2] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
Message-ID: <20200925074215.GA3389@dhcp22.suse.cz>
References: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
 <1600305709-2319-2-git-send-email-vijayb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600305709-2319-2-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-09-20 18:21:48, Vijay Balakrishna wrote:
> When memory is hotplug added or removed the min_free_kbytes must be
> recalculated based on what is expected by khugepaged.  Currently
> after hotplug, min_free_kbytes will be set to a lower default and higher
> default set when THP enabled is lost.  This change restores min_free_kbytes
> as expected for THP consumers.
> 
> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

I am ok with this patch. I am not sure this is worth backporting to
stable trees becasuse this is not a functional bug. Surprising behavior,
yes, but not much more than that.

Acked-by: Michal Hocko <mhocko@suse.com>

One minor comment below
[...]
> @@ -857,6 +858,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	zone_pcp_update(zone);
>  
>  	init_per_zone_wmark_min();
> +	khugepaged_min_free_kbytes_update();
>  
>  	kswapd_run(nid);
>  	kcompactd_run(nid);
> @@ -1600,6 +1602,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  
>  	init_per_zone_wmark_min();
> +	khugepaged_min_free_kbytes_update();
>  
>  	if (!populated_zone(zone)) {
>  		zone_pcp_reset(zone);

Can we move khugepaged_min_free_kbytes_update into
init_per_zone_wmark_min? If it stays external we might hit the same
problem when somebody else needs to modify min_free_kbytes. Early init
call will be likely too early for khugepaged but that shouldn't matter
AFAICS because it will call khugepaged_min_free_kbytes_update on its
own.
-- 
Michal Hocko
SUSE Labs
