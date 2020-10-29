Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD029E61C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgJ2IPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:15:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgJ2IPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:15:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC305ABF5;
        Thu, 29 Oct 2020 08:15:02 +0000 (UTC)
Date:   Thu, 29 Oct 2020 09:14:59 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, vishal.l.verma@intel.com,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [RFC][PATCH 7/9] mm/vmscan: Consider anonymous pages without swap
Message-ID: <20201029081454.GA30442@linux>
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
 <20201007161749.4C56D1F1@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007161749.4C56D1F1@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:17:49AM -0700, Dave Hansen wrote:
> 
> From: Keith Busch <kbusch@kernel.org>
> 
> Age and reclaim anonymous pages if a migration path is available. The
> node has other recourses for inactive anonymous pages beyond swap,
> 
> #Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> [vishal: fixup the migration->demotion rename]
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>

I have a question regarding this one.

It seems that we do have places where we read total_swap_pages directly and other
places where we use get_nr_swap_pages.
One seems to give the total number of swap pages, while the other gives 
the number of free swap pages.

With this patch, we will use always the atomic version get_nr_swap_pages from
now on.
Is that ok? I guess so, but it might warrant a mention in the changelog?

E.g: age_active_anon seems to base one of its decisions on whether we have
swap (it seems it does not care if swap space is available).

-- 
Oscar Salvador
SUSE L3
