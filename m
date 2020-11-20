Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4362BAF96
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgKTQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:04:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:24706 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728235AbgKTQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:04:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AKFvU9v028043;
        Fri, 20 Nov 2020 10:04:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=o2+8fR8KhbhX8XK+Zt0dXm6do+vMPon60U2hdksJtUw=;
 b=LdN/EoC3b++HBBB0CtwCQxPAlOShx/IXw5T/4yi1G2zGD5inaDczKMRrecIAHUFU186r
 qDsx/EY8B9aRD1UJFhG9EOdTQJ4Df5cyhV0ZMSMmhfzvWQ7ImMA9Z4IlrZt5eIwiVFiM
 ON0pr/oRw60Ukiel/E/y0LfZBHwxnv/DUALWuVk/cKHcTJKgRl4JygPoeJiNCMUiRHPm
 ng05pL8v+tqY6bBNV6wJNp03WqKnDutnfWFyDguKKK416HyYITBlL4U0vZv0Yp7Pl5Aw
 K7FEB9p5MVSsR8MEoCdnGHFJKdjq5Z59y/tNA+tdWcQj39ST6SPXllYGpe72NEUH1vWa YA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 34tdh7jukw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Nov 2020 10:04:10 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 20 Nov
 2020 16:04:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 20 Nov 2020 16:04:23 +0000
Received: from [10.0.2.15] (ausnpc0lsnw1.ad.cirrus.com [198.61.65.1])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 05A8F45;
        Fri, 20 Nov 2020 16:04:07 +0000 (UTC)
Subject: Re: [PATCH] lib: vsprintf: Fix handling of number field widths in
 vsscanf
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
CC:     <sergey.senozhatsky@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20201116143252.19983-1-rf@opensource.cirrus.com>
 <X7ei9cENZ0dVkGZh@alley> <20201120100705.3a7fb747@gandalf.local.home>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <59d43108-814e-4bf1-73f9-4994291abc05@opensource.cirrus.com>
