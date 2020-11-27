Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105462C609E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392750AbgK0Hpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:45:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8599 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbgK0Hpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:45:50 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cj69T60lGzLvt5;
        Fri, 27 Nov 2020 15:45:17 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Nov
 2020 15:45:40 +0800
Subject: Re: [PATCH -next] perf util: Fix memory leak in __parse_regs()
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>
References: <20200703093344.189450-1-zhengzengkai@huawei.com>
 <20200703103106.GA3261456@krava>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <0e52c7be-ca81-2f4d-ee2f-8f9ced382f60@huawei.com>
Date:   Fri, 27 Nov 2020 15:45:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200703103106.GA3261456@krava>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

> On Fri, Jul 03, 2020 at 05:33:44PM +0800, Zheng Zengkai wrote:
>> when using perf record option '-I' or '--user-regs='
>> along with argument '?' to list available register names,
>> memory of variable 'os' allocated by strdup() needs to be released
>> before __parse_regs() returns, otherwise memory leak will occur.
>>
>> Fixes: bcc84ec65ad1 ("perf record: Add ability to name registers to record")
>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> thanks,
> jirka
>
>> ---
>>   tools/perf/util/parse-regs-options.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> index e687497b3aac..a4a100425b3a 100644
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
>> @@ -54,7 +54,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>   #endif
>>   				fputc('\n', stderr);
>>   				/* just printing available regs */
>> -				return -1;
>> +				goto error;
>>   			}
>>   #ifdef HAVE_PERF_REGS_SUPPORT
>>   			for (r = sample_reg_masks; r->name; r++) {
>> -- 
>> 2.20.1
>>
> .
>
