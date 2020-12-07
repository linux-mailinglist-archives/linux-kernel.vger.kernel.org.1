Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3576D2D0E7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLGKys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgLGKyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:54:47 -0500
Date:   Mon, 7 Dec 2020 10:53:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607338446;
        bh=1oou2RFP/SKwiJkBvHYPfbfrjSBKYsSmyIsovvwhrcQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwNHFxC2ppcoTe2xqpFwZMHqqkbdNDlPaUPPsivySCHE1x7htTD8AezIRtMQC8Xqk
         mx0rbCRLYPCgemajWzSjJsI5v8lddp1pxLoTa1PPGDLjqUnEAFDqlzrq2HNoH+mE3s
         z9kTKLRHQfX8hR0X0CfYVmp/t86IiNLY1J2nyeCX4CbAtO+RimMSrSEzVnNEv4iZ0o
         L4CHOd+T2hsh2IfiYkwidgvJdbT68AOvTVFUDEKoCutxEQUQTLBMMlLkxl9BAl/zVG
         OjfZB52wRaGT6MU2BuhtqGu/zDT2SXAgXJm4LwC+bSBDv8Vt2Os5jcrlc6IRHR6wYJ
         XgfdP8PJlp6cg==
From:   Will Deacon <will@kernel.org>
To:     Chanho Park <parkch98@gmail.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] perf arm pmu: fix build error on MUSL libc
Message-ID: <20201207105359.GA4198@willie-the-truck>
References: <20201206144527.1670483-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206144527.1670483-1-chanho61.park@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 11:45:27PM +0900, Chanho Park wrote:
> __always_inline can cause build error on musl libc. The fix patch has
> submitted but not merged yet[1]. To build perf tool with musl libc,
> <linux/stddef.h> inclusion is necessary and it should be included before
> perf_event.h.
> 
> from /usr/include/linux/byteorder/little_endian.h:13,
> from /usr/include/asm/byteorder.h:23,
> from tools/include/uapi/linux/perf_event.h:20,
> from arch/arm64/util/../../arm/util/pmu.c:9:
> 
> /usr/include/linux/swab.h:171:8: error: unknown type name '__always_inline'
>   171 | static __always_inline __u16 __swab16p(const __u16 *p)
>       |        ^~~~~~~~~~~~~~~
> 
> [1]: https://lkml.org/lkml/2018/9/13/78
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Khem Raj <raj.khem@gmail.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  tools/perf/arch/arm/util/pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index bbc297a7e2e3..4c0357e8c0ab 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -6,6 +6,9 @@
>  
>  #include <string.h>
>  #include <linux/coresight-pmu.h>
> +#if !defined(__GLIBC__)
> +#include <linux/stddef.h>
> +#endif

Looks like other files just include this unconditionally, but have a comment
explaining why. See util/branch.h and util/event.h. Maybe we should do the
same for util/pmu.h, which is already included here?

Will
