Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46B2F04D7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 04:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbhAJDLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 22:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAJDLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 22:11:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC77C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 19:10:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p12so5759304pju.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 19:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vT0FkEjXW8DIDHB065Q//aR3LirVFKwkxDvSdptPY5g=;
        b=iSpAnKRbDG+keqi4cvokwgzZtNuS6aa/UUnjs9wj+CpRuvF32Y3JWeyhgeIZo2+ZLl
         1agnpKeBHqsBiH+Kqpuu9w9tP3rNkY/dNtg73xJihvo4CwaQTme6c7a1Jlo7nv5O4/cP
         JFAvx/+vv3onHHI2Yfc67uTf2WE03Apeha+Kgjx2mm2WymW+PnHTKpfbuAa2BkL4sLmn
         GlRjoaoITYzzAsvQ0AJdKoOVZuv8XIH2oxf1FskMf8y0VEed6TzaV9u5m4FzYjjsuONM
         TwiktuoEcgXdYGc4eSIeujF2Xd8S8FB3scwCNL6cDgyy+c+Lznqj2wEOEOBtl1XvcrDa
         mstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vT0FkEjXW8DIDHB065Q//aR3LirVFKwkxDvSdptPY5g=;
        b=WbeV59NPUiTlA3gX75J3MAww19X7AwIPOKMy4M6en8s5I1OuypbFwVvbGusW+hQsav
         M0UTznkdnnQOPEdMzCRrlvvH4sTLeqtHXIF/97rmkutqyIdfjmmcbBxYwqy3dd3zjyek
         m4vilszTfjd2VwEbQzQMc/FMiQuV65w0NJNn/U5Pjc9MSvt0NpB1C3wicshrKPnZf0OC
         bga2TQq1YCT3rH0fbfx5i1gUxjIUTsQ+vzlYCv7dwkBauqmYfCt67RZ6m/RpZ9ailEGu
         cxk6kkJEVItMHfJBSvuGMXQodqt4+gXk+B3SNt3JWj73U2FhzVR40oCzGUShJbsZbOZj
         0gIQ==
X-Gm-Message-State: AOAM532Z8pZu3DUCfJh11ZS2S3FnVRkIvgQB0aNsOr/UnMg4YiWQAKU3
        QnlGo7145B5VtKAH5kIqBCbRHjwQhi1OiA==
X-Google-Smtp-Source: ABdhPJz0BxuDuloHU1pozHHvbAldSwRIEepO71qfwXAKlmeCS/uX2UPRYcdh3Mcu960yZZzFlH5wTw==
X-Received: by 2002:a17:90b:204:: with SMTP id fy4mr11083534pjb.57.1610248249733;
        Sat, 09 Jan 2021 19:10:49 -0800 (PST)
Received: from [10.2.24.220] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id e5sm13037776pjs.0.2021.01.09.19.10.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jan 2021 19:10:49 -0800 (PST)
Subject: Re: [External] Re: [PATCH v3 2/2] misc: pvpanic: introduce module
 parameter 'events'
To:     Greg KH <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-3-pizhenwei@bytedance.com>
 <X/hnF0W+TMj36LDN@kroah.com>
 <58eca97c-f72e-66a7-2696-611124ce0943@redhat.com>
 <X/h3BAdea48p+L+p@kroah.com>
 <2729803e-c9b2-abc9-e93f-ace19f521945@redhat.com>
 <X/mT/9qKswNUIWTc@kroah.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <a85467db-f6d8-4ac3-1be4-af31c881616f@bytedance.com>
Date:   Sun, 10 Jan 2021 11:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <X/mT/9qKswNUIWTc@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/21 7:31 PM, Greg KH wrote:
> On Fri, Jan 08, 2021 at 04:26:17PM +0100, Paolo Bonzini wrote:
>> On 08/01/21 16:15, Greg KH wrote:
>>> On Fri, Jan 08, 2021 at 04:04:24PM +0100, Paolo Bonzini wrote:
>>>> On 08/01/21 15:07, Greg KH wrote:
>>>>>>     static void __iomem *base;
>>>>>> +static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>>>>>> +module_param(events, uint, 0644);
>>>>>> +MODULE_PARM_DESC(events, "set event limitation of pvpanic device");
>>>>> I do not understand you wanting a module parameter as well as a sysfs
>>>>> file.  Why is this needed?  Why are you spreading this information out
>>>>> across different apis and locations?
>>>>
>>>> It can be useful to disable some functionality, for example in case you want
>>>> to fake running on an older virtualization host.  This can be done for
>>>> debugging reasons, or to keep uniform handling across a fleet that is
>>>> running different versions of QEMU.
>>>
>>> And where is this all going to be documented?
>>
>> I don't disagree.
>>
>>> And what's wrong with just making the sysfs attribute writable?
>>
>> Isn't it harder to configure it at boot?  Also the sysfs attribute added by
>> patch 1 is documenting what is supported by the device, while the module
>> parameter can be set to any value (you can think of the module parameter as
>> of a "what to log" option, except the logging happens on another machine).
> 
> But the module parameter is global, and not device specific.
> 
> And yes, it would be harder to configure this at boot, is this something
> that is required?  If so, please document that somewhere.
> 
>> Therefore, if you make the sysfs attribute writable, you would actually need
>> _two_ attributes, one for the in-use capabilities and one for the device
>> capabilities.  And sysfs files are runtime values, which is different
>> concept than 0444 module parameters (which are more like just
>> configuration).
> 
> That's not the module parameter mode setting in this patch :(
> 
>> So you would have to decide whether it's valid to write 2
>> to the in-use capabilities file when the device capabilities are "1", and I
>> don't really have a good answer for that.
>>
>> Also considering that there will not be more than one copy of this device
>> (it doesn't make sense as they would all do exactly the same thing), in this
>> case a module parameter really seems to be the simplest way to configure it.
> 
> So you never can have more than one of these in the system at one time?
> Because if this ever becomes not true, the module parameter is a mess...
> 
> thanks,
> 
> greg k-h
> 

What about adding _two_ device attribute:
capability (0444): detect from device which the hypervisor really supports.

events (0644): root user could enable/disable feature(s) from guest side.

-- 
zhenwei pi
