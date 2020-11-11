Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548B82AF713
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKKRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:01:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:11035 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgKKRBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:01:33 -0500
IronPort-SDR: oGePMO0PuUmBtzFQAc5t6/qrzcfn83uPYfK11SCdR7/zndcntNHI/22fWt15zdB45b/SRFePBV
 FntH/4bhxIBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="169393419"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="169393419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 09:00:49 -0800
IronPort-SDR: b2AZ/erPk+w6/U+0ava8raATh6xzlxM1plaWf+6YSQQVvjiT3jco99LcGPrh2OfDJ8buLQckrn
 aUNcT3yBXptA==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="354898270"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 09:00:48 -0800
Date:   Wed, 11 Nov 2020 09:00:46 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/24] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201111170046.GB466880@tassilo.jf.intel.com>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-25-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109215415.400153-25-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:54:15PM +0100, Jiri Olsa wrote:
> Adding --buildid-mmap option to enable build id in mmap2 events.
> It will only work if there's kernel support for that and it disables
> build id cache (implies --no-buildid).

What's the point of the option? Why not enable it by default
if the kernel supports it?

With the option most user won't get the benefit.

The only reason I can think of for an option would be to disable
so that old tools can still process.

-Andi
