Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A9279622
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 04:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgIZCFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 22:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgIZCFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 22:05:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A52EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 19:05:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a2so4104267otr.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 19:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xIEdKDvK2ICWtBjC/bRIDnXPDwo+7XOBDbqUgm7tYTY=;
        b=X1PDz8tuQOT0hPqGqNcnIuHD1DhEyv0Ke0Wlf/nczWWIjjwYzNht7vp5fbbRYDA7rG
         UR92zl9xKS6OWDvi+qoEcimQRN6VKOKy0OAKm5xEtobaTRcotolt0xes3QYbi+b76utu
         +z79pYdLpx0loFohQfeB1oQ/PCU2JRmRZ5cPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xIEdKDvK2ICWtBjC/bRIDnXPDwo+7XOBDbqUgm7tYTY=;
        b=YflouPrJjvXprkIQeolS6YVCKK1S5lTzIDEOvdjFV9CdVWKzvx2dLt/8j5ytklkAzH
         hcdStB3Y4kOsVD22+DYY/vcmqH9T+YMM4U6gpkOUrkKzjuDk+ox83D1DcsIHK457oLJ8
         SVtCx9dzJNQ8vOpiqbcftaKmmbHjHYSXs7Twcj95JgdU7JK/h5Uq9L3Jev+CjLNkWjkM
         0PnHjdIhBn/r/3bq+RTXTP3XJhfUR3n+Y2xPouncn3alz0yV/MaZtEUR22xiuNRHXZeD
         AIBLsTILjGOOfRAY5if3Hg/Y0l4NEQwU1HteTpRM4lgOHZ6GQkVF6gvpb7DvhNzFWmxe
         kYgA==
X-Gm-Message-State: AOAM531SEyfzp6BNm2+xcLbxYzwLF8xeGMwJcBrTfZnj6UsKgkQvUvOe
        IoqL/f//+dWaszsJ7sIs9x9mqtm9tv88Ug==
X-Google-Smtp-Source: ABdhPJzPedgFR9s1+TVpNOnx5pm0cwxYtxWwsXuoOBDCeeLYuFwbO9CpkIl+2SmipWnC3S6jZzHW+w==
X-Received: by 2002:a05:6830:1f09:: with SMTP id u9mr2057198otg.175.1601085941760;
        Fri, 25 Sep 2020 19:05:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j18sm1112946otr.12.2020.09.25.19.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 19:05:40 -0700 (PDT)
Subject: Re: [PATCH 09/11] drivers/char/ipmi: convert stats to use
 counter_atomic32
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, keescook@chromium.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <b742c2637a8b6083c471a6dd829db70071909f83.1601073127.git.skhan@linuxfoundation.org>
 <20200926001510.GH3674@minyard.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dc07811e-d8e9-f9dd-bc6a-1877d7f06344@linuxfoundation.org>
Date:   Fri, 25 Sep 2020 20:05:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926001510.GH3674@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 6:15 PM, Corey Minyard wrote:
> On Fri, Sep 25, 2020 at 05:47:23PM -0600, Shuah Khan wrote:
>> counter_atomic* is introduced to be used when a variable is used as
>> a simple counter and doesn't guard object lifetimes. This clearly
>> differentiates atomic_t usages that guard object lifetimes.
>>
>> counter_atomic* variables will wrap around to 0 when it overflows and
>> should not be used to guard resource lifetimes, device usage and
>> open counts that control state changes, and pm states.
>>
>> atomic_t variables used for stats are atomic counters. Overflow will
>> wrap around and reset the stats and no change with the conversion.
>>
>> Convert them to use counter_atomic32.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> 

Thanks Corey.

> I assume for this conversion that the plan is to eliminate atomic_t
> completely and convert all atomic counters used for object lifetime to
> struct kref?  The new naming is certainly more clear and I'm happy with
> this change.
> 

No plans to replace or get rid of atomic_t/refcount_t ops. The reason is
to clearly differentiate atomic_t uses that don't guard object lifetimes
or state management, hence prone to overflow and underflow errors.

By clearly differentiating the ones guard the lifetimes and that don't
using this new counter interface, the existing tools that scan for
overflow/underflow conditions can filter out Counters API and look for
the variables that truly guard the lifetimes. Currently it is becoming
very hard to zero in on the errors with the noise.

Second reason is, atomic_t is overused. Non-atomic counters in this
API can be used for stats/counters that don't need atomocity.

Hope this helps.

thanks,
-- Shuah

