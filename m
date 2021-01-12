Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015502F2D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbhALKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:49:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:50116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbhALKtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:49:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77524AD18;
        Tue, 12 Jan 2021 10:48:25 +0000 (UTC)
Date:   Tue, 12 Jan 2021 11:48:23 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
Message-ID: <20210112104817.GA12956@linux>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
 <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:53:17AM +0100, David Hildenbrand wrote:
> That's not sufficient for alternative implementations of pfn_valid().
> 
> You still need some kind of pfn_valid(pfn) for alternative versions of
> pfn_valid(). Consider arm64 memory holes in the memmap. See their
> current (yet to be fixed/reworked) pfn_valid() implementation.
> (pfn_valid_within() is implicitly active on arm64)
> 
> Actually, I think we should add something like the following, to make
> this clearer (pfn_valid_within() is confusing)
> 
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> 	/* We might have to check for holes inside the memmap. */
> 	if (!pfn_valid())
> 		return NULL;
> #endif

I have to confess that I was a bit confused by pfn_valid_within + HOLES_IN_ZONES
+ HAVE_ARCH_PFN_VALID.

At first I thought that we should stick with pfn_valid_within, as we also
depend on HOLES_IN_ZONES, so it could be that

 if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
  ...

would to too much work, as if CONFIG_HOLES_IN_ZONES was not set but an arch
pfn_valid was provided, we would perform unedeed checks.
But on a closer look, CONFIG_HOLES_IN_ZONES is set by default on arm64, and
on ia64 when SPARSEMEM is set, so looks fine.


-- 
Oscar Salvador
SUSE L3
