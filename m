Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59862295EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507016AbgJVMof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:44:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506291AbgJVMof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:44:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55E2EAC3F;
        Thu, 22 Oct 2020 12:44:34 +0000 (UTC)
Date:   Thu, 22 Oct 2020 14:44:32 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 6/7] mm, page_alloc: move draining pcplists to page
 isolation users
Message-ID: <20201022124431.GD26121@linux>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008114201.18824-7-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 01:42:00PM +0200, Vlastimil Babka wrote:
> Currently, pcplists are drained during set_migratetype_isolate() which means
> once per pageblock processed start_isolate_page_range(). This is somewhat
> wasteful. Moreover, the callers might need different guarantees, and the
> draining is currently prone to races and does not guarantee that no page
> from isolated pageblock will end up on the pcplist after the drain.
> 
> Better guarantees are added by later patches and require explicit actions
> by page isolation users that need them. Thus it makes sense to move the
> current imperfect draining to the callers also as a preparation step.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
