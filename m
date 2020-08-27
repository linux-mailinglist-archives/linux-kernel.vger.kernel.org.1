Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3579255138
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgH0WgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 18:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0WgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:36:15 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB362080C;
        Thu, 27 Aug 2020 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598567774;
        bh=zCwLUTsolSQXOkxJkseUzl/upnu+HKW/B0upKZVRkZU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uEdGTT5mDZ//mbcwX7HZuplGpks1x5qn1IjDkqEGI/tskxVnaSS5R3IvfEyUmQN6h
         qHPM3kIxcO+LXTdmiTpxRmBZESsfLzSKONbbpB3VBBp+irE4FjCEg4rW0h2joAxoDI
         j6En+RFiycNMTMFWdf3f0iusnmBGoG61XfQrQbNk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AA31F3522611; Thu, 27 Aug 2020 15:36:14 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:36:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/next 10/11] kernel/rcu/tasks.h:594:20: error: static
 declaration of 'exit_tasks_rcu_start' follows non-static declaration
Message-ID: <20200827223614.GM2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202008280306.rWMY2XnY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008280306.rWMY2XnY%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:45:13AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   2ec296bd21c79b080bd6b3fb143122f18440d930
> commit: 8c8942d72e9bf1e19b6af0a8df4c7f44d2d384c0 [10/11] rcu-tasks: Prevent complaints of unused show_rcu_tasks_classic_gp_kthread()
> config: x86_64-randconfig-a014-20200827 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 71f3169e1baeff262583b35ef88f8fb6df7be85e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout 8c8942d72e9bf1e19b6af0a8df4c7f44d2d384c0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:578:
> >> kernel/rcu/tasks.h:594:20: error: static declaration of 'exit_tasks_rcu_start' follows non-static declaration
>    static inline void exit_tasks_rcu_start(void) { }
>                       ^
>    include/linux/rcupdate.h:181:6: note: previous declaration is here
>    void exit_tasks_rcu_start(void);
>         ^
>    In file included from kernel/rcu/update.c:578:
> >> kernel/rcu/tasks.h:595:20: error: static declaration of 'exit_tasks_rcu_finish' follows non-static declaration
>    static inline void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
>                       ^
>    include/linux/rcupdate.h:182:6: note: previous declaration is here
>    void exit_tasks_rcu_finish(void);
>         ^
>    2 errors generated.

Good catch, alleged fix folded into this commit.

							Thanx, Paul

> # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=8c8942d72e9bf1e19b6af0a8df4c7f44d2d384c0
> git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git fetch --no-tags rcu rcu/next
> git checkout 8c8942d72e9bf1e19b6af0a8df4c7f44d2d384c0
> vim +/exit_tasks_rcu_start +594 kernel/rcu/tasks.h
> 
>    591	
>    592	#else /* #ifdef CONFIG_TASKS_RCU */
>    593	static inline void show_rcu_tasks_classic_gp_kthread(void) { }
>  > 594	static inline void exit_tasks_rcu_start(void) { }
>  > 595	static inline void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
>    596	#endif /* #else #ifdef CONFIG_TASKS_RCU */
>    597	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


