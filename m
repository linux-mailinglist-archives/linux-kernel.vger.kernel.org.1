Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50578269FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgIOHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:40:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2819 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbgIOHkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:40:04 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D54C260BE7146B3813A7;
        Tue, 15 Sep 2020 08:40:00 +0100 (IST)
Received: from [127.0.0.1] (10.47.11.114) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 15 Sep
 2020 08:40:00 +0100
Subject: Re: [PATCH 10/11] perf test: Free aliases for PMU event map aliases
 test
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-11-namhyung@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d1704e16-0561-8bd7-02bb-dbef0233e395@huawei.com>
Date:   Tue, 15 Sep 2020 08:37:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200915031819.386559-11-namhyung@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.114]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2020 04:18, Namhyung Kim wrote:
> The aliases were never released causing the following leaks:
> 
>    Indirect leak of 1224 byte(s) in 9 object(s) allocated from:
>      #0 0x7feefb830628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
>      #1 0x56332c8f1b62 in __perf_pmu__new_alias util/pmu.c:322
>      #2 0x56332c8f401f in pmu_add_cpu_aliases_map util/pmu.c:778
>      #3 0x56332c792ce9 in __test__pmu_event_aliases tests/pmu-events.c:295
>      #4 0x56332c792ce9 in test_aliases tests/pmu-events.c:367
>      #5 0x56332c76a09b in run_test tests/builtin-test.c:410
>      #6 0x56332c76a09b in test_and_print tests/builtin-test.c:440
>      #7 0x56332c76ce69 in __cmd_test tests/builtin-test.c:695
>      #8 0x56332c76ce69 in cmd_test tests/builtin-test.c:807
>      #9 0x56332c7d2214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
>      #10 0x56332c6701a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
>      #11 0x56332c6701a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
>      #12 0x56332c6701a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
>      #13 0x7feefb359cc9 in __libc_start_main ../csu/libc-start.c:308
> 
> Cc: John Garry <john.garry@huawei.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Just a minor comment below, either way:
Reviewed-by: John Garry <john.garry@huawei.com>

Thanks

> Fixes: 956a78356c24c ("perf test: Test pmu-events aliases")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/tests/pmu-events.c | 5 +++++
>   tools/perf/util/pmu.c         | 2 +-
>   tools/perf/util/pmu.h         | 1 +
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index eb19f9a0bc15..d3517a74d95e 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -274,6 +274,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>   	int res = 0;
>   	bool use_uncore_table;
>   	struct pmu_events_map *map = __test_pmu_get_events_map();
> +	struct perf_pmu_alias *a, *tmp;
>   
>   	if (!map)
>   		return -1;
> @@ -347,6 +348,10 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>   			  pmu_name, alias->name);
>   	}
>   
> +	list_for_each_entry_safe(a, tmp, &aliases, list) {
> +		list_del(&a->list);
> +		perf_pmu_free_alias(a);
> +	}

You could also consider putting this in a helper in pmu.c

>   	free(pmu);
>   	return res;
>   }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f1688e1f6ed7..555cb3524c25 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -274,7 +274,7 @@ static void perf_pmu_update_alias(struct perf_pmu_alias *old,
>   }
>   
>   /* Delete an alias entry. */
> -static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
> +void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
>   {
>   	zfree(&newalias->name);
>   	zfree(&newalias->desc);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 44ccbdbb1c37..b63c4c5e335e 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -113,6 +113,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>   
>   struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
>   bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
> +void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>   
>   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>   
> 

