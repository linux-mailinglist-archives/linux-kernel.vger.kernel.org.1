Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECFC2907EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409716AbgJPPC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409709AbgJPPCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:02:55 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC04B20829;
        Fri, 16 Oct 2020 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602860575;
        bh=XyqtwR2y51dE9uIuwWaTfw9Z8mjhamhBFpsKxY2bOmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sVsKZNh7fdrzfsQqd6EWla8mtHG/NDqnN7YDXzrHBOH4pIX+0U3yIwvjay4jMReZa
         4r3NeKF1MYf3n2YXNUpiYvtKds0eM0L2luj0giQ/hItU532QeaiORUGDymJKkNBOTM
         w1r2VLDx4Uxx+N+TJ5AawD2wXYn8sTnti+MmXJtA=
Date:   Fri, 16 Oct 2020 08:02:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: arch/mips/include/asm/addrspace.h:88:37: warning: passing
 argument 1 of 'kfree' makes pointer from integer without a cast
Message-ID: <20201016080251.3e3c4dc0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202010161852.CGdSDJx5-lkp@intel.com>
References: <202010161852.CGdSDJx5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 18:04:29 +0800 kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9ff9b0d392ea08090cd1780fb196f36dbb586529
> commit: 3af5f0f5c74ecbaf757ef06c3f80d56751277637 net: korina: fix kfree of rx/tx descriptor array
> date:   4 days ago
> config: mips-rb532_defconfig (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3af5f0f5c74ecbaf757ef06c3f80d56751277637
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 3af5f0f5c74ecbaf757ef06c3f80d56751277637
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/mips/include/asm/barrier.h:11,
>                     from arch/mips/include/asm/bitops.h:19,
>                     from include/linux/bitops.h:29,
>                     from include/linux/kernel.h:12,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:12,
>                     from drivers/net/ethernet/korina.c:36:
>    drivers/net/ethernet/korina.c: In function 'korina_probe':
> >> arch/mips/include/asm/addrspace.h:88:37: warning: passing argument 1 of 'kfree' makes pointer from integer without a cast [-Wint-conversion]  
>       88 | #define KSEG0ADDR(a)  (CPHYSADDR(a) | KSEG0)
>          |                       ~~~~~~~~~~~~~~^~~~~~~~
>          |                                     |
>          |                                     unsigned int
>    drivers/net/ethernet/korina.c:1116:8: note: in expansion of macro 'KSEG0ADDR'
>     1116 |  kfree(KSEG0ADDR(lp->td_ring));
>          |        ^~~~~~~~~

Valentin, looks like we're missing a cast to (void *) or some other
pointer.. Would you mind sending a fix? You can find cross compilers 
to test it here, cause this probably only builds for MIPS:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

