Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1B2E2014
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgLWRoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgLWRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:44:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62A09207A1;
        Wed, 23 Dec 2020 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608745407;
        bh=Aou68FCkuvPA2ZYtb8U8CVmPvAVfi7f51UqquCYEYcI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YM/xL0AFGkfxhgJPsy1GmfTvQzelsEicGUwj3fS+khZxTzmyOekk9GjUdMVdola6k
         99CPHo0D0+U8IqHyogIvN6bK++2XwI+uL7n/eCHb5TKbl7utBA1Oz/7bs+2DLKlW2m
         w4TAZhFlRNP27kvkC7qCOxedfj3o8OCXfHkVpPjuWd/YgEyWqtywBve9bQPFQSodrG
         eKXVTamWOWCE0EkPmQBjXm/2xFvVoVCWZP7WLbsREYGzHhJRMR0fQF2SkZm3BHx+IV
         pIny80gw5dxPWGt1Y8eegs4QnNC6gJ5JcnzT/TUOtkniOYEI69PN2e86RwZOhmED2V
         mQUSUNkaDbK6Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 274F63522E72; Wed, 23 Dec 2020 09:43:27 -0800 (PST)
Date:   Wed, 23 Dec 2020 09:43:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        ysato@users.sourceforge.jp, uclinux-h8-devel@lists.sourceforge.jp
Subject: Re: update.c:undefined reference to `irq_work_queue'
Message-ID: <20201223174327.GE2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012232343.8TN3HwnU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012232343.8TN3HwnU-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 11:14:48PM +0800, kernel test robot wrote:
> Hi Paul,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   614cb5894306cfa2c7d9b6168182876ff5948735
> commit: b38f57c1fe64276773b124dffb0a139cc32ab3cb rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
> date:   8 months ago
> config: h8300-randconfig-s032-20201220 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-184-g1b896707-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b38f57c1fe64276773b124dffb0a139cc32ab3cb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b38f57c1fe64276773b124dffb0a139cc32ab3cb
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    h8300-linux-ld: section .init.text LMA [000000000043a160,0000000000452569] overlaps section .rodata LMA [00000000003ff420,000000000047df2f]
>    h8300-linux-ld: section .data VMA [0000000000400000,000000000043a15f] overlaps section .rodata VMA [00000000003ff420,000000000047df2f]
>    h8300-linux-ld: section __ksymtab VMA [000000000047df30,000000000048611f] overlaps section .bss VMA [000000000045ebd0,000000000056a053]
>    h8300-linux-ld: kernel/rcu/update.o: in function `rcu_read_unlock_trace_special':
> >> update.c:(.text+0x8f9): undefined reference to `irq_work_queue'

And despite my "select IRQ_WORK", your .config file does not have
CONFIG_IRQ_WORK.

As it stands, Tasks Trace RCU needs irq_work_queue() in order to defer a
wakeup to a point in the code where it is safe to do a wakeup.  If h8300
does not support irq_work_queue(), then h8300 should not try to use
Tasks Trace RCU.

I could add something like a BUILD_BUG_ON(!IS_ENABLED(CONFIG_IRQ_WORK))
in order to make this restriction official.

Adding the H8300 people on CC for their thoughts.

							Thanx, Paul
