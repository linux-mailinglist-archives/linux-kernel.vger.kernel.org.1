Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08A6260214
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgIGRSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbgIGOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:01:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E0DC061756
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 07:01:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so15943952wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3yqLenHCPoqZrIKpooufqqBwsVq0mXq7ilOpODhrUnI=;
        b=aHFvksQujTdggw97cyEMBUIDWbyNKKzTFEMugO4p2ZKgWzaTydXy9Awhl6X0DXWY58
         oEaTk44UP3RMo+8METMNE9LRM/yLK270f/davU3IOuIDZkzDztCORSDiT/3B1o3z63mM
         GNuSQjSCgcizqtwaFxReW7iCTQ4i9cnK0M6akHPU2rDG/J/CDb9OoX85Pb0WxcH1L7Vc
         CG5ja5OFH/qo8deTEk7l8sE3n35cNYfdpyCzOi4bIXaYZ+vn4rcJxAg9j6pkvIQUBvES
         EXzE/0YJ69GWzrIjY5/s0sfLJE4iUWP1FrsNsQlb64hsqBKqrSnK9MIYMe7rE8RV2S33
         3z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3yqLenHCPoqZrIKpooufqqBwsVq0mXq7ilOpODhrUnI=;
        b=rHt5/wyE2efm8+IhQnWnJYNexanmRqjzdSL6ki+pJNOJfGbrO22S7I3Nhkz7K8RPI4
         7YOg8beEeohkwkc+yzhiFmyY0GVsyNCbz8nfas9YA+G1Tm+byfQpmsnwCu+MBODxYt/j
         yYtxTGR75yW0M/0slyiQIxm0tmXb0skmtqRpEEK83+DVwvUwun6H8HAWXS2LsuQLWk4P
         oB6p2kX8TSB5HSvGK1xIVQ/fGSiwN/sXpaCmpnsJpVi1reINVKqZ+XIKjDJpcwv+MhVc
         LvjA1lAo+KhdG0AHWljecXUCLHM3uPEafl39C49T+bRe4qvrUEw4vUiCFE0cI5m+/z1U
         8sEA==
X-Gm-Message-State: AOAM5312nDXQw346L7p0G4ao/sg/VyqhB/Gt2o4SkfsYoXeZ4+w9Y9fP
        v4bdq/3fdB6i+hnE9QaXow4pbxH3lfcOmw==
X-Google-Smtp-Source: ABdhPJzoJcfLaxWjMwyLqCvhxjDEuDUMEwVpfFLq6Lmj6kj5U1a+91N5u3NhIyKL2eHHQzQcMpAthQ==
X-Received: by 2002:adf:8405:: with SMTP id 5mr9299149wrf.143.1599487279925;
        Mon, 07 Sep 2020 07:01:19 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id s2sm18343294wrw.96.2020.09.07.07.01.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:01:19 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: add ioctl for attaching to sensors pd
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901003300.11985-1-jonathan@marek.ca>
 <fa436d55-b986-944f-e90f-b81cb32eeb0e@linaro.org>
 <3f1f8ff1-cf23-ae2c-4cff-cdcce0b11e2e@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f2faa7b2-1e7d-2f39-ef36-a3790cedfab9@linaro.org>
Date:   Mon, 7 Sep 2020 15:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3f1f8ff1-cf23-ae2c-4cff-cdcce0b11e2e@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2020 14:47, Jonathan Marek wrote:
> On 9/7/20 8:36 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 01/09/2020 01:32, Jonathan Marek wrote:
>>> -#define FASTRPC_IOCTL_MMAP              _IOWR('R', 6, struct 
>>> fastrpc_req_mmap)
>>> -#define FASTRPC_IOCTL_MUNMAP            _IOWR('R', 7, struct 
>>> fastrpc_req_munmap)
>>> +#define FASTRPC_IOCTL_MMAP        _IOWR('R', 6, struct 
>>> fastrpc_req_mmap)
>>> +#define FASTRPC_IOCTL_MUNMAP        _IOWR('R', 7, struct 
>>> fastrpc_req_munmap)
>>
>> Looks like changes that do not belong to this patch!
>>
>> I wanted to try this patch on SM8250.
>> How do you test attaching fastrpc to sensor core?, I mean which 
>> userspace lib/tool do you use?
>>
>> --srini
>>
> 
> I pushed my sdsprpcd implementation to github, which is responsible for 
> initializing the sensors, and uses this ioctl:
> 
> https://github.com/flto/fastrpc

Thanks!, I can take a look and see if I can try it out with linaro 
fastrpc library!
> 
> Note: it uses my own WIP fastrpc "library" instead of the one from 
> linaro, I also have other related code, like a sensor client, and 
> cDSP/aDSP compute examples, but need to confirm that I can share them
> 
> Also, the corresponding dts patch I sent has a problem, the label = 
> "dsps"; should be label = "sdsp"; (copied the "dsps" from downstream, 
> but upstream expects "sdsp"), will send a v2 later today.
Also the dts patch will fail to apply as it is, as it seems me that you 
have based the patch after adding audio dts patch!


--srini
> 
>>> +#define FASTRPC_IOCTL_INIT_ATTACH_SNS    _IO('R', 8)
