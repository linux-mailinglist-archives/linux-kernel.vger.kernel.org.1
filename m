Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15F226C62B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIPRfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:35:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:36654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbgIPRdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:33:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F2A8B1E5;
        Wed, 16 Sep 2020 14:09:48 +0000 (UTC)
Date:   Wed, 16 Sep 2020 16:09:30 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Message-ID: <20200916140921.GA17949@linux>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org>
 <20200916072658.GA10692@linux>
 <20200916135358.GB17169@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916135358.GB17169@cathedrallabs.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:53:58AM -0400, Aristeu Rozanski wrote:
> Hi Oscar,

Thanks Aristeu,

> 
> On Wed, Sep 16, 2020 at 09:27:02AM +0200, Oscar Salvador wrote:
> > Could you please re-run the tests with the below patch applied, and
> > attached then the logs here?
> 
> here it is:
> (removed previous dump_page() calls for other pages that didn't fail)
> 
> [  109.709342] Soft offlining pfn 0x3fb526 at process virtual address 0x7ffc7a180000
> [  109.716969] page:00000000f367dde5 refcount:1 mapcount:0 mapping:0000000000000000 index:0x7ffc7a18 pfn:0x3fb526
> [  109.716978] anon flags: 0x3ffff80008000e(referenced|uptodate|dirty|swapbacked)
> [  109.716988] raw: 003ffff80008000e 5deadbeef0000100 5deadbeef0000122 c000003fcd56d839
> [  109.716997] raw: 000000007ffc7a18 0000000000000000 00000001ffffffff c000003fd42f5000
> [  109.717005] page dumped because: page_handle_poison
> [  109.717011] page->mem_cgroup:c000003fd42f5000
> [  109.725882] page_handle_poison: hugepage_or_freepage failed
> [  109.725885] __soft_offline_page: page_handle_poison -EBUSY
> [  109.725898] page:00000000f367dde5 refcount:3 mapcount:0 mapping:00000000b43d73e6 index:0x58 pfn:0x3fb526
> [  109.725951] aops:xfs_address_space_operations [xfs] ino:49f9c5f dentry name:"messages"
> [  109.725958] flags: 0x3ffff800002008(dirty|private)
> [  109.725963] raw: 003ffff800002008 5deadbeef0000100 5deadbeef0000122 c000003fb8b7eea8
> [  109.725969] raw: 0000000000000058 c000003fdd94eb20 00000003ffffffff c000003fd3c42000
> [  109.725975] page dumped because: __soft_offline_page after migrate
> [  109.725980] page->mem_cgroup:c000003fd3c42000

Can you try the other patch I posted in response to Naoya?

thanks

-- 
Oscar Salvador
SUSE L3
