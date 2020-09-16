Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC526BA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgIPCyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgIPCya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:54:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C90FC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:54:28 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o8so5327809otl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M13D7pDeqTfRTeAMAwDS2McvOADXrbuV9/Z+TsYHP7k=;
        b=Xm6mZzlwP7ArzgmSu1R1ZzWO+9pCdDaBzxDbswdRJseOFa7CNodv4WC3+qKooITW0X
         MvtXbeCE+fyuzwM5kLUsmV9Ltvvqw7k1o6Je3IA+BXmj0/ejob2j79Rlxow+8l5lciX9
         3zT9u1CFnth1Er8PSBvy8+PQWFKLCS20kehdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M13D7pDeqTfRTeAMAwDS2McvOADXrbuV9/Z+TsYHP7k=;
        b=lR3IN3K1gLjkadXoQ2XFiYqUKE4Pxp2USyKO+jzbRLB4fZ55pZj5c542cojZkBM6z7
         B5oPnwc3iiIdtAmBYnsSdgs9StDCGH9m9YmgfY3pfZ+A+UtFpmugg/QG2qMkoamznfEm
         4z4mqRceUVgiEZlZPkigAJV//fltEnmV/pioQY8WllgoEdOG9kqf2WgMYPR7/Yf/RtLI
         A2lNiv9tTeelGQeZdSd78V6IWy5huAPdksIWLt7Jsyn2hXvbXLlG2HXalPeDKfgXw24R
         UfXHWcL+ufxKs8U/79WUCWVv5SzCSsgLtrK4lfK+qE4rocYXi3IQzxQeznjNzLHQaYqD
         pVTw==
X-Gm-Message-State: AOAM530CPuVwQakFaeV71iqsS+cxa3c2vyCdwYmfOOmcQI5LWuN3I2V+
        ULmmtCJ3pLujUTRx3qptIHNMsA==
X-Google-Smtp-Source: ABdhPJyv2arqvwRfSk8gbheLk76ChJwq5LQdVTpxdnFbXlWhXw9EfGiaHG9QY3UvRBYSY75WjUX+lg==
X-Received: by 2002:a9d:7dd8:: with SMTP id k24mr15539136otn.160.1600224867700;
        Tue, 15 Sep 2020 19:54:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c25sm9278372oot.42.2020.09.15.19.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 19:54:26 -0700 (PDT)
Subject: Re: [PATCH 5.8 000/177] 5.8.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200915140653.610388773@linuxfoundation.org>
 <b94c29b3-ef68-897b-25a8-e6fcc181a22a@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8277900f-d300-79fa-eac7-096686a6fbc3@linuxfoundation.org>
Date:   Tue, 15 Sep 2020 20:54:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b94c29b3-ef68-897b-25a8-e6fcc181a22a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/20 3:06 PM, Shuah Khan wrote:
> On 9/15/20 8:11 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.8.10 release.
>> There are 177 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 17 Sep 2020 14:06:12 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.10-rc1.gz 
>>
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
>> linux-5.8.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Compiled and booted fine. wifi died:
> 
> ath10k_pci 0000:02:00.0: could not init core (-110)
> ath10k_pci 0000:02:00.0: could not probe fw (-110)
> 
> This is regression from 5.8.9 and 5.9-rc5 works just fine.
> 
> I will try to bisect later this evening to see if I can isolate the
> commit.
>

The following commit is what caused ath10k_pci driver problem
that killed wifi.

Prateek Sood <prsood@codeaurora.org>
     firmware_loader: fix memory leak for paged buffer

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.8.y&id=ec0a59266c9c9f46037efd3dcc0323973e102271

thanks,
-- Shuah
