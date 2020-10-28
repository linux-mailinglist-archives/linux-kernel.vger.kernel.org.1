Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A112729D8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbgJ1Wfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbgJ1Wfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:35:36 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95F2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:35:35 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id m188so546420ybf.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B1ciQs0tIUrzamgMFIiR9+0gbuBBSi5PbiyG4MiAZuo=;
        b=fmJX2ejnDVI8dcSjhMLymoA7Z2Eqy+pQYeWFz5jhy63fgQy2ttCBz1h6z0zaM6SjnA
         IXAwdr5gcrzyxaftD/b6bXEPCqeuu1x+S1NelVa/5nT9g8XINQaL4+rxRAyy7wvdjAa6
         /BIGiYKHme6ALbRPbCAzPK72rEhO74wu+a6ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1ciQs0tIUrzamgMFIiR9+0gbuBBSi5PbiyG4MiAZuo=;
        b=GuI4Rcsuffjj0jmLpqbVC+9PRneVoFFbuH1mO7wlWrof4ob5/OEYkXSBYyoYkCCKP5
         z3BvJfjZZ8APLbeplWc3fu+6pu/b4vq/OuwKaiAHQ3um3tdLeCmt+nbAYGYjg1xy/edv
         ExpfMWYiBEp8rZDwbm3+PAq03aC/zrOASBA95M4THZtwM8fYqO0YfspNEip1siX5C1eL
         cbEFHIFoOdpiLJz9Ae21N86bqcBin7ZDkUGk4gGO31xutY8GFg3q9jlhVlkmt9uu52uQ
         6FDMDj4dSw3qhe7Q3ZwoO69+fej+BjHNxMBzfXNhRGqv28S+mFQWCH0ceZrbQvWUdjNV
         IZFA==
X-Gm-Message-State: AOAM531orgpNDZ8jQXJtnigjlU6Q2mlfFDmTRyacJECjvL/7NU4hIWym
        K3UOD3hZfGiRIYdLpyxT3Y7FSnxic+FlEw==
X-Google-Smtp-Source: ABdhPJxIhDXad77eNUS6JVTDUuoz5BPKcp8l4YkIqQuFS+EEs1MCsoLBv8wRS1ctm7FG86BaJHPlkQ==
X-Received: by 2002:a9d:1ee5:: with SMTP id n92mr5985068otn.152.1603898453779;
        Wed, 28 Oct 2020 08:20:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d11sm2221331oti.69.2020.10.28.08.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:20:52 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] kselftest: Extend vDSO tests
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201026114945.48532-1-vincenzo.frascino@arm.com>
 <87y2js1tic.fsf@nanos.tec.linutronix.de>
 <127f025c-1ce5-0dcb-30a2-a26b4a8e5b35@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c7f84f84-7e76-05ee-9fc6-915dec1d51f0@linuxfoundation.org>
Date:   Wed, 28 Oct 2020 09:20:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <127f025c-1ce5-0dcb-30a2-a26b4a8e5b35@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/20 6:50 PM, Shuah Khan wrote:
> On 10/26/20 5:01 PM, Thomas Gleixner wrote:
>> On Mon, Oct 26 2020 at 11:49, Vincenzo Frascino wrote:
>>> This series extends the kselftests for the vDSO library making sure: 
>>> that
>>> they compile correctly on non x86 platforms, that they can be cross
>>> compiled and introducing new tests that verify the correctness of the
>>> library.
>>>
>>> The so extended vDSO kselftests have been verified on all the platforms
>>> supported by the unified vDSO library [1].
>>>
>>> The only new patch that this series introduces is the first one, 
>>> patch 2 and
>>> patch 3 have already been reviewed in past as part of other series 
>>> [2] [3].
>>>
>>> [1] 
>>> https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com 
>>>
>>> [2] 
>>> https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com 
>>>
>>> [3] 
>>> https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com 
>>>
>>>
>>> It is possible to build the series using the command below:
>>>
>>> make -C tools/testing/selftests/ ARCH=<arch> TARGETS=vDSO CC=<compiler>
>>>
>>> A version of the series rebased on 5.10-rc1 to simplify the testing 
>>> can be found
>>> at [4].
>>>
>>> [4] https://git.gitlab.arm.com/linux-arm/linux-vf.git vdso/v4.tests
>>
>> Assuming Shuah will pick them up:
>>
>>    Acked-by: Thomas Gleixner <tglx@linutronix.de>
>>
> 
> 
> Thanks. I will pick these up.


Applied to linux-kselftest next

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

thanks,
-- Shuah

