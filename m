Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A272F2AE146
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgKJVCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:02:17 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC34C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:02:16 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id a20so13519767ilk.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hTEZuc82d1g5VvucdImgjg3ULND3nOsOgigDk2DI/+8=;
        b=T9D/WIcsClZwpGKErlJuHTFALDz6vsuxGxC1d23FpoAq5emQMX6ZPFB58AHesKL4Np
         tcU2ntQUFGsV5Fmvtxy12aE51gFg/hgx6zBLjtyGmAoHaAFYlV6HWA1e1dPXHWbBGFq0
         jKWHhyDfPV6q/pCSOGvu4Zn12BRot5pZCwKDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hTEZuc82d1g5VvucdImgjg3ULND3nOsOgigDk2DI/+8=;
        b=HUFtrMKdftHsp/ylQA1RCiDLbcwDOx9i8YGtag9vZX5FVX3Spta8Vww2JPYqVAS4Gd
         VJ0HY6NoSO1ciTk2SCnEuVY8lC5naN8ReMFITbQFI9zEor7VcvIF3HfMwJj8BWUQ3nC0
         oMeKPY+J8pBbR0xGXQGGSd427SXiaP0qEtFju2bvyeMzm4SAd0Cj/FRJpwqLdCUlkpA4
         TZscONy8SyaAWRam/HnRSDnkwhJj/akQr3lB1gm18r/DT7aKuSDgz8+a7QAf9Hex5RMw
         PMPScdyAF/2dZJU7znSrzC8PTCtNYhWabIkSspCPVUGYDvRTNFuy7Z8nMyFvMR84Tt78
         vhug==
X-Gm-Message-State: AOAM530o0nzHBEeM2O2txEsuohC7efTfIQT+3ATvRa8MDQFkg0LZgL9V
        Ho8THlntjZjuORHZ2HNuMcbGug==
X-Google-Smtp-Source: ABdhPJwy0XBegJgfxBv38odl1jCZvoE6acuK2Tr9mU3ARqr4mDAA0qHwmB6d9Byriqqy6+c1VLzreA==
X-Received: by 2002:a92:85cd:: with SMTP id f196mr14652639ilh.92.1605042136242;
        Tue, 10 Nov 2020 13:02:16 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x14sm58031ior.7.2020.11.10.13.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:02:15 -0800 (PST)
Subject: Re: [PATCH 12/13] drivers/staging/unisys/visorhba: convert stats to
 use seqnum_ops
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     david.kershner@unisys.com, keescook@chromium.org,
        peterz@infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <6fb679d23de785bbd1be6a528127e29f8ee6abd7.1605027593.git.skhan@linuxfoundation.org>
 <X6r7LVcXBBvRIbd8@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <82a5ad26-a633-bf76-0591-14f803133666@linuxfoundation.org>
Date:   Tue, 10 Nov 2020 14:02:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <X6r7LVcXBBvRIbd8@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 1:42 PM, Greg KH wrote:
> On Tue, Nov 10, 2020 at 12:53:38PM -0700, Shuah Khan wrote:
>> seqnum_ops api is introduced to be used when a variable is used as
>> a sequence/stat counter and doesn't guard object lifetimes. This
>> clearly differentiates atomic_t usages that guard object lifetimes.
>>
>> seqnum32 variables wrap around to INT_MIN when it overflows and
>> should not be used to guard resource lifetimes, device usage and
>> open counts that control state changes, and pm states.
>>
>> atomic_t variables used for error_count and ios_threshold are atomic
>> counters and guarded by max. values. No change to the behavior with
>> this change.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   .../staging/unisys/visorhba/visorhba_main.c   | 37 ++++++++++---------
>>   1 file changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
>> index 7ae5306b92fe..3209958b8aaa 100644
>> --- a/drivers/staging/unisys/visorhba/visorhba_main.c
>> +++ b/drivers/staging/unisys/visorhba/visorhba_main.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/module.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/visorbus.h>
>> +#include <linux/seqnum_ops.h>
>>   #include <scsi/scsi.h>
>>   #include <scsi/scsi_host.h>
>>   #include <scsi/scsi_cmnd.h>
>> @@ -41,8 +42,8 @@ MODULE_ALIAS("visorbus:" VISOR_VHBA_CHANNEL_GUID_STR);
>>   struct visordisk_info {
>>   	struct scsi_device *sdev;
>>   	u32 valid;
>> -	atomic_t ios_threshold;
>> -	atomic_t error_count;
>> +	struct seqnum32 ios_threshold;
>> +	struct seqnum32 error_count;
> 
> Are you sure the threshold variable is a sequence number >
> It goes up and down, not just up and up and up.

Right. I does go down. Turns out this is the only place seqnum32_dec()
is used. :)

I will fix. I noticed you made a comment about _dec() interfaces on
1/13. I can drop those as well. This way seqnum_ops can be just used
for up counters.

thanks,
-- Shuah
