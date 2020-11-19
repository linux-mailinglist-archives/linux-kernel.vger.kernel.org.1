Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2E2B8BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgKSHGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:06:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:60119 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKSHGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:06:05 -0500
IronPort-SDR: t9mgPz3Up32dnHkh8XTp4F3ARZ17/E9CHtri5o7hQ/ZfaO4f6rcwcbUBZNi7v1YWrhOSLZ41kC
 81/fGGZd5KnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170462173"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="170462173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 23:06:05 -0800
IronPort-SDR: dMwpwwAbDsFmjME4k+rOxpbx2OFoZr2n4f3zjdBOL57nmGyJY8HnKibfxYczauYR496aIy8fF/
 57P0qH6OULNw==
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="310959751"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 23:05:59 -0800
Date:   Thu, 19 Nov 2020 15:20:18 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zbigniew =?utf-8?Q?Kempczy=C5=84ski?= 
        <zbigniew.kempczynski@intel.com>,
        Matthew Auld <matthew.william.auld@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, guobing.chen@intel.com,
        ming.a.chen@intel.com, frank.du@intel.com, Shuhua.Fan@intel.com,
        wangyang.guo@intel.com, Wenhuan.Huang@intel.com,
        jessica.ji@intel.com, shan.kang@intel.com, guangli.li@intel.com,
        tiejun.li@intel.com, yu.ma@intel.com, dapeng1.mi@intel.com,
        jiebin.sun@intel.com, gengxin.xie@intel.com, fan.zhao@intel.com,
        zhengjun.xing@linux.intel.com, intel-gfx@lists.freedesktop.org
Subject: Re: [drm/i915/gem]  59dd13ad31:
 phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second
 -54.0% regression
Message-ID: <20201119072018.GA15197@xsang-OptiPlex-9020>
References: <20201111155811.GB24657@xsang-OptiPlex-9020>
 <160527763346.5566.3471508802857132043@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <160527763346.5566.3471508802857132043@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:27:13PM +0200, Joonas Lahtinen wrote:
> Hi,
> 
> Could you add intel-gfx@lists.freedesktop.org into reports going
> forward.
> 
> Quoting kernel test robot (2020-11-11 17:58:11)
> > 
> > Greeting,
> > 
> > FYI, we noticed a -54.0% regression of phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second due to commit:
> 
> How many runs are there on the bad version to ensure the bisect is
> repeatable?

test 4 times.
zxing@inn:/result/phoronix-test-suite/performance-true-Radial_Gradient_Paint-1024x1024-jxrendermark-1.2.4-ucode=0xd6-monitor=da39a3ee/lkp-cfl-d1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-9/59dd13ad310793757e34afa489dd6fc8544fc3da$ grep -r "operations_per_second" */stats.json
0/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4133.487932,
1/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4120.421503,
2/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4188.414835,
3/stats.json: "phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second": 4068.549514,

> 
> According to Chris test has various factors affecting why the result
> could fluctuate and has been known. Reverting the patch did not have
> an effect on the benchmark and was not expected to do so, either.
> 
> Is there some mechanism to queue a re-run?
> 
> Would it make sense to do further runs before sending out the e-mail
> to avoid false positives.
> 
> It could of course be also solved by sticking to tests that have less
> fluctuation in them.
> 
> Regards, Joonas
> 
> > 
> > 
> > commit: 59dd13ad310793757e34afa489dd6fc8544fc3da ("drm/i915/gem: Flush coherency domains on first set-domain-ioctl")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: phoronix-test-suite
> > on test machine: 12 threads Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory
> > with following parameters:
> > 
> >         need_x: true
> >         test: jxrendermark-1.2.4
> >         option_a: Radial Gradient Paint
> >         option_b: 1024x1024
> >         cpufreq_governor: performance
> >         ucode: 0xd6
> > 
> > test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
> > test-url: http://www.phoronix-test-suite.com/
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/need_x/option_a/option_b/rootfs/tbox_group/test/testcase/ucode:
> >   gcc-9/performance/x86_64-rhel-8.3/true/Radial Gradient Paint/1024x1024/debian-x86_64-phoronix/lkp-cfl-d1/jxrendermark-1.2.4/phoronix-test-suite/0xd6
> > 
> > commit: 
> >   0dccdba51e ("Merge tag 'gvt-fixes-2020-10-30' of https://github.com/intel/gvt-linux into drm-intel-fixes")
> >   59dd13ad31 ("drm/i915/gem: Flush coherency domains on first set-domain-ioctl")
> > 
> > 0dccdba51e852271 59dd13ad310793757e34afa489d 
> > ---------------- --------------------------- 
> >          %stddev     %change         %stddev
> >              \          |                \  
> >       8980 ±  2%     -54.0%       4127        phoronix-test-suite.jxrendermark.RadialGradientPaint.1024x1024.operations_per_second
> >       9.00           +13.9%      10.25 ±  4%  phoronix-test-suite.time.percent_of_cpu_this_job_got
> > 
> > 
> >                                                                                 
> >                                                                                 
> >                                                                                 
> >   10000 +-------------------------------------------------------------------+   
> >         |                                                                   |   
> >    9000 |-+.+. .+.+.+.+.+.   .+. .+.   .+. .+.+.     .+. .+.   .+. .+.+.   .|   
> >         |.+   +           +.+   +   +.+   +     +.+.+   +   +.+   +     +.+ |   
> >         |                                                                   |   
> >    8000 |-+                                                                 |   
> >         |                                                                   |   
> >    7000 |-+                                                                 |   
> >         |                                                                   |   
> >    6000 |-+                                                                 |   
> >         |                                                                   |   
> >         |                                                                   |   
> >    5000 |-+                                                                 |   
> >         |                                 O                                 |   
> >    4000 +-------------------------------------------------------------------+   
> >                                                                                 
> >                                                                                 
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> > 
> > 
> > 
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> > 
> > 
> > Thanks,
> > Oliver Sang
> > 
