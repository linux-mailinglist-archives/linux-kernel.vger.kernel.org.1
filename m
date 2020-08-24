Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5510F25016E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHXPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:48:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:36560 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgHXPsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:48:23 -0400
IronPort-SDR: ZK1JCUw0SgOyHqNhlS2T+86/N1AOFFpAtUAafJDskC8OmaDquyhgdQ/weNM6+cm/AMrjpTbNY6
 hbyvAgMNWwZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="217464446"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="217464446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:48:23 -0700
IronPort-SDR: jnr+6qjcEgTvvkrseGxF9XNoE+ylVqyWrTlX6PSSkmeE1x9y2/sRY5ZuFhMsWRjCMTaBQ+QP8R
 8K22yHgo/jJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="298757873"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2020 08:48:21 -0700
Date:   Mon, 24 Aug 2020 23:48:18 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Mel Gorman <mgorman@suse.com>
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200824154818.GB56944@shbuild999.sh.intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <6e996ad05e434a6fb13f069ee72b876b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e996ad05e434a6fb13f069ee72b876b@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:38:53PM +0800, Luck, Tony wrote:
> > Yes, that's what we suspected. And I just did another try to force the
> > percpu mce structure aligned. And the regression seems to be gone (reduced
> > from 14.1% to 2%), which further proved it.
> 
> I wonder whether it would be useful for bisection of performance issues
> for you to change the global definition of DEFINE_PER_CPU() to make
> all per CPU definitions aligned. Just like you switch compiler flags to make
> all functions aligned.

Thanks for the hint! This will definitely help tracking strange performance
changes like this, as a general debug mthod.

Thanks,
Feng

> 
> -Tony
