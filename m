Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAFA2CB561
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLBG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:57:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:7461 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgLBG5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:57:15 -0500
IronPort-SDR: sFhi2PLOeMR2FqbWHROti706EjvwTpZO3GEGdyRAoWBc/pWEURBnyooTgz4Gn32yG8wqhKlE+G
 fVsRuJcGKAHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191177299"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="191177299"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:55:28 -0800
IronPort-SDR: 6zOGQ4OUp/IhOQcWblEiSI5CyWmGZlxJZG7LbmCkqPjOo++OgKlAe76NffYmKTf4R39RA1Z+eD
 k2DkgMWOYaJw==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="365157555"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:55:28 -0800
Date:   Tue, 1 Dec 2020 22:55:26 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v4 5/5] perf metric: Don't compute unused events.
Message-ID: <20201202065526.GE1363814@tassilo.jf.intel.com>
References: <20201202062646.3780002-1-irogers@google.com>
 <20201202062646.3780002-6-irogers@google.com>
 <20201202063657.GC1363814@tassilo.jf.intel.com>
 <CAP-5=fVMuRCZEyG+s3z2gw3OvcDdtE1Kwe-7LG7uXOKfwmzFcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVMuRCZEyG+s3z2gw3OvcDdtE1Kwe-7LG7uXOKfwmzFcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>      Can't this be all in a macro? It's still a lot of duplication.
> 
>      I'm still not a fan, but I think with a macro it wouldn't be too bad.
> 
>    Ugh, not a fan of macros. They expand to a single line of code and make
>    debugging hard. I'll do a v5 with a macro :-/

I suppose you could inlines with callbacks too, with one liner functions for
the operands.

-Andi
