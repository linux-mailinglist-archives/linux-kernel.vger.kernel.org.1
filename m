Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3599C2C6868
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgK0PCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:02:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:54808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgK0PCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:02:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606489373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v4TKnwpt34GOmnbBGpsXCxPVfzwSqU1ksAh0rwDzx+k=;
        b=AsYyALuXVEpBKUehNq+bcdmyFn/XAyfhDkDi0xWI25WqWNoJLZ1VOnWQOXvHq2TBjPJ07c
        n2286ROf/HNZRh2C+cnzPJsAp0ayf8JB/NPBcwIKHBr1HtOn4YsRVvdnXHqA95NCBBn5ey
        IsTwKBHRZTGg2tcVkkIW8czk6tSVMgw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7E48ACBF;
        Fri, 27 Nov 2020 15:02:53 +0000 (UTC)
Date:   Fri, 27 Nov 2020 16:02:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v2 3/4] mm,memory_hotplug: Add
 mhp_supports_memmap_on_memory
Message-ID: <20201127150253.GU31550@dhcp22.suse.cz>
References: <20201125112048.8211-1-osalvador@suse.de>
 <20201125112048.8211-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125112048.8211-4-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-11-20 12:20:47, Oscar Salvador wrote:
> mhp_supports_memmap_on_memory is meant to be used by the caller prior
> to hot-adding memory in order to figure out whether it can enable
> MHP_MEMMAP_ON_MEMORY or not.
> 
> Enabling MHP_MEMMAP_ON_MEMORY requires:
> 
>  - CONFIG_SPARSEMEM_VMEMMAP
>  - architecture support for altmap
>  - hot-added range spans a single memory block

It should also require a tunable (kernel parameter for now but maybe we
will need a more fine grained control later) to enable this explicitly.
Earlier discussions have pointed out that allocating vmemmap from each
section can lead to a sparse memory unsuitable for very large pages.
So I believe this should be an opt in.
 
Also is there any reason why this cannot be a preparatory patch for the
actual implementation? It would look more natural that way to me.

-- 
Michal Hocko
SUSE Labs
