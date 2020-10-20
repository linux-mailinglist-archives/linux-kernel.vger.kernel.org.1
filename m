Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EEC2936EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392088AbgJTIip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:38:45 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2995 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389211AbgJTIio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:38:44 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D81CDD4F6E017D6BAAEB;
        Tue, 20 Oct 2020 09:38:42 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.97) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 20 Oct
 2020 09:38:41 +0100
Subject: Re: [PATCH 1/2] perf jevents: Tidy error handling
To:     kajoljain <kjain@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Yao Jin <yao.jin@linux.intel.com>, <yeyunfeng@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1603121908-53543-1-git-send-email-john.garry@huawei.com>
 <1603121908-53543-2-git-send-email-john.garry@huawei.com>
 <CAM9d7cg0j3j-EXY2MULYWpyMri5_GxBnHVNvrHN4UG0pwsa=mw@mail.gmail.com>
 <eb3073cd-7184-58f3-f03f-b094abaff007@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3fda581b-3f2b-5dce-b388-916117d20e7c@huawei.com>
Date:   Tue, 20 Oct 2020 09:35:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <eb3073cd-7184-58f3-f03f-b094abaff007@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.97]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2020 09:14, kajoljain wrote:
> 
> 
> On 10/20/20 11:13 AM, Namhyung Kim wrote:
>> Hello,
>>
>> On Tue, Oct 20, 2020 at 12:42 AM John Garry <john.garry@huawei.com> wrote:
>>>
>>> There is much duplication in the error handling for directory traversing
>>> for processing JSONs.
>>>
>>> Factor out the common code to tidy a bit.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>> [SNIP]
>>> -empty_map:
>>> +err_processing_std_arch_event_dir:
>>> +       err_string_ext = " for std arch event";
>>> +err_processing_dir:
>>> +       if (verbose || rc > 0) {
>>> +               pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,
>>> +                       err_string_ext);
>>
>> This was printed only if verbose is set but now changed.
> 

pr_info() is silenced if verbose is unset, so in effect it is the same - 
see pr_info() definition in json.h

> Hi John,
>     Yes I agree with Namhyung.
> So, this is our original checks
> 
> if (rc && verbose) {
> 		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
> 		goto empty_map;
> 	} else if (rc < 0) {
> 		/* Make build fail */
> 		fclose(eventsfp);
> 		free_arch_std_events();
> 		ret = 1;
> 		goto out_free_mapfile;
> 	} else if (rc) {
> 		goto empty_map;
> 	}
> 
> May be we can use similar checks:
> 
> if( verbose)
>    pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,err_string_ext);
> if(rc > 0)
>     empty_map = 1;
> else
>    ret = 1;
> 

Not that it matters much, this logic is slightly different for verbose 
set and rc < 0. I don't mind going with that, so let me know.

Thanks for checking,
John

> Thanks,
> Kajol Jain
>    
>>
>> Thanks
>> Namhyung
>>
>>
>>> +               empty_map = 1;
>>> +       } else {
>>> +               ret = 1;
>>> +       }
>>> +err_close_eventsfp:
>>>          fclose(eventsfp);
>>> -       create_empty_mapping(output_file);
>>> +       if (empty_map)
>>> +               create_empty_mapping(output_file);
>>> +err_out:
>>>          free_arch_std_events();
>>> -out_free_mapfile:
>>>          free(mapfile);
>>>          return ret;
>>>   }
>>> --
>>> 2.26.2
>>>
> .
> 

