Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E7B2E2565
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgLXIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 03:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgLXIOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 03:14:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5DCC229CA;
        Thu, 24 Dec 2020 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608797619;
        bh=jG/HDfzJ8x1rN86dqlQ/8a0VNxCUVr9L4c/b5HGWkqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ap1xWWbDv1y8pk6WiDBAaVC1lMxL2o9T/GYgc6IfX+0ZyIDtA0eVcRePzYGu4jt06
         i27db4k5pCKSxFEuZQTtI+GsgIgpI89kiTm20GcpW32s+SKXg+Yv4hbgjVYyp55PkB
         hGl5jTcnu/VtZ4rumgpMV9HB5gt9Q+vw/W0mNNaxYqPwbtQc9dV0wVZRMQr2qhKWpX
         7bu2dkimsNJ2faZYw+ngiooW8FETIGCdW4Qc8CVdW3RahNn+u3jep79Y9cGSMKxjoH
         ayNZFUiY7NNwXSo3GyY2VRFYEUbiTKcN0T9i/8phSaaj/sRugmjZKFGgzbHOTGDJZ4
         hJm0e+rRErShg==
Date:   Thu, 24 Dec 2020 17:13:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        He Zhe <zhe.he@windriver.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] perf arm64: Support SDT
Message-Id: <20201224171333.b3fe418e3c5a1e3a6f46e00a@kernel.org>
In-Reply-To: <20201223063905.25784-1-leo.yan@linaro.org>
References: <20201223063905.25784-1-leo.yan@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Wed, 23 Dec 2020 14:39:03 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> This patch is to enable SDT on Arm64.
> 
> Since Arm64 SDT marker in ELF file is different from other archs,
> especially for using stack pointer (sp) to retrieve data for local
> variables, patch 01 is used to fixup the arguments for this special
> case.  Patch 02 is to add argument support for Arm64 SDT.

Both patches look good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org> for the seires.

Thank you!

