Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6142E2BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLYQmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 11:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgLYQmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 11:42:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 647D120C56;
        Fri, 25 Dec 2020 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608914504;
        bh=OnwEm6ba9xkRD7EiYLOoH/c+dOnWkyhuYxAQZ8SklYw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QIW28PqMloV5fP57EAxHG3Ygoqhxq5KzNkexZw3varhNFjPfz13h9MVIfxPCUb0dU
         bNh0NE1o7yWjs6p92RF8Yreua5SLpihYndACRmXd5MvgGsYhjnjIS5ePHFKapl32kx
         cMgWp7Jo1E74mIBUEKzgJS9+UCcSKUpxipuq+YfKhP9V0N+zLfNa3BGp/toa1CljGa
         nqBsycZvuIbji8nhvQF3DHYTpLCz9gnMRovP/WQuQ1oZpMw7KM4vlVKNckPFWfdVsZ
         BEFcydMPSk+NGy8+wsGqgfsW8P/W7G4WwVMDBlCXY++4dRTNM0+bEGc1/Tg6HkLJoJ
         Jee66EYWc1MQA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2B21F352264C; Fri, 25 Dec 2020 08:41:44 -0800 (PST)
Date:   Fri, 25 Dec 2020 08:41:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.12.23a 133/149] kernel/time/clocksource.c:220:6:
 warning: no previous prototype for function 'clocksource_verify_one_cpu'
Message-ID: <20201225164144.GI2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012251802.XTQ1RN7B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012251802.XTQ1RN7B-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 06:55:07PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.12.23a
> head:   7cc07f4867eb9618d4f7c35ddfbd746131b52f51
> commit: 6a70298420b2bd6d3e3dc86d81b993f618df8569 [133/149] clocksource: Check per-CPU clock synchronization when marked unstable
> config: x86_64-randconfig-r013-20201223 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=6a70298420b2bd6d3e3dc86d81b993f618df8569
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2020.12.23a
>         git checkout 6a70298420b2bd6d3e3dc86d81b993f618df8569
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good catch!  I will fold the fix into the original with attribution,
thank you!

							Thanx,Paul

> All warnings (new ones prefixed by >>):
> 
> >> kernel/time/clocksource.c:220:6: warning: no previous prototype for function 'clocksource_verify_one_cpu' [-Wmissing-prototypes]
>    void clocksource_verify_one_cpu(void *csin)
>         ^
>    kernel/time/clocksource.c:220:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void clocksource_verify_one_cpu(void *csin)
>    ^
>    static 
>    1 warning generated.
> 
> 
> vim +/clocksource_verify_one_cpu +220 kernel/time/clocksource.c
> 
>    219	
>  > 220	void clocksource_verify_one_cpu(void *csin)
>    221	{
>    222		struct clocksource *cs = (struct clocksource *)csin;
>    223	
>    224		__this_cpu_write(csnow_mid, cs->read(cs));
>    225	}
>    226	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


