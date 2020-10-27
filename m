Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C429CC86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 00:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507629AbgJ0XD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 19:03:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:1277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507603AbgJ0XD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:03:27 -0400
IronPort-SDR: Fq+uNb5LRdBRwsmT1ix9+lIgI9+ZgxTAss6a0gFPf7HTslf9Wxjzzrvvp0w6+rOFxE+zpTZwnZ
 s/6U8Ccy7k8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="185926627"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="185926627"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 16:03:11 -0700
IronPort-SDR: nWivGKt7mr8FknP9Bw0UC726cpQlPoD7qwD0O4Xr8/Ir528rZSeQu7tNjLXYh5pvIBztJNXCy8
 /N4+a3Gl9QjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="524909663"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga006.fm.intel.com with ESMTP; 27 Oct 2020 16:03:09 -0700
Date:   Wed, 28 Oct 2020 07:00:39 +0800
From:   Philip Li <philip.li@intel.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     kernel test robot <lkp@intel.com>,
        Geliang Tang <geliangtang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, mptcp@lists.01.org,
        lkp@lists.01.org
Subject: Re: [MPTCP] Re: [selftests] f2ff7f11f9: WARNING:suspicious_RCU_usage
Message-ID: <20201027230039.GA25647@intel.com>
References: <20201027131624.GO31092@shao2-debian>
 <c971b9f8-fd4a-292f-a7d8-8f6ef43c347e@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c971b9f8-fd4a-292f-a7d8-8f6ef43c347e@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:07:28PM +0100, Matthieu Baerts wrote:
> Hi all,
> 
> On 27/10/2020 14:16, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: f2ff7f11f9a74842245db52d685bf9bc7ac2c4b1 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
> > https://github.com/multipath-tcp/mptcp_net-next.git export
> 
> Thanks for the maintainer of the kernel test robot at Intel for this bug
> report!
thanks, you are welcome!

> 
> FYI, this was already reported earlier:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/issues/102
Thanks for the info, we didn't notice this. We will take a look
of reported issues in future to avoid duplicated report.

> 
> And Geliang is working on a fix (a v2 is available).
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> _______________________________________________
> mptcp mailing list -- mptcp@lists.01.org
> To unsubscribe send an email to mptcp-leave@lists.01.org
