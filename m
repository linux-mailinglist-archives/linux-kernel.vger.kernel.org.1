Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4327824345D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMHHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 03:07:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgHMHHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:07:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D1B2B17C;
        Thu, 13 Aug 2020 07:08:13 +0000 (UTC)
Date:   Thu, 13 Aug 2020 09:07:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: fix core hung in free_pcppages_bulk()
Message-ID: <20200813070744.GB9477@dhcp22.suse.cz>
References: <1597075833-16736-1-git-send-email-charante@codeaurora.org>
 <3b07d2a6-8ce7-5957-8ca5-a8d977852e14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b07d2a6-8ce7-5957-8ca5-a8d977852e14@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-08-20 10:29:24, David Hildenbrand wrote:
[...]
> I was wondering if we should rather set all pageblocks to
> MIGRATE_ISOLATE in online_pages() before doing the online_pages_range()
> call, and do undo_isolate_page_range() after onlining is done.
> 
> move_pfn_range_to_zone()->memmap_init_zone() marks all pageblocks
> MIGRATE_MOVABLE, and as that function is used also during boot, we could
> supply a parameter to configure this.
> 
> This would prevent another race from happening: Having pages exposed to
> the buddy ready for allocation in online_pages_range() before the
> sections are marked online.
> 
> This would avoid any pages from getting allocated before we're
> completely done onlining.

This sounds like a reasonable idea to me.

> We would need MIGRATE_ISOLATE/CONFIG_MEMORY_ISOLATION also for
> CONFIG_MEMORY_HOTPLUG.

We already do depend on the memory isolation in the hotremove. Doing the
same for hotplug in general makes sense as well.

Thanks!
-- 
Michal Hocko
SUSE Labs
