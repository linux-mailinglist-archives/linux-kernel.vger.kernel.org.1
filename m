Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB2326B01E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgIOWBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:01:23 -0400
Received: from lobo.ruivo.org ([173.14.175.98]:60026 "EHLO lobo.ruivo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgIOV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:27:59 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2020 17:27:59 EDT
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 9B68D53091; Tue, 15 Sep 2020 17:22:45 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tate.lan.ruivo
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.5 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 0861E52B01;
        Tue, 15 Sep 2020 17:22:22 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id B66B91A18EC; Tue, 15 Sep 2020 17:22:22 -0400 (EDT)
Date:   Tue, 15 Sep 2020 17:22:22 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Oscar Salvador <osalvador@suse.de>, naoya.horiguchi@nec.com
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Message-ID: <20200915212222.GA18315@cathedrallabs.org>
References: <20200914101559.17103-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914101559.17103-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar, Naoya,

On Mon, Sep 14, 2020 at 12:15:54PM +0200, Oscar Salvador wrote:
> The important bit of this patchset is patch#1, which is a fix to take off
> HWPoison pages off a buddy freelist since it can lead us to having HWPoison
> pages back in the game without no one noticing it.
> So fix it (we did that already for soft_offline_page [1]).
> 
> The other patches are clean-ups and not that important, so if anything,
> consider patch#1 for inclusion.
> 
> [1] https://patchwork.kernel.org/cover/11704083/

I found something strange with your and Naoya's hwpoison rework. We have a
customer with a testcase that basically does:

	p1 = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	p2 = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

	madvise(p1, size, MADV_MERGEABLE);
	madvise(p2, size, MADV_MERGEABLE);

	memset(p1, 'a', size);
	memset(p2, 'a', size);

	madvise(p1, size, MADV_SOFT_OFFLINE);

	madvise(p1, size, MADV_UNMERGEABLE);
	madvise(p2, size, MADV_UNMERGEABLE);


where size is about 200,000 pages. It works on a x86_64 box (with and without the
hwpoison rework). On ppc64 boxes (tested 3 different ones with at least 250GB memory)
it fails to take a page off the buddy list (page_handle_poison()/take_page_off_buddy())
(madvise MADV_SOFT_OFFLINE returns -EBUSY). Without the hwpoison rework the test passes.

Possibly related is that ppc64 takes a long time to run this test and according
perf, it spends most of the time clearing pages:

	  17.15%  ksm_poison  [kernel.kallsyms]  [k] copypage_power7
	  13.39%  ksm_poison  [kernel.kallsyms]  [k] clear_user_page
	   8.70%  ksm_poison  libc-2.28.so       [.] __memset_power8
	   8.63%  ksm_poison  [kernel.kallsyms]  [k] opal_return
	   6.04%  ksm_poison  [kernel.kallsyms]  [k] __opal_call
	   2.67%  ksm_poison  [kernel.kallsyms]  [k] opal_call
	   1.52%  ksm_poison  [kernel.kallsyms]  [k] _raw_spin_lock
	   1.45%  ksm_poison  [kernel.kallsyms]  [k] opal_flush_console
	   1.43%  ksm_poison  [unknown]          [k] 0x0000000030005138
	   1.43%  ksm_poison  [kernel.kallsyms]  [k] opal_console_write_buffer_space
	   1.26%  ksm_poison  [kernel.kallsyms]  [k] hvc_console_print
(...)

I've run these tests using mmotm and mmotm with this patchset on top.

Do you know what might be happening here?

-- 
Aristeu

