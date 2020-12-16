Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14E2DC369
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgLPPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgLPPtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:49:42 -0500
Date:   Wed, 16 Dec 2020 12:49:14 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608133741;
        bh=1uBKVHJd8VxnuyjpoJ4tyy/dpjzMoXI6BFG/eU1uIWg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKkpw6yb0sWw4IDVGdIvhvb750zynZAqhC99loh5kUDvydFcDsdBP5gTGP6exh07U
         +Y28MDB5bO1lJCAx+0xkeShRaudDxpgc7spxLcCoLtN5AH1NqVTsybfQF2ObZv+AH3
         Dj9ryWvdJxRDvPEETGAyinMa8DrvvcYKWh+FFqhw3PqP4Uud3U4N9ruwTf7DXwYKnI
         o0S0w2nJ7Tmz9/FNO5stpZrA7EFPRI/goRQxrFkq8mY8LYyDCMEtHobLhxGLIw6UUG
         Mqz5xWzBAMG1QqiJRuy/YR6obgc9wncEn6ugBvz//MH+Jn2iWfSlgZl6VHuwCQJeut
         HzGxesNFqSsmQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 02/12] perf record: Support new sample type for data
 page size
Message-ID: <20201216154914.GB297512@kernel.org>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-3-kan.liang@linux.intel.com>
 <20201207170759.GB129853@kernel.org>
 <124d0414-f834-e2f0-8359-50488add60d1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124d0414-f834-e2f0-8359-50488add60d1@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 07, 2020 at 03:25:07PM -0500, Liang, Kan escreveu:
> 
> 
> On 12/7/2020 12:07 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Nov 30, 2020 at 09:27:53AM -0800, kan.liang@linux.intel.com escreveu:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Support new sample type PERF_SAMPLE_DATA_PAGE_SIZE for page size.
> > > 
> > > Add new option --data-page-size to record sample data page size.
> > 
> > So, trying this on a kernel without this feature I get:
> > 
> > [acme@five perf]$ perf record --data-page-size sleep 1
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles:u).
> > /bin/dmesg | grep -i perf may provide additional information.
> > 
> > [acme@five perf]$
> > 
> > I'm adding the following patch right after yours, next time please test
> > this and provide a similar error message.
> > 
> 
> Sorry, I missed it.
> 
> Besides the PERF_SAMPLE_DATA_PAGE_SIZE, I think we have to fix the
> PERF_SAMPLE_CODE_PAGE_SIZE as well.
> Should I send a separate patch to fix it?

I've got back to this and what I have is out in acme/perf/core, so you can
continue from there.

I had to add the patch below to fix 'perf test "Sample parsing"'.

- Arnaldo

commit eec7b53d59167a1063e704f86ec0aa36ff765e1a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Dec 16 12:45:10 2020 -0300

    perf test: Make sample-parsing test aware of PERF_SAMPLE_{CODE,DATA}_PAGE_SIZE
    
    To fix this:
    
      $ perf test -v "Sample parsing".
      27: Sample parsing                                                  :
      --- start ---
      test child forked, pid 586013
      sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating
      test child finished with -1
      ---- end ----
      Sample parsing: FAILED!
      $
    
    This patchset is still not completely merged, so when adding the
    PERF_SAMPLE_CODE_PAGE_SIZE to 'struct perf_sample' we need to add the
    bits added in this patch for 'perf_sample.data_page_size'.
    
    Fixes: 251cc77b8176de37 ("tools headers UAPI: Update tools's copy of linux/perf_event.h")
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index a0bdaf390ac8ea78..2393916f6128a6fb 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -154,6 +154,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_CGROUP)
 		COMP(cgroup);
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		COMP(data_page_size);
+
 	if (type & PERF_SAMPLE_AUX) {
 		COMP(aux_sample.size);
 		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
@@ -234,6 +237,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		},
 		.phys_addr	= 113,
 		.cgroup		= 114,
+		.data_page_size = 115,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -340,7 +344,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CGROUP << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CODE_PAGE_SIZE << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
