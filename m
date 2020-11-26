Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF702C5DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391897AbgKZWmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391890AbgKZWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:42:03 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE8C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:42:03 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id lt17so4987003ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xk6dpp3QXMon0rgJ31KZCvDjLv/ZsYBwSzJcCfrqz5I=;
        b=DK+xWgkJcFqDYt+2Sso0ixFAhc/BTRT1RAiMe1UX+VoVXGF5If+ialDZgZ5D7Fj6dZ
         MIrM/RKvjOUQ+DFDOurW5mwtcre75I+kYFak53/q2q4jKAdGu6GnU/KcKNSbZLBEldDW
         xHnAIgE4v6Ak7g/GYkALohrjMM8pDBQyncy5bEVNj2tvOlJKPpVTZu/fB55OAy3ShVFt
         jSCKQp8KyVZvEJta++aNnPUWP/60+GNkXp6nQ+Xf1xlI5UuuYgk4dmiC/0dqdFFLN63b
         BeN2GRuuvlHmGUd3g/T0XT+V+i+CTfE82Z+1BLqN34RV1StpG5b882jpP9gCuOP/Ohu7
         SWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xk6dpp3QXMon0rgJ31KZCvDjLv/ZsYBwSzJcCfrqz5I=;
        b=nm1evadi5iwE8t3qbZ7glC8KU4/T83Nj+r79mXcrcl9BWuJyKFN1rV6w26YQGvltQH
         j72st93Oo5yTzSgV9nRXP+gJd3YxrUbwLPmZC7K+jl7WtSmEHXTxMr8a2pdxuFrEuMcA
         rYcaS+mOtk/4FThe2BvWQpVbp+1i/gZK8Bmg/eSoREs/VGf6x2iAsIspf72wd9Nx7E6y
         n9QIAdRkFJn3ixQ1ZLjEpboKCYyxLsyZkPCMYuSnAEF+ZnTBt4CHUwbzjAeDSiUfcQzo
         fjTSZP41NqVrTsseLEGW7GdY81SU0UFmH6YDRO2EAPc6gfV/J88CNUicI2rmyZSK1PCS
         SXqg==
X-Gm-Message-State: AOAM530m1rEn6fsP7+uhUWFPhsQz3Wu4hTlLSahLz5drzA0j0dA3O52d
        IPCCE/5S0962t4PtHdofw2DKsg==
X-Google-Smtp-Source: ABdhPJy+qnCNge3CzkFlKGQWvgy7E1BFFkndL8WxdlgUanP6TO1z5RBhxot47xACoQVXRq/JPzmfJg==
X-Received: by 2002:a17:906:fa86:: with SMTP id lt6mr4630585ejb.483.1606430521607;
        Thu, 26 Nov 2020 14:42:01 -0800 (PST)
Received: from [192.168.0.3] (hst-221-3.medicom.bg. [84.238.221.3])
        by smtp.googlemail.com with ESMTPSA id s12sm3838457ejy.25.2020.11.26.14.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 14:42:00 -0800 (PST)
Subject: Re: [PATCH 2/3] venus: Limit HFI sessions to the maximum supported
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>
References: <20201120001037.10032-1-stanimir.varbanov@linaro.org>
 <20201120001037.10032-3-stanimir.varbanov@linaro.org>
 <CAPBb6MUnXmtSKy9NwikYXjafgB+WM9TKEFjkYK16T2V7KRx=JQ@mail.gmail.com>
 <8c6231b2-61c2-d432-aa47-ddc29de8da19@linaro.org>
 <CAPBb6MXRat0g_+d04eoOL9Vpbv-2iJfqdOkzGB17=yjRMeVWXQ@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <59068381-43e4-559b-faa0-0e177de541f9@linaro.org>
