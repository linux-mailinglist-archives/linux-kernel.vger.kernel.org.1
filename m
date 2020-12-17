Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC62DD962
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgLQTgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 14:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 14:36:19 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A713C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 11:35:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i7so9314282pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 11:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wPZrnA5/SetkiT4mAmTLqyH+8YY+s0za4WlgxwCw6jk=;
        b=CKi4msHEuMRaYQ8/7JWOfiZs5cZtUDrQJkcjMq53HqPd94CpGez6LZZuubVsZJ76Ls
         qj6GnshbiGyBh9k/8dsss+y4f2DoEj/NqRHzSq5xs1ozY+dfrMOydxKvQj8HnPMcXmzp
         tpAyZ8OZ3yLbllqzr8KTOVtF/WKbR31fBfhEkWKqD1sPtuOTXQQCKkwOBTDc0Stwipr5
         87zlI1z24qSJ6C/wR/nFnQKA1vjSnri0jnLL0Y8BRgAoHERy8njYgWWVE1aYX0kVPSWP
         IKCIRgDHATuxQF+tBSn2kxNRN4iQFtpo6VbrPvDSut8vaUE5FcCd4/canoZFJKUwMr3U
         n+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wPZrnA5/SetkiT4mAmTLqyH+8YY+s0za4WlgxwCw6jk=;
        b=pLegS0ZR7NkQilNVpVDriDCP4VpdHhTr+QJ6MQgpbiD8iIfKTkwqeacYt2sPjpwHI9
         oOGLnzTfoW0x22Z4RkPGYwNf+1Fmn66eCWSnN432VYhw4qKOKoFyDuHH5agnpqcKy/sA
         FvvUS/Nm9An/58/JXs2NmZnAAOJftyOAQixdMQR0MFAd1vEZ15ZGdKSLhb8qlvq7srYp
         b9KDVA6CTMPq7qEOWBw7RTjMTjjGjbsAV5XjPB2Zzq6ngmUTe+4mJbaG53emU21wGhgG
         LIQSPyWX5q0uLBWy5gNxJdDt6K5aaXz6aw2jS6sCIcsNDm5ZEtWjz/I52f3r+1KwrqbG
         lOhg==
X-Gm-Message-State: AOAM533xKUOTBYuPMh6zKdzxZgUFqrH5F/51zfxTG68ktJWSQP1Fyak+
        8SvFwM05sEwQVImvhlcL/BwL4ccP5jjXAA==
X-Google-Smtp-Source: ABdhPJw3/zoD3b3R02YffcY/DVXZyhW/+zU7UByVXTRwBnMbRT2BPFWzI2X9Wb50fd7//HDNp+9Zzg==
X-Received: by 2002:a63:2c93:: with SMTP id s141mr802674pgs.150.1608233738229;
        Thu, 17 Dec 2020 11:35:38 -0800 (PST)
Received: from ?IPv6:2402:3a80:410:eec3:5d38:be:6298:62ae? ([2402:3a80:410:eec3:5d38:be:6298:62ae])
        by smtp.gmail.com with ESMTPSA id q11sm6980195pgh.16.2020.12.17.11.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 11:35:37 -0800 (PST)
Subject: Re: [PATCH] checkpatch: fix false positive for COMMIT_LOG_LONG_LINE
 with URLs
To:     Joe Perches <joe@perches.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20201217134221.16178-1-yashsri421@gmail.com>
 <94d6a56174c56ef13c9794186fdbfcc12c376c00.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <1ce4502a-d75a-7e27-5844-f195607c4c99@gmail.com>
Date:   Fri, 18 Dec 2020 01:05:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <94d6a56174c56ef13c9794186fdbfcc12c376c00.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/20 10:33 pm, Joe Perches wrote:
> On Thu, 2020-12-17 at 19:12 +0530, Aditya Srivastava wrote:
>> Currently checkpatch warns for long line in commit messages even for
>> URL lines.
>>
>> An evaluation over v4.13..v5.8 showed that out of ~11000 warnings for
>> this class, around 790 are due to the line containing link.
>>
>> E.g. running checkpatch on commit 3cde818cd02b ("ASoC: topology:
>> Consolidate how dtexts and dvalues are freed") reports this warning:
>>
>> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
>> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
>>
>> Avoid giving users warning for character limit, instead suggest them to
>> prefix the URLs with "Link:"
>>
>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>> ---
>>  scripts/checkpatch.pl | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3032,8 +3032,14 @@ sub process {
>>  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
>>  					# A Fixes: or Link: line or signature tag line
>>  		      $commit_log_possible_stack_dump)) {
>> -			WARN("COMMIT_LOG_LONG_LINE",
>> -			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
>> +			if ($line =~ /(?:http|https|ftp):\/\//) {
>> +				WARN("COMMIT_LOG_LONG_LINE",
>> +				     "Consider prefixing the URL with 'Link:'\n" . $herecurr);
>> +			}
>> +			else {
>> +				WARN("COMMIT_LOG_LONG_LINE",
>> +				     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
>> +			}
> 
> NAK.
> 
> Aditya, you've submitted several patches to checkpatch and
> you should know better by now what coding style is necessary
> for acceptance.
> 
> 			} else {
> 

Sorry, I missed it. Will change it :)

> Make the URI/URL check follow the styles allowed by RFC 3986.
> Look at the long_line check around line 3500 introduced by
> commit 2e4bbbc550be336cbb3defc67430fc0700aa1426
> Author: Andreas Brauchli <a.brauchli@elementarea.net>
> Date:   Tue Feb 6 15:38:45 2018 -0800
> checkpatch: allow long lines containing URL
> 
> Also likely the URI should not be allowed to exceed the line
> maximum unless it's the first non-whitespace of the line and
> not starting after some other word in the line.
> 
> Lastly, this sets $commit_log_long_line even for lines that
> are now nominally exempted from the long line check.
> 

Okay. I'll make these changes and send the modified patch.

> The number of nominal fixes you showed above is not correct.
> 
> Retrospective testing of checkpatch using --git history
> should be aware of changes to checkpatch.
> 
> This should count only lines from 75 to 80 chars for the
> commit range you tested and only for 75 to 100 for commits
> after checkpatch changed its allowed long line maximum in
> commit bdc48fa11e46f867ea4d75fa59ee87a7f48be144
> checkpatch/coding-style: deprecate 80-column warning
> 

Joe, I think this is probably true only for "WARNING:LONG_LINE".
However, here I have analyzed the count for
"WARNING:COMMIT_LOG_LONG_LINE".

I ran git log on these lines. Probably these lines were last changed
at 2a076f40d8c9be95bee7bcf18436655e1140447f.

I think I can change the count with exact numbers.

What do you think?

Thanks
Aditya
