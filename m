Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5829665C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372141AbgJVVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897428AbgJVVGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:06:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 14:06:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh6so1628964plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgx65QdBaew41efkl7/UustFO3l6mgj7XMQW6o29430=;
        b=HQCFJCbIFWvSuo38i16Rub4lCN88taQMhrFe+FRgqkw/TIv5d2DvYu2OVEn118yvBJ
         DiUL14SAQ9GOKknTCRysjQGwgVQ/UAPqOgj4a8Hb/QDiVhEPu4jAcqYSJqt1gYlJV7dG
         qQs9PKFryUjI5UhUi1PWxFIYDHTV3Sqiy4yq1jR7XdSDWEe7Viy7S2I4RYeue5ffCNcx
         sReJoJEqZRVVPwVCb0k0o64qO1xtxGn4Dk61oAEfHc33198RfjLTO4wWLQvng+hmzKb1
         fV6ZDdTt5k8iihB+MkcLuQw5mgdB+CeKp37lP092OVkGY1Q8tpgxX/YPnERsuSebJpPn
         GpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgx65QdBaew41efkl7/UustFO3l6mgj7XMQW6o29430=;
        b=FQmeUnayzsMsdvziZaymx5EuLVUWaZgFToqHSr1fI/qtiYJPHi6NwrLs0CfZzWYBPX
         FpRCcOdAg4VCkDZ5LzRl3b8SQzdKJmNo1dwTQ0xei7xFmm1jS06+lFj8y82RaFV+4NAy
         VJbtO5NpfP0cDvmm4YdxRC/cv3TFjvqBfoSra197brrsDJ372vYaqWXv0BlE/Tpbiwcn
         uMN+i/0hGnEpX3obgwJbvJ0FsEjM1UiQ/U7k4J1r8+vM+8EN6/dBL2vJnMqm9ktyksjY
         8hamxQunVB2YqDEeA6fdQQdvVrgDLq1VJgLhSX7SV8QTRtPk2vcRVOl89RLyGOrwp9L8
         V5+g==
X-Gm-Message-State: AOAM530Mm6dknuOJWg4ldZczmuvIs6Dsnnwnq9n3wSTjbmLh/xEReMzP
        XYX5i/KuHRhiZiM28SOeZKSrzTMRWbFrgFf2
X-Google-Smtp-Source: ABdhPJwI9oxpreulvx1O3dcmUsiSwk41Tsf7f6mdhDWRoN3FNXgR/d3eY9HPYsow4LkzwSEkcYRFgg==
X-Received: by 2002:a17:902:203:b029:d2:5660:8c84 with SMTP id 3-20020a1709020203b02900d256608c84mr4287853plc.80.1603400763218;
        Thu, 22 Oct 2020 14:06:03 -0700 (PDT)
Received: from ?IPv6:2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1? ([2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1])
        by smtp.gmail.com with ESMTPSA id g16sm2969793pgm.38.2020.10.22.14.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 14:06:02 -0700 (PDT)
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
From:   Aditya <yashsri421@gmail.com>
Message-ID: <edaa9012-d512-26fc-0aca-f0eaf889a050@gmail.com>
Date:   Fri, 23 Oct 2020 02:35:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <67247b2d51aa8b2da7377e400e9191733144ed0f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/20 1:03 am, Joe Perches wrote:
> On Fri, 2020-10-23 at 00:44 +0530, Aditya wrote:
>> On 22/10/20 9:40 pm, Joe Perches wrote:
>>> On Thu, 2020-10-22 at 20:20 +0530, Aditya Srivastava wrote:
>>>> Presence of hexadecimal address or symbol results in false warning
>>>> message by checkpatch.pl.
>>> []
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> []
>>>> @@ -3051,7 +3051,10 @@ sub process {
>>>>  		}
>>>>  
>>>>  # check for repeated words separated by a single space
>>>> -		if ($rawline =~ /^\+/ || $in_commit_log) {
>>>> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
>>>> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
>>>> +		$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
>>>
>>> Alignment and use \b before and after the regex please.
>>
>> If we use \b either before or after or both it does not match patterns
>> such as:
>> +   -rw-r--r--. 1 root root 112K Mar 20 12:16'
> selinux-policy-3.14.4-48.fc31.noarch.rpm
> 
> OK, thanks, it's good you checked.
> 
>>> []
> 
>>> What does all this code actually avoid?
>>
>> Sir, there are multiple variations of hex for which this warning is
>> occurring, for eg:
>> 1) 00 c0 06 16 00 00 ff ff 00 93 1c 18 00 00 ff ff  ................
>> 2) ffffffff ffffffff 00000000 c070058c
>> 3)     f5a:       48 c7 44 24 78 ff ff    movq
>> $0xffffffffffffffff,0x78(%rsp)
>> 4) +    fe fe
>> 5) +    fe fe   - ? end marker ?
>> 6) Code: ff ff 48 (...)
> 
> So why not just match first with /^[0-9a-f]+$/i ?
> 
> Doesn't that match all the cases listed above?
> 
> 

Then, we'll not be able to account for cases such as:

1) +     * sets this to -1, the slack value will be calculated to be be
halfway [For 'be' 'be']
2) + * @seg: index of packet segment whose raw fields are to be be
extracted [For 'be' 'be']
3) Let's also add add a note about using only the l3 access without l4
[For 'add' 'add']

where it will not detect them.

Aditya
