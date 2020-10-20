Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F6293499
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbgJTGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391943AbgJTGML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603174330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2bbNCyi2EBWUT4bh/BUzR0gKWHNYcDtD9otqK0dudk=;
        b=I7F5ZiJ2b7edj9g0VT4nfQBOobveLdcOR65k2o2XGQqDfxoEo7ANGnZCoZD6yF0uCMXGPF
        19HUI4UL0nq7x2IqcEAS96Da1bGmpeJQsj5qnfQgBmoNuryvfyXYsIdcyxVTcY9GzbNm34
        F9dx3mE0IpbamJhY9Iabq/7eJJMiCMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-lzUE9TjIPh64DdiQD0tJTA-1; Tue, 20 Oct 2020 02:12:07 -0400
X-MC-Unique: lzUE9TjIPh64DdiQD0tJTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 716F31074653;
        Tue, 20 Oct 2020 06:12:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 18D4D5B4B3;
        Tue, 20 Oct 2020 06:12:00 +0000 (UTC)
Date:   Tue, 20 Oct 2020 08:11:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] perf: Make tsc testing as a common testing case
Message-ID: <20201020061159.GB2084117@krava>
References: <20201019100236.23675-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019100236.23675-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 06:02:34PM +0800, Leo Yan wrote:
> This patch set is to move tsc testing from x86 specific to common
> testing case.  Since Arnaldo found the building failure for patch set
> v4 [1], the first four patches have been merged but the last two patches
> were left out; this patch set is to resend the last two patches with
> fixed the building failure (by removing the header "arch-tests.h" from the
> testing code).
> 
> These two patches have been tested on x86_64 and Arm64.  Though I don't
> test them on archs MIPS, PowerPC, etc, I tried to search every header so
> ensure included headers are supported for all archs.
> 
> These two patches have been rebased on the perf/core branch with its
> latest commit 744aec4df2c5 ("perf c2c: Update documentation for metrics
> reorganization").
> 
> Changes from v5:
> * Found the merging confliction on latest perf/core, so rebased it.
> 
> [1] https://lore.kernel.org/patchwork/cover/1305382/#1505752
> 
> 
> Leo Yan (2):
>   perf tests tsc: Make tsc testing as a common testing
>   perf tests tsc: Add checking helper is_supported()

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/arch/x86/include/arch-tests.h      |  1 -
>  tools/perf/arch/x86/tests/Build               |  1 -
>  tools/perf/arch/x86/tests/arch-tests.c        |  4 ----
>  tools/perf/tests/Build                        |  1 +
>  tools/perf/tests/builtin-test.c               |  5 +++++
>  .../{arch/x86 => }/tests/perf-time-to-tsc.c   | 19 +++++++++++++++----
>  tools/perf/tests/tests.h                      |  2 ++
>  7 files changed, 23 insertions(+), 10 deletions(-)
>  rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (92%)
> 
> -- 
> 2.17.1
> 