> 
> This patch set has been verified on Arm64/x86_64 platforms with a
> testing program usdt_test [1].  The program run the SDT interfaces
> one by one for DTRACE_PROBE, DTRACE_PROBE1, ..., DTRACE_PROBE12, so
> it tries to verify probe with different count of arguments (the
> arguments count is 0 to 12).
> 
> The testing flow and result are shown as below:
> 
>   # perf buildid-cache --add /root/test/usdt_test
>   # perf probe sdt_usdt:test_probe
>   # perf probe sdt_usdt:test_probe_param1
>   # perf probe sdt_usdt:test_probe_param1x
>   # perf probe sdt_usdt:test_probe_param2
>   # perf probe sdt_usdt:test_probe_param2x
>   # perf probe sdt_usdt:test_probe_param3
>   # perf probe sdt_usdt:test_probe_param3x
>   # perf probe sdt_usdt:test_probe_param4
>   # perf probe sdt_usdt:test_probe_param4x
>   # perf probe sdt_usdt:test_probe_param5
>   # perf probe sdt_usdt:test_probe_param5x
>   # perf probe sdt_usdt:test_probe_param6
>   # perf probe sdt_usdt:test_probe_param6x
>   # perf probe sdt_usdt:test_probe_param7
>   # perf probe sdt_usdt:test_probe_param7x
>   # perf probe sdt_usdt:test_probe_param8
>   # perf probe sdt_usdt:test_probe_param8x
>   # perf probe sdt_usdt:test_probe_param9
>   # perf probe sdt_usdt:test_probe_param9x
>   # perf probe sdt_usdt:test_probe_param10
>   # perf probe sdt_usdt:test_probe_param10x
>   # perf probe sdt_usdt:test_probe_param11
>   # perf probe sdt_usdt:test_probe_param11x
>   # perf probe sdt_usdt:test_probe_param12
>   # perf probe sdt_usdt:test_probe_param12x
> 
>   # perf record \
>         -e sdt_usdt:test_probe_param1 -e sdt_usdt:test_probe_param1x \
>         -e sdt_usdt:test_probe_param2 -e sdt_usdt:test_probe_param2x \
>         -e sdt_usdt:test_probe_param3 -e sdt_usdt:test_probe_param3x \
>         -e sdt_usdt:test_probe_param4 -e sdt_usdt:test_probe_param4x \
>         -e sdt_usdt:test_probe_param5 -e sdt_usdt:test_probe_param5x \
>         -e sdt_usdt:test_probe_param6 -e sdt_usdt:test_probe_param6x \
>         -e sdt_usdt:test_probe_param7 -e sdt_usdt:test_probe_param7x \
>         -e sdt_usdt:test_probe_param8 -e sdt_usdt:test_probe_param8x \
>         -e sdt_usdt:test_probe_param9 -e sdt_usdt:test_probe_param9x \
>         -e sdt_usdt:test_probe_param10 -e sdt_usdt:test_probe_param10x \
>         -e sdt_usdt:test_probe_param11 -e sdt_usdt:test_probe_param11x \
>         -e sdt_usdt:test_probe_param12 -e sdt_usdt:test_probe_param12x \
>         -e sdt_usdt:test_probe  -aR sleep 5
> 
>    # ./usdt_test   => Execute in another terminal
> 
>    # perf script
> 
>        usdt_test  7999 [003] 80493.418276:          sdt_usdt:test_probe: (aaaab0d80714)
>        usdt_test  7999 [003] 80493.418352:   sdt_usdt:test_probe_param1: (aaaab0d80728) arg1=1
>        usdt_test  7999 [003] 80493.418379:   sdt_usdt:test_probe_param2: (aaaab0d80744) arg1=1 arg2=2
>        usdt_test  7999 [003] 80493.418405:   sdt_usdt:test_probe_param3: (aaaab0d80764) arg1=1 arg2=2 arg3=3
>        usdt_test  7999 [003] 80493.418432:   sdt_usdt:test_probe_param4: (aaaab0d80788) arg1=1 arg2=2 arg3=3 arg4=4
>        usdt_test  7999 [003] 80493.418459:   sdt_usdt:test_probe_param5: (aaaab0d807b0) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5
>        usdt_test  7999 [003] 80493.418487:   sdt_usdt:test_probe_param6: (aaaab0d807dc) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6
>        usdt_test  7999 [003] 80493.418516:   sdt_usdt:test_probe_param7: (aaaab0d8080c) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7
>        usdt_test  7999 [003] 80493.418545:   sdt_usdt:test_probe_param8: (aaaab0d80840) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8
>        usdt_test  7999 [003] 80493.418574:   sdt_usdt:test_probe_param9: (aaaab0d80874) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9
>        usdt_test  7999 [003] 80493.418603:  sdt_usdt:test_probe_param10: (aaaab0d808a8) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10
>        usdt_test  7999 [003] 80493.418632:  sdt_usdt:test_probe_param11: (aaaab0d808dc) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10 arg11=11
>        usdt_test  7999 [003] 80493.418662:  sdt_usdt:test_probe_param12: (aaaab0d80910) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10 arg11=11 arg12=12
>        usdt_test  7999 [003] 80493.418687:  sdt_usdt:test_probe_param1x: (aaaab0d8092c) arg1=1
>        usdt_test  7999 [003] 80493.418713:  sdt_usdt:test_probe_param2x: (aaaab0d80950) arg1=1 arg2=2
>        usdt_test  7999 [003] 80493.418739:  sdt_usdt:test_probe_param3x: (aaaab0d8097c) arg1=1 arg2=2 arg3=3
>        usdt_test  7999 [003] 80493.418766:  sdt_usdt:test_probe_param4x: (aaaab0d809b0) arg1=1 arg2=2 arg3=3 arg4=4
>        usdt_test  7999 [003] 80493.418792:  sdt_usdt:test_probe_param5x: (aaaab0d809ec) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5
>        usdt_test  7999 [003] 80493.418820:  sdt_usdt:test_probe_param6x: (aaaab0d80a30) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6
>        usdt_test  7999 [003] 80493.418847:  sdt_usdt:test_probe_param7x: (aaaab0d80a7c) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7
>        usdt_test  7999 [003] 80493.418875:  sdt_usdt:test_probe_param8x: (aaaab0d80ad0) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8
>        usdt_test  7999 [003] 80493.418904:  sdt_usdt:test_probe_param9x: (aaaab0d80b2c) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9
>        usdt_test  7999 [003] 80493.418933: sdt_usdt:test_probe_param10x: (aaaab0d80b90) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10
>        usdt_test  7999 [003] 80493.418962: sdt_usdt:test_probe_param11x: (aaaab0d80bfc) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10 arg11=11
>        usdt_test  7999 [003] 80493.418991: sdt_usdt:test_probe_param12x: (aaaab0d80cb0) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=281474762776336 arg10=281474762776340 arg11=281474762776344 arg12=281474762776348
> 
> [1] https://people.linaro.org/~leo.yan/debug/perf/usdt_test.c
> 
> 
> Leo Yan (2):
>   perf probe: Fixup Arm64 SDT arguments
>   perf arm64: Add argument support for SDT
> 
>  tools/perf/arch/arm64/util/perf_regs.c | 94 ++++++++++++++++++++++++++
>  tools/perf/util/probe-file.c           | 32 ++++++++-
>  2 files changed, 124 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
