Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3162FF367
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbhAUIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:47:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbhAUIov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611218597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qceA6Mj17tYbQrPYRIWS65DjH+HsiHQ9R/ygw96D7U=;
        b=iQ+mqrrkz/mXlcvvhMYENQlXfGyz1rAS8bEpqnJ1l3PlpHbFOmCU5ZzlETCXsJhm+mPYW7
        uCKQRMbglzKL/nZlPioeSyEE30fCpXbgJOUL4jH1qUNF4fY0ipcrp1SXpV+zVIa9CsnB7V
        cyBPFo4cEowHYaKp84aoVPffDapmBI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-3dqsZpoiMAml-8w_v8ipCQ-1; Thu, 21 Jan 2021 03:43:13 -0500
X-MC-Unique: 3dqsZpoiMAml-8w_v8ipCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 592B551DA;
        Thu, 21 Jan 2021 08:43:12 +0000 (UTC)
Received: from localhost (ovpn-12-177.pek2.redhat.com [10.72.12.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C35210016FF;
        Thu, 21 Jan 2021 08:43:08 +0000 (UTC)
Date:   Thu, 21 Jan 2021 16:43:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com
Subject: Re: [PATCH v4 1/4] mm: rename memmap_init() and memmap_init_zone()
Message-ID: <20210121084305.GI20161@MiWiFi-R3L-srv>
References: <20210120045213.6571-2-bhe@redhat.com>
 <202101202302.EE9LLAFu-lkp@intel.com>
 <20210121081727.GG20161@MiWiFi-R3L-srv>
 <20210121082522.GS1106298@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121082522.GS1106298@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/21 at 10:25am, Mike Rapoport wrote:
> On Thu, Jan 21, 2021 at 04:17:27PM +0800, Baoquan He wrote:
> > On 01/20/21 at 11:47pm, kernel test robot wrote:
> > > Hi Baoquan,
> > > 
> > > I love your patch! Perhaps something to improve:
> > > 
> > > [auto build test WARNING on linux/master]
> > > [also build test WARNING on linus/master v5.11-rc4 next-20210120]
> > > [cannot apply to mmotm/master hnaz-linux-mm/master ia64/next]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Baoquan-He/mm-clean-up-names-and-parameters-of-memmap_init_xxxx-functions/20210120-135239
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1e2a199f6ccdc15cf111d68d212e2fd4ce65682e
> > > config: mips-randconfig-r036-20210120 (attached as .config)
> > > compiler: mips-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/0day-ci/linux/commit/1bbb0b35dd2fae4a7a38098e63899677c2e53108
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Baoquan-He/mm-clean-up-names-and-parameters-of-memmap_init_xxxx-functions/20210120-135239
> > >         git checkout 1bbb0b35dd2fae4a7a38098e63899677c2e53108
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >    mm/page_alloc.c:3597:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
> > >     3597 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
> > >          |               ^~~~~~~~~~~~~~~~~~~~~~
> > > >> mm/page_alloc.c:6258:23: warning: no previous prototype for 'memmap_init_zone' [-Wmissing-prototypes]
> > >     6258 | void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> > 
> > This is not introduced by this patch, but existing issue, should
> > be not related to this patchset. I will investigate and see what we
> > should do with memmap_init_zone(), adding static or adding it to header
> > file, or just leave it as should_fail_alloc_page().
> > 
> > 
> > By the way, I tried to reproduce on a fedora 32 system of x86 arch, but
> > met below issue. could you help check what I can do to fix the error.
> > 
> > 
> > [root@dell-per710-01 linux]# COMPILER_INSTALL_PATH=~/0day COMPILER=gcc-9.3.0 ~/bin/make.cross ARCH=mips
> > Compiler will be installed in /root/0day
> > make W=1 CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/root/0day/gcc-9.3.0-nolibc/mips-linux/bin/mips-linux- --jobs=16 ARCH=mips
> >   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> >   HOSTCXX scripts/gcc-plugins/structleak_plugin.so
> >   HOSTCXX scripts/gcc-plugins/randomize_layout_plugin.so
> > In file included from /root/0day/gcc-9.3.0-nolibc/mips-linux/bin/../lib/gcc/mips-linux/9.3.0/plugin/include/gcc-plugin.h:28,
> >                  from scripts/gcc-plugins/gcc-common.h:7,
> >                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> > /root/0day/gcc-9.3.0-nolibc/mips-linux/bin/../lib/gcc/mips-linux/9.3.0/plugin/include/system.h:687:10: fatal error: gmp.h: No such file or directy
> >   687 | #include <gmp.h>
> >       |          ^~~~~~~
> > compilation terminated.
> > make[2]: *** [scripts/gcc-plugins/Makefile:47: scripts/gcc-plugins/latent_entropy_plugin.so] Error 1
> > make[2]: *** Waiting for unfinished jobs..
> 
> Do you have gmp-devel installed?

Ah, I didn't, thanks. Then libmpc-devel is needed. Will continue.

