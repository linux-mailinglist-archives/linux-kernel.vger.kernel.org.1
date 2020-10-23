Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055692969C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372828AbgJWGd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372782AbgJWGd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:33:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABCC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:33:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so351264pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uuo4nUiVLSySBOciEaIBUaKDItknrQkVKbQWMateKYs=;
        b=tW+DxZVfWESe5cJt98r3MECDjupJoUYGOLIHdFBMXrhowzHuDMEFxdHv0+MD773W4n
         au4N9iP24CUAj0tS0Ft45RunDbvu4oT9Hknr6zA0YBS+AlM2urBKaaQhSpaj014o0AWu
         f0JPAwSUjbGOZaQ9PYSOw7NZiFGqMi6BVy4W4bFwtsferMXhvBG+1BTkH0oPqam3pH+3
         nrhitWxT/hXnrX5NZEHYCaCoOc7b3hpX/uvDf3hJGfkfzRjsExVFI5WhPewT8w/Qy8xv
         oFhvPskhrMKrs60uTSHUUjhEgCEHzncS3WyuEARUjWRkJRlVTprZFI4LiZUYtre+CZsg
         a1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uuo4nUiVLSySBOciEaIBUaKDItknrQkVKbQWMateKYs=;
        b=njKqwTsjFkuNTTeMWw3Ahws+TxDrskktHKqo1X/Ne70Qa5KE36fDZux1C7nbtTxqhx
         S+wTBnaK9TQ6eOYm2UdBPwFR1kuhjM92xnjcCsmYHCPUdvUsN8KkDSTJT1NULfyJ4dr3
         GEb/zBUhfdK3PEVmXkY994ZnPDwl7iU36RXOP2/dutdj7QpLcBMETmroSFWpyE0Hu5t7
         yI89uxCtF4+z+BCWleRZi5LYPwtKOPYh1b42lqTP8qWPNMLz7Q7S6jcAZZ3PAYR5foiM
         v+bbSLo2/zUZi0rCeNn6EVXyyVOiy84UVuew//8Dgj0cn6MMnhK6C2AVXMUpSbIZFt73
         EtYA==
X-Gm-Message-State: AOAM532yha56/BgprMOofB4s6MOI971i2tshiuNsiTxhOQSTxojvlkXN
        dJUwhfVPVN3TN5OLHW8mHk38XvniliBjbY+g
X-Google-Smtp-Source: ABdhPJw2EmJlWlFn0DsQOlmkTgPZm4Pz6jzuwE/1ig6MIGiNFiXeW37qUO5GA2h27YyfNPeXC5OerQ==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr926904pgl.305.1603434807452;
        Thu, 22 Oct 2020 23:33:27 -0700 (PDT)
Received: from ?IPv6:2402:3a80:429:6ba7:30ef:4722:a786:585f? ([2402:3a80:429:6ba7:30ef:4722:a786:585f])
        by smtp.gmail.com with ESMTPSA id g1sm825991pjj.3.2020.10.22.23.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 23:33:26 -0700 (PDT)
Subject: Re: [PATCH v2] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
References: <20201022145021.28211-1-yashsri421@gmail.com>
 <4cbbd8d8b6c4d686f71648af8bc970baa4b0ee9b.camel@perches.com>
 <5121bf7c-a126-6178-62ff-e54f0bb4cb6e@gmail.com>
 <67247b2d51aa8b2da7377e400e9191733144ed0f.camel@perches.com>
 <edaa9012-d512-26fc-0aca-f0eaf889a050@gmail.com>
 <b853a8ab4daface74075e93d83f94655f13a2979.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <8845d575-596e-b2e0-26c1-16e704074fc8@gmail.com>
Date:   Fri, 23 Oct 2020 12:03:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b853a8ab4daface74075e93d83f94655f13a2979.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/20 4:16 am, Joe Perches wrote:
> On Fri, 2020-10-23 at 02:35 +0530, Aditya wrote:
>> On 23/10/20 1:03 am, Joe Perches wrote:
>>> On Fri, 2020-10-23 at 00:44 +0530, Aditya wrote:
>>>> On 22/10/20 9:40 pm, Joe Perches wrote:
>>>>> On Thu, 2020-10-22 at 20:20 +0530, Aditya Srivastava wrote:
>>>>>> Presence of hexadecimal address or symbol results in false warning
>>>>>> message by checkpatch.pl.
>>>>> []
>>>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>>> []
>>>>>> @@ -3051,7 +3051,10 @@ sub process {
>>>>>>  		}
>>>>>>  
>>>>>>  # check for repeated words separated by a single space
>>>>>> -		if ($rawline =~ /^\+/ || $in_commit_log) {
>>>>>> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
>>>>>> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
>>>>>> +		$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
>>>>>
>>>>> Alignment and use \b before and after the regex please.
>>>>
>>>> If we use \b either before or after or both it does not match patterns
>>>> such as:
>>>> +   -rw-r--r--. 1 root root 112K Mar 20 12:16'
>>> selinux-policy-3.14.4-48.fc31.noarch.rpm
>>>
>>> OK, thanks, it's good you checked.
>>>
>>>>> []
>>>>> What does all this code actually avoid?
>>>>
>>>> Sir, there are multiple variations of hex for which this warning is
>>>> occurring, for eg:
>>>> 1) 00 c0 06 16 00 00 ff ff 00 93 1c 18 00 00 ff ff  ................
>>>> 2) ffffffff ffffffff 00000000 c070058c
>>>> 3)     f5a:       48 c7 44 24 78 ff ff    movq
>>>> $0xffffffffffffffff,0x78(%rsp)
>>>> 4) +    fe fe
>>>> 5) +    fe fe   - ? end marker ?
>>>> 6) Code: ff ff 48 (...)
>>>
>>> So why not just match first with /^[0-9a-f]+$/i ?
>>>
>>> Doesn't that match all the cases listed above?
>>>
>>>
>>
>> Then, we'll not be able to account for cases such as:
>>
>> 1) +     * sets this to -1, the slack value will be calculated to be be
>> halfway [For 'be' 'be']
>> 2) + * @seg: index of packet segment whose raw fields are to be be
>> extracted [For 'be' 'be']
>> 3) Let's also add add a note about using only the l3 access without l4
>> [For 'add' 'add']
> 
> Like the use of long, I think you're better off with
> either a list or hash of specific words to ignore.
> 
> 
> 

Ok Sir. Actually, I was proceeding with this approach initially. But
it has some side affects like it won't be able to detect hex such as:

'ff 4d be be be 9f 04 48'

Here although 'be' is part of hex sequence, it will be reported in the
warning.
However, though such cases haven't occurred over v6..v8.

Actually, we could simplify it more on the basis of occurrences in
v6..v8, for eg. if we check for /[0-9c-f][0-9a-f]+/ (instead of
/[0-9a-f]{2,}/), it gives us desired result over v6..v8, but again
we'll miss out cases such as:

'ff af af bc bc ba ba bd bd'

To counter all these, I had implemented the solution in the proposed
way. But, I'll change it as you suggested. The advantage of it can be
that the code complexity is less and the negatives will be few.

Thanks
Aditya
