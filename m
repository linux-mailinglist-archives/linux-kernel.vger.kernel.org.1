Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2486B27E8B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgI3MlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgI3MlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:41:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601469677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=japR/FcTQ37gzZwkUqJJBnKu2O74T029FHS4Yb6cUIU=;
        b=JwHgssClqLuK1XIDBdnWajIKracsTtjojojvlZf+JXnVxfmPY694cYttyscQqRGzKuTS4C
        m+wsvU6Bj8LNzBRortWgpoMMOA2zvzKdXSXwSJC7i38HehlZLSBO086ygkEwk87hwyEIY8
        cP84rUn7B/BVOL2FO7PY0UqXoiFbqFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-6X2q-kI2OK6260zRtJ9Gfw-1; Wed, 30 Sep 2020 08:41:13 -0400
X-MC-Unique: 6X2q-kI2OK6260zRtJ9Gfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE9E364080;
        Wed, 30 Sep 2020 12:41:11 +0000 (UTC)
Received: from Diego (unknown [10.40.208.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19CF778806;
        Wed, 30 Sep 2020 12:41:08 +0000 (UTC)
Date:   Wed, 30 Sep 2020 14:41:07 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     kernel test robot <rong.a.chen@intel.com>
cc:     Jiri Olsa <jolsa@kernel.org>,
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
In-Reply-To: <20200930091943.GB393@shao2-debian>
Message-ID: <alpine.LRH.2.20.2009301439250.12057@Diego>
References: <20200930091943.GB393@shao2-debian>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. To me, it looks rather a random failure. Is it actually reproducible
and proven that the patch has caused it? The patch doesn't seem to cause
the fails below.
Cheers,
Michael

On Wed, 30 Sep 2020, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 977f739b7126bf98b5202e243f60cbc0a1ec2c3b ("perf report: Disable ordered_events for raw dump")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: perf-test
> version: perf-test-x86_64-git-1_20200717
> with following parameters:
> 
> 	type: lkp
> 	ucode: 0xd6
> 
> test-description: The internal Perf Test suite.
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> 2020-09-28 17:02:40 ./skid_test/run.sh
> Mon Sep 28 17:02:58 UTC 2020
> 3 test cases pass for skid_test test. 3 test cases fail for skid_test test.
> Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_with_NMI PASS!
> Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_with_NMI PASS!
> Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_with_NMI FAILED!
> Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_without_NMI_fixed_period PASS!
> Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_without_NMI_fixed_period FAILED!
> Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_without_NMI_fixed_period FAILED!
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Rong Chen
> 
> 

