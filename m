Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00FB280AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbgJAXG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:06:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:38805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgJAXG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:06:56 -0400
IronPort-SDR: OT8YfXpzyf5Qfi1c7KCC2i61+pnCItzBXzFZgeq5h39FTFIt9DdACRrTLXunplFGS3NBUvX1f9
 +AuyxMfsLYfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="163716412"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="163716412"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 16:06:55 -0700
IronPort-SDR: uk+/ERHnTqAoNL6znz+qxeGNeHZ7ZAsPkcbsIadHN2V8DfCG2Sjj2FXP1jqpxYui4/5YAg15AR
 x1stSN17pswQ==
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="346250726"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 16:06:54 -0700
Date:   Thu, 1 Oct 2020 16:06:53 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
Message-ID: <20201001230653.GM50079@tassilo.jf.intel.com>
References: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 12:57:29AM +1300, Barry Song wrote:
> Commit 7736627b865d ("perf stat: Use affinity for closing file
> descriptors") will use FD(evsel, cpu, thread) to read and write
> file descriptors xyarray. For a kernel PMU event, this leads to
> serious memory corruption and perf crash.
> I have seen evlist->core.cpus->nr is 1 while evsel has cpus->nr
> with the total number of CPUs. so xyarray which is allocated by
> evlist->core.cpus->nr will get overflow. This leads to various
> segmentation faults in perf tool for kernel PMU events, eg:
> ./perf stat -e bus_cycles  sleep 1
> *** Error in `./perf': free(): invalid next size (fast): 0x00000000401e6370 ***
> Aborted (core dumped)

Thanks.

I believe there is already a patch queued for this.

The problem seems to only happen on ARM64.

-Andi
