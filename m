Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1F2BB1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKTSCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgKTSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:02:23 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DF1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:02:23 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so8596761pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pi314qbACkjvb24O5TOH5mgSNjJFBx6zBuaW1GBgOBw=;
        b=anUMddH1t++aHeatBjzyWQq6MC3KcPFQxcSP0boTBtJ1Wf8V8zxkpr9PANfBJ7nuXA
         iy323bWUVOhNqEj33fQ3duFIF7Z0s4nI12XRaYbXvet1AmLNdWAI6sGCTpCoAPf9za+E
         TX6tmnT0QipCiXBBfml6V8jVo88QHDO67A5yupSqyiSExAh6HBrDuwSYuBr2r6JEImvh
         u9fdM1PQcrrkpH4DRvZ9Jr7OF06Wh58Rv8wJ+2hunkuGfC57xLm8bGPKngYpP6NGBYp8
         2nAiUdId0sye5vi5QuDn4c2JvdPbm+Al0+VF4ceJdPrGh02TQRPkz7IgxhZOtfQr6ieK
         yudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pi314qbACkjvb24O5TOH5mgSNjJFBx6zBuaW1GBgOBw=;
        b=AokVHa7q3iWy2rwzp+jw/bm2yxsze2JmJcrnsawn2Zt+CFARYP+l39uZfCuzsMIy1W
         QB+UW+WLOO/reuUTgbUFsXGVV7HozhqbLWILqHN9Lo7g4UdXGBk6diQG8glaYIozWTas
         42tz2t7oA7BVwcv88k+LP27q8J8pvbIJCEFb+TNNuUEr7zptHzmn5N5dfAysAZBWvSZO
         hki/KfSpegTZyRbnB1FmQaRDLKsN6xX1s7vkYuOtkewirBqZwduaiEbktvdczLfkO/Cj
         rFnyZSS3cmDnBvKtwaS2sVmfbhFIdfs3ai822shWUIDv8VWDsECdJEjZBGB0Q1DvssAQ
         lwFQ==
X-Gm-Message-State: AOAM5314TaATH7HClbaWXc34MpZRLaQew4RwArXk43/R5hSYxadxHc4T
        AQZz/wBUAJFt5LKK8Rj+2crLBzXIgakwWg==
X-Google-Smtp-Source: ABdhPJyMU0p+BzlD058jBRxrtiWOLaHeym1uqUUcGQUYH93F6JCRU4jFp0pLuLw2RuC3SktGxcFUAA==
X-Received: by 2002:a17:90a:14e5:: with SMTP id k92mr11376797pja.169.1605895343009;
        Fri, 20 Nov 2020 10:02:23 -0800 (PST)
Received: from ?IPv6:2402:3a80:415:f607:e09e:f6d6:daa6:f3cd? ([2402:3a80:415:f607:e09e:f6d6:daa6:f3cd])
        by smtp.gmail.com with ESMTPSA id a12sm4684255pjh.48.2020.11.20.10.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:02:22 -0800 (PST)
Subject: Re: [PATCH v3] checkpatch: add fix option for
 ASSIGNMENT_CONTINUATIONS
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <20201117171856.13284-1-yashsri421@gmail.com>
 <48f56f40-a365-faac-542d-0e120fcf4365@gmail.com>
 <08f164e93dc40e066e81c4021485d27d5ad5a6b7.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <6deacf63-a80f-67b5-0594-e5cb5e82f42b@gmail.com>
Date:   Fri, 20 Nov 2020 23:32:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <08f164e93dc40e066e81c4021485d27d5ad5a6b7.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/20 10:56 pm, Joe Perches wrote:
> On Fri, 2020-11-20 at 16:11 +0530, Aditya wrote:
>> On 17/11/20 10:48 pm, Aditya Srivastava wrote:
>>> Currently, checkpatch warns us if an assignment operator is placed
>>> at the start of a line and not at the end of previous line.
>>>
>>> E.g., running checkpatch on commit 8195b1396ec8 ("hv_netvsc: fix
>>> deadlock on hotplug") reports:
>>>
>>> CHECK: Assignment operator '=' should be on the previous line
>>> +	struct netvsc_device *nvdev
>>> +		= container_of(w, struct netvsc_device, subchan_work);
>>>
>>> Provide a simple fix by appending assignment operator to the previous
>>> line and removing from the current line, if both the lines are additions
>>> (ie start with '+')
>>>
>>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>>> ---
>>> Changes in v2:
>>> add check if both the lines are additions (ie start with '+')
>>>
>>> Changes in v3:
>>> quote $operator; test with division assignment operator ('/=')
>>>
>>>  scripts/checkpatch.pl | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> index c9aaaa443265..d5bc4d8e4f6c 100755
>>> --- a/scripts/checkpatch.pl
>>> +++ b/scripts/checkpatch.pl
>>> @@ -3542,8 +3542,14 @@ sub process {
>>>  
>>>
>>>  # check for assignments on the start of a line
>>>  		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
>>> -			CHK("ASSIGNMENT_CONTINUATIONS",
>>> -			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
>>> +			my $operator = "$1";
>>> +			if (CHK("ASSIGNMENT_CONTINUATIONS",
>>> +				"Assignment operator '$1' should be on the previous line\n" . $hereprev) &&
>>> +			    $fix && $prevrawline =~ /^\+/) {
>>> +				# add assignment operator to the previous line, remove from current line
>>> +				$fixed[$fixlinenr - 1] .= " $operator";
>>> +				$fixed[$fixlinenr] =~ s/$operator\s*//;
>>> +			}
>>>  		}
>>>  
>>>
>>>  # check for && or || at the start of a line
>>>
>>
>> Hi Joe
>> This patch probably got missed. Please review :)
> 
> Did you look at $Assignment?  Did you see it can be /= ?
> 

Yes, I tested the patch with '/=' operator as well.
As I could not find any occurrences in the past(over 4.13..5.8), I
created an example for myself by modifying the above mentioned commit
example i.e. commit 8195b1396ec8 ("hv_netvsc: fix deadlock on
hotplug") as:

+	struct netvsc_device *nvdev
+		/= container_of(w, struct netvsc_device, subchan_work);

[For Line 144 and 145(where the warning was reported for '=' earlier)]

The fix changes these lines to:
+	struct netvsc_device *nvdev /=
+		container_of(w, struct netvsc_device, subchan_work);

On retesting the patch with checkpatch.pl, it did not give this CHECK,
nor did we add any new warning/error.

> If it is, what happens in the $fixed[$fixlinenr] line?
>

In $fixed[$fixlinenr], we are just getting rid of the operator and any
space(s) following it.

What do you think?

Thanks
Aditya
