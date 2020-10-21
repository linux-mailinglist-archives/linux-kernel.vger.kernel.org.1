Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4395A294DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442976AbgJUNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:38:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439032AbgJUNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:38:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09LDWpdi068605;
        Wed, 21 Oct 2020 09:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cwjPt9FH+sK9o8PK3bSkaWtXJPSCTFPOax7ciIIr2K0=;
 b=iUrOMNzHOYc44c0R4lfLHxhMtH0QfEh2U9uMtMhYYRGUV923/SYalBHwJRBrULMhE2mf
 8sTJL18ETexOE+S2SNXbs7Qo42qC1IH0OVfixYaIZRmx+Opji5U8uKK/FCNzpBGsE4aP
 UZb66pTv2OQS/FK1z0cV8mdfnKhpzzV12+4DaF9f1olarYLoAKjmTkPrKQqa3Tk3JxjT
 wvvGNgbXyTwvW+7HV2XSvP0QyYOG4JUNOqhSx0OfDVnzWb1UaSTn5oN0959GdlDOqSnw
 IFz5FilawNrFxkAGa2HEljc5aPxCqn9PjqtD9UN6JdWpPMtmfAAH6j1ng2YMM9kmtrzK bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ane19dst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 09:38:05 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09LDX4mo069835;
        Wed, 21 Oct 2020 09:38:04 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ane19dsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 09:38:04 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09LDarCU003206;
        Wed, 21 Oct 2020 13:38:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 347r898bt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 13:38:03 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09LDc2Y649873236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 13:38:03 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE3FF6A04D;
        Wed, 21 Oct 2020 13:38:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 303036A04F;
        Wed, 21 Oct 2020 13:37:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.234])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 21 Oct 2020 13:37:54 +0000 (GMT)
Subject: Re: [PATCH 1/2] perf jevents: Tidy error handling
To:     John Garry <john.garry@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Yao Jin <yao.jin@linux.intel.com>, yeyunfeng@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1603121908-53543-1-git-send-email-john.garry@huawei.com>
 <1603121908-53543-2-git-send-email-john.garry@huawei.com>
 <CAM9d7cg0j3j-EXY2MULYWpyMri5_GxBnHVNvrHN4UG0pwsa=mw@mail.gmail.com>
 <eb3073cd-7184-58f3-f03f-b094abaff007@linux.ibm.com>
 <3fda581b-3f2b-5dce-b388-916117d20e7c@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <7e7c5aeb-5c9b-727a-d605-e871007af34a@linux.ibm.com>
Date:   Wed, 21 Oct 2020 19:07:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3fda581b-3f2b-5dce-b388-916117d20e7c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_06:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 suspectscore=2 malwarescore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/20 2:05 PM, John Garry wrote:
> On 20/10/2020 09:14, kajoljain wrote:
>>
>>
>> On 10/20/20 11:13 AM, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Tue, Oct 20, 2020 at 12:42 AM John Garry <john.garry@huawei.com> wrote:
>>>>
>>>> There is much duplication in the error handling for directory traversing
>>>> for processing JSONs.
>>>>
>>>> Factor out the common code to tidy a bit.
>>>>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>> ---
>>> [SNIP]
>>>> -empty_map:
>>>> +err_processing_std_arch_event_dir:
>>>> +       err_string_ext = " for std arch event";
>>>> +err_processing_dir:
>>>> +       if (verbose || rc > 0) {
>>>> +               pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,
>>>> +                       err_string_ext);
>>>
>>> This was printed only if verbose is set but now changed.
>>
> 
> pr_info() is silenced if verbose is unset, so in effect it is the same - see pr_info() definition in json.h
> 
>> Hi John,
>>     Yes I agree with Namhyung.
>> So, this is our original checks
>>
>> if (rc && verbose) {
>>         pr_info("%s: Error walking file tree %s\n", prog, ldirname);
>>         goto empty_map;
>>     } else if (rc < 0) {
>>         /* Make build fail */
>>         fclose(eventsfp);
>>         free_arch_std_events();
>>         ret = 1;
>>         goto out_free_mapfile;
>>     } else if (rc) {
>>         goto empty_map;
>>     }
>>
>> May be we can use similar checks:
>>
>> if( verbose)
>>    pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,err_string_ext);
>> if(rc > 0)
>>     empty_map = 1;
>> else
>>    ret = 1;
>>
> 
> Not that it matters much, this logic is slightly different for verbose set and rc < 0. I don't mind going with that, so let me know.

Yes right. Sure if required we can made changes on these checks and include appropriate condition for verbose set and rc < 0. Seems fine to me.

Thanks,
Kajol Jain
> 
> Thanks for checking,
> John
> 
>> Thanks,
>> Kajol Jain
>>   
>>>
>>> Thanks
>>> Namhyung
>>>
>>>
>>>> +               empty_map = 1;
>>>> +       } else {
>>>> +               ret = 1;
>>>> +       }
>>>> +err_close_eventsfp:
>>>>          fclose(eventsfp);
>>>> -       create_empty_mapping(output_file);
>>>> +       if (empty_map)
>>>> +               create_empty_mapping(output_file);
>>>> +err_out:
>>>>          free_arch_std_events();
>>>> -out_free_mapfile:
>>>>          free(mapfile);
>>>>          return ret;
>>>>   }
>>>> -- 
>>>> 2.26.2
>>>>
>> .
>>
> 