Date:   Fri, 27 Nov 2020 00:41:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPBb6MXRat0g_+d04eoOL9Vpbv-2iJfqdOkzGB17=yjRMeVWXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/20 8:28 AM, Alexandre Courbot wrote:
> On Wed, Nov 25, 2020 at 10:01 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>>
>>
>> On 11/25/20 5:46 AM, Alexandre Courbot wrote:
>>> On Fri, Nov 20, 2020 at 9:12 AM Stanimir Varbanov
>>> <stanimir.varbanov@linaro.org> wrote:
>>>>
>>>> Currently we rely on firmware to return error when we reach the maximum
>>>> supported number of sessions. But this errors are happened at reqbuf
>>>> time which is a bit later. The more reasonable way looks like is to
>>>> return the error on driver open.
>>>>
>>>> To achieve that modify hfi_session_create to return error when we reach
>>>> maximum count of sessions and thus refuse open.
>>>>
>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>> ---
>>>>  drivers/media/platform/qcom/venus/core.h      |  1 +
>>>>  drivers/media/platform/qcom/venus/hfi.c       | 19 +++++++++++++++----
>>>>  .../media/platform/qcom/venus/hfi_parser.c    |  3 +++
>>>>  3 files changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>>>> index db0e6738281e..3a477fcdd3a8 100644
>>>> --- a/drivers/media/platform/qcom/venus/core.h
>>>> +++ b/drivers/media/platform/qcom/venus/core.h
>>>> @@ -96,6 +96,7 @@ struct venus_format {
>>>>  #define MAX_CAP_ENTRIES                32
>>>>  #define MAX_ALLOC_MODE_ENTRIES 16
>>>>  #define MAX_CODEC_NUM          32
>>>> +#define MAX_SESSIONS           16
>>>>
>>>>  struct raw_formats {
>>>>         u32 buftype;
>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
>>>> index 638ed5cfe05e..8420be6d3991 100644
>>>> --- a/drivers/media/platform/qcom/venus/hfi.c
>>>> +++ b/drivers/media/platform/qcom/venus/hfi.c
>>>> @@ -175,6 +175,7 @@ static int wait_session_msg(struct venus_inst *inst)
>>>>  int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
>>>>  {
>>>>         struct venus_core *core = inst->core;
>>>> +       int ret;
>>>>
>>>>         if (!ops)
>>>>                 return -EINVAL;
>>>> @@ -183,12 +184,22 @@ int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
>>>>         init_completion(&inst->done);
>>>>         inst->ops = ops;
>>>>
>>>> -       mutex_lock(&core->lock);
>>>> -       list_add_tail(&inst->list, &core->instances);
>>>> -       atomic_inc(&core->insts_count);
>>>> +       ret = mutex_lock_interruptible(&core->lock);
>>>> +       if (ret)
>>>> +               return ret;
>>>
>>> Why do we change to mutex_lock_interruptible() here? This makes this
>>
>> Because mutex_lock_interruptible is preferable in kernel docs, but I
>> agree that changing mutex_lock with mutex_lock_interruptible should be
>> subject of another lock related patches. I will drop this in next patch
>> version.
>>
>>> function return an error even though we could obtain the lock just by
>>> trying a bit harder.
>>
>> I didn't get that. The behavior of mutex_lock_interruptible is that same
>> as mutex_lock, i.e. the it will sleep to acquire the lock. The
>> difference is that the sleep could be interrupted by a signal. You might
>> think about mutex_trylock?
> 
> Unless that mutex can be held by someone else for a rather long time
> (i.e. to the point where we may want to give priority to signals when
> userspace opens the device, since that's where hfi_session_create() is
> called), I am not convinced this change is necessary? It may confuse

Exactly, if there is a case where the core->lock is taken (firmware
recovery) and it is not unlocked for very long time (deadlock?) then
client process cannot be interrupted with a signal.

> userspace into thinking there was a serious error while there is none.

The client should be able to handle EINTR, right?

> Granted, userspace should manage this case, and from what I can see
> this code is correct, but I'm not sure we would gain anything by
> adding this extra complexity.

The benefit is that if something wrong is happening in the driver the
client process will be killable.

> 
>>
>>>
>>>> +
>>>> +       ret = atomic_read(&core->insts_count);
>>>> +       if (ret + 1 > core->max_sessions_supported) {
>>>> +               ret = -EAGAIN;
>>>> +       } else {
>>>> +               atomic_inc(&core->insts_count);
>>>> +               list_add_tail(&inst->list, &core->instances);
>>>> +               ret = 0;
>>>> +       }
>>>> +
>>>>         mutex_unlock(&core->lock);
>>>>
>>>> -       return 0;
>>>> +       return ret;
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(hfi_session_create);
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
>>>> index 363ee2a65453..52898633a8e6 100644
>>>> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
>>>> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
>>>> @@ -276,6 +276,9 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
>>>>                 words_count--;
>>>>         }
>>>>
>>>> +       if (!core->max_sessions_supported)
>>>> +               core->max_sessions_supported = MAX_SESSIONS;
>>>> +
>>>>         parser_fini(inst, codecs, domain);
>>>>
>>>>         return HFI_ERR_NONE;
>>>> --
>>>> 2.17.1
>>>>
>>
>> --
>> regards,
>> Stan

-- 
regards,
Stan
