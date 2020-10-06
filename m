Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24628444F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgJFDgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 23:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJFDgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:36:04 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B8C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 20:36:02 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f37so7402665otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 20:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fKgIvZr0CtFhZw4VtdITEcPYj8HHKx+5kfmcgZQUwP4=;
        b=SYwgRWMun0G7+wQOEmhRrg4dhJQ1hTIHS8nAQfaAQXyEsHiSS8OY++HA8Ww0GGW/5z
         shrZtt5ny5vwha24atuHTQI533x3IwJvcigXV8ntvvsg/69hAM8/DR4cVDcRXGS3kdWG
         5HNFQaLHFbCQqasPn/GW3TCVtvdItrB4JpXVzm1XVgDGPzJO8BzJFuwFWNPcryYTr8HT
         SihLuw6oKIIBQ2gQTmcjoZA0JjLV/RR+CvRV9vjkHrm5q7lWZ2kh0fGz1Jjoe57cKLr/
         m5St0zE/9JxX5hmODQOppbE7DYjwJR72/WhtH+YtjaFfu2zzqNn6JaIOeAVuBXlq3bgJ
         Nycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fKgIvZr0CtFhZw4VtdITEcPYj8HHKx+5kfmcgZQUwP4=;
        b=QiS9odYe0t4H02BOJphRsASnzRHDbf0ovsVKZKQGaB8U64G0vYXTfou+F/OASvx5U8
         VINv+YpcASEt8sVMjfH3peAreU6RGsKyxU5xwKE6N6KZEDQcfZ5y+yCc23E3NWl+HUo3
         c/fP2awc9N/mz6igcDayC4WpWm4Z8tFdngSeHDoTSUhJ8C3YaNeLKmOtN1s+hgreZS+a
         gN72wib7jTkqmeXIeJb9ELlcrLpuDXolzyCL3O7IJWn4dQRcC1LZjKTi3ioMHy5E48og
         63W0+3UBI2cNRp7ux9kdeQgIWX2cCLhvbvrFnCrhZ/OXkI3oWJhxOYsh0ERD2UuMZCWI
         urrA==
X-Gm-Message-State: AOAM531lMm3tb2mIEDvXTh4vLif0d2Xefe6Whmp+M2bxrky2tR/e/PdS
        LpO3XIr+TJ3xdoBbTE0UP2qnaU5J1oI=
X-Google-Smtp-Source: ABdhPJzaz8lRdOLDyEau8avxTgWlOi/paePg6I4KUIJktv2h0fjWwqAy7ropql1du0P7SYKdcY2TSA==
X-Received: by 2002:a05:6830:196:: with SMTP id q22mr1575491ota.221.1601955361589;
        Mon, 05 Oct 2020 20:36:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15sm555179ooj.10.2020.10.05.20.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 20:36:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
Date:   Mon, 5 Oct 2020 20:35:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006025935.GA597@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 7:59 PM, Sergey Senozhatsky wrote:
> Cc-ing Guenter,
> 
> On (20/05/22 12:00), Petr Mladek wrote:
>> On Fri 2020-05-22 16:53:06, Shreyas Joshi wrote:
>>> If uboot passes a blank string to console_setup then it results in a trashed memory.
>>> Ultimately, the kernel crashes during freeing up the memory. This fix checks if there
>>> is a blank parameter being passed to console_setup from uboot.
>>> In case it detects that the console parameter is blank then
>>> it doesn't setup the serial device and it gracefully exits.
>>>
>>> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
>>> ---
>>>  V1:
>>>     Fixed console_loglevel to default as per the review comments
>>>
>>>  kernel/printk/printk.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>>> index ad4606234545..e9ad730991e0 100644
>>> --- a/kernel/printk/printk.c
>>> +++ b/kernel/printk/printk.c
>>> @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
>>>  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
>>>  	char *s, *options, *brl_options = NULL;
>>>  	int idx;
>>> -
>>> +	if (str[0] == 0) {
>>> +		return 1;
>>> +	}
>>>  	if (_braille_console_setup(&str, &brl_options))
>>>  		return 1;
>>
>> I have fixed formatting and pushed it into printk/linux.git,
>> branch for-5.8.
> 
> Petr, this patch's causing regressions for us. We use blank console= boot
> param to bypass dts. It appears that it'd be better to revert the change.
> 

Not just to bypass dts, it was also possible to use console= to disable consoles
passed as config option, as well as other default console options. A quick test
confirms that this affects all platforms/architectures, not just Chromebooks.
Prior to this patch, it was possible to disable a default console with an
empty "console=" parameter. This is no longer possible. This means that
this patch results in a substantial (and, as far as I can see, completely
undiscussed) functionality change.

I don't understand why (yet), but the patch also causes regressions with
seemingly unrelated functionality, specifically with dm-verity on at least
one Chromebook platform. I filed crbug.com/1135157 to track the problem,
and reverted the patch from all our stable releases immediately after
the last round of stable release merges.

On a side note, I don't see the problem presumably fixed with this
patch in any of my tests.

Guenter
