Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280092B3AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 01:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgKPASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 19:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgKPASf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 19:18:35 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4786F222EC;
        Mon, 16 Nov 2020 00:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605485914;
        bh=32x/FuihwS5C6ddzVnph7HNF9npffyaAnq2MtvA6Kzw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2Bv7ss8dSKNs51kzD1f4/utqWUIsKQC59Ft1h/EHNp734z24+B/RO/+4ngUUft/QG
         CZLq4rollXMgFfz3rOeZXfLEzpyCjPd3Z2eD186l2m981M4A/mBZ9oBPPw92m7Jhjj
         cPCpO67Wn0VEmIFdB9QWQvyKDWApv2QIqtCeuY9Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 278293522ABD; Sun, 15 Nov 2020 16:18:34 -0800 (PST)
Date:   Sun, 15 Nov 2020 16:18:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.11.10a 39/46] ERROR: modpost:
 "get_state_synchronize_srcu" undefined!
Message-ID: <20201116001834.GO3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202011160746.rMeDMJQM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011160746.rMeDMJQM-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 07:25:48AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.11.10a
> head:   1bc2f285f9c940176cc2c231db1372d5b2f0c635
> commit: 7c1d4bacb30f91a0962490cb9db98371aef1f4d6 [39/46] rcutorture: Add initial test for ->get_gp_state and ->poll_gp_state
> config: x86_64-randconfig-s022-20201115 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-107-gaf3512a6-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=7c1d4bacb30f91a0962490cb9db98371aef1f4d6
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2020.11.10a
>         git checkout 7c1d4bacb30f91a0962490cb9db98371aef1f4d6
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "get_state_synchronize_srcu" [kernel/rcu/rcutorture.ko] undefined!
> >> ERROR: modpost: "start_poll_synchronize_srcu" [kernel/rcu/rcutorture.ko] undefined!
> >> ERROR: modpost: "poll_state_synchronize_srcu" [kernel/rcu/rcutorture.ko] undefined!

Good catch, fixed, thank you!

						Thanx, Paul
