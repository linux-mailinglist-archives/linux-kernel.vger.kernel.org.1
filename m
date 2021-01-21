Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817062FE4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbhAUI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbhAUI0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:26:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA0EE23976;
        Thu, 21 Jan 2021 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611217529;
        bh=6bziHd7oBvKnbE11P6CRY+Ruy7iCaXkMj5CVt9SKGcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOx+zVrYjZGFNfjjovtJhtGZaQ6NtIx4+HLzRQhgTrqwPQHXXtapfEhw397gV9xFW
         1IkDz+h01Q/5nsfAyD4q4tT1mCeTOwSBLbMJSluWlFOz0CF7rGWkoC52WFeFAlchQE
         /MKXuCvjggck3m8XNuJmjI0mxz9bCgw8DMFlaHQ7Tdk4I9EvSNiQZhPEC+xqQo4ggj
         ZAFA9uMLOMdEm4NbZ7QU2gPf8azka0x/ODppUouGZqk9jQihUF927cViMWLE8Z8G7E
         4ExCl9qqi3u1qw9IUI/4kEvr6Jx342pLADOEWnkKkpXgXtdW9PKG+j7rbfe2io2v9s
         PyNCeBq/w4mog==
Date:   Thu, 21 Jan 2021 10:25:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com
Subject: Re: [PATCH v4 1/4] mm: rename memmap_init() and memmap_init_zone()
Message-ID: <20210121082522.GS1106298@kernel.org>
References: <20210120045213.6571-2-bhe@redhat.com>
 <202101202302.EE9LLAFu-lkp@intel.com>
 <20210121081727.GG20161@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121081727.GG20161@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:17:27PM +0800, Baoquan He wrote:
> On 01/20/21 at 11:47pm, kernel test robot wrote:
> > Hi Baoquan,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on linux/master]
> > [also build test WARNING on linus/master v5.11-rc4 next-20210120]
> > [cannot apply to mmotm/master hnaz-linux-mm/master ia64/next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Baoquan-He/mm-clean-up-names-and-parameters-of-memmap_init_xxxx-functions/20210120-135239
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1e2a199f6ccdc15cf111d68d212e2fd4ce65682e
> > config: mips-randconfig-r036-20210120 (attached as .config)
> > compiler: mips-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/1bbb0b35dd2fae4a7a38098e63899677c2e53108
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Baoquan-He/mm-clean-up-names-and-parameters-of-memmap_init_xxxx-functions/20210120-135239
> >         git checkout 1bbb0b35dd2fae4a7a38098e63899677c2e53108
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    mm/page_alloc.c:3597:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
> >     3597 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
> >          |               ^~~~~~~~~~~~~~~~~~~~~~
> > >> mm/page_alloc.c:6258:23: warning: no previous prototype for 'memmap_init_zone' [-Wmissing-prototypes]
> >     6258 | void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> 
> This is not introduced by this patch, but existing issue, should
> be not related to this patchset. I will investigate and see what we
> should do with memmap_init_zone(), adding static or adding it to header
> file, or just leave it as should_fail_alloc_page().
> 
> 
> By the way, I tried to reproduce on a fedora 32 system of x86 arch, but
> met below issue. could you help check what I can do to fix the error.
> 
> 
> [root@dell-per710-01 linux]# COMPILER_INSTALL_PATH=~/0day COMPILER=gcc-9.3.0 ~/bin/make.cross ARCH=mips
> Compiler will be installed in /root/0day
> make W=1 CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/root/0day/gcc-9.3.0-nolibc/mips-linux/bin/mips-linux- --jobs=16 ARCH=mips
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
>   HOSTCXX scripts/gcc-plugins/structleak_plugin.so
>   HOSTCXX scripts/gcc-plugins/randomize_layout_plugin.so
> In file included from /root/0day/gcc-9.3.0-nolibc/mips-linux/bin/../lib/gcc/mips-linux/9.3.0/plugin/include/gcc-plugin.h:28,
>                  from scripts/gcc-plugins/gcc-common.h:7,
>                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> /root/0day/gcc-9.3.0-nolibc/mips-linux/bin/../lib/gcc/mips-linux/9.3.0/plugin/include/system.h:687:10: fatal error: gmp.h: No such file or directy
>   687 | #include <gmp.h>
>       |          ^~~~~~~
> compilation terminated.
> make[2]: *** [scripts/gcc-plugins/Makefile:47: scripts/gcc-plugins/latent_entropy_plugin.so] Error 1
> make[2]: *** Waiting for unfinished jobs..

Do you have gmp-devel installed?
 
> Thanks
> Baoquan
> 
> >          |                       ^~~~~~~~~~~~~~~~
> > 
> > 
> > vim +/memmap_init_zone +6258 mm/page_alloc.c
> > 
> >   6257	
> > > 6258	void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> >   6259					  unsigned long zone,
> >   6260					  unsigned long range_start_pfn)
> >   6261	{
> >   6262		unsigned long start_pfn, end_pfn;
> >   6263		unsigned long range_end_pfn = range_start_pfn + size;
> >   6264		int i;
> >   6265	
> >   6266		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> >   6267			start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> >   6268			end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> >   6269	
> >   6270			if (end_pfn > start_pfn) {
> >   6271				size = end_pfn - start_pfn;
> >   6272				memmap_init_range(size, nid, zone, start_pfn, range_end_pfn,
> >   6273						 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >   6274			}
> >   6275		}
> >   6276	}
> >   6277	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 

-- 
Sincerely yours,
Mike.
