Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD11226C899
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgIPSxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:53:52 -0400
Received: from lobo.ruivo.org ([173.14.175.98]:34584 "EHLO lobo.ruivo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgIPSH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:57 -0400
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 24DBC53035; Wed, 16 Sep 2020 10:46:23 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tate.lan.ruivo
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.5 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 0350552ACB;
        Wed, 16 Sep 2020 10:46:03 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id C4AF51A1A61; Wed, 16 Sep 2020 10:46:03 -0400 (EDT)
Date:   Wed, 16 Sep 2020 10:46:03 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Message-ID: <20200916144603.GC17169@cathedrallabs.org>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org>
 <20200916072658.GA10692@linux>
 <20200916135358.GB17169@cathedrallabs.org>
 <20200916140921.GA17949@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916140921.GA17949@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

On Wed, Sep 16, 2020 at 04:09:30PM +0200, Oscar Salvador wrote:
> On Wed, Sep 16, 2020 at 09:53:58AM -0400, Aristeu Rozanski wrote:
> Can you try the other patch I posted in response to Naoya?

Same thing:

[  369.195056] Soft offlining pfn 0x3fb5bf at process virtual address 0x7ffc84350000
[  369.195073] page:000000002bb131e4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x7ffc8435 pfn:0x3fb5bf
[  369.195080] anon flags: 0x3ffff80008000e(referenced|uptodate|dirty|swapbacked)
[  369.202131] raw: 003ffff80008000e 5deadbeef0000100 5deadbeef0000122 c000003fda1c7431
[  369.202137] raw: 000000007ffc8435 0000000000000000 00000001ffffffff c000003fd63af000
[  369.202141] page dumped because: page_handle_poison
[  369.202145] page->mem_cgroup:c000003fd63af000
[  369.215055] page_handle_poison: hugepage_or_freepage failed�n
[  369.215057] __soft_offline_page: page_handle_poison -EBUSY
[  369.215068] page:000000002bb131e4 refcount:3 mapcount:0 mapping:00000000f6ca3f32 index:0x5c pfn:0x3fb5bf
[  369.215110] aops:xfs_address_space_operations [xfs] ino:49f9c5f dentry name:"messages"
[  369.215117] flags: 0x3ffff800002008(dirty|private)
[  369.215121] raw: 003ffff800002008 5deadbeef0000100 5deadbeef0000122 c000003fadd3daa8
[  369.215127] raw: 000000000000005c c000003fd9497c20 00000003ffffffff c000003fd1143000
[  369.215132] page dumped because: __soft_offline_page after migrate
[  369.215136] page->mem_cgroup:c000003fd1143000

-- 
Aristeu

