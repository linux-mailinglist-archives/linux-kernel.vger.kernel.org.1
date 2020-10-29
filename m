Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8029F4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgJ2TYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:24:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJ2TXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C21A2AD31;
        Thu, 29 Oct 2020 19:08:07 +0000 (UTC)
Date:   Thu, 29 Oct 2020 20:08:04 +0100
From:   osalvador <osalvador@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, kbusch@kernel.org,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC][PATCH 7/9] mm/vmscan: Consider anonymous pages without swap
Message-ID: <20201029190804.GA4205@localhost.localdomain>
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
 <20201007161749.4C56D1F1@viggo.jf.intel.com>
 <20201029081454.GA30442@linux>
 <99dff0cd-2b1a-2c41-2596-eda7ecc7c160@intel.com>
 <CAHbLzkpfwsR663Kv_16kW81aZ7sLMPQp6WYbqwBBpofq3x0HNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpfwsR663Kv_16kW81aZ7sLMPQp6WYbqwBBpofq3x0HNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 08:57:32AM -0700, Yang Shi wrote:
> IMHO, we don't have to modify those two places at all. They are used
> to rebalance the anon lru active/inactive ratio even if we did not try
> to evict anon pages at all, so "total_swap_pages" is used instead of
> checking swappiness and available swap space.
> 
> The changes may result in imbalanced anon lru.

I might be missing something, so bear with me.

It is true that since we are only rebalancing the lists, we do not need to
check for swap space yet, but here we are also adding a new end-point where we
can migrate to in case of memory pressure.

So in case we can demote pages, it makes sense to proceed with the aging
and rebalancing regardless of whether we have swap in place, right?

But maybe the right procedure would be to perform some sort of the
following check in those two places:

	if (total_swap_pages || can_migrate_to_demote_node)
		- proceed_with_rebalancing_or_aging

--
Oscar Salvador
SUSE L3
