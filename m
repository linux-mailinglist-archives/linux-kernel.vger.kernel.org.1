Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B128C516
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbgJLXET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:04:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:56679 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgJLXES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:04:18 -0400
IronPort-SDR: 7qKY9lxU+5mmGRztc/7/18CEr+wqvYRCi5oO8DXPpqXLT7tmxX0cvMDhm904/qr9+ttWkCv8Jq
 FEXLv6CCR12Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165029576"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="165029576"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 16:04:17 -0700
IronPort-SDR: jEnIP4wB77BIL1VjPSes2BsTJLTkvxBfedty6Z5NB+2nNstxTVSM8M6uUrI3hWGpHok6KlTaY9
 2pzDAXWEyIeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="530153144"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2020 16:04:15 -0700
Date:   Tue, 13 Oct 2020 07:01:18 +0800
From:   Philip Li <philip.li@intel.com>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mac80211_hwsim] 148fe295b7: hwsim.ap_long_preamble.fail
Message-ID: <20201012230118.GA19671@intel.com>
References: <20201002082945.GJ393@shao2-debian>
 <ffe9deeeb714d233c47d693c899f9577@adapt-ip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe9deeeb714d233c47d693c899f9577@adapt-ip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:38:45AM -0700, Thomas Pedersen wrote:
> On 2020-10-02 01:29, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 148fe295b7d9d892b2b0f47070233ccdc70c83cd ("mac80211_hwsim:
> > indicate support for S1G")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > 
> > in testcase: hwsim
> > version: hwsim-x86_64-6eb6cf0-1_20200619
> > with following parameters:
> > 
> > 	group: hwsim-04
> > 	ucode: 0x21
> > 
> > 
> > 
> > on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz
> > with 16G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire
> > log/backtrace):
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > 2020-10-06 00:22:09 	./run-tests.py ap_long_preamble
> > DEV: wlan0: 02:00:00:00:00:00
> > DEV: wlan1: 02:00:00:00:01:00
> > DEV: wlan2: 02:00:00:00:02:00
> > APDEV: wlan3
> > APDEV: wlan4
> > START ap_long_preamble 1/1
> > Test: AP with long preamble
> > Starting AP wlan3
> > Failed to enable hostapd interface wlan3
> > Traceback (most recent call last):
> >   File "./run-tests.py", line 533, in main
> >     t(dev, apdev)
> >   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_params.py", line
> > 821, in test_ap_long_preamble
> >     hapd = hostapd.add_ap(apdev[0], params)
> >   File "/lkp/benchmarks/hwsim/tests/hwsim/hostapd.py", line 581, in
> > add_ap
> >     hapd.enable()
> >   File "/lkp/benchmarks/hwsim/tests/hwsim/hostapd.py", line 248, in
> > enable
> >     raise Exception("Failed to enable hostapd interface " + self.ifname)
> > Exception: Failed to enable hostapd interface wlan3
> > FAIL ap_long_preamble 0.064398 2020-10-06 00:22:09.608978
> > passed 0 test case(s)
> > skipped 0 test case(s)
> > failed tests: ap_long_preamble
> 
> This is actually a bug in hostap which was exposed by this commit (and fixed
> by https://patchwork.ozlabs.org/project/hostap/patch/20200827225940.18151-1-thomas@adapt-ip.com/).
Thanks for the info, we have upgraded hwsim test suite to contain this fix.
And apologize for the false positive.

> 
> -- 
> thomas
> 
