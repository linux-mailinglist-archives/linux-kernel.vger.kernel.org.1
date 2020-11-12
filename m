Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFEC2B08C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgKLPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:47:22 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39988 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727789AbgKLPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:47:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ACFVtcx029015;
        Thu, 12 Nov 2020 09:46:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=atI4x9M0beb8HFgGmL5+7NHEF9qu8BJJH3GSE7McGGw=;
 b=ZpjsT1I58Gek54XKJI+OKpAk8bGFrJI6S3S4pvAjdK/g2ZL/SmyiErhVp/PDyG7z8tZU
 ARw9U7wEGhNbcZFen6jjDt2FH6uNUGlhuwj/I9PcPK+ZXt0tqWG2qr/AXR+WCcv5SvpM
 Qa+FCwfkfKZgzjn7a2uO1XKZUn+zu9wOBUWIGb53iQ1rcV6XufX03yo8ASZa8t3xh63h
 jcp6PdgtYy9DVPVSsIVCik8B35OsLBzhDgd51ax7WR5wLUQgcZHP08Kp1hwlw/FiVJdp
 +53L6orQVyvb+VIRmp8PxgYHhxG3vq6b/skmjm82n/yIo7Sj7ISo8o8wCs3Poe3gJzCY 3g== 
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 34rn2yhkeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 09:46:49 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 12 Nov
 2020 15:46:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 12 Nov 2020 15:46:47 +0000
Received: from [10.0.2.15] (ausnpc0lsnw1.ad.cirrus.com [198.61.64.168])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 279DA7C;
        Thu, 12 Nov 2020 15:46:47 +0000 (UTC)
Subject: Re: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf number
 parsing
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20201112111759.16377-1-rf@opensource.cirrus.com>
 <20201112103546.5981815b@gandalf.local.home>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <b200a554-be81-f8b0-28a4-39c6f3c6900f@opensource.cirrus.com>
Date:   Thu, 12 Nov 2020 15:46:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201112103546.5981815b@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2020 15:35, Steven Rostedt wrote:
> On Thu, 12 Nov 2020 11:17:59 +0000
> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
> 
>> Number conversion in vsscanf converts a whole string of digits and then
>> extracts the field width part from the converted value. The maximum run
>> of digits is limited by overflow. Conversion was using either
>> simple_strto[u]l or simple_strto[u]ll based on the 'L' qualifier. This
>> created a difference in truncation between builds where long is 32-bit
>> and builds where it is 64-bit. This especially affects parsing a run of
>> contiguous digits into separate fields - the maximum length of the run
>> is 16 digits if long is 64-bit but only 8 digits if long is 32-bits.
>> For example a conversion "%6x%6x" would convert both fields correctly if
>> long is 64-bit but not if long is 32-bit.
>>
>> It is undesirable for vsscanf to parse numbers differently depending on
>> the size of long on the target build.
>>
>> As simple_strto[u]l just calls simple_strto[u]ll anyway the conversion
>> is always 64-bit, and the result is manipulated as a u64, so this is an
>> avoidable behaviour difference between 32-bit and 64-bit builds. The
>> conversion can call simple_strto[u]ll directly and preserve the full
>> 64-bits that were parsed out of the string.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   lib/vsprintf.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index 14c9a6af1b23..63b6cddfa7f7 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -3444,13 +3444,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>>   			break;
>>   
>>   		if (is_sign)
>> -			val.s = qualifier != 'L' ?
>> -				simple_strtol(str, &next, base) :
>> -				simple_strtoll(str, &next, base);
>> +			val.s = simple_strtoll(str, &next, base);
>>   		else
>> -			val.u = qualifier != 'L' ?
>> -				simple_strtoul(str, &next, base) :
>> -				simple_strtoull(str, &next, base);
>> +			val.u = simple_strtoull(str, &next, base);
>>   
>>   		if (field_width > 0 && next - str > field_width) {
>>   			if (base == 0)
> 
> It looks like this is fixing the symptom and not the disease. The real
> issue I see here is that vsscanf is not honoring the '6' of '%6x' here. It
> should only read the 6 characters then do the conversion, not the other
> way around! This looks to me that the design is of issue.
> 
> -- Steve
> 

See this thread from 2014 where the field width problem was raised and
explained:
http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03443.html

and the reply from Linus Torvalds that was against fixing field width
handling:
http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03488.html

which I assume is why the field handling wasn't unoptimized to be
strictly correct.

Nevertheless, I see no reason not to remove avoidable inconsistencies
from the current design.
