Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADA28CABE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbgJMJDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbgJMJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:03:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3653C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:03:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c22so27201447ejx.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yix8uA8ccUHN4fake0yiRHNn/uIqI1ulnAUvcNoP2CU=;
        b=YnOZMGM37Q8OfZjtCsKEZM7LeipsZdLC9ekHYA/oX9EPQ6piOwqvv8DzbjdPKnaj15
         7acx8UzDGnVu7ygc8NcQfm7ilC2q2fbcZNpYd+x3xnae12cTwEgzSQv+aH5FGyG0KQeA
         Qk5RfFWMcGiCN1LM1doK5aJ5I1EdYVDtuXjW2KIfbUAgLdUudkJSTkvQWyl2sRMeQIsT
         AHS3HqK6eOaaKR0o0LzFJ76VWMQWDdr5FhUjMD3wdYb5sudBqu6QnNATXIMUmAo+AD42
         xxJHhXzHrG/vTy3R8/vZ7IlFxOy5d77e3AEjKX5cBC/qYR3VFBbLCSiHyO3fKnsABrPx
         fvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yix8uA8ccUHN4fake0yiRHNn/uIqI1ulnAUvcNoP2CU=;
        b=lw2UC63IMoy2ZjR8iIxGwGXCbfZRVx/bbtmxwOyG44ugysJay6OMoNlYhxYfVMMlNG
         upxVJYNjTtg0g7xkPtQ0cyjknl3ujIfIOUNtseIiPukFLnm+5bm/BUn2pQ0/bCNhjwKh
         203B/+r6wvumnfl+cCItDqVliuJpC7pejdwLBIzmqOMHS2AKvYpQ5/YzmacbLBJAhoue
         kdyChln7KX5wtqKwh05Y2yu+5Ss0URqxK4mLgLdtSUHu/uA2mDJK3eBTFMeO4ddoBRDS
         ExAo+hCxm71MUDMF+8hEIK0kmwiyiDLRNr5KuWyfJVCmddDMyWLsxNksVb/7Pek1Jd7g
         Z4Dg==
X-Gm-Message-State: AOAM530rQgS7DAegdfI7/g9Tb3g9RiMsxjxZcqeW4MjxGqDOvj1VSBOF
        /b3E0r5CrQq9QfXY5/g5YV7dLOldp+hFbRex
X-Google-Smtp-Source: ABdhPJz6urimsOcuJgj3i5jKUukfiZ36eFQhiILV02hNGx+tFWg75eGdKZuwuZOVE4fwZGIha0mBxQ==
X-Received: by 2002:a17:906:3ada:: with SMTP id z26mr10117309ejd.151.1602579782287;
        Tue, 13 Oct 2020 02:03:02 -0700 (PDT)
Received: from [192.168.43.233] (212-5-158-214.ip.btc-net.bg. [212.5.158.214])
        by smtp.googlemail.com with ESMTPSA id q1sm11973152ejy.37.2020.10.13.02.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 02:03:01 -0700 (PDT)
Subject: Re: [PATCH] v4l: Add source change event for colorimetry
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
References: <20200702100017.24700-1-stanimir.varbanov@linaro.org>
 <8dafbb4b-4626-5191-c57a-f3ef19c14618@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <d11da037-92e5-2ee7-8723-10162d16eba9@linaro.org>
Date:   Tue, 13 Oct 2020 12:02:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8dafbb4b-4626-5191-c57a-f3ef19c14618@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/2/20 2:52 PM, Stanimir Varbanov wrote:
> Hi,
> 
> Once we have this event there is still open question how the client will
> know the data buffer on which the new colorspace is valid/applied.
> 
> The options could be:
>  * a new buffer flag and
>  * some information in the v4l2_event structure.
> 
> Thoughts?

Kindly ping.

> 
> On 7/2/20 1:00 PM, Stanimir Varbanov wrote:
>> This event indicate that the source colorspace is changed
>> during run-time. The client has to retrieve the new colorspace
>> identifiers by getting the format (G_FMT).
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  .../userspace-api/media/v4l/vidioc-dqevent.rst        | 11 ++++++++++-
>>  .../userspace-api/media/videodev2.h.rst.exceptions    |  1 +
>>  include/uapi/linux/videodev2.h                        |  1 +
>>  3 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
>> index a9a176d5256d..3f69c753db58 100644
>> --- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
>> +++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
>> @@ -381,7 +381,16 @@ call.
>>  	that many Video Capture devices are not able to recover from a temporary
>>  	loss of signal and so restarting streaming I/O is required in order for
>>  	the hardware to synchronize to the video signal.
>> -
>> +    * - ``V4L2_EVENT_SRC_CH_COLORIMETRY``
>> +      - 0x0002
>> +      - This event gets triggered when a colorspace change is detected at
>> +	an input. By colorspace change here we include also changes in the
>> +	colorspace specifiers (transfer function, Y'CbCr encoding and
>> +	quantization). This event can come from an input or from video decoder.
>> +	Once the event has been send to the client the driver has to update
>> +	the colorspace specifiers internally so that they could be retrieved by
>> +	client. In that case queue re-negotiation is not needed as this change
>> +	only reflects on the interpretation of the data.
>>  
>>  Return Value
>>  ============
>> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>> index ca05e4e126b2..54fc21af852d 100644
>> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>> @@ -492,6 +492,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
>>  replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
>>  
>>  replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
>> +replace define V4L2_EVENT_SRC_CH_COLORIMETRY src-changes-flags
>>  
>>  replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
>>  
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 303805438814..b5838bc4e3a3 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -2351,6 +2351,7 @@ struct v4l2_event_frame_sync {
>>  };
>>  
>>  #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
>> +#define V4L2_EVENT_SRC_CH_COLORIMETRY		(1 << 1)
>>  
>>  struct v4l2_event_src_change {
>>  	__u32 changes;
>>
> 

-- 
regards,
Stan
