Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EFB2CEBD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgLDKHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:07:24 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35895C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:06:44 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b23so2823994pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zzTrdNftutVe8hIRxXL9S4BM8nND3L+cvOiVEJjpe8g=;
        b=bfqe7CWhDthYzEuXs8BihXx31kSv4NSUO79Q86hmE2q31eim1laoYbovCPmOintj+A
         58JQl3eN8z6gS53HmuoZmA9v0sAQkVfULiWwtcCukgyCEJDlMiEJSyEvN5oO/TzRlNHj
         qraJlhRXH10W4zSPXXriH+2PW8TvZxGrFsrrmQJjHR8Gq0YCN8vDuKuPrZaDmRKfVCvo
         Fqh+5qytRBp3qk/d1iemkYPH7NYH3kE7Pj1zbECnlb0ZvLC3IlPFoJIfLYZkjvuaHXGM
         BJw+Ui/av8I4aTr+KaXJ/0nG7ql/VVFsckRseOWknxKvSqonpQlB5sM/Idr/C4qmehN7
         XwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zzTrdNftutVe8hIRxXL9S4BM8nND3L+cvOiVEJjpe8g=;
        b=G4l6bYtL+Up32w+v1O/yicLZsYKaUcuB+kANdeP4jW/7qEgr/EXyovAjp0FzZQMbE2
         WqEhPBxVvXTPRL79cMCGc+78OXZdA8Qli3XfTFMDolvXf5ZUAaB6i+JKiaM/kh8cdlpY
         fSn7sKjZVAKIL+2gDSh9j1NBm/mKKcAFB9OdTH24tYd8dVyayXQnn7TklW1IxtJ0eXeD
         Lb1GVg3mYRxoygqeH6tUJr3AAl1pTXTye9IJROnA7JItF/M0ekIRANbvVLEWK6X8lVkU
         cYtZcpfDpavFEDKs6Nb7wwKZRsOV8jmom3qgeTs7K2qEfwUuFlC8t7gKv2YiarlAOBv1
         +QgA==
X-Gm-Message-State: AOAM533+AZr5rHdh/orrI8fJWB3psuDJPjXClnuw8xaUkVJgShWxhK2z
        oXrOLhTdNlTIRSphFd2r0FEC43hrCoDn0w==
X-Google-Smtp-Source: ABdhPJw/S70m7nomAimJ8M79ghC22pyF0pvfNZl/Pkj5iBe5rqODI3qPaShISTHU9azza7zEJIQXaQ==
X-Received: by 2002:a17:902:b182:b029:da:d0c:abac with SMTP id s2-20020a170902b182b02900da0d0cabacmr3211602plr.40.1607076403410;
        Fri, 04 Dec 2020 02:06:43 -0800 (PST)
Received: from ?IPv6:2402:3a80:414:1e71:d059:d26:c75b:b30a? ([2402:3a80:414:1e71:d059:d26:c75b:b30a])
        by smtp.gmail.com with ESMTPSA id w14sm4403542pfj.53.2020.12.04.02.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 02:06:42 -0800 (PST)
Subject: Re: [PATCH] checkpatch: add fix for BAD_SIGN_OFF
To:     Joe Perches <joe@perches.com>
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20201108134317.25400-1-yashsri421@gmail.com>
 <e8fef5fbd71331b010988769b249af6a79048f48.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <c1d7168c-2bc0-7de6-6590-a1752b4918fd@gmail.com>
Date:   Fri, 4 Dec 2020 15:36:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8fef5fbd71331b010988769b249af6a79048f48.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 1:27 am, Joe Perches wrote:
> On Sun, 2020-11-08 at 19:13 +0530, Aditya Srivastava wrote:
>> Currently, checkpatch warns us if the author of the commit signs-off
>> as co-developed-by.
> []
>> A quick manual check found out that all fixes were correct in those
>> cases.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -2827,8 +2827,11 @@ sub process {
>>  # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
>>  			if ($sign_off =~ /^co-developed-by:$/i) {
>>  				if ($email eq $author) {
>> -					WARN("BAD_SIGN_OFF",
>> -					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
>> +					if (WARN("BAD_SIGN_OFF",
>> +						 "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline) &&
>> +					    $fix) {
>> +						fix_delete_line($fixlinenr, $rawline);
>> +					}
>>  				}
>>  				if (!defined $lines[$linenr]) {
>>  					WARN("BAD_SIGN_OFF",
> 
> Looks OK to me.
> 
> Another option might be to add a Signed-off-by: line derived from
> any "From:" line when:
> 
> 	if ($is_patch && $has_commit_log && $chk_signoff) {
> 		if ($signoff == 0) {
> 			ERROR("MISSING_SIGN_OFF",
> 			      "Missing Signed-off-by: line(s)\n");
> 
> etc...
> 

Hi Joe

You probably forgot to Ack this patch.

Thanks
Aditya
