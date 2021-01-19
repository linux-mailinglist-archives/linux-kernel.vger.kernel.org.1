Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395252FAF78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbhASE3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:29:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730874AbhASE2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:28:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F449207C4;
        Tue, 19 Jan 2021 04:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611030441;
        bh=7NwNR5W4ohdUOths1UUy38NvjQ/TF3RD6yRZmGqw8t8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KUjPpNlIUyz6kiuYHOhajAb8MEajNmn6SQTF6IqtL9p+Erz0t/h3Fly88+yR4/rKj
         92Y78KuPBVkgW6keKU7hp6EyV1CgCeShod7R4XmvuBc6U6+fo85id8NUPa8jZ6zp7W
         bY56b2vgEhHXD54M+aQFYWSiZ26q9nvpL6KoYNBzjPtyjgrmSAZgy05B392JBpnsTC
         Yi76ILvvBd1RvguqX/ldD2wu97bzBEKNBd8XDU2uPH1fNpJONRDLYv/C/YL97SfdBi
         DnHt3DazNtK44taWqYv5Nry/u5DWBAfW3WEIqoAZWf+yiuqQ0cuzcc/+MsB+lfxgH6
         ZOaFNNL3F7PCg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4FA1F352268F; Mon, 18 Jan 2021 20:27:21 -0800 (PST)
Date:   Mon, 18 Jan 2021 20:27:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        kernel test robot <oliver.sang@intel.com>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210119042721.GA12664@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210112142109.GE30747@xsang-OptiPlex-9020>
 <20210112141438.GF13086@zn.tnic>
 <20210116035251.GB29609@shbuild999.sh.intel.com>
 <20210116153413.GP2743@paulmck-ThinkPad-P72>
 <20210116160921.GA101665@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116160921.GA101665@shbuild999.sh.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 12:09:21AM +0800, Feng Tang wrote:
> On Sat, Jan 16, 2021 at 07:34:26AM -0800, Paul E. McKenney wrote:
> > On Sat, Jan 16, 2021 at 11:52:51AM +0800, Feng Tang wrote:
> > > Hi Boris,
> > > 
> > > On Tue, Jan 12, 2021 at 03:14:38PM +0100, Borislav Petkov wrote:
> > > > On Tue, Jan 12, 2021 at 10:21:09PM +0800, kernel test robot wrote:
> > > > > 
> > > > > Greeting,
> > > > > 
> > > > > FYI, we noticed a -4.5% regression of netperf.Throughput_tps due to commit:
> > > > > 
> > > > > 
> > > > > commit: 7bb39313cd6239e7eb95198950a02b4ad2a08316 ("x86/mce: Make mce_timed_out() identify holdout CPUs")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git ras/core
> > > > > 
> > > > > 
> > > > > in testcase: netperf
> > > > > on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> > > > > with following parameters:
> > > > > 
> > > > > 	ip: ipv4
> > > > > 	runtime: 300s
> > > > > 	nr_threads: 16
> > > > > 	cluster: cs-localhost
> > > > > 	test: TCP_CRR
> > > > > 	cpufreq_governor: performance
> > > > > 	ucode: 0x5003003
> > > > > 
> > > > > test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> > > > > test-url: http://www.netperf.org/netperf/
> > > > 
> > > > I'm very very sceptical this thing benchmarks #MC exception handler
> > > > performance. Because the code this patch adds gets run only during a MCE
> > > > exception.
> > > > 
> > > > So unless I'm missing something obvious please check your setup.
> > > 
> > > We've tracked some similar strange kernel performance changes, like
> > > another mce related one [1]. For many of them, the root cause is
> > > the patch changes the code or data alignment/address of other
> > > components, as could be seen from System.map file.
> > > 
> > > We added debug patch trying to force data sections of each .o be
> > > aligned (isolating components), and run the test 3 times, and
> > > the regression is gone.
> > > 
> > >          %stddev     %change         %stddev
> > >              \          |                \  
> > >     263059            -0.2%     262523        netperf.Throughput_total_tps
> > >      16441            -0.2%      16407        netperf.Throughput_tps
> > > 
> > > So the -4.5% is likely to be caused by data address change. 
> > > 
> > > But still there is something I don't understand, that the patch
> > > introduces a new cpumask 'mce_missing_cpus', which is 1024B, and
> > > from the System.map, all data following it get a 1024B offset,
> > > without changing the cacheline alignment situation.
> > > 
> > > 2 original system map files are attached in case people want
> > > to check.
> > > 
> > > [1]. https://lore.kernel.org/lkml/20200425114414.GU26573@shao2-debian/
> > 
> > One possibility is that the data-address changes put more stress on the
> > TLB, for example, if that region of memory is not covered by a huge
> > TLB entry.  If this is the case, is there a convenient way to define
> > mce_missing_cpus so as to get it out of the way?
> 
> Yes! I also tried some experiment for dTLB, by adding 3 more cpumask_t
> right after 'mce_missing_cpus', so that the total offset will be 4KB.
> I expected the regression could be gone, but it turns out to have 
> a +2.4% improvement.
>  
>      16741            -4.5%      15980            +2.4%      17149        netperf.Throughput_tps
> 
> Which is still kind of out of our control :) 

I bet that the results vary depending on the type of CPU, and also on
the kernel address-space layout, which of course also varies based on
the Kconfig options.  Let's see how the maintainers would like to proceed.

							Thanx, Paul
