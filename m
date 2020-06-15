Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF40F1F9AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgFOOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 10:52:48 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728304AbgFOOws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:52:48 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 55033B26EC0FA270F1FE;
        Mon, 15 Jun 2020 15:52:42 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.237) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 15 Jun
 2020 15:52:41 +0100
Subject: Re: [PATCH 2/2] perf pmu: Improve CPU core PMU HW event list ordering
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        Ian Rogers <irogers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1592214046-32385-1-git-send-email-john.garry@huawei.com>
 <1592214046-32385-3-git-send-email-john.garry@huawei.com>
 <CAM9d7ciyOmzxUZ4dGJ12607rTnCCdNBbuQtv1gEmUe0FQJxELA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7554ef7d-6d85-fa5f-2018-415f2260fa60@huawei.com>
Date:   Mon, 15 Jun 2020 15:51:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciyOmzxUZ4dGJ12607rTnCCdNBbuQtv1gEmUe0FQJxELA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.237]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2020 15:36, Namhyung Kim wrote:>>   static int cmp_sevent(const 
void *a, const void *b)
>> @@ -1416,6 +1417,12 @@ static int cmp_sevent(const void *a, const void *b)
>>                  if (n)
>>                          return n;
>>          }
>> +
>> +       if (as->is_cpu && !bs->is_cpu)
>> +               return -1;
>> +       else if (!as->is_cpu && bs->is_cpu)
>> +               return 1;
>> +
> This can be:
> 
>          if (as->is_cpu != bs->is_cpu)
>                  return bs->is_cpu - as->is_cpu;
> 

That's more concise, but maybe not as readable at a glance. I don't mind 
though, so can change.

Thanks,
John

