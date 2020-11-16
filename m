Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB82B41B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgKPKsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:48:13 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:48364 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729200AbgKPKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:48:12 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AGAlebE025199;
        Mon, 16 Nov 2020 04:47:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=po7HDvoELwneNBHq3Yb/YcprQmiFOlqAjo/qipMHhFE=;
 b=Q5UOkcjsZ+pymsCfXOCgs+hkNHbQ95CDQf3PeWggUTSNSYzZ8s3E7HN1qF+dGUrwpCGS
 fH82pO+X7LbBUwHlV2aqJreRJaio5UE2Vw0pqeMWsj7xNe5Koe5S29j580s4wtc/JAfh
 L7YTX7q7IoCoZCYWJ6vfVa/rcR17X1h51CgvKJnduDYlpLQ6DIFk58Q8y++uMwfJ3+rk
 3QdQ/vfR8XdpDSi9HPTgp9weyU9UNp6yimQ3YUkSvbCIhzSVMwQbPi/IdTS7ORRzDzVS
 EiCO6HEccgIZW7w/ixMatH/w+KiZbvwUvdmmNjWN4WDk6FkGKB/ZoI0v7MAXdBgwZTgZ JA== 
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 34tchtj58p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Nov 2020 04:47:39 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 16 Nov
 2020 10:47:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 16 Nov 2020 10:47:38 +0000
Received: from [10.0.2.15] (ausnpc0lsnw1.ad.cirrus.com [198.61.65.1])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2A6F12A1;
        Mon, 16 Nov 2020 10:47:38 +0000 (UTC)
Subject: Re: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf number
 parsing
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <sergey.senozhatsky@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20201112111759.16377-1-rf@opensource.cirrus.com>
 <20201112103546.5981815b@gandalf.local.home>
 <b200a554-be81-f8b0-28a4-39c6f3c6900f@opensource.cirrus.com>
 <20201112120427.72c0a237@gandalf.local.home> <20201113140052.GM1602@alley>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <efd71e08-2df2-db4e-4448-a096bf05b667@opensource.cirrus.com>
Date:   Mon, 16 Nov 2020 10:47:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201113140052.GM1602@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2020 14:00, Petr Mladek wrote:
> On Thu 2020-11-12 12:04:27, Steven Rostedt wrote:
>> On Thu, 12 Nov 2020 15:46:46 +0000
>> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>
>>> See this thread from 2014 where the field width problem was raised and
>>> explained:
>>> http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03443.html
>>>
>>> and the reply from Linus Torvalds that was against fixing field width
>>> handling:
>>> http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03488.html
>>
>> Thanks for the pointers, but note, that references to older emails should
>> use https://lore.kernel.org/ as these links format the output really
>> horribly.
>>
>>>
>>> which I assume is why the field handling wasn't unoptimized to be
>>> strictly correct.
> 
> Honestly, the handling of the number width by div does not look like
> a real optimization to me. It avoids the need of the temporary buffer
> by expensive and error-prone operation.
> 
> IMHO, it is safe to assume that the width will be limited so that
> the value would never overflow.
> 
> The longest supported number would be (2^64 - 1) in octal. If I am
> counting correctly, it is
> 
>       01777777777777777777777
> 
> and it fits into buf[24] including the trailing '\0'.
> 
> We could call WARN_ON_ONCE() when the width >= 24 is higher.
> And we could add a compiler check when long long is bigger
> than 64-bit.
> 
>> Yes, but perhaps its time to fix the real problem and not just add
>> band-aids. That thread is over 6 years old (the email was from Jan 14, 2014)
>>
>> $ git diff `git rev-list --before 'Jan 14 2014' HEAD --max-count=1` |
>>    grep '^+' | grep sscanf | wc -l
>> 622
>>
>> There's been over 600 new additions of sscanf(). Now is the time to just
>> fix it correctly.
> 
> And the following one might suffer from this problem:
> 
> drivers/soundwire/slave.c:              ret = sscanf(compat, "sdw%01x%04hx%04hx%02hhx", &sdw_version,
> 

That's exactly the bug I have.
I'll look at reworking the code to handle number field widths properly.

> I agree with Steven that it is time to fix it properly.
> 
> Best Regards,
> Petr
> 
