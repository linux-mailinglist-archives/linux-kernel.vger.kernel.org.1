Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898EA27612F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIWTia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWTia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:38:30 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F954C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:38:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x14so1050661oic.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rw51cvz3QnIOIt4hSXy3ElMG0kXuaHwF7XqGtXNCNiU=;
        b=SYEIeXY3xxEe+qAznqikx7tgHItmLhRQOFw+kXXZ3Ysjbf/ft3EzOAUcFSXHwOq/WT
         qkVF0uJPfFvlMTgryoLOnJ5H1zcVlZ5voLiVdC+tWbu/4Ko8qLXL6p/mv2zvGuUgE8a8
         YpptWzVEhLWk/8iAE7v1xL7PGGW1v5ibQhAX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rw51cvz3QnIOIt4hSXy3ElMG0kXuaHwF7XqGtXNCNiU=;
        b=QqoGUt0o7fMQrqmT8ByRcyEYkcCy/kNf+8deKMd52RPHzDOk+nzTm1jROcEZBL7ZeJ
         XLcfAtKUVMXU+Uu/ymNHQAm9WMCAAy0UUaWZTAv9UZV3oZiOJ5GN+LLRWMt+FuZ0I2ai
         lv/83cHtumIFXHMqYn9EAD7hTLEFfMawkpxW9KuC8qb3MWhnU27TFWDyvApN4mGwEnfY
         +X8I2H00YxPyPnlCCnvtaWGe9IQIvE4SwPd9dchlM8bLqsIPq6KEUiOjuwL7S380UrxL
         SolV/31F4YBNU1zxfK6dbaBqRTd7iTyCbeZGi75W9eLJEW0hYrHlzS2iqmmaFYxWTbUp
         2G5g==
X-Gm-Message-State: AOAM532c9ffHDcnfSkNJKVSTPxB4hoHYiG3ag6jZRIgLPMgOm1dAnVc7
        D1ivvxDP/Oun4TLAL/iZ3VpDXw==
X-Google-Smtp-Source: ABdhPJy0B1gufbobPqOVx3H6tHlHfPvA0nAAumbwFERRDFULTgnf+zSHpvfT9GZe0yWuTWXlikm2OQ==
X-Received: by 2002:a05:6808:a05:: with SMTP id n5mr621421oij.154.1600889909478;
        Wed, 23 Sep 2020 12:38:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a75sm145311oii.55.2020.09.23.12.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 12:38:28 -0700 (PDT)
Subject: Re: drivers/misc/habanalabs: atomic_t api usage inconsistencies
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Lee Jones <lee.jones@linaro.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <3dfdda44-3564-1775-c844-f7a2680c9c58@linuxfoundation.org>
 <CAFCwf11Fg8gH6wMO5aPqwtNovgB153J2vNWdLF_zrua5b6Qetw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <07dd76cf-adb4-f7c4-2f33-85f08de95404@linuxfoundation.org>
Date:   Wed, 23 Sep 2020 13:38:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFCwf11Fg8gH6wMO5aPqwtNovgB153J2vNWdLF_zrua5b6Qetw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 2:41 AM, Oded Gabbay wrote:
> On Tue, Sep 22, 2020 at 1:08 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> All,
>>
>> While I was looking at the atomic_t api usages for an unrelated issue,
>> I noticed free_slots_cnt in struct hl_cq incerment/decrement/reads are
>> not consistent.
>>
>> atomic_inc() and atomic_set() are used, however instead of atomic_read()
>> the value is referenced directly in
>> drivers/misc/habanalabs/common/hw_queue.c
>>
>> hl_queue_add_ptr()
>> atomic_t *free_slots = &hdev->completion_queue[q->cq_id].free_slots_cnt;
>>
>> hl_hw_queue_schedule_cs()
>>
>> atomic_t *free_slots = &hdev->completion_queue[i].free_slots_cnt;
>>
>> Any reason why this is necessary. I don't know that this is causing
>> any problems, it is just odd that access is inconsistent.
>>
>> thanks,
>> -- Shuah
> 
> Hi Shuah,
> Thanks for taking notice of this issue :)
> We will take a deeper look and fix the inconsistencies, although I
> must say that we didn't notice any impact of this issue.

If you haven't noticed any problems, it could be that this variable
doesn't need to atomic or you haven't run into it yet?

thanks,
-- Shuah





