Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3B27B7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgI1XSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgI1XSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:18:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FECC0604C0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:01:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 60so2665510otw.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G0T+RHalnOsx2x8ckC0/qbcC+AW5CzDJJe/ApeOC0+k=;
        b=Bm4inKBH6owPhXAt+WYO1qUH2sD6gp/JHO/rGqnxUTTZurVuB2oOlCFyuxF6Mrm1Fb
         Jl3P3mG83W6n3SQ1lAam+xSpWMDhH6aKSofFE4lx90AFeuypIUoqFdZzThdjUvc+zhBH
         v12MOvqlrd7l6N2Dd1M3mkf+WXumL1sotF7rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G0T+RHalnOsx2x8ckC0/qbcC+AW5CzDJJe/ApeOC0+k=;
        b=tdeGNX4dtUwoG5BEO0MVQVc6aNWAI3Z6ie8pBRrHIJCojn8tuGkWiVNBb5gVT7C/xK
         uAw+/3ElJq+rFxgJjeCoN516KJlX8wYvHbi4X3SGcyMdRAerrgxCkamUlWPy3V8AxQtb
         l5STTe+yAARgeWI1BgXL+51YucXuW4jcLWNJjZJw43DzhuoyeXd7i6tJz5QgyAYihP02
         PJgNG2qF/9cPaUE2kCAtllDqaMm6ISzISu9abcvfU1GHkdKirshxiIWcoYgIKF7lchad
         fAtP74cGcmzk0ro6uLjqABsWwKR9egFTJnNT3v9DrraxbnxxKMoy4c4oarHzH9ANHena
         VPFA==
X-Gm-Message-State: AOAM531PrtOCDxOKLDFi4oKKsGAsk1jyqHs8g0YjIGTuoC++KQBM9jjV
        o3HFcrNDT4okWBwEj+kpD/DKgg==
X-Google-Smtp-Source: ABdhPJwSkr7ZuRk8wTA1EBTCYkbbMO+PyhCPeIPgE2gfdGNAWiJW8KkTuzvV5dYyicY9sgk6dMhK3A==
X-Received: by 2002:a05:6830:1616:: with SMTP id g22mr823663otr.289.1601334117878;
        Mon, 28 Sep 2020 16:01:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a22sm559885oie.13.2020.09.28.16.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 16:01:57 -0700 (PDT)
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
To:     Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <20200927233526.GA500818@google.com> <202009281331.444F36A7B@keescook>
 <20200928211709.GA2641213@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c237ead-5b68-2e3f-2af6-a08c03b24fde@linuxfoundation.org>
Date:   Mon, 28 Sep 2020 17:01:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928211709.GA2641213@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/20 3:17 PM, Joel Fernandes wrote:
> On Mon, Sep 28, 2020 at 01:34:31PM -0700, Kees Cook wrote:
>> On Sun, Sep 27, 2020 at 07:35:26PM -0400, Joel Fernandes wrote:
>>> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>>>> This patch series is a result of discussion at the refcount_t BOF
>>>> the Linux Plumbers Conference. In this discussion, we identified
>>>> a need for looking closely and investigating atomic_t usages in
>>>> the kernel when it is used strictly as a counter without it
>>>> controlling object lifetimes and state changes.
>>>>
>>>> There are a number of atomic_t usages in the kernel where atomic_t api
>>>> is used strictly for counting and not for managing object lifetime. In
>>>> some cases, atomic_t might not even be needed.
>>>>      
>>>> The purpose of these counters is twofold: 1. clearly differentiate
>>>> atomic_t counters from atomic_t usages that guard object lifetimes,
>>>> hence prone to overflow and underflow errors. It allows tools that scan
>>>> for underflow and overflow on atomic_t usages to detect overflow and
>>>> underflows to scan just the cases that are prone to errors. 2. provides
>>>> non-atomic counters for cases where atomic isn't necessary.
>>>
>>> Nice series :)
>>>

Thanks.

>>> It appears there is no user of counter_simple in this series other than the
>>> selftest. Would you be planning to add any conversions in the series itself,
>>> for illustration of use? Sorry if I missed a usage.
>>>
>>> Also how do we guard against atomicity of counter_simple RMW operations? Is
>>> the implication that it should be guarded using other synchronization to
>>> prevent lost-update problem?
>>>
>>> Some more comments:
>>>
>>> 1.  atomic RMW operations that have a return value are fully ordered. Would
>>>      you be adding support to counter_simple for such ordering as well, for
>>>      consistency?
>>
>> No -- there is no atomicity guarantee for counter_simple. I would prefer
>> counter_simple not exist at all, specifically for this reason.
> 
> Yeah I am ok with it not existing, especially also as there are no examples
> of its conversion/usage in the series.
> 

No. counter_simple is just for counting when there is no need for
atomicity with the premise that there might be some use-cases. You
are right that this patch series doesn't use these. My hunch is though
that atomic_t is overused and it isn't needed in all cases.

I will do some research to look for any places that can use
counter_simple before I spin v2. If I don't find any, I can drop them.

thanks,
-- Shuah

