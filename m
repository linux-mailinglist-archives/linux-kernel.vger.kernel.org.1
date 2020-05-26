Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABCF1AE7FB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgDQWMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 18:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgDQWMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:12:48 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC87120B1F;
        Fri, 17 Apr 2020 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587161568;
        bh=ON4JdnnSp41GHtVfQ1OKELVDXoHAdZJmnEWPX+XFdCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDWhqyB/IlZyphu6jsbA1XfIALDH+nOe4HMk0CDTKJ7edRKniwEH2Cq+6D/wK2Gtl
         LEi7bg2GM4iBlFWRMCs4hLDij8zeCyTpVgDxl8AmR4nH1dTgIso263RiE9OJ6J4j6z
         gAz6SYiK4GGU1A0Frqsr7AiKouEeUxj1Au0TBSAk=
Date:   Fri, 17 Apr 2020 15:12:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2] mm/page_alloc: fix watchdog soft lockups during
 set_zone_contiguous()
Message-Id: <20200417151247.0068d5aa3f026ced2289ce31@linux-foundation.org>
In-Reply-To: <20200416073417.5003-1-david@redhat.com>
References: <20200416073417.5003-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 09:34:17 +0200 David Hildenbrand <david@redhat.com> wrote:

> Without CONFIG_PREEMPT, it can happen that we get soft lockups detected,
> e.g., while booting up.
> 
> ...
> 
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1607,6 +1607,7 @@ void set_zone_contiguous(struct zone *zone)
>  		if (!__pageblock_pfn_to_page(block_start_pfn,
>  					     block_end_pfn, zone))
>  			return;
> +		cond_resched();
>  	}
>  
>  	/* We confirm that there is no hole */

I added cc:stable to this one.  Please let me know if that wasn't a
good idea.

