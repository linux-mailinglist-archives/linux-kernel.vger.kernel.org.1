Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2972BBECB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 12:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgKULu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 06:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgKULu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 06:50:57 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46566C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 03:50:57 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v21so5083238plo.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84ayGdyMy9/CMyxg2boT2AM+rRZOX/cQEK+WefQ2g/4=;
        b=QuZksbDgMjiA5TmkKkRV7AHpwtsdiivSs1QIiKM7vWidWCFBElPQ8b6S1x8LzpWxyq
         Uw/s3sJeUhBL2WNmdXrIKD3pVvA8RrReWnKTvrCf9e0jL3Eldi3VWHVY0EzqKVwLVSKK
         UTlTRA92Yt84is7MsP7aIMwqS/KWXjFH7YiYltzJlplMa7ZsDBTttREhRc9UCeEBX++F
         afEY1N7+i51wec6xqVFxchmFNKQXfgsACJtB8+WoeJq/di/niBEJU/F+yNc0eDMVMXsa
         TYj1jPk8NMmxsP9TvEJQwxPUJlJxIlDvAmJUrN2H8PgB7T6scMrzjLgSCS2aIC/f421M
         luWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84ayGdyMy9/CMyxg2boT2AM+rRZOX/cQEK+WefQ2g/4=;
        b=NLHFqg8yQ8pqqEWwh7BQsrFRfrXXeQYr8CDqTyY+wOgDoQDVlKVrGdyOtAMy7YjNuF
         xGHfzwXdFy9zcaUL9sVEbRyounXBv2Xb2dYhniLQOPnCfx6+FmfaP9BWfIkHWhyFRqfh
         LFehWOzlchDOeu4gchiOLrwBCRrIvYf82/lYtRb82B/Pb0hoCLBIYs7v9mrpsHC+v71u
         LJUzfsqy6/QkuCmJ1jI8jQ8lLjgG/HfsgCWCtbXGmerXDvx3M2+a6pNwoW4Kqw9t4kpd
         OYwIor1rNWyYATsRfsQFOZ51oCI9PH341iUl3EAZbyq+6AQ6jIPvJI4ssAEcLunu0sxg
         I0uA==
X-Gm-Message-State: AOAM530ofCMnDwey0hyKLkSTc/pS/CCMYhMbasiC1jbaWqeiXwMRRPat
        1xdS/CJbv/AICnTHIX2CHyQ=
X-Google-Smtp-Source: ABdhPJx11SQAjLXEas3HcY7jPIA/q5sldcz5fjkNIjhB566JHKZCc/GZY3O41glg1xssxJKdbNAlyg==
X-Received: by 2002:a17:902:9a84:b029:d9:d5ad:a669 with SMTP id w4-20020a1709029a84b02900d9d5ada669mr12858444plp.53.1605959456673;
        Sat, 21 Nov 2020 03:50:56 -0800 (PST)
Received: from ?IPv6:2402:3a80:400:4498:ed91:20bf:333c:1bc4? ([2402:3a80:400:4498:ed91:20bf:333c:1bc4])
        by smtp.gmail.com with ESMTPSA id t7sm7363754pji.27.2020.11.21.03.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 03:50:56 -0800 (PST)
Subject: Re: [PATCH v3] checkpatch: add fix option for
 ASSIGNMENT_CONTINUATIONS
From:   Aditya <yashsri421@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <20201117171856.13284-1-yashsri421@gmail.com>
 <48f56f40-a365-faac-542d-0e120fcf4365@gmail.com>
 <08f164e93dc40e066e81c4021485d27d5ad5a6b7.camel@perches.com>
 <6deacf63-a80f-67b5-0594-e5cb5e82f42b@gmail.com>
Message-ID: <1d7692d0-359f-6b6a-32d4-1627ebd8b100@gmail.com>
Date:   Sat, 21 Nov 2020 17:20:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6deacf63-a80f-67b5-0594-e5cb5e82f42b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/20 11:32 pm, Aditya wrote:
> On 20/11/20 10:56 pm, Joe Perches wrote:
>> On Fri, 2020-11-20 at 16:11 +0530, Aditya wrote:
>>> On 17/11/20 10:48 pm, Aditya Srivastava wrote:
>>>> Currently, checkpatch warns us if an assignment operator is placed
>>>> at the start of a line and not at the end of previous line.
>>>>
>>>> E.g., running checkpatch on commit 8195b1396ec8 ("hv_netvsc: fix
>>>> deadlock on hotplug") reports:
>>>>
>>>> CHECK: Assignment operator '=' should be on the previous line
>>>> +	struct netvsc_device *nvdev
>>>> +		= container_of(w, struct netvsc_device, subchan_work);
>>>>
>>>> Provide a simple fix by appending assignment operator to the previous
>>>> line and removing from the current line, if both the lines are additions
>>>> (ie start with '+')
>>>>
>>>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> add check if both the lines are additions (ie start with '+')
>>>>
>>>> Changes in v3:
>>>> quote $operator; test with division assignment operator ('/=')
>>>>
>>>>  scripts/checkpatch.pl | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>> index c9aaaa443265..d5bc4d8e4f6c 100755
>>>> --- a/scripts/checkpatch.pl
>>>> +++ b/scripts/checkpatch.pl
>>>> @@ -3542,8 +3542,14 @@ sub process {
>>>>  
>>>>
>>>>  # check for assignments on the start of a line
>>>>  		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
>>>> -			CHK("ASSIGNMENT_CONTINUATIONS",
>>>> -			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
>>>> +			my $operator = "$1";
>>>> +			if (CHK("ASSIGNMENT_CONTINUATIONS",
>>>> +				"Assignment operator '$1' should be on the previous line\n" . $hereprev) &&
>>>> +			    $fix && $prevrawline =~ /^\+/) {
>>>> +				# add assignment operator to the previous line, remove from current line
>>>> +				$fixed[$fixlinenr - 1] .= " $operator";
>>>> +				$fixed[$fixlinenr] =~ s/$operator\s*//;
>>>> +			}
>>>>  		}
>>>>  
>>>>
>>>>  # check for && or || at the start of a line
>>>>
>>>
>>> Hi Joe
>>> This patch probably got missed. Please review :)
>>
>> Did you look at $Assignment?  Did you see it can be /= ?
>>
> 
> Yes, I tested the patch with '/=' operator as well.
> As I could not find any occurrences in the past(over 4.13..5.8), I
> created an example for myself by modifying the above mentioned commit
> example i.e. commit 8195b1396ec8 ("hv_netvsc: fix deadlock on
> hotplug") as:
> 
> +	struct netvsc_device *nvdev
> +		/= container_of(w, struct netvsc_device, subchan_work);
> 
> [For Line 144 and 145(where the warning was reported for '=' earlier)]
> 
> The fix changes these lines to:
> +	struct netvsc_device *nvdev /=
> +		container_of(w, struct netvsc_device, subchan_work);
> 
> On retesting the patch with checkpatch.pl, it did not give this CHECK,
> nor did we add any new warning/error.
> 
>> If it is, what happens in the $fixed[$fixlinenr] line?
>>
> 
> In $fixed[$fixlinenr], we are just getting rid of the operator and any
> space(s) following it.
> 
> What do you think?
> 

I think I understood quoting incorrectly here. I had to use \Q.
I'll resend the modified patch with desired changes.
Sorry for inconvenience.

Thanks
Aditya
