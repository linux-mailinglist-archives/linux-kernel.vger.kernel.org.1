Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75092B08ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgKLPvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgKLPvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:51:42 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3167C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:51:40 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so4479942pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R63elO6azLmdFhexBWQ7vR6miEsYpAf0xG4oKKmf0Xc=;
        b=s+cxOOsWOMeyYdWMTOwpqZ0+551FdX+Fjyu55bHhAXHtctcSeRZ9CR/RcmLwWd/g3f
         OpVdKLJWIWr8cMj5AQq68AQr3da3T5viH3JaZFNLsifHDNhBjd/QP+Ae4EU1RyJLKFV5
         UdPDnD7xeVu6+rXR+YK30hU2lg9YigtCnC2iYE5BKLgrIXhj8W8HruoF06OZX9umAGOR
         xNiXHuD5Az6OpSwDHHZkJwwNvuJFvSUrhkYoRIG4YHHAouhf1cUUO9BrZvei+zMQziJq
         b2sfdM2PcvyrF+OtVxdEs5TJ6xACxD6IE3z+hCj44bpKVxzbaASinsgUsrnngblDf6ah
         oDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R63elO6azLmdFhexBWQ7vR6miEsYpAf0xG4oKKmf0Xc=;
        b=K67Nv4lMx1gRsMX9Td8p2SlRv6IMGZXfCGMqZNFnukIeUbSvlgYYggv/6YLYZnIvm0
         G2JZyo8bNUEOFk2fYBXQLRXjKsU632WZI2y+oRyFFQLQERdmiZ5aaKhUB5vjJP9hw3tm
         34WJPAOUPzrgrzLtMjdWZm1ZZUzATRrWANfDQldtue5dpV4zricrS/2givR7InbfI3t7
         X9jgb1xKfatWMEB65yqcGZs/Jgy+VN40G+xOvM6oWwWELjzd2eHDmYjAYiIXS0e7MRnx
         jx2AIz92yAH6+yzhvzFHaUtip/oVdqkYD9r4eVYJD9h9DrHDcNI1DFJgSWFc9roZ2PVe
         VK1Q==
X-Gm-Message-State: AOAM530OhGfHsTpUYbrsmrbLyR5+aOMR784JwzN5YTEEs/jkP+0jKJao
        OIbUPTlQZxT8Kz9b+rVZh72qnQ==
X-Google-Smtp-Source: ABdhPJxnlZ1iNwusya9sKmPk+F3FZ0n19kbDxf5aj1R1pRS8fMP3NOIl96u8ubvCDardNy2kejvl1g==
X-Received: by 2002:a17:90b:2343:: with SMTP id ms3mr10237511pjb.130.1605196300218;
        Thu, 12 Nov 2020 07:51:40 -0800 (PST)
Received: from [192.168.11.16] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id s11sm6578972pfh.128.2020.11.12.07.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:51:39 -0800 (PST)
Subject: Re: ac0e958a00:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:run_init_process
To:     David Laight <David.Laight@ACULAB.COM>,
        kernel test robot <oliver.sang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        0day robot <lkp@intel.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>
References: <20201112071145.GC17067@xsang-OptiPlex-9020>
 <87765a0e-3a49-d437-4010-4848b8ece199@landley.net>
 <2bd72a2f0af948d29eb201e3072e514e@AcuMS.aculab.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <c214546d-e678-2ef3-4b4d-54df3f264cbd@landley.net>
Date:   Thu, 12 Nov 2020 10:02:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2bd72a2f0af948d29eb201e3072e514e@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 7:49 AM, David Laight wrote:
> From: Rob Landley
>> Sent: 12 November 2020 12:46
>>
>> On 11/12/20 1:11 AM, kernel test robot wrote:
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>
>> Blah, switched from strlcpy to sprintf due to the lack of spaces and didn't
>> adjust the size.
>>
>> (And yes, the compiler's lifetime analysis should free the stack space before
>> the tail call, and I'd assume exec restarts the stack anyway.)

This is why I didn't put anything like that in the first submission. (I knew
better, and did it anyway...)

>> Second-attempt-by: Rob Landley <rob@landley.net>
>> ---
>>
>>  init/main.c |   15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index 130376ec10ba..e92320816ef8 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -1328,15 +1328,16 @@ static void __init do_pre_smp_initcalls(void)
>>  static int run_init_process(const char *init_filename)
>>  {
>>  	const char *const *p;
>> +	char buf[512], *s = buf;
>>
>>  	argv_init[0] = init_filename;
>> -	pr_info("Run %s as init process\n", init_filename);
>> -	pr_debug("  with arguments:\n");
>> -	for (p = argv_init; *p; p++)
>> -		pr_debug("    %s\n", *p);
>> -	pr_debug("  with environment:\n");
>> -	for (p = envp_init; *p; p++)
>> -		pr_debug("    %s\n", *p);
>> +
>> +	for (p = (void *)envp_init; *p; p++)
>> +		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)-2), *p);
>> +	for (p = (void *)argv_init; *p; p++)
>> +		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)-2), *p);
>> +	pr_info("Run init: %s\n", buf);
>> +
> 
> Why not use scnprintf() as:
> 	len += scnprintf(buf + len, 256 - len, " %s", *p);

Because what I did worked for me?

The buffer size isn't 256, sizeof() means if the buffer size changes the code
automatically adjusts and the -2 gets constant folded at compile time anyway,
you've proposed switching from a posix function to a kernel-specific function
for no obvious benefit, it's the same number of arguments and other than 2 bytes
in a string constant you've just swapped s-buf for buf+len, I didn't want to dig
into whether passing rdinit= could have an empty environment so the "skip a
space" has no space to skip and thus you skip the null terminator so I just left
one harmlessly trailing on the end, if I wanted to get FANCY I'd measure and
allocate space then free it after printing...

I could go on, but that's about as much bikeshedding as I have the stomach for
right now on two for loops calling print statements, thanks.

> or even:
> 	s = buf + sizeof buf;
> 	len = sizeof buf;
> 	...
> 		len -= scnprintf(s - len, len, " %s", *p);
> 
> and remove the " " before the %s in the final pr_info().

Feel free to submit your own patch...?

I don't really expect this to get merged. It's not like I cc'd any humans. My
latest thingied-by tag is not an approved entry in
Documentation/process/submitting-patches.rst and I didn't go through all 27
steps in Documentation/process/submit-checklist.rst because I'm not part of the
fulltime kernel political clique and I don't bother to fight them anymore. It's
just a small thing that annoyed me and I mostly posted it here so when some
clown sues us for shipping a modified kernel I can cost them more money by
pointing their lawyers at the patch on the list's web archive. (I could do so on
a website I maintain, but then I'd have to track it and dowanna.)

I was only ever involved here as a hobbyist. The Linux Foundation is currently
holding a "conference dedicated to driving collaboration and innovation in
financial services" with "featured speakers" including the Managing Director of
Goldman Sachs, the Founder of the Alliance for Innovative Regulation, the former
CIO of Deutsche Bank, Red Hat's Director of Financial Services Strategy, and
whatever "Open Source Wonk, Azure Office of the CTO, Microsoft" means.

No, I did not make that up, they spammed me about it as part of their perpetual
fundraising strategy to sell for-profit conference tickets:

  https://events.linuxfoundation.org/open-source-strategy-forum/

Rob
