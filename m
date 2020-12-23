Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880DC2E1DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgLWPQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgLWPQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:16:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2B17224B1;
        Wed, 23 Dec 2020 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608736519;
        bh=9DYcz59Se72+Bp5su7l6QBTv71OF+h4eoDenVA0Y10A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bX+cs+poA4MOZf4vNT0gI/B9uMqv7tWqPYy9GOQooo5qzRBTuQ+cOAkcsg4uZpkfb
         tLMCO4uQMxWQj3rIt97Fz/+d+Pe9PBDap2pVfnd/iHdM08LbyPFjjKae34xRVkWATQ
         uusbP1iJLbvRyQS5LsWeJCeBFyRZcgDMexoE90jCcmtv+3/pj7cRQ4EKR2AT5lGxyM
         xTrrgoeiXm2+42f1NSLQlQesN2FbhM12s3E1CRvdQQudzFUoIuQRT4lJPBpG3rzfhd
         1m1dGZvexP4mPVzDLV9F4f+Wlav11Zw4mG1nDkxsivCkAbIjRtm8GQYiRnkStqrNB9
         0/9XRL8JGLweA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6521C352264C; Wed, 23 Dec 2020 07:15:19 -0800 (PST)
Date:   Wed, 23 Dec 2020 07:15:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/test 138/143]
 rcutorture.c:(.text.rcu_torture_reader_do_mbchk+0x30): undefined reference
 to `torture_num_online_cpus'
Message-ID: <20201223151519.GD2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012232257.xvh3k6a0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012232257.xvh3k6a0-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:14:02PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/test
> head:   4c4c8e04a7f8522de634aa062f4cd6b8b80c151b
> commit: cf516f4063cae6b69de6dd734d6c57901d24f112 [138/143] torture: Maintain torture-specific set of CPUs-online books
> config: mips-randconfig-r024-20201221 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=cf516f4063cae6b69de6dd734d6c57901d24f112
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu rcu/test
>         git checkout cf516f4063cae6b69de6dd734d6c57901d24f112
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mipsel-linux-ld: kernel/rcu/rcutorture.o: in function `rcu_torture_reader_do_mbchk':
> >> rcutorture.c:(.text.rcu_torture_reader_do_mbchk+0x30): undefined reference to `torture_num_online_cpus'
>    mipsel-linux-ld: kernel/rcu/rcutorture.o: in function `rcu_torture_reader':
> >> rcutorture.c:(.text.rcu_torture_reader+0x118): undefined reference to `torture_num_online_cpus'

Good catch, fix applied with attribution, thank you!

							Thanx, Paul
