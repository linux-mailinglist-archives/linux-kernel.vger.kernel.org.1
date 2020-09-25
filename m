Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E677E277E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIYDcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgIYDcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:32:52 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787342176B;
        Fri, 25 Sep 2020 03:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601004771;
        bh=+GJrOHMXTCoFujOdxii3B4HR0KCIzhDzHOkbFzS+X04=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F9o8RvvmBiLJaBBhJ2YIparA0+YTFgeLiU/Xc94RDuJWmHkEQMz4FO4YqHTwr0/Rt
         rWNuDAjX/nQzouGuXQkT5Gn+JEvdZiiEefdzkJG05/OerFb1zcbGYYlaX5N1weNSBO
         VQVtapHCgIsutGcqHqhPDwBPxw0aEHwF6su271HY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4635B35230AC; Thu, 24 Sep 2020 20:32:51 -0700 (PDT)
Date:   Thu, 24 Sep 2020 20:32:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/test 55/64] kernel/rcu/rcutorture.c:1507:13: warning:
 no previous prototype for 'rcu_nocb_cpu_offload'
Message-ID: <20200925033251.GC29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202009251115.6CzgMdc0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009251115.6CzgMdc0%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:08:19AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/test
> head:   516c2f87d0d1204a9ea1b36298283f74056a7eab
> commit: 4df5d8a622235d0b26aba92c881d190667e4d6c3 [55/64] rcutorture: Test runtime toggling of CPUs' callback offloading
> config: microblaze-randconfig-r033-20200923 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 4df5d8a622235d0b26aba92c881d190667e4d6c3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/rcu/rcutorture.c:1507:13: warning: no previous prototype for 'rcu_nocb_cpu_offload' [-Wmissing-prototypes]
>     1507 | void __weak rcu_nocb_cpu_offload(int cpu) {}
>          |             ^~~~~~~~~~~~~~~~~~~~
> >> kernel/rcu/rcutorture.c:1508:13: warning: no previous prototype for 'rcu_nocb_cpu_deoffload' [-Wmissing-prototypes]
>     1508 | void __weak rcu_nocb_cpu_deoffload(int cpu) {}
>          |             ^~~~~~~~~~~~~~~~~~~~~~

The previous prototype will be showing up later, once the code that
this is testing appears.  At which point these two lines will go away.

							Thanx, Paul

> # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=4df5d8a622235d0b26aba92c881d190667e4d6c3
> git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git fetch --no-tags rcu rcu/test
> git checkout 4df5d8a622235d0b26aba92c881d190667e4d6c3
> vim +/rcu_nocb_cpu_offload +1507 kernel/rcu/rcutorture.c
> 
>   1506	
> > 1507	void __weak rcu_nocb_cpu_offload(int cpu) {}
> > 1508	void __weak rcu_nocb_cpu_deoffload(int cpu) {}
>   1509	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


