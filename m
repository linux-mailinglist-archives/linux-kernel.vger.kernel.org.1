Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6E2F095E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbhAJTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610307841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1dYfoWP3G2nAzxG7PaOeZ2GC7vIthKJOgs5Vk0jAI8=;
        b=NwCD4UdQOiOZKc8CaET8tJXP63OXE+mwXGE+EQDsdtR4lhPt53mhIAWLzpps9JPwG/33dM
        k/GwWBa6sDCvQwfpdPMpNmwVFnEJajK5WKF/N6x9wbJiSHdchwR/QhAU6boxLatBWXaAPf
        A6uAhjaK9wNOn52OIFQe/6SoXozqEE4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-wqjxfeZOOUqcokNvvlvPug-1; Sun, 10 Jan 2021 14:43:59 -0500
X-MC-Unique: wqjxfeZOOUqcokNvvlvPug-1
Received: by mail-io1-f72.google.com with SMTP id t23so11198070ioh.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 11:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f1dYfoWP3G2nAzxG7PaOeZ2GC7vIthKJOgs5Vk0jAI8=;
        b=iK3Z1/5urjlvxFO3FVkFgZUvlggy11XYxX/HM57NSHOXpT/+Sg3HttaWGeMWndkc6V
         mjyltnUWhtIJOa7NXtnp1VvQQLzvFCT79bFTGfUtB9n2WWA/KepWFuURd1ohlApvhtfJ
         u5vfraLT1NBBo7nX5mq25O3EOXj/olx8gtbVzww6CHXzRQ2by8BJpxjJ0lSwYA0xs1Wf
         Oifqk589fCTU02Azq5Sl1Ai3ZqsV7wOssMDE46Y0WDg0pSlvaxZHb/d7oKRdcvC0W+HR
         5cZDE894wVf+NrQaftlEonq17NehKTzYBTzM2hghsU+eE0cEyq7B6o5+oXdHSEvg1dV1
         i/cg==
X-Gm-Message-State: AOAM532IChItV4K8FCKxXhYbZTbRsVaVQxLK/JhQOzjEm8W0oBe3ytEL
        B3OCJ9jDQullZtnbmOoJAttuBaKTRMRB0y7QTjoDtiW100/mS8yHFN60Di7XjmzGVZlJAWSUJEW
        8VH+YALk7f8gINT7Ik1a3UWnT
X-Received: by 2002:a92:418d:: with SMTP id o135mr13296760ila.213.1610307838407;
        Sun, 10 Jan 2021 11:43:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtrhrsF/kYCnIjUyqnRA4Oe36UpBrov9xC91eYfAlLOBBdxkH7wwiDRRctSnShZLYmp/aKag==
X-Received: by 2002:a92:418d:: with SMTP id o135mr13296744ila.213.1610307838181;
        Sun, 10 Jan 2021 11:43:58 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 17sm7030271ilt.15.2021.01.10.11.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 11:43:57 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com> <X/sz6lDq8WFzrRUJ@archbook>
From:   Tom Rix <trix@redhat.com>
Message-ID: <95af46d6-d123-f610-2f21-6d6de6f248e9@redhat.com>
Date:   Sun, 10 Jan 2021 11:43:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/sz6lDq8WFzrRUJ@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/21 9:05 AM, Moritz Fischer wrote:
> Tom,
>
> On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
>> On 1/7/21 8:09 AM, Tom Rix wrote:
>>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>>> This is a resend of the previous (unfortunately late) patchset of
>>>> changes for FPGA DFL.
>>> Is there something I can do to help ?
>>>
>>> I am paid to look after linux-fpga, so i have plenty of time.
>>>
>>> Some ideas of what i am doing now privately i can do publicly.
>>>
>>> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
> Is it not? It currently points to v5.11-rc1. If I start applying patches
> that require the changes that went into Greg's branch I can merge.

I mean the window between when we have staged patches and when they go into Greg's branch.

We don't have any now, maybe those two trival ones.

Since Greg's branch moves much faster than ours, our staging branch needs to be rebased regularly until its merge.

There are no outstanding fixes so all changes would go to -next.

>>> 2. an in-flight dev branch for the outstanding patches 
>> I have setup these branches based on Greg's char-misc-next
>>
>> fpga-next, which is char-misc-next base for fpga-testing
>>
>> fpga-testing, all the in-flight patches that would apply with automatic merge conflict resolution
>>
>> These are respectively
>>
>> https://github.com/trixirt/linux-fpga/tree/fpga-next
>>
>> https://github.com/trixirt/linux-fpga/tree/fpga-testing
> Feel free to have your own repos/branches etc, but I'd like to keep the
> offical trees on kernel.org.
Is there a way for me to move these to kernel.org ?
>
> Tbh I'd much rather see the patchwork instance be cleaned up if you want
> to do stuff.
Please point me at the wreckage and I will clean it up.
>>
>> There are two trivial changes, that could go to 5.12 now.
>>
>> fpga: dfl: fme: Constify static attribute_group structs
>>
>> fpga: Use DEFINE_SPINLOCK() for spinlock
>>
>> respectively
>>
>> https://lore.kernel.org/linux-fpga/20210108235414.48017-1-rikard.falkeborn@gmail.com/
>>
>> https://lore.kernel.org/linux-fpga/20201228135135.28788-1-zhengyongjun3@huawei.com/
> I was going to pick them up monday ...
>>
>> There are a couple of patchsets that conflict
>>
>> https://lore.kernel.org/linux-fpga/20210105230855.15019-7-russell.h.weight@intel.com/
>>
>> https://lore.kernel.org/linux-fpga/20201203171548.1538178-3-matthew.gerlach@linux.intel.com/
> Conflict between what and what?

There are basic git am ... applying problems.

By having a -testing branch it is easier to see where the conficts with all the outstanding patchsets.

>  
>> And the xilinx patchset
>>
>> https://lore.kernel.org/linux-fpga/20201217075046.28553-1-sonals@xilinx.com/
>>
>> Which is being split/worked on offline.
> I'm not sure what that means.

Don't worry about this until a new patchset lands.

Tom

>>
>> If I have missed any patchset, poke me.
>>
>> Tom
> - Moritz
>

