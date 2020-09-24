Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136172774D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgIXPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgIXPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:08:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A49C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:08:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so3427136ota.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oKut7+ZE8Cwg1H0GjJjlU6QFhq4QfWKGoaWrzXaMdPQ=;
        b=VeYYf3vkSJaJTKjSHt+ahxijhfiWy07sbqhRFNB0b5LvH7k+8GTTQfwTPDvbJG9hs4
         nvNOxUL/BWQokmlPGL12ud/TUqbXsogCeqT2zRDRnKKm1WZnqdsay9Lr/iVjiexNTHh4
         p9Mhd9dQ71pSQlXJ7uIXGNVQZekU7vvWLupZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oKut7+ZE8Cwg1H0GjJjlU6QFhq4QfWKGoaWrzXaMdPQ=;
        b=Fkfeg+d1II4kl0PEqp2A4MwLSJR/1+RxoNZeZk/uPbpjxaYJVXnz5Fk3pYck4Iu8Eh
         13CqRJ95WlbqLESD5e+YzpYn+xEb+iWrBwoC5ILdaRvI+KsIe8LOaZqbQb65iSvnTnkJ
         0wzBNyGHHEytWE7VhGQTVQkph3NtCe2MX0Z53dQlPstbqY8GATiFWRO2tPTU8gs/Q2WF
         hwIFQgh5qiLlvihOEOfoRMUUQSW4GFh5wAxpyEiZnoZcApUAbHZMViaAlhMfcDd+Q4F8
         sEibZc/LnnKJ2fn7jtTNqmFOpdvCfOq7DBoT5yjItUbqZGXp/KxEEYR2XD7Jf5KQx0ng
         H/ng==
X-Gm-Message-State: AOAM530fn2DP8PyguUVpNEHm/iJZpwmtMqHUOKmXGtyAJ8O/lmn/j0Dp
        kLuAs0N3UM/PVIsAi/BcY/vewQ==
X-Google-Smtp-Source: ABdhPJwcaYObD6Zecw0a5f2Axhe2/u582XLt8J7QRbvkVnxZhcDq7TBRAeSuG1P7AzLJ2JFGI7vqOA==
X-Received: by 2002:a9d:128d:: with SMTP id g13mr52032otg.245.1600960114168;
        Thu, 24 Sep 2020 08:08:34 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x15sm869317oor.33.2020.09.24.08.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 08:08:33 -0700 (PDT)
Subject: Re: [RFC PATCH 05/11] drivers/acpi: convert seqno counter_atomic
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <9e2c6cccabc96fe1e5304e2fa2dfdad28ca5ac9c.1600816121.git.skhan@linuxfoundation.org>
 <CAJZ5v0iS2wpvvJGLsEJSSdCJ0tf4DmJ9fQWVU3PzFuMB7Zbkjw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3cc1e840-6525-e125-499a-03b9c86c0243@linuxfoundation.org>
Date:   Thu, 24 Sep 2020 09:08:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iS2wpvvJGLsEJSSdCJ0tf4DmJ9fQWVU3PzFuMB7Zbkjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 5:13 AM, Rafael J. Wysocki wrote:
> On Wed, Sep 23, 2020 at 3:44 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> counter_atomic is introduced to be used when a variable is used as
>> a simple counter and doesn't guard object lifetimes. This clearly
>> differentiates atomic_t usages that guard object lifetimes.
>>
>> counter_atomic variables will wrap around to 0 when it overflows and
>> should not be used to guard resource lifetimes, device usage and
>> open counts that control state changes, and pm states.
>>
>> seqno is a sequence number counter for logging. This counter gets
>> incremented. Unsure if there is a chance of this overflowing. It
>> doesn't look like overflowing causes any problems since it is used
>> to tag the log messages and nothing more.
>>
>> Convert it to use counter_atomic.
>>
>> This conversion doesn't change the oveflow wrap around behavior.

I see typo here. Will fix it.

>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Both this change and the next patch are fine by me.
> 

Thanks Rafael. Okay to add your Acked-by?

thanks,
-- Shuah
