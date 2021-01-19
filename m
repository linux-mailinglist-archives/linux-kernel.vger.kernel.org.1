Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51212FBE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbhASSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:03:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:25149 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731579AbhASPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:09:48 -0500
IronPort-SDR: avp2JOxGA+t9j8bnwIJUeARcO8jUiDH3u2z5nDU94klEwd1p+dCNW9mzhY1x+pUpgt3qvpc+S0
 5kDuV14bC7Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158120166"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158120166"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 07:09:07 -0800
IronPort-SDR: MsgoQPqvrTfosBebGgkoYq6V3sQJ6hFFy79yIQMfKjoSlSKN0NufMINSN4E795rOeQnytD32ns
 qseCgcci07ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="383969690"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2021 07:09:04 -0800
Date:   Tue, 19 Jan 2021 23:09:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210119150903.GA21908@shbuild999.sh.intel.com>
References: <20210112142109.GE30747@xsang-OptiPlex-9020>
 <20210112141438.GF13086@zn.tnic>
 <20210116035251.GB29609@shbuild999.sh.intel.com>
 <20210116153413.GP2743@paulmck-ThinkPad-P72>
 <20210116160921.GA101665@shbuild999.sh.intel.com>
 <20210119042721.GA12664@paulmck-ThinkPad-P72>
 <20210119100255.GC27433@zn.tnic>
 <20210119121505.GA111354@shbuild999.sh.intel.com>
 <20210119131759.GL27433@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119131759.GL27433@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, Jan 19, 2021 at 02:17:59PM +0100, Borislav Petkov wrote:
> On Tue, Jan 19, 2021 at 08:15:05PM +0800, Feng Tang wrote:
> > On Tue, Jan 19, 2021 at 11:02:55AM +0100, Borislav Petkov wrote:
> > > On Mon, Jan 18, 2021 at 08:27:21PM -0800, Paul E. McKenney wrote:
> > > > I bet that the results vary depending on the type of CPU, and also on
> > > > the kernel address-space layout, which of course also varies based on
> > > > the Kconfig options.  Let's see how the maintainers would like to proceed.
> > > 
> > > So I ran the "reproduce" script in the original mail on a KBL box here
> > > with the .config tailored for it:
> > > 
> > > cpu family      : 6
> > > model           : 158
> > > model name      : Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
> > > stepping        : 12
> > > microcode       : 0xd6
> > 
> > I will also try to find a similar KBL in 0day to run the job. This
> > -4.5% comes from a CascadeLake AP which is 4 nodes, 96C/192T.
> > 
> > > and I get mixed results. But I'd need to know how exactly they generate
> > > the metrics "netperf.Throughput_total_tps" and "netperf.Throughput_tps"
> > > 
> > > Feng?
> > 
> > I have to admit I'm just a dumb user of 0day :) I'll leave this question
> > to Philip/Oliver/Rong who are from 0day team.
> > 
> > I assumed you've cloned the lkp-tests.git, and seems one Ruby file
> > https://github.com/intel/lkp-tests/blob/master/stats/netperf is used to
> > process the output of the netperf.
> 
> $ ../lkp-tests/stats/netperf  < rc2.log
> Throughput_tps: 12759.701875000002
> Throughput_total_tps: 204155.23000000004
> workload: 61246569.000000015
> 
> $ ../lkp-tests/stats/netperf  < with-holdout.log
> Throughput_tps: 12863.416875
> Throughput_total_tps: 205814.67
> workload: 61744401.00000001
> 
> So this definitely depends on the .config because in my case, *with* the
> holdout patch it is better vs plain 5.11-rc2.

Yes, that can happen. I started a 4 tasks netperf on a 4C/8T KBL desktop,
and also saw around 2% improvement. Both the kernel config and the
platform matters.

For the performance changes I have checked, sometimes the change can be
reproduced on platforms of different generations (the exact delta number
may differs), sometimes it can only be reproduced on one specific platform,
like some old generation, or special one like Xeon Phi.

Thanks,
Feng

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
