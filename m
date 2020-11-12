Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BD2B08BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgKLPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgKLPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:45:06 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:45:05 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r12so6497824iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=brn3R8KBs8wYY9F38FOEVZjLdrmapsworNs/VEfyn78=;
        b=EMZp+dkNOJgMCUaFI8F9bpcnS4tuoQAq3Qi0p5oJBBaLyqgo2zX23HVBUZbAtjDdog
         4H6LuKraNTVaR5nD/XBu5uWuaFNrPWDJ/hVPWUk4UDf1onH9c9eMRy2bkkD3qAXWdVZ3
         WFYV1QhmX1mtEsrlbqtAcYsR13T6HAsu3MHDfDeCY+NacZlUS84WRqhXd9AoqDXa45FS
         LQTkWGFxPGjYI3DERrTWhvT/MdhsStsv24Y84E8go5gFGojrMwIVpI0BA8ys5bgV7t8x
         oW56PEZcH8BYjMa40QCnvcIwoJvRmr9aP1QGUVIB5FlE/rGbBNltvg20tYXxpu1B/TVf
         HH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=brn3R8KBs8wYY9F38FOEVZjLdrmapsworNs/VEfyn78=;
        b=PEcV7vgG6Dwy7O+oOhmfIVVh79tLj2BkQQ+ntKW5ks3kqXgqAQf4urqVMkbOBpzEEj
         XFUgOjOyHbSUj2a6LBUXRkRMF6IeK7OJgMMcahDWWvvDdp+4AN5/7sMdIIKkCFHe38QV
         BNm2EJ9D519oZeKn8fXxnU7AikVDy7B7JYRyXYUSdVEIU6pklcH5SVqzkngLjEKf4SP6
         MnLB8SJIoTrjhnOEX9LmvKUyXZyYlrrQTxVD18wkwpT1nvWMlTK4ZwQq8DLOX7cXBz01
         ldVOtPCeODj3zH9utwpOoDey/SgqRGRq7cADUWseuGs4hVq9bkKisFIrxUT1YYiV9wWx
         Zmug==
X-Gm-Message-State: AOAM533YKCw74ZTBS3SiDA6rlAeK8xi1lDBb3AxVOvw81V5YtC72ssJl
        dEk8NSibhZ/mGVjpcn+WRI7RqzWJNwIp4Q==
X-Google-Smtp-Source: ABdhPJzc5AhomIbucq4GM96fehqbBGCC5lSC0drtMkmXr2imbRspNzoykRTL/51ci/Vv0KQ7Pgh1pg==
X-Received: by 2002:a05:6602:2d93:: with SMTP id k19mr23037731iow.51.1605195901956;
        Thu, 12 Nov 2020 07:45:01 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i14sm3272086ilb.2.2020.11.12.07.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:45:01 -0800 (PST)
Subject: Re: [PATCH v2] xtensa: fix broken TIF_NOTIFY_SIGNAL assembly
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <20201111205349.24815-1-jcmvbkbc@gmail.com>
 <faf78325-3aef-e4aa-ddc6-c21e84a8c7ef@kernel.dk>
 <CAMo8BfL=3PEi3GWd6LR9kiKViN=t1KbgbkjEEwT8GAb-Uvnp0A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7998b455-c7bd-5caf-d6a9-d1c0404f2b5f@kernel.dk>
Date:   Thu, 12 Nov 2020 08:45:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfL=3PEi3GWd6LR9kiKViN=t1KbgbkjEEwT8GAb-Uvnp0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 2:12 AM, Max Filippov wrote:
> On Wed, Nov 11, 2020 at 1:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 11/11/20 1:53 PM, Max Filippov wrote:
>>> TIF_NOTIFY_SIGNAL handling in xtensa assembly is implemented
>>> incorrectly: there should be a call to do_notify_resume when either
>>> TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_NOTIFY_SIGNAL bit is set in the
>>> thread_info::flags. The straightforward way to do it would be
>>>
>>>     _bbsi.l a4, TIF_NEED_RESCHED, 3f
>>>     _bbsi.l a4, TIF_NOTIFY_RESUME, 2f
>>>     _bbsi.l a4, TIF_NOTIFY_SIGNAL, 2f
>>>     _bbci.l a4, TIF_SIGPENDING, 5f
>>>
>>> Optimize it a little bit and use bit mask and bnone opcode to skip
>>> do_notify_resume invocation. Shuffle _TIF_* flags a bit so that used bit
>>> mask fits into the immediate field of movi opcode.
>>
>> Thanks - do you mind if I fold this in with a reference to your
>> changes? Seems like that'd be a better option than leaving it
>> broken for a bit.
> 
> Sure Jens, by all means!

Thanks! Done.

-- 
Jens Axboe

