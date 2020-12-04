Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF70C2CF4AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgLDTXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgLDTXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:23:13 -0500
Date:   Fri, 4 Dec 2020 11:22:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607109752;
        bh=lit+LYm24PpbjBYLiVoEersRpz93ixb8rCRdwgRtJOI=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G62ea3c0kMGJ9qtSCNDKkjVdz9X13ChNfmihph8RWd6xAm8yXQzhlLfZcDPn6Dzbk
         KzT1vMBwev0kl3THFnkNbjpkmdmKCKplF3nUJGqqxlZmYA92jN4HkJAO8Kc6On9i/U
         KBJM+R9ldwcocSJZ4q0QtQ6MMVm1nYxqT5y0Pev/rz+AI9vZQ3nUSEZ8u1ocs+GIho
         JOx9qleV7Fm/p/6ktdnlyqCHlKyiYf0wO/5x1SFuwZfVXNl8MVJ91wO1BWNpFcFiJA
         J7UcS7lpRcDp5JmrBNsfafJ2nbv1oZbq0oYrkSC0H8BJpSWmERrOroA29hHwAcJ6Y+
         x6Gj/VxOjm+0Q==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/next 94/101] mm/slab_common.c:555: undefined reference
 to `kmem_cache_last_alloc'
Message-ID: <20201204192231.GB1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012041254.XzddO1Xv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012041254.XzddO1Xv-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:53:56PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   413d9f332cbd16d951c22a41f2e5f53c1a75ae1c
> commit: f7c3fb4fc476a8a7a3cfc78cffbf1de13c1899b7 [94/101] mm: Add kmem_last_alloc() to return last allocation for memory block
> config: i386-randconfig-p001-20201204 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=f7c3fb4fc476a8a7a3cfc78cffbf1de13c1899b7
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu rcu/next
>         git checkout f7c3fb4fc476a8a7a3cfc78cffbf1de13c1899b7
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: mm/slab_common.o: in function `kmem_last_alloc':
> >> mm/slab_common.c:555: undefined reference to `kmem_cache_last_alloc'
> 
> vim +555 mm/slab_common.c

Good catch!  I had no idea that the slab definition of the
kmem_cache_last_alloc() function was under CONFIG_NUMA...

Will fold a fix in with attribution.

							Thanx, Paul

>    538	
>    539	/*
>    540	 * If the pointer references a slab-allocated object and if sufficient
>    541	 * debugging is enabled, return the returrn address for the corresponding
>    542	 * allocation.  Otherwise, return NULL.  Note that passing random pointers
>    543	 * to this function (including addresses of on-stack variables) is likely
>    544	 * to result in panics.
>    545	 */
>    546	void *kmem_last_alloc(void *object)
>    547	{
>    548		struct page *page;
>    549	
>    550		if (!virt_addr_valid(object))
>    551			return NULL;
>    552		page = virt_to_head_page(object);
>    553		if (!PageSlab(page))
>    554			return NULL;
>  > 555		return kmem_cache_last_alloc(page->slab_cache, object);
>    556	}
>    557	EXPORT_SYMBOL_GPL(kmem_last_alloc);
>    558	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


