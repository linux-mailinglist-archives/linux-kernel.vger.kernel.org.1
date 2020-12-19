Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF292DF12E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgLSTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgLSTHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:07:06 -0500
Date:   Sat, 19 Dec 2020 11:06:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608404786;
        bh=Rpp+Mv16l3KA4MK+PhsAFQQcrHuurkbv+RCgYjbM6KA=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gY3ZslQi2hUdW4opapLFkAvL5ULkXrYCojg0knGn6LpddftzmNN+e3nuCPCs0TsVN
         /ecBeZ6LbqhmDu4wurRG55igb5hIDrh/mLWTvUTJrmr7BHPNU/RaHnLrLE8laI7Mlp
         MtYKv4hkryMql8TFx0DZKVZ9keOr6z6fJXUx2Q+Oj6EyeNHs/Al2snVUZ/grjRRhtT
         XObERVzybjKulfSL97UD5o6W49eDnuGM0B4YUmQ9T6E7LVvuKjliGDifbUFYtiQQsO
         rWqfweBuupdlBU00tLn1nZ5odjOmzrf0nNEAWtYcY6gLD8P6sP4UQWDXzOCGhimz6n
         /1hP3PIhzS7MQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.12.15b 128/134] ERROR: modpost:
 "rcu_nocb_cpu_deoffload" undefined!
Message-ID: <20201219190625.GV2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012200104.Q6vxFujD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012200104.Q6vxFujD-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 01:37:07AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.12.15b
> head:   f895a17eec290b0038a6294d884a9cc92d7d6e80
> commit: 892f898ac8cfffe89e3c7fd483c8eaf71b3f12aa [128/134] rcutorture: Test runtime toggling of CPUs' callback offloading
> config: x86_64-rhel (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=892f898ac8cfffe89e3c7fd483c8eaf71b3f12aa
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2020.12.15b
>         git checkout 892f898ac8cfffe89e3c7fd483c8eaf71b3f12aa
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "rcu_nocb_cpu_deoffload" [kernel/rcu/rcutorture.ko] undefined!

Good catch!  I have queued a fix to be squashed into the original
with attribution.

							Thanx, Paul
