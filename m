Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0B2AFAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgKKVqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:46:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:44753 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKKVqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:46:50 -0500
IronPort-SDR: TdcOOrJN+puDRrfGADOXqEOyRA0EifYoYes/Et/fTT93BtxbKrqDIaeD2zH52mJ0xXoeA9gizr
 w6F0pSgRAlWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="231844127"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="231844127"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 13:46:50 -0800
IronPort-SDR: cz5CgVbwdT157QTQboiueYidKYb0axhJb0JOK2cbV0rMamqr1eYLOXOk1HQ6IVTX5QrM9+0sgz
 6dg8kYBFGceQ==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="354983260"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 13:46:50 -0800
Date:   Wed, 11 Nov 2020 13:46:46 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] Topdown parser
Message-ID: <20201111214635.GA894261@tassilo.jf.intel.com>
References: <20201110100346.2527031-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:03:34AM -0800, Ian Rogers wrote:
> This RFC is for a new tool that reads TMA_Metrics.csv as found on
> download.01.org/perfmon and generates metrics and metric groups from
> it. To show the functionality the TMA_Metrics.csv is downloaded, but
> an accepted change would most likely include a copy of this file from
> Intel. With this tool rather than just level 1 topdown metrics, a full
> set of topdown metrics to level 4 are generated.

I'm not sure I understand the motivation for making the spreadsheet parsing
part of the perf tool? It only needs to run once when the metrics are generated
to build perf.

FWIW I did something similar in python (that's how the current metrics
json files were generated from the spreadsheet) and it was a lot
simpler and shorter in a higher level language.

One problem I see with putting the full TopDown model into perf is 
that to do a full job it requires a lot more infrastructure that is
currently not implemented in metrics: like an event scheduler,
hierarchical thresholding over different nodes, SMT mode support etc.

I implemented it all in toplev, but it was a lot of work to get it all right.
I'm not saying it's not doable, but it will be a lot of additional work
to work out all the quirks using the metrics infrastructure.

I think adding one or two more levels is probably ok, but doing all levels
without these mechanisms might be difficult to use in the end.

-Andi
