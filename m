Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20B6252268
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHYVEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:04:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7917C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:04:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q14so128251wrn.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jY1ve4o0FYvXUegFkiZsb70dsnRPer3p4b75WJ0zx1g=;
        b=WCd5cWgx4qD4GbPglfHLReQTfVu4cs1Z0zpBg4upTskpjioQUrtjoAW/0P/boDqFuQ
         8ZNXozUb4ilp2iAmoktYvlng1ucPBDK1CwDf8HN6+ViTrBspxSIXZgCJRb+QgNtr6plR
         ryGPBpuGJ8joDxUjZxmjMOHlhHuSRcHTEgTZZrr/IlTEiGg6V/o+YuTiDreQ8pPzjf+g
         U1nVesV2yH+jsGSl5xvxq/rTGmuyqJKynLAsdJqudZ2ZjMzT1N94wJfplvMlWitKzqk0
         n1efeILf37xFOENxFV4HbruY4/s8Mzh/a31/d56DgGot9VS/TGrxxMfuwE+nB7/EE7og
         8ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jY1ve4o0FYvXUegFkiZsb70dsnRPer3p4b75WJ0zx1g=;
        b=Ax4SRIXkKqprwJpXQVWP9EKlncMI2HfeAHrZbaNdThsexkJoJom2iIHwhJwSk0IP/F
         BNFLQmHTgi8zmYsOzi8ge6Pz3LoKoAZnz2dFvkRB3Z5TTt0m8PzlMd60dLKmX5yWo5Qd
         rJiJyalMAjniFp0HW4KqlJg5dI+qj5FD4cJzVVlmJCIX6c4I4maTM5vHBkThpZuX6o2d
         4j4vvbi6FdVqjx84mdB13IF5xWUTlqss8m8uDpgt2Kaf/ThyUZaqqwFiGGppTgeN9Uqm
         J2MJRP4Js1PLwm3lyq1uvTavpdOc5JmvoQtEcTvh6zD5Za/uswC8hrdjaXc0gk0VZluD
         h6/A==
X-Gm-Message-State: AOAM532Zro6dZJEpVadCb+mvBqpyGj20m8PQ2WdZ3D7e3NtMZHG9wZQR
        hzWkmraZJrmQwcBaKiK4wnNLUtxDoYp+ta5cjAEJXA==
X-Google-Smtp-Source: ABdhPJzIKgeMLbWr2hv/mCbueL/26GZ42A9+WiqjPjMDr1KSkBzVmIwo+i1OEbFH5Hd64LYzc9R9grAGgmAxCXSX4B8=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr13263145wro.271.1598389482099;
 Tue, 25 Aug 2020 14:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200825071211.16959-1-tmricht@linux.ibm.com>
In-Reply-To: <20200825071211.16959-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 25 Aug 2020 14:04:30 -0700
Message-ID: <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
Subject: Re: [PATCH] perf test: Perf test 67 dumps core on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 12:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> Linux 5.9 introduced perf test case "Parse and process metrics" and
> on s390 this test case always dumps core:
>
> [root@t35lp67 perf]# ./perf test -vvvv -F 67
> 67: Parse and process metrics                             :
> --- start ---
> metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
> parsing metric: inst_retired.any / cpu_clk_unhalted.thread
> Segmentation fault (core dumped)
> [root@t35lp67 perf]#
>
> I debugged this core dump and gdb shows this call chain:
>
> (gdb) where
>  #0  0x000003ffabc3192a in __strnlen_c_1 () from /lib64/libc.so.6
>  #1  0x000003ffabc293de in strcasestr () from /lib64/libc.so.6
>  #2  0x0000000001102ba2 in match_metric(list=0x1e6ea20 "inst_retired.any",
>           n=<optimized out>)
>      at util/metricgroup.c:368
>  #3  find_metric (map=<optimized out>, map=<optimized out>,
>          metric=0x1e6ea20 "inst_retired.any")
>     at util/metricgroup.c:765
>  #4  __resolve_metric (ids=0x0, map=<optimized out>, metric_list=0x0,
>          metric_no_group=<optimized out>, m=<optimized out>)
>     at util/metricgroup.c:844
>  #5  resolve_metric (ids=0x0, map=0x0, metric_list=0x0,
>         metric_no_group=<optimized out>)
>     at util/metricgroup.c:881
>  #6  metricgroup__add_metric (metric=<optimized out>,
>       metric_no_group=metric_no_group@entry=false, events=<optimized out>,
>       events@entry=0x3ffd84fb878, metric_list=0x0,
>       metric_list@entry=0x3ffd84fb868, map=0x0)
>     at util/metricgroup.c:943
>  #7  0x00000000011034ae in metricgroup__add_metric_list (map=0x13f9828 <map>,
>       metric_list=0x3ffd84fb868, events=0x3ffd84fb878,
>       metric_no_group=<optimized out>, list=<optimized out>)
>     at util/metricgroup.c:988
>  #8  parse_groups (perf_evlist=perf_evlist@entry=0x1e70260,
>         str=str@entry=0x12f34b2 "IPC", metric_no_group=<optimized out>,
>         metric_no_merge=<optimized out>,
>         fake_pmu=fake_pmu@entry=0x1462f18 <perf_pmu.fake>,
>         metric_events=0x3ffd84fba58, map=0x1)
>     at util/metricgroup.c:1040
>  #9  0x0000000001103eb2 in metricgroup__parse_groups_test(
>         evlist=evlist@entry=0x1e70260, map=map@entry=0x13f9828 <map>,
>         str=str@entry=0x12f34b2 "IPC",
>         metric_no_group=metric_no_group@entry=false,
>         metric_no_merge=metric_no_merge@entry=false,
>         metric_events=0x3ffd84fba58)
>     at util/metricgroup.c:1082
>  #10 0x00000000010c84d8 in __compute_metric (ratio2=0x0, name2=0x0,
>         ratio1=<synthetic pointer>, name1=0x12f34b2 "IPC",
>         vals=0x3ffd84fbad8, name=0x12f34b2 "IPC")
>     at tests/parse-metric.c:159
>  #11 compute_metric (ratio=<synthetic pointer>, vals=0x3ffd84fbad8,
>         name=0x12f34b2 "IPC")
>     at tests/parse-metric.c:189
>  #12 test_ipc () at tests/parse-metric.c:208
> .....
> ..... omitted many more lines
>
> This test case was added with
> commit 218ca91df477 ("perf tests: Add parse metric test for frontend metric").
>
> When I compile with make DEBUG=y it works fine and I do not get a
> core dump.
> It turned out that the above listed function call chain worked on
> a struct pmu_event array which requires a trailing element with zeroes
> which was missing. The marco map_for_each_event() loops over that
> array tests for members metric_expr/metric_name/metric_group
> being non-NULL. Adding this element fixes the issue.
>
> Output after:
>   [root@t35lp46 perf]# ./perf test 67
>   67: Parse and process metrics                             : Ok
>   [root@t35lp46 perf]#
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

