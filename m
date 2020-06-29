Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290C20DE51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbgF2UYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732546AbgF2UYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:24:35 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744072067D;
        Mon, 29 Jun 2020 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593462275;
        bh=wEIaLX71dfGicqQIWZky1iByqXvab7v8PvlHmX+vmWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ow0w90ZCmyfal+adkRjsIQpW7g7XWqTq/MOUKtMTpPj6QkRvuUBvney2UMWoRZg+P
         9FT+ytQ5jYVsJE4wvynybaWOkXYN+Rvu2RcVkggJAcvQZwwdFVWX528Qco0/BAJx8z
         /ul5NvzHoiwFUAWCGITz6BO3KRpf7MJs5iB8TjoU=
Date:   Mon, 29 Jun 2020 23:24:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Su Hui <sh_def@163.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove the redundancy code
Message-ID: <20200629202429.GG1492837@kernel.org>
References: <20200629173047.GA38128@ubuntu>
 <alpine.DEB.2.22.394.2006291149040.1030250@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006291149040.1030250@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:50:15AM -0700, David Rientjes wrote:
> On Tue, 30 Jun 2020, Su Hui wrote:
> 
> > remove the redundancy code, the zone_start_pfn
> > is assigned from zone->zone_start_pfn
> > Signed-off-by: Su Hui <sh_def@163.com>
> 
> I don't think this is redundant, it's used by memory hotplug when onlining 
> new memory.

Right, it is:

$ git grep -wn init_currently_empty_zone mm/memory_hotplug.c
mm/memory_hotplug.c:697:            init_currently_empty_zone(zone, start_pfn, nr_pages);


> > ---
> >  mm/page_alloc.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3c4eb750a199..3372a8c9fbc4 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6215,8 +6215,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
> >  	if (zone_idx > pgdat->nr_zones)
> >  		pgdat->nr_zones = zone_idx;
> >  
> > -	zone->zone_start_pfn = zone_start_pfn;
> > -
> >  	mminit_dprintk(MMINIT_TRACE, "memmap_init",
> >  			"Initialising map node %d zone %lu pfns %lu -> %lu\n",
> >  			pgdat->node_id,
> 

-- 
Sincerely yours,
Mike.
