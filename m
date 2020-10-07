Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64EC2868B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgJGT7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGT7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:59:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064ADC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 12:59:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so3488421ilo.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IwgQensmuIWkrmA6j7r/6BGsRVhrPuzFEJ6hEvgkY0U=;
        b=RORB9oyCY6dzY6nPNsrKI79ozaXE6Ioz/UdCurkrFXUEbp7V2u91B447PmHwg6RDxb
         UIu4kXmFcIxltMDcj/Hq5jHuCSehy5qhN0O2PsQPCW2DcagM7wjTJhXd0OJEHytklvWi
         Ut4hFxprE8vKYx5Aq3/XweEc834RPg2NHJtWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IwgQensmuIWkrmA6j7r/6BGsRVhrPuzFEJ6hEvgkY0U=;
        b=YbGNTnBz0XVs/xTEloR8kH7My2hgGe8dGhYdaCZEpwVBx9fZjnFFa4jM1cJv8ZSCvj
         MxwA1fobHanzpuQYNRA2hRUUEM41704ENbPKFtkJN7SB6K4ZpGs/fh+DWTuVKhzZvC4i
         3drYIrNIIjv1xlOs0DSKuOGsUk1x+Umfp9c6cO3H0ClnaphuMaxUjsQG5Car9P5+/bhm
         KOuuwUDev4l1uuQy4JJObqMJrJ3NWJNh8TNwYKHUo5fYmXVXROR/xgNM/8koUNkU21u4
         e7FSdpLV9hrmg5hqMGrghyB9ZUcNMjbG5tJ+Sux2V7/m4FFHuvnOkonlHHilWXxpynK7
         TbBg==
X-Gm-Message-State: AOAM530R0wtrmuhUr7my25iaSTRn3BImDONH7VGMPjcYcm9AHH3IWf2J
        rGJ27YgMF0JGv52OVfFKfIE08A==
X-Google-Smtp-Source: ABdhPJw6F4ocZqDmvKHKXvkKFyPoJCixPp1pMoYEJ5KOnugvxyqTIBRl7LpIh+HbcK1YoCSd+02tGQ==
X-Received: by 2002:a92:91d6:: with SMTP id e83mr4330659ill.263.1602100753218;
        Wed, 07 Oct 2020 12:59:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o12sm1492928ilh.49.2020.10.07.12.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 12:59:12 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count to
 counter_atomic32
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>, gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
 <202010071114.EE9A2A47C@keescook>
 <cb86761a-5531-cbb2-3987-0897771949b8@linuxfoundation.org>
 <f27149d6b9b781ccf9c2fa041082c134abccd925.camel@sipsolutions.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <60e0a7ba-4a54-3713-3fcc-623910bcc650@linuxfoundation.org>
Date:   Wed, 7 Oct 2020 13:59:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f27149d6b9b781ccf9c2fa041082c134abccd925.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 1:38 PM, Johannes Berg wrote:
> On Wed, 2020-10-07 at 13:33 -0600, Shuah Khan wrote:
>> On 10/7/20 12:15 PM, Kees Cook wrote:
>>> On Tue, Oct 06, 2020 at 02:44:35PM -0600, Shuah Khan wrote:
>>>> counter_atomic* is introduced to be used when a variable is used as
>>>> a simple counter and doesn't guard object lifetimes. This clearly
>>>> differentiates atomic_t usages that guard object lifetimes.
>>>>
>>>> counter_atomic* variables will wrap around to 0 when it overflows and
>>>> should not be used to guard resource lifetimes, device usage and
>>>> open counts that control state changes, and pm states.
>>>>
>>>> devcd_count is used to track dev_coredumpm device count and used in
>>>> device name string. It doesn't guard object lifetimes, device usage
>>>> counts, device open counts, and pm states. There is very little chance
>>>> of this counter overflowing. Convert it to use counter_atomic32.
>>>>
>>>> This conversion doesn't change the overflow wrap around behavior.
>>>>
>>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> I actually wonder if this should use refcount_t just because it is
>>> designed to be an alway-unique value. It is hard to imagine ever causing
>>> this to overflow, but why not let it be protected?
>>>
>>
>> This is one of the cases where devcd_count doesn't guard lifetimes,
>> however if it ever overflows, refcount_t is a better choice.
>>
>> If we decide refcount_t is a better choice, I can drop this patch
>> and send refcount_t conversion patch instead.
>>
>> Greg! Any thoughts on refcount_t for this being a better choice?
> 
> I'm not Greg, but ... there's a 5 minute timeout. So in order to cause a
> clash you'd have to manage to overflow the counter within a 5 minute
> interval, otherwise you can actually reuse the numbers starting again
> from 0 without any ill effect.
> 
> And even if you *do* manage to overflow it quickly enough it'll just
> fail device_add() and error out, and nothing happens.
> 
> So I think it's fairly much pointless to think about protecting against
> some kind of overflows. It's just trying to get a "temporarily unique
> ID" here, could be doing anything else instead, but most other things
> would require bigger data structures and/or (higher level) locking.
> 
> OTOH, if you *do* somehow create that many core dumps (huge uptimes and
> extremely frequent crashes?) it seems like refcount_t would be a bad
> choice because it saturates, and then you can only do one more dump per
> 5 minutes? Or maybe that's a good thing in these ill cases ...
> 
> I don't think it'll really happen either way :)
> 

I didn't think this could overflow and if it does we might have other
problems.

Thank you taking the time for this detailed analysis. This clarifies the
"very little chance of this counter overflowing and no ill effects".

thanks,
-- Shuah


