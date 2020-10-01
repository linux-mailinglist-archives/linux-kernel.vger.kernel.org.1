Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7F2809E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbgJAWNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJAWNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:13:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8027EC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 15:13:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d9so6005548pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oaHXuT3eUKsEP4LurE8OstOc6l74398i66/HBR3jSqA=;
        b=dJO6rm3zOhTp9ala9QvFhDh1niYXq6f30zGAiuN9W4galP5AAsIdb972Fd32/rZtJD
         D7LEpGyyQ/AYX+zSq3s9p36C9OWaM5TA40hpZvFNGzu7NRzTsmM/BSNETRG5oWUSmbMy
         DRhU6Oh5U7IwGhxviAL7sl/eYAPMYIjZnVl1WacXnwh0W4uiF6MEPJx4LVi1vqEzoZYl
         l15MXu5oZAkAZoNnTk4Cc3QMgzQQPI2RirRGe5biG4UUm2lzradfCND/7BIiljrXPbkD
         B1ASlxEm7cHLwx/gCCaBpRdiYBdFcQ8cO8f8I9yQ5BLMFt+KNerxSzh1TeqtMBe9yaLe
         QBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oaHXuT3eUKsEP4LurE8OstOc6l74398i66/HBR3jSqA=;
        b=b7KiYhRPBUBxCNFBiyMZuW5nAdbuGJG766i09Ma2yxw5AfaysZcDa9XE9jpbh1lr2Y
         Chrd+k7xYJGubMSaryNwTG1LB8CkM7lMJPU++XxM+11MQO/2AZEd4p1ynE9gDQNLyEX6
         CCtVOMDeGEjxHXRQmusjxs6HzwdftndsC1roNvZzpGT/8o8/4nZ36wrkSh/wzMW87xCc
         9wy0zepaQMAcfbURO/FkZBq6RIGK7hAxBju1mweeexwmVRzZXcYmSCb3IMhn7gpJZvAz
         zFpbOPmaqokgQWwq9wKH2g/ZJWMY+w5K7vw20/exyfobAvNSLGWRhr+m7HaWSa5w5gP2
         Jqlw==
X-Gm-Message-State: AOAM5333pcPchhAIC+ni3LgG8/9F8Es7ewbb9zELu72xv7HNXEnEc5Ft
        MKP3fycqhMtjh7VUPzShxks=
X-Google-Smtp-Source: ABdhPJz8On5pp3ocgq7x1lHs9FhGAUhk81D9spCPG2BBb374ywSxNc62CvJFenKx4YPgGYnYDtDdQw==
X-Received: by 2002:a17:902:b107:b029:d2:ab87:c418 with SMTP id q7-20020a170902b107b02900d2ab87c418mr9762125plr.40.1601590418974;
        Thu, 01 Oct 2020 15:13:38 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e14sm6324578pgu.47.2020.10.01.15.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:13:38 -0700 (PDT)
Subject: Re: [PATCH v5 11/15] misc: bcm-vk: add BCM_VK_QSTATS
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-12-scott.branden@broadcom.com>
 <e7b3a4b6-0662-6ead-8ddb-0cf6324a9bd2@gmail.com>
 <5d76c89d-f53a-be22-dcd7-7854a3e1e034@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0fb4556e-91bf-d364-c7bb-c876136b3991@gmail.com>
Date:   Thu, 1 Oct 2020 15:13:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5d76c89d-f53a-be22-dcd7-7854a3e1e034@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2020 3:12 PM, Scott Branden wrote:
> 
> 
> On 2020-09-30 7:33 p.m., Florian Fainelli wrote:
>>
>>
>> On 9/30/2020 6:28 PM, Scott Branden wrote:
>>> Add BCM_VK_QSTATS Kconfig option to allow for enabling debug VK
>>> queue statistics.
>>>
>>> These statistics keep track of max, abs_max, and average for the
>>> messages queues.
>>>
>>> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
>>> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>
>> [snip]
>>
>>> +#if defined(CONFIG_BCM_VK_QSTATS)
>>> +    /* clear qstats */
>>> +    for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
>>> +        memset(&vk->to_v_msg_chan.qstats[i].qcnts, 0,
>>> +               sizeof(vk->to_v_msg_chan.qstats[i].qcnts));
>>> +        memset(&vk->to_h_msg_chan.qstats[i].qcnts, 0,
>>> +               sizeof(vk->to_h_msg_chan.qstats[i].qcnts));
>>> +    }
>>> +#endif
>>>        /* clear 4096 bits of bitmap */
>>>        bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
>>
>> It was not clear from looking at this patch how are the statistics exposed and how does one actually get them?
> The QSTATS, since it is only for debug purpose, it will dump out periodically based on processed_num.
> Nothing fancy as we only compile it in in extreme case for recreating a scenario.

But what kind of interface is that? Cannot you at least expose those 
through sysfs if nothing else?
-- 
Florian
