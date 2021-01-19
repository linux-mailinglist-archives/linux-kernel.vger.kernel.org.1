Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F452FB85D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403846AbhASMYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:24:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:54319 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391066AbhASMPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:15:52 -0500
IronPort-SDR: YYjqQEtcqpj/gfL5aDo3lR0VagP7Ymy84OAVE/g1Z5AdwaZRjwF6xeBdXv7hNMrH0gtU9e4ElA
 2oRX5lfdvGZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="240455122"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="240455122"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 04:15:09 -0800
IronPort-SDR: vj+Apvp/8/VQRHEBXKQjBg/oMEfZ6oult7Y1XIAk4hbexeLre335bF1JWJUbuFhcIN21+ZpbwC
 Sz9Ju5KFMBLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="355572711"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 04:15:06 -0800
Date:   Tue, 19 Jan 2021 20:15:05 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210119121505.GA111354@shbuild999.sh.intel.com>
References: <20210112142109.GE30747@xsang-OptiPlex-9020>
 <20210112141438.GF13086@zn.tnic>
 <20210116035251.GB29609@shbuild999.sh.intel.com>
 <20210116153413.GP2743@paulmck-ThinkPad-P72>
 <20210116160921.GA101665@shbuild999.sh.intel.com>
 <20210119042721.GA12664@paulmck-ThinkPad-P72>
 <20210119100255.GC27433@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119100255.GC27433@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:02:55AM +0100, Borislav Petkov wrote:
> On Mon, Jan 18, 2021 at 08:27:21PM -0800, Paul E. McKenney wrote:
> > I bet that the results vary depending on the type of CPU, and also on
> > the kernel address-space layout, which of course also varies based on
> > the Kconfig options.  Let's see how the maintainers would like to proceed.
> 
> So I ran the "reproduce" script in the original mail on a KBL box here
> with the .config tailored for it:
> 
> cpu family      : 6
> model           : 158
> model name      : Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
> stepping        : 12
> microcode       : 0xd6

I will also try to find a similar KBL in 0day to run the job. This
-4.5% comes from a CascadeLake AP which is 4 nodes, 96C/192T.

> and I get mixed results. But I'd need to know how exactly they generate
> the metrics "netperf.Throughput_total_tps" and "netperf.Throughput_tps"
> 
> Feng?

I have to admit I'm just a dumb user of 0day :) I'll leave this question
to Philip/Oliver/Rong who are from 0day team.

I assumed you've cloned the lkp-tests.git, and seems one Ruby file
https://github.com/intel/lkp-tests/blob/master/stats/netperf is used to
process the output of the netperf.

Thanks,
Feng

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
