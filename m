Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794BF2D171F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgLGRIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLGRIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:08:31 -0500
Date:   Mon, 7 Dec 2020 14:07:59 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607360870;
        bh=a970EhfEbrk/JJVxpU7b8914DtQrmf35iq1oze/2Jwk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=X33xqTvKYo2ZJ9q8j2VkzanU17YO2fSkwLlPwvJfEl+MXCNEHU8/ng2c0HRrFAgLr
         0lHMCHvvSePpUKaUIAbNRnImNiimGg2p1SWO8a+NjNt61y0fRwAYO4vnBjLKbamjN8
         HFkPMhT+m3A+X/zIxGIrC/CFQSHCtk4O9zf292JCEmZs/qJT+1hghdx9jxs+V42UMk
         sSUqR+8Xz+E6ooDFtj0bvOoejk/P5cMck8iLmX0zZ/8Y6QZTXxp/Qz6LWmTuA8Be9v
         kbpX18o3kolmvwckfFtSO/7nrj87YVwpYqJZ9FJiklMEFUsaw75OHhvM54T2ANF0jJ
         mnxZAcCIqN7/Q==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 02/12] perf record: Support new sample type for data
 page size
Message-ID: <20201207170759.GB129853@kernel.org>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130172803.2676-3-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 30, 2020 at 09:27:53AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Support new sample type PERF_SAMPLE_DATA_PAGE_SIZE for page size.
> 
> Add new option --data-page-size to record sample data page size.

So, trying this on a kernel without this feature I get:

[acme@five perf]$ perf record --data-page-size sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles:u).
/bin/dmesg | grep -i perf may provide additional information.

[acme@five perf]$

I'm adding the following patch right after yours, next time please test
this and provide a similar error message.

- Arnaldo

commit 2044fec7fcc6070b09f9b6a67922b0b9e4295dba
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Dec 7 14:04:05 2020 -0300

    perf evsel: Emit warning about kernel not supporting the data page size sample_type bit
    
    Before we had this unhelpful message:
    
      $ perf record --data-page-size sleep 1
      Error:
      The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles:u).
      /bin/dmesg | grep -i perf may provide additional information.
      $
    
    Add support to the perf_missing_features variable to remember what
    caused evsel__open() to fail and then use that information in
    evsel__open_strerror().
    
      $ perf record --data-page-size sleep 1
      Error:
      Asking for the data page size isn't supported by this kernel.
      $
    
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Michael Ellerman <mpe@ellerman.id.au>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Will Deacon <will@kernel.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5e6085c3fc761a55..c26ea82220bd8625 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1873,7 +1873,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-        if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+        if (!perf_missing_features.data_page_size &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
+		perf_missing_features.data_page_size = true;
+		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
+		goto out_close;
+	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
 		perf_missing_features.cgroup = true;
 		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
 		goto out_close;
@@ -2673,6 +2678,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 	"We found oprofile daemon running, please stop it and try again.");
 		break;
 	case EINVAL:
+		if (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE && perf_missing_features.data_page_size)
+			return scnprintf(msg, size, "Asking for the data page size isn't supported by this kernel.");
 		if (evsel->core.attr.write_backward && perf_missing_features.write_backward)
 			return scnprintf(msg, size, "Reading from overwrite event is not supported by this kernel.");
 		if (perf_missing_features.clockid)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 79a860d8e3eefe23..cd1d8dd431997b84 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -144,6 +144,7 @@ struct perf_missing_features {
 	bool aux_output;
 	bool branch_hw_idx;
 	bool cgroup;
+	bool data_page_size;
 };
 
 extern struct perf_missing_features perf_missing_features;
