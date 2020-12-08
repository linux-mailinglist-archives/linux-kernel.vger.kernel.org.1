Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA22D374B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgLIAAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 19:00:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbgLIAAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 19:00:00 -0500
Date:   Tue, 8 Dec 2020 15:59:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607471960;
        bh=XYs0emBCmuLeGGt/7UAH86zykdKFundc7LB/E+rW4xU=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tWlTHNSFBzVyW+fqhtGiQoeXeG3uYZq3VroTtgwz5iax6fCQi0zAQrnAu0mSa2HCc
         8zron8VEPsOo+h5eX/o6vkPUyA+dzIRoEOnye1dbC0maEtf12jiR4Ilfg7kwgVCTbX
         CRtB7+lBTIL4mNmlh4fUJpkowAvmiPdWNhcIzcnrLyW2l+YGg+IgvKNklznxcVZiQ/
         MIToqWc7caEWLhZbyJeE3ptNIVcL7cj9HiEmp/48/apvCIQYOzrrYQfMJJ7+BFpYAp
         oiU1dDQOUOH6T08VzMfbZDPoRiJWj99dG0PsQ8SvLJu5GuT+nHLqUMG9VGh0OhguC8
         9Ih4s7qO6g8pQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.12.08a 96/97] mm/slab_common.c:583: undefined
 reference to `kmem_struct_debug_provenance'
Message-ID: <20201208235919.GY2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012090722.a8hLT2LU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012090722.a8hLT2LU-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:46:24AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.12.08a
> head:   c5c1f436c5434ca260106aa0713ec8e4de3cba22
> commit: f1bf0344f92961c0691b3baeaa1c2f23bb076bc8 [96/97] mm: Add kmalloc_debug_print_provenance() to print source of memory block
> config: i386-randconfig-s002-20201208 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-179-ga00755aa-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=f1bf0344f92961c0691b3baeaa1c2f23bb076bc8
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2020.12.08a
>         git checkout f1bf0344f92961c0691b3baeaa1c2f23bb076bc8
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good catch, but this commit has been obsoleted by fc2cf07ea677 ("mm:
Add mem_dump_obj() to print source of memory block") which in your
defense I just now pushed out.

This and many other bugs have since been fixed, but Murphy insists
that there are plenty more to be found.  ;-)

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    ld: mm/slab_common.o: in function `kmalloc_debug_print_provenance':
> >> mm/slab_common.c:583: undefined reference to `kmem_struct_debug_provenance'
> 
> vim +583 mm/slab_common.c
> 
>    557	
>    558	/**
>    559	 * kmalloc_debug_print_provenance - Print available provenance information
>    560	 * @object: object for which to find provenance information.
>    561	 *
>    562	 * This function uses pr_cont(), so that the caller is expected to have
>    563	 * printed out whatever preamble is appropriate.  The provenance information
>    564	 * depends on the type of object and on how much debugging is enabled.
>    565	 * For a slab-cache object, the slab name is printed, and, if available,
>    566	 * the return address and stack trace from the allocation of that object.
>    567	 */
>    568	void kmalloc_debug_print_provenance(void *object)
>    569	{
>    570		int i;
>    571		struct page *page;
>    572		struct kmem_provenance kp;
>    573	
>    574		if (!virt_addr_valid(object)) {
>    575			pr_cont(" non-paged (local) memory.\n");
>    576			return;
>    577		}
>    578		page = virt_to_head_page(object);
>    579		kp.kp_ptr = object;
>    580		kp.kp_page = page;
>    581		kp.kp_nstack = KS_ADDRS_COUNT;
>    582		if (PageSlab(page)) {
>  > 583			kmem_struct_debug_provenance(&kp);
>    584			if (page->slab_cache)
>    585				pr_cont(" slab %s", page->slab_cache->name);
>    586			if (kp.kp_ret)
>    587				pr_cont(" allocated at %pS\n", kp.kp_ret);
>    588			if (kp.kp_stack[0]) {
>    589				for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
>    590					if (!kp.kp_stack[i])
>    591						break;
>    592					pr_info("    %pS\n", kp.kp_stack[i]);
>    593				}
>    594			}
>    595			return;
>    596		}
>    597		pr_cont(" non-slab memory.\n");
>    598	}
>    599	EXPORT_SYMBOL_GPL(kmalloc_debug_print_provenance);
>    600	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


