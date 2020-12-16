Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166ED2DBFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgLPLmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:42:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2264 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPLmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:42:35 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CwtSN4Htjz67QcF;
        Wed, 16 Dec 2020 19:39:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 16 Dec 2020 12:41:51 +0100
Received: from [10.210.169.48] (10.210.169.48) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 16 Dec 2020 11:41:51 +0000
Subject: Re: [BUG] jevents problem when cross building Re: [PATCH 2/3] perf
 tools: Allow to enable/disable events via control file
From:   John Garry <john.garry@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Budankov <abudankov@huawei.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava> <20201210171503.GA195565@kernel.org>
 <20201210171903.GB195565@kernel.org> <20201210172608.GC195565@kernel.org>
 <30e7907d-868a-a673-59a7-3bb4766093b4@huawei.com>
 <20201210181708.GD195565@kernel.org>
 <1a608e92-d0d0-2e5e-ba7e-e9fa2e02b0f9@huawei.com>
 <650baaf2-36b6-a9e2-ff49-963ef864c1f3@huawei.com>
Message-ID: <3323c9fa-3e71-2426-4f53-f6740fa71112@huawei.com>
Date:   Wed, 16 Dec 2020 11:41:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <650baaf2-36b6-a9e2-ff49-963ef864c1f3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.169.48]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2020 19:57, John Garry wrote:
> Hi Arnaldo,
> 
> Can you try this on top:
> 
> ----8<-----
> 
>  From 201aa2cb7bc8723765afd84a5d3972248af0f0a1 Mon Sep 17 00:00:00 2001
> From: John Garry <john.garry@huawei.com>
> Date: Thu, 10 Dec 2020 19:45:14 +0000
> Subject: [PATCH] perf jevents: Add system events table for empty mapping
> 
> For architectures which have no PMU event lists - like arm32 - an empty
> mapping table is printed. This is how the "pmu_events_map" symbol -
> referenced in util/pmu.c::perf_pmu__find_map() - is created for those
> architectures.
> 
> Since pmu-events.c now includes a new table - "pmu_sys_event_tables" -
> which is also referenced from util/pmu.c, also add this for the empty
> mappings.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/tools/perf/pmu-events/jevents.c 
> b/tools/perf/pmu-events/jevents.c
> index e930096ad713..28e20d9ec0f5 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -816,19 +816,30 @@ static void print_mapping_test_table(FILE *outfp)
>       fprintf(outfp, "},\n");
>   }
> 
> +static void print_system_event_mapping_table_prefix(FILE *outfp)
> +{
> +    fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
> +}
> +
> +static void print_system_event_mapping_table_suffix(FILE *outfp)
> +{
> +    fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");
> +
> +    fprintf(outfp, "\n};\n");
> +}
> +
>   static int process_system_event_tables(FILE *outfp)
>   {
>       struct sys_event_table *sys_event_table;
> 
> -    fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
> +    print_system_event_mapping_table_prefix(outfp);
> 
>       list_for_each_entry(sys_event_table, &sys_event_tables, list) {
>           fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
>               sys_event_table->soc_id);
>       }
> -    fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");
> 
> -    fprintf(outfp, "\n};\n");
> +    print_system_event_mapping_table_suffix(outfp);
> 
>       return 0;
>   }
> @@ -938,6 +949,9 @@ static void create_empty_mapping(const char 
> *output_file)
>       fprintf(outfp, "#include \"pmu-events/pmu-events.h\"\n");
>       print_mapping_table_prefix(outfp);
>       print_mapping_table_suffix(outfp);
> +    print_system_event_mapping_table_prefix(outfp);
> +    print_system_event_mapping_table_suffix(outfp);
> +
>       fclose(outfp);
>   }
> 
> ---->8----
> 
> Obviously I never tested building for one of test architectures which 
> does not use PMU events - sorry!
> 

Hi Arnaldo,

Just wondering if you have had any more problems here? Shall I send a 
formal patch? I tested that change and it looked ok.

Thanks,
John
