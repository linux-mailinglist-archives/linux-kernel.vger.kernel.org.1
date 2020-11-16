Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013662B3FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgKPJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:31:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:56594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKPJb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:31:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6722B03F;
        Mon, 16 Nov 2020 09:31:25 +0000 (UTC)
Message-ID: <1605519085.19452.74.camel@suse.cz>
Subject: Re: [x86, sched]  2a0abc5969:
 phoronix-test-suite.stress-ng.SystemVMessagePassing.bogo_ops_s -14.1%
 regression
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, guobing.chen@intel.com,
        ming.a.chen@intel.com, frank.du@intel.com, Shuhua.Fan@intel.com,
        wangyang.guo@intel.com, Wenhuan.Huang@intel.com,
        jessica.ji@intel.com, shan.kang@intel.com, guangli.li@intel.com,
        tiejun.li@intel.com, yu.ma@intel.com, dapeng1.mi@intel.com,
        jiebin.sun@intel.com, gengxin.xie@intel.com, fan.zhao@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Date:   Mon, 16 Nov 2020 10:31:25 +0100
In-Reply-To: <20201116070733.GA22371@xsang-OptiPlex-9020>
References: <20201116070733.GA22371@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-16 at 15:07 +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -14.1% regression of phoronix-test-suite.stress-ng.SystemVMessagePassing.bogo_ops_s due to commit:
> 
> 
> commit: 2a0abc59699896f03bf6f16efb8a3a490511216f ("x86, sched: Add support for frequency invariance on SKYLAKE_X")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: phoronix-test-suite
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> with following parameters:
> 
> 	test: stress-ng-1.2.2
> 	option_a: System V Message Passing
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01

I haven't checked this regression yet, but when a "schedutil" change like
this patch triggers a regression when the "performance" governor is used,
the trouble might come in some roundabout way, eg. from cache alignment issues.

The patch defines a number of (not necessarily aligned) per-cpu variables, and
there was a recent thread where Boris Petkov, Tony Luck and Mel Gorman debugged
something that had similar characteristics:

"RE: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops -14.1% regression"
https://lore.kernel.org/lkml/6e996ad05e434a6fb13f069ee72b876b@intel.com/

I'll study this problem with that in mind.


Giovanni


