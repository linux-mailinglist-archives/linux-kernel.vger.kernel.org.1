Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279826DC94
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgIQNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:10:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgIQNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:09:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF53EACB0;
        Thu, 17 Sep 2020 13:10:28 +0000 (UTC)
Date:   Thu, 17 Sep 2020 15:09:52 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aris@ruivo.org" <aris@ruivo.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Message-ID: <20200917130948.GA1812@linux>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917113920.GA19898@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917113920.GA19898@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:39:21AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> Thanks for the update.
> This patchset triggers the following BUG_ON() with Aristeu's workload:

I just took a look, but I found more oddities.
The patchset you sent seems to be a bit buggy and it is missing some things
my patchset contains, e.g:

static __always_inline bool free_pages_prepare(struct page *page,
					unsigned int order, bool check_free)
{
	...
	if (unlikely(PageHWPoison(page)) && !order) {
	...
		return false;
}

Moreover, in page_handle_poison, you managed it wrong because:

static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
{
        if (release) {
                put_page(page);
                drain_all_pages(page_zone(page));
        }

	...
        SetPageHWPoison(page);
        page_ref_inc(page);

1) You are freeing the page first, which means it goes to buddy
2) Then you set it as poisoned and you update its refcount.

Now we have a page sitting in Buddy with a refcount = 1 and poisoned, and that is quite wrong.

Honestly, I do not know how your patchset diverged so much from mine, but is
not right.

I will go over my patchset and yours and compare/fix things.

-- 
Oscar Salvador
SUSE L3
