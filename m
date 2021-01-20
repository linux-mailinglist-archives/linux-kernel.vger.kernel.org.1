Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02AA2FCAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 06:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbhATFtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 00:49:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:56688 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbhATFtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 00:49:00 -0500
IronPort-SDR: 7Qj265oUfyhxVNOVZ26kSLsUbTQkBdeG6Fzd06CObxvumesFwWB1vD4x5Uqz8YjU9vAgiBqsTn
 O1UUEzC+mxHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="197772779"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="197772779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 21:48:19 -0800
IronPort-SDR: cze3eNIFhrm9+YB8Y1pX59WbACbPhMknXaZiQAQf1/WyZfzFuyzptPRl9wjOiAuwuBJAXcg+1y
 dC6ZHIJXG86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="384433394"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2021 21:48:16 -0800
Date:   Wed, 20 Jan 2021 13:48:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210120054815.GA83476@shbuild999.sh.intel.com>
References: <20210112141438.GF13086@zn.tnic>
 <20210116035251.GB29609@shbuild999.sh.intel.com>
 <20210116153413.GP2743@paulmck-ThinkPad-P72>
 <20210116160921.GA101665@shbuild999.sh.intel.com>
 <20210119042721.GA12664@paulmck-ThinkPad-P72>
 <20210119100255.GC27433@zn.tnic>
 <20210119121505.GA111354@shbuild999.sh.intel.com>
 <20210119131759.GL27433@zn.tnic>
 <20210119150903.GA21908@shbuild999.sh.intel.com>
 <20210119153350.GM27433@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119153350.GM27433@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 04:33:50PM +0100, Borislav Petkov wrote:
> On Tue, Jan 19, 2021 at 11:09:03PM +0800, Feng Tang wrote:
> > Yes, that can happen. I started a 4 tasks netperf on a 4C/8T KBL desktop,
> > and also saw around 2% improvement. Both the kernel config and the
> > platform matters.
> 
> Oh great. ;-\
> 
> > For the performance changes I have checked, sometimes the change can be
> > reproduced on platforms of different generations (the exact delta number
> > may differs), sometimes it can only be reproduced on one specific platform,
> > like some old generation, or special one like Xeon Phi.
> 
> Probably because that Xeon Phi thing is not as powerful cache-wise as
> some newer ones which have bigger caches and smarter hw prefetchers,
> etc.

Yes, cache size/architecture/policy plays a critical role in these
benchmarking, which is our first thing to check for these strange
kernel performance changes.

Thanks,
Feng
