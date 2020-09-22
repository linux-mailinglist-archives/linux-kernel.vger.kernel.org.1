Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2527497D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIVTun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:50:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:21699 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVTun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:50:43 -0400
IronPort-SDR: MUl1UcJZw/fESt+MydABCh26nT+d5X2MSA+tFuKsKrfbTcaDyFu60yrBRorYGDauSvfqnm7naj
 yKT9WsUxD8gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="224854573"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="224854573"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 12:50:39 -0700
IronPort-SDR: 5Zp3q7bqiagXrW4yXDtHWAo51m8BHS/JEsCqhw7KJSPsSoW8cYjsLPjvGoTR0UQ7o79MSH5dS2
 +iq1S16j2z/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="291411874"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2020 12:50:35 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4B453301C71; Tue, 22 Sep 2020 12:50:35 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:50:35 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Message-ID: <20200922195035.GA42577@tassilo.jf.intel.com>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com>
 <20200922192321.GL13818@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922192321.GL13818@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:23:21PM -0700, Andi Kleen wrote:
> > After debugging, i found the root reason is that the xyarray fd is created
> > by evsel__open_per_thread() ignoring the cpu passed in
> > create_perf_stat_counter(), while the evsel' cpumap is assigned as the
> > corresponding PMU's cpumap in __add_event(). Thus, the xyarray fd is created
> > with ncpus of dummy cpumap and an out of bounds 'cpu' index will be used in
> > perf_evsel__close_fd_cpu().
> > 
> > To address this, add a flag to mark this situation and avoid using the
> > affinity technique when closing/enabling/disabling events.
> 
> The flag seems like a hack. How about figuring out the correct number of 
> CPUs and using that?

Also would like to understand what's different on ARM64 than other architectures.
Or could this happen on x86 too?

-Andi
