Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC672BC637
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgKVOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 09:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgKVOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 09:48:13 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A22C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 06:48:11 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so13925677ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZDzM+WFxB6B4dYDN2InEoPdN/On7LdDZTygjQx7Z3HE=;
        b=AoYJEnCWNGa4KeyI+NPaATo88wNu7HuVnrllcEhjCoSydwgnpCRxFrp/aEVpyCaZTP
         kGVOmy+4vyQZ08oHkdu9sC6mpM8Rd9OwTuMVL6rpro9VrcuWzq1z6Gb0/9R29Fi5NcR2
         ZqAf9XnKARayCGpsJV+xT0N6KlQQTHUtkVMfjZ+dgI9tImkVGo4/wpYt6leXP49Pxzvn
         o+9XN2J5KlWBJ5vbgaG58iHYzrUUaIFNfk7S0UqGda/mhwtd1eS+6ApLwnuXRD6A/4R/
         BD5xHRYYC4Pr+FzyvvqIeRz+MxYM5LRWkM1vgxliWC06wKnwPzA2fUwXJz+nVI2ytwYS
         7DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZDzM+WFxB6B4dYDN2InEoPdN/On7LdDZTygjQx7Z3HE=;
        b=hetkrw5e+1SpsKYxpJuRos91eBGkRAzccAI6PcuPaPnhu/kUUC7ey6xZnSLBo+iFYh
         3/kC8zKS1O7nJ7ZdwLyrVpV55K3Eh/4AOn+iOdjq2jRrf9dGwAItf6Gk8me6pMAZDukh
         kBg/gw7F3/ls1lYTqC2dSUlDxe4WU3nvwstb2LhZcGO6h6hRPJzwNTunPik1KUJgyMQi
         gPJgCMPvXVggUwpD5m3Roy59hFRxug8R/YXcNgOtsHpnMPi1cLdeSwbTNeY8MK195fyz
         bTK2PoaIeMgfomL8LW4PdNAUbrmncqvwE+V90yJYEwFPPTN5GdUuFvFN/Y43gjapmdgs
         gF2Q==
X-Gm-Message-State: AOAM530CwMkxXiG7A8BzuuATJE1bCpK6+fTuc/2zmoMTV6Bc2EmjcChe
        U1FtXTPCEK76WdNImdRJ4ghKNTkvMt7xUidS
X-Google-Smtp-Source: ABdhPJyyZfJg2Mp2xz//lvIK1I7WQhOVkaRrzdSGyA7L5GU0Dlc7ddu/ECtee//fy6hevNa7Q/qVMQ==
X-Received: by 2002:a17:906:60d4:: with SMTP id f20mr42394347ejk.156.1606056490114;
        Sun, 22 Nov 2020 06:48:10 -0800 (PST)
Received: from [192.168.1.9] (hst-221-20.medicom.bg. [84.238.221.20])
        by smtp.googlemail.com with ESMTPSA id q15sm3629250edt.95.2020.11.22.06.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 06:48:09 -0800 (PST)
Subject: Re: [PATCH 2/3] venus: Limit HFI sessions to the maximum supported
To:     Fritz Koenig <frkoenig@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>
References: <20201120001037.10032-1-stanimir.varbanov@linaro.org>
 <20201120001037.10032-3-stanimir.varbanov@linaro.org>
 <CAMfZQbwjRTuF7_joa9sL0HLTkFC70FqymPOmtxmETt38qey+NA@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <88838aa8-9c25-3fae-86dd-35b2a3df83d9@linaro.org>
Date:   Sun, 22 Nov 2020 16:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMfZQbwjRTuF7_joa9sL0HLTkFC70FqymPOmtxmETt38qey+NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/20 3:14 AM, Fritz Koenig wrote:
> On Thu, Nov 19, 2020 at 4:12 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Currently we rely on firmware to return error when we reach the maximum
>> supported number of sessions. But this errors are happened at reqbuf
>> time which is a bit later. The more reasonable way looks like is to
>> return the error on driver open.
>>
>> To achieve that modify hfi_session_create to return error when we reach
>> maximum count of sessions and thus refuse open.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.h      |  1 +
>>  drivers/media/platform/qcom/venus/hfi.c       | 19 +++++++++++++++----
>>  .../media/platform/qcom/venus/hfi_parser.c    |  3 +++
>>  3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index db0e6738281e..3a477fcdd3a8 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -96,6 +96,7 @@ struct venus_format {
>>  #define MAX_CAP_ENTRIES                32
>>  #define MAX_ALLOC_MODE_ENTRIES 16
>>  #define MAX_CODEC_NUM          32
>> +#define MAX_SESSIONS           16
>>
>>  struct raw_formats {
>>         u32 buftype;
>> diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
>> index 638ed5cfe05e..8420be6d3991 100644
>> --- a/drivers/media/platform/qcom/venus/hfi.c
>> +++ b/drivers/media/platform/qcom/venus/hfi.c
>> @@ -175,6 +175,7 @@ static int wait_session_msg(struct venus_inst *inst)
>>  int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
>>  {
>>         struct venus_core *core = inst->core;
>> +       int ret;
>>
>>         if (!ops)
>>                 return -EINVAL;
>> @@ -183,12 +184,22 @@ int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
>>         init_completion(&inst->done);
>>         inst->ops = ops;
>>
>> -       mutex_lock(&core->lock);
>> -       list_add_tail(&inst->list, &core->instances);
>> -       atomic_inc(&core->insts_count);
>> +       ret = mutex_lock_interruptible(&core->lock);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = atomic_read(&core->insts_count);
>> +       if (ret + 1 > core->max_sessions_supported) {
>> +               ret = -EAGAIN;
>> +       } else {
>> +               atomic_inc(&core->insts_count);
>> +               list_add_tail(&inst->list, &core->instances);
>> +               ret = 0;
>> +       }
>> +
>>         mutex_unlock(&core->lock);
>>
>> -       return 0;
>> +       return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(hfi_session_create);
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
>> index 363ee2a65453..52898633a8e6 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
>> @@ -276,6 +276,9 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
>>                 words_count--;
>>         }
>>
> 
> My understanding of the hardware is that there is a max number of
> macroblocks that can be worked on at a time.  That works out to
> nominally 16 clips.  But large clips can take more resources.  Does
> |max_sessions_supported| get updated with the amount that system can
> use?  Or is it always a constant?

The number of max sessions supported is constant.

> 
> If it changes depending on system load, then couldn't
> |core->max_sessions_supported| be 0 if all of the resources have been
> used up?  If that is the case then the below check would appear to be
> incorrect.

No, this is not the case. Changing dynamically the number of max
sessions depending on session load is possible but it would be complex
to implement. For example, think of decoder dynamic resolution change
where we don't know in advance the new resolution (session load).

> 
>> +       if (!core->max_sessions_supported)
>> +               core->max_sessions_supported = MAX_SESSIONS;
>> +
>>         parser_fini(inst, codecs, domain);
>>
>>         return HFI_ERR_NONE;
>> --
>> 2.17.1
>>

-- 
regards,
Stan