This also shows up with address sanitizer on all architectures
(perhaps change the patch title) and perhaps add a "Fixes: <commit>"
tag.
=================================================================
==4718==ERROR: AddressSanitizer: global-buffer-overflow on address
0x55c93b4d59e8 at pc 0x55c93a1541e2 bp 0x7ffd24327c60 sp
0x7ffd24327c58
READ of size 8 at 0x55c93b4d59e8 thread T0
    #0 0x55c93a1541e1 in find_metric tools/perf/util/metricgroup.c:764:2
    #1 0x55c93a153e6c in __resolve_metric tools/perf/util/metricgroup.c:844:9
    #2 0x55c93a152f18 in resolve_metric tools/perf/util/metricgroup.c:881:9
    #3 0x55c93a1528db in metricgroup__add_metric
tools/perf/util/metricgroup.c:943:9
    #4 0x55c93a151996 in metricgroup__add_metric_list
tools/perf/util/metricgroup.c:988:9
    #5 0x55c93a1511b9 in parse_groups tools/perf/util/metricgroup.c:1040:8
    #6 0x55c93a1513e1 in metricgroup__parse_groups_test
tools/perf/util/metricgroup.c:1082:9
    #7 0x55c93a0108ae in __compute_metric tools/perf/tests/parse-metric.c:159:8
    #8 0x55c93a010744 in compute_metric tools/perf/tests/parse-metric.c:189:9
    #9 0x55c93a00f5ee in test_ipc tools/perf/tests/parse-metric.c:208:2
    #10 0x55c93a00f1e8 in test__parse_metric
tools/perf/tests/parse-metric.c:345:2
    #11 0x55c939fd7202 in run_test tools/perf/tests/builtin-test.c:410:9
    #12 0x55c939fd6736 in test_and_print tools/perf/tests/builtin-test.c:440:9
    #13 0x55c939fd58c3 in __cmd_test tools/perf/tests/builtin-test.c:661:4
    #14 0x55c939fd4e02 in cmd_test tools/perf/tests/builtin-test.c:807:9
    #15 0x55c939e4763d in run_builtin tools/perf/perf.c:313:11
    #16 0x55c939e46475 in handle_internal_command tools/perf/perf.c:365:8
    #17 0x55c939e4737e in run_argv tools/perf/perf.c:409:2
    #18 0x55c939e45f7e in main tools/perf/perf.c:539:3

0x55c93b4d59e8 is located 0 bytes to the right of global variable
'pme_test' defined in 'tools/perf/tests/parse-metric.c:17:25'
(0x55c93b4d54a0) of size 1352
SUMMARY: AddressSanitizer: global-buffer-overflow
tools/perf/util/metricgroup.c:764:2 in find_metric
Shadow bytes around the buggy address:
  0x0ab9a7692ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ab9a7692af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ab9a7692b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ab9a7692b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ab9a7692b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0ab9a7692b30: 00 00 00 00 00 00 00 00 00 00 00 00 00[f9]f9 f9
  0x0ab9a7692b40: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  0x0ab9a7692b50: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  0x0ab9a7692b60: f9 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
  0x0ab9a7692b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ab9a7692b80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc


> ---
>  tools/perf/tests/parse-metric.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index fc0838a7abc2..80c71a10999d 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -70,6 +70,11 @@ static struct pmu_event pme_test[] = {
>  {
>         .metric_expr    = "1/m3",
>         .metric_name    = "M3",
> +},
> +{
> +       .metric_expr    = NULL,
> +       .metric_name    = NULL,
> +       .metric_group   = NULL
>  }
>  };
>
> --
> 2.26.2
>
