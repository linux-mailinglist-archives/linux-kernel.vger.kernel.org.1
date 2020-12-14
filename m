Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1E2D954F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgLNJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:31:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726289AbgLNJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:31:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BE939UA078237;
        Mon, 14 Dec 2020 04:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jZIK2eIIL1Sm9DhKAei30RHmIal4MbWENVwLni7EHz4=;
 b=RvJJ0+axlsPGhqRj7CUfF6KV8Fkdmq1BJOTPyzaxX2TIqSxnW4vNU68IUnyiWGpk3RzD
 /Yy8ecnJ9HZEA8IsQpAbIXIkYD5lPeMXC2cJ7l1EAc16fJlvT3S0TQ+QCtde49Szovrg
 eJaMupUUleyzT+/YfeM36FYUo0Cjpb/UVt4B9B/pM7gimak2Jo/yLYmW9+8ccsbQpDmI
 c/YiX61o3fVeiV1anYKfcb1gJsN4Rg6kwoQb+tD+NdDHXgj9ECyteCgYBwOuPgWajYM6
 Q+LvEuzLIdU6UW/AfjOyfEBPoqZMzd8vojds3cqsmTgaCGDQT1894SkKiUA4OYeNAZ9M Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35e2dun2gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 04:30:21 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BE96VCg091418;
        Mon, 14 Dec 2020 04:30:21 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35e2dun2fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 04:30:21 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BE9BhPS009313;
        Mon, 14 Dec 2020 09:30:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 35cng89yh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 09:30:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BE9UGxf51642856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 09:30:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 417734C050;
        Mon, 14 Dec 2020 09:30:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06B7F4C04E;
        Mon, 14 Dec 2020 09:30:16 +0000 (GMT)
Received: from pomme.local (unknown [9.145.29.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Dec 2020 09:30:15 +0000 (GMT)
Subject: Re: [PATCH] mm/memory_hotplug: quieting offline operation
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com
References: <20201211150157.91399-1-ldufour@linux.ibm.com>
 <CAFqt6zbpWyaJmTGjXcHzdU8+Vow=Kawe6K=UGb4zW0sJJ0LKmg@mail.gmail.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <f6454d1d-cdc4-bacb-bd9b-12e1baf6ceba@linux.ibm.com>
Date:   Mon, 14 Dec 2020 10:30:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbpWyaJmTGjXcHzdU8+Vow=Kawe6K=UGb4zW0sJJ0LKmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_04:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/12/2020 à 16:04, Souptick Joarder a écrit :
> On Fri, Dec 11, 2020 at 8:32 PM Laurent Dufour <ldufour@linux.ibm.com> wrote:
>>
>> On PowerPC, when dymically removing memory from a system we can see in the console a
>> lot of messages like this:
>> [  186.575389] Offlined Pages 4096
> 
> Is it specific to PowerPC ?

No, this applies to all architectures, but this is surfacing a bit more on 
PowerPC where the memory block size is set to 256MB currently by the firmware.

> 
>>
>> This message is displayed on each LMB (256MB) removed, which means that we
>> removing 1TB of memory, this message is displayed 4096 times.
>>
>> Moving it to DEBUG to not flood the console.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> ---
>>   mm/memory_hotplug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index b44d4c7ba73b..c47a53a16782 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1587,7 +1587,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>>
>>          /* Mark all sections offline and remove free pages from the buddy. */
>>          __offline_isolated_pages(start_pfn, end_pfn);
>> -       pr_info("Offlined Pages %ld\n", nr_pages);
>> +       pr_debug("Offlined Pages %ld\n", nr_pages);
>>
>>          /*
>>           * The memory sections are marked offline, and the pageblock flags
>> --
>> 2.29.2
>>
>>