Date:   Fri, 20 Nov 2020 16:04:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201120100705.3a7fb747@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2020 15:07, Steven Rostedt wrote:
> On Fri, 20 Nov 2020 12:05:25 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
>> On Mon 2020-11-16 14:32:52, Richard Fitzgerald wrote:
>>> The existing code attempted to handle numbers by doing a strto[u]l(),
>>> ignoring the field width, and then bitshifting the field out of the
>>> converted value. If the string contains a run of valid digits longer
>>> than will fit in a long or long long, this would overflow and no amount
>>> of bitshifting can recover the correct value.
>>>
>>> This patch fixes vsscanf to obey number field widths.
>>>
>>> A new _parse_integer_limit() is added that takes a limit for the number
>>> of characters to parse. A length of INT_MAX is effectively unlimited, as
>>> we are not likely to need parsing of digit strings >INT_MAX length.
>>>
>>> The number field conversion in vsscanf is changed to use this new
>>> _parse_integer_limit() function so that field widths are obeyed when
>>> parsing the number. Note also that the conversion is always done as a
>>> long long - as there's currently no overflow checking there is no point
>>> implementing separate long and long long conversions.
>>>
>>> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
>>> index a14ccf905055..9867501a4ab0 100644
>>> --- a/lib/kstrtox.c
>>> +++ b/lib/kstrtox.c
>>> @@ -39,20 +39,23 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
>>>   
>>>   /*
>>>    * Convert non-negative integer string representation in explicitly given radix
>>> - * to an integer.
>>> + * to an integer. The maximum number of characters to convert can be given.
>>> + * A character limit of INT_MAX is effectively unlimited since a string that
>>> + * long is unreasonable.
>>
>> The INT_MAX value meaning is obvious. It does not need to be
>> mentioned. It is the same as with vsnprintf().
> 
> Yeah, but I never think that restating the obvious is a bad idea.
> Especially when something that is obvious to us, is not obvious to a new
> comer. There's been lots of times I wish someone mentioned the obvious in a
> comment somewhere, because it wasn't obvious to me ;-)
> 
> I vote to keep it in.
> 
>>
>>
>>>    * Return number of characters consumed maybe or-ed with overflow bit.
>>>    * If overflow occurs, result integer (incorrect) is still returned.
>>>    *
>>>    * Don't you dare use this function.
>>>    */
>>> -unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
>>> +unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
>>> +				  int max_chars)
>>
>> Please, use size_t. Passing negative value usually means
>> that the caller did not handle some situation correctly.
>> And it actually happened in this patch, see below.
>>
>> nit: better ballance the length of the lines above. I mean to move
>>       *p to the next line:
>>
>> unsigned int _parse_integer_limit(const char *s, unsigned int base,
>> 				  unsigned long long *p, size_t max_chars)
>>
>>
>>>   {
>>>   	unsigned long long res;
>>>   	unsigned int rv;
>>>   
>>>   	res = 0;
>>>   	rv = 0;
>>> -	while (1) {
>>> +	for (; max_chars > 0; max_chars--) {
>>>   		unsigned int c = *s;
>>>   		unsigned int lc = c | 0x20; /* don't tolower() this line */
>>>   		unsigned int val;
>>> @@ -82,6 +85,11 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
>>>   	return rv;
>>>   }
>>>   
>>> +unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
>>> +{
>>> +	return _parse_integer_limit(s, base, p, INT_MAX);
>>> +}
>>> +
>>>   static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>>>   {
>>>   	unsigned long long _res;
>>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>>> index 14c9a6af1b23..8ec47b5da2cb 100644
>>> --- a/lib/vsprintf.c
>>> +++ b/lib/vsprintf.c
>>> @@ -53,6 +53,25 @@
>>>   #include <linux/string_helpers.h>
>>>   #include "kstrtox.h"
>>>   
>>> +static unsigned long long simple_strntoull(const char *startp, int max_chars,
>>> +					   char **endp, unsigned int base)
>>> +{
>>> +	const char *cp;
>>> +	unsigned long long result;
>>> +	unsigned int rv;
>>> +
>>> +	cp = _parse_integer_fixup_radix(startp, &base);
>>> +	max_chars -= (cp - startp);
>>
>> Negative value means that _parse_integer_fixup_radix() already
>> proceed more characters than allowed. I would handle this
>> the following way:
>>
>> 	if (cp - startp > max_chars) {
>> 		cp = startp + max_chars;
>> 		result = 0LL;
>> 		goto out;
> 
> Agreed. I was looking at what sscanf() in user space does.
> 
> And testing it with the following:
> 
> 	char *line = "0x123456789abcdef0123456789\n";
> 	int i;
> 
> 	for (i = 0; i < 10; i++) {
> 		char str[32];
> 		long a, b;
> 
> 		if (i)
> 			sprintf(str, "%%%dli%%9lx", i);
> 		else
> 			strcpy(str, "%li%6lx");
> 
> 		ret = sscanf(line, str, &a, &b);
> 		switch (ret) {
> 		case 1:
> 			printf("read 1 '%s': %lx\n", str, a);
> 			break;
> 		case 2:
> 			printf("read 2 '%s': %lx %lx\n", str, a, b);
> 			break;
> 		default:
> 			printf("Failed to read: '%s' ret = %d\n", str, ret);
> 		}
> 	}
> 
> And the above produced:
> 
> read 1 '%li%6lx': 7fffffffffffffff
> read 1 '%1li%9lx': 0
> read 2 '%2li%9lx': 0 123456789
> read 2 '%3li%9lx': 1 23456789a
> read 2 '%4li%9lx': 12 3456789ab
> read 2 '%5li%9lx': 123 456789abc
> read 2 '%6li%9lx': 1234 56789abcd
> read 2 '%7li%9lx': 12345 6789abcde
> read 2 '%8li%9lx': 123456 789abcdef
> read 2 '%9li%9lx': 1234567 89abcdef0
> 
> The first line I'm assuming is because %li overflowed (more digits than a
> 64 bit could hold).
> 
> But yeah, we could very much have cp - startp > max_chars.
> 

My code handles the prefix overflow, but I did it by having
__parse_integer_limit() simply give 0 if max_chars <= 0.

So if the field width isn't enough for the prefix/leading '-' and at
least one digit, subtracting the prefix length from the field length
will give a max_chars <= 0. And you'll get a result of 0 as in your
'%2li%9lx' test case.

I thought this was nice because it didn't need to add code to check
for the prefix overflow - it comes inherently from the loop in
__parse_integer_limit(). But I'm willing to change
__parse_integer_limit() to take an unsigned and add explicit checks for
the prefix/'-' overflow cases.

> 
>>
>>> +	rv = _parse_integer_limit(cp, base, &result, max_chars);
>>> +	/* FIXME */
>>> +	cp += (rv & ~KSTRTOX_OVERFLOW);
>>
>> out:
>>
>>> +	if (endp)
>>> +		*endp = (char *)cp;
>>> +
>>> +	return result;
>>> +}
>>> +
>>>   /**
>>>    * simple_strtoull - convert a string to an unsigned long long
>>>    * @cp: The start of the string
>>> @@ -126,6 +134,15 @@ long long simple_strtoll(const char *cp, char **endp, unsigned int base)
>>>   }
>>>   EXPORT_SYMBOL(simple_strtoll);
>>>   
>>> +static long long simple_strntoll(const char *cp, int max_chars, char **endp,
>>> +				 unsigned int base)
>>> +{
>>> +	if (*cp == '-')
>>> +		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
>>> +
>>> +	return simple_strntoull(cp, max_chars, endp, base);
>>> +}
>>
>> Please, use this in simple_strtoll() like it is already done in
>> simple_strtoull(). I mean:
>>
>> long long simple_strtoll(const char *cp, char **endp, unsigned int base)
>> {
>> 	return simple_strntoll(cp, INT_MAX, endp, base);
>> }
> 
> Agreed.
> 
>>
>>> +
>>>   static noinline_for_stack
>>>   int skip_atoi(const char **s)
>>>   {
>>
>> Finally, it would be great to add some selftests for this into
>> lib/test_printf.c.
>>
>> Thanks a lot for working on this. I like this approach.
> 
> +1
> 
> -- Steve
> 
