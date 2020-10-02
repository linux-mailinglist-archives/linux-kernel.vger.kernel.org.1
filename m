Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57686280D24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 07:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgJBFqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 01:46:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:30079 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgJBFqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 01:46:05 -0400
IronPort-SDR: l/PiKGKKpIWPxDb4vtadNe6sKVTezqCa2AF6qxufU0H/R/vBhF3E2zXGYnD0mirEQ/1BL6lmGI
 MjE9xiZSNPew==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160253799"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="160253799"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 22:46:04 -0700
IronPort-SDR: ZEMbEXiYoOiCKoQUx3OEMk45GKj/zcRfMBY9fV2ndS0PZDoNoPGHy6CQBY8Kcao6Qi25sZOKL9
 NFiOdDRoHkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="515048858"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2020 22:46:02 -0700
Date:   Fri, 2 Oct 2020 13:42:45 +0800
From:   Philip Li <philip.li@intel.com>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [perf report] 977f739b71:
 perf-test.skid_test.round2.MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_withou
 t_NMI_fixed_period.fail
Message-ID: <20201002054245.GE30771@intel.com>
References: <20200930091943.GB393@shao2-debian>
 <alpine.LRH.2.20.2009301439250.12057@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2009301439250.12057@Diego>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 02:41:07PM +0200, Michael Petlan wrote:
> Hello. To me, it looks rather a random failure. Is it actually reproducible
> and proven that the patch has caused it? The patch doesn't seem to cause
thanks for the input, we will look into this and provide update. Now since
we are in Chinese national holiday (until Oct 9), please allow some time
before we get back to work on this.

Thanks

> the fails below.
> Cheers,
> Michael
> 
> On Wed, 30 Sep 2020, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 977f739b7126bf98b5202e243f60cbc0a1ec2c3b ("perf report: Disable ordered_events for raw dump")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: perf-test
> > version: perf-test-x86_64-git-1_20200717
> > with following parameters:
> > 
> > 	type: lkp
> > 	ucode: 0xd6
> > 
> > test-description: The internal Perf Test suite.
> > 
> > 
> > on test machine: 4 threads Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz with 32G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > 2020-09-28 17:02:40 ./skid_test/run.sh
> > Mon Sep 28 17:02:58 UTC 2020
> > 3 test cases pass for skid_test test. 3 test cases fail for skid_test test.
> > Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_with_NMI PASS!
> > Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_with_NMI PASS!
> > Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_with_NMI FAILED!
> > Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_without_NMI_fixed_period PASS!
> > Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_without_NMI_fixed_period FAILED!
> > Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_without_NMI_fixed_period FAILED!
> > 
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> > 
> > 
> > 
> > Thanks,
> > Rong Chen
> > 
> > 
> 
