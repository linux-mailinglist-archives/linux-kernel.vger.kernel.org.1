Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2569426CC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgIPUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:43:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgIPRDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23FBEB5B1;
        Wed, 16 Sep 2020 16:31:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Sep 2020 18:30:56 +0200
From:   osalvador@suse.de
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
In-Reply-To: <20200916144603.GC17169@cathedrallabs.org>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org> <20200916072658.GA10692@linux>
 <20200916135358.GB17169@cathedrallabs.org> <20200916140921.GA17949@linux>
 <20200916144603.GC17169@cathedrallabs.org>
User-Agent: Roundcube Webmail
Message-ID: <9bd7ac81968a7897474804d53bfc1286@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-16 16:46, Aristeu Rozanski wrote:
> Hi Oscar,
> 
> On Wed, Sep 16, 2020 at 04:09:30PM +0200, Oscar Salvador wrote:
>> On Wed, Sep 16, 2020 at 09:53:58AM -0400, Aristeu Rozanski wrote:
>> Can you try the other patch I posted in response to Naoya?
> 
> Same thing:
> 
> [  369.195056] Soft offlining pfn 0x3fb5bf at process virtual address
> 0x7ffc84350000
> [  369.195073] page:000000002bb131e4 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x7ffc8435 pfn:0x3fb5bf
> [  369.195080] anon flags:
> 0x3ffff80008000e(referenced|uptodate|dirty|swapbacked)
> [  369.202131] raw: 003ffff80008000e 5deadbeef0000100 5deadbeef0000122
> c000003fda1c7431
> [  369.202137] raw: 000000007ffc8435 0000000000000000 00000001ffffffff
> c000003fd63af000
> [  369.202141] page dumped because: page_handle_poison
> [  369.202145] page->mem_cgroup:c000003fd63af000
> [  369.215055] page_handle_poison: hugepage_or_freepage failed�n
> [  369.215057] __soft_offline_page: page_handle_poison -EBUSY
> [  369.215068] page:000000002bb131e4 refcount:3 mapcount:0
> mapping:00000000f6ca3f32 index:0x5c pfn:0x3fb5bf
> [  369.215110] aops:xfs_address_space_operations [xfs] ino:49f9c5f
> dentry name:"messages"
> [  369.215117] flags: 0x3ffff800002008(dirty|private)
> [  369.215121] raw: 003ffff800002008 5deadbeef0000100 5deadbeef0000122
> c000003fadd3daa8
> [  369.215127] raw: 000000000000005c c000003fd9497c20 00000003ffffffff
> c000003fd1143000
> [  369.215132] page dumped because: __soft_offline_page after migrate
> [  369.215136] page->mem_cgroup:c000003fd1143000


Ok, this is something different.
The race you saw previously is kinda normal as there is a race window 
between spotting a freepage and taking it off the buddy freelists.
The retry patch should help there.

The issue you are seeing right here is due to the call to 
page_handle_poison in __soft_offline_page being wrong, as we pass 
hugepage_or_freepage = true inconditionally, which is wrong.

Should be:
