Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB70226CC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgIPUnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:43:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:50184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgIPRDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 544ABAFE6;
        Wed, 16 Sep 2020 14:07:01 +0000 (UTC)
Date:   Wed, 16 Sep 2020 16:06:43 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Aristeu Rozanski <aris@ruivo.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Message-ID: <20200916140624.GA17833@linux>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org>
 <20200916134215.GA30407@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916134215.GA30407@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:42:15PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Sep 15, 2020 at 05:22:22PM -0400, Aristeu Rozanski wrote:
 
> I reproduced the similar -EBUSY with small average x86 VM, where it seems to me
> a race between page_take_off_buddy() and page allocation.  Oscar's debug patch
> shows the following kernel messages:
> 
>     [  627.357009] Soft offlining pfn 0x235018 at process virtual address 0x7fd112140000
>     [  627.358747] __get_any_page: 0x235018 free buddy page
>     [  627.359875] page:00000000038b52c9 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x1 pfn:0x235018
>     [  627.362002] flags: 0x57ffe000000000()
>     [  627.362841] raw: 0057ffe000000000 fffff84648d12688 ffff955abffd1dd0 0000000000000000
>     [  627.364555] raw: 0000000000000001 0000000000000000 00000000ffffff7f 0000000000000000
>     [  627.366258] page dumped because: page_handle_poison
>     [  627.367357] page->mem_cgroup:ffff9559b6912000
>     [  627.368342] page_handle_poison: hugepage_or_freepage failed\xb8n
>     [  627.368344] soft_offline_free_page: page_handle_poison -EBUSY
>     [  627.370901] page:00000000038b52c9 refcount:6 mapcount:3 mapping:000000001226bf89 index:0x2710 pfn:0x235018
>     [  627.373048] aops:ext4_da_aops ino:c63f3 dentry name:"system.journal"
>     [  627.374526] flags: 0x57ffe00000201c(uptodate|dirty|lru|private)
>     [  627.375865] raw: 0057ffe00000201c fffff84648d300c8 ffff955ab8c3f020 ffff955aba5f4ee0
>     [  627.377586] raw: 0000000000002710 ffff9559b811fc98 0000000500000002 ffff9559b6912000
>     [  627.379308] page dumped because: soft_offline_free_page
>     [  627.380480] page->mem_cgroup:ffff9559b6912000
> 
>     CPU 0                                CPU 1
> 
>     get_any_page // returns 0 (free buddy path)
>       soft_offline_free_page
>                                          the page is allocated
>         page_handle_poison -> fail
>           return -EBUSY
> 
> I'm still not sure why this issue is invisible before rework patch,
> but setting migrate type to MIGRATE_ISOLATE during offlining could affect
> the behavior sensitively.

Well, this is very timing depending.
AFAICS, before the rework patchset, we could still race with an allocation
as the page could have been allocated between the get_any_page()
and the call to set_hwpoison_free_buddy_page() which takes the zone->lock
to prevent that.

Maybe we just happen to take longer now to reach take_page_off_buddy, so the
race window is bigger.

AFAICS, this has nothing to do with MIGRATE_ISOLATE, because here we are
dealing with pages that already free (part of the buddy system).

The only thing that comes to my mind right off the bat, might be to do
a "retry" in soft_offline_page in case soft_offline_free_page returns -EBUSY,
so we can call again get_any_page and try to handle the new type of page.
Something like (untested):

@@ -1923,6 +1977,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
 	struct page *page;
+	bool try_again = true;
 
 	if (!pfn_valid(pfn))
 		return -ENXIO;
@@ -1938,6 +1993,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return 0;
 	}
 
+retry:
 	get_online_mems();
 	ret = get_any_page(page, pfn, flags);
 	put_online_mems();
@@ -1945,7 +2001,10 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (ret > 0)
 		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
-		ret = soft_offline_free_page(page);
+		if (soft_offline_free_page(page) && try_again) {
+			try_again = false;
+			goto retry;
+		}
 
 	return ret;


-- 
Oscar Salvador
SUSE L3
