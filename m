Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8CB29F678
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgJ2UyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ2UyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:54:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506DC0613CF;
        Thu, 29 Oct 2020 13:54:24 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f16so4524375ilr.0;
        Thu, 29 Oct 2020 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JWn7AQ10KBK6fvTH/BDTQtj7AiCq8pG0QDOCUv5Y/H8=;
        b=YRINJYmst4pVmROk+zxPD2k2zTuzwyK+zOHIV/ecoC7ajFFTiKXXCOsyPpXiPYIa+h
         oIi+gwHv6zqZW3lc/Exw1578PoV13d38dUAD8epxlh4OJCHioSn0ocNIFMqmNOGL+FO5
         o0Ton0wPe2gUEOzwB/tqttA5NjyX3lvPCvqQ5f5M+WTCiaqijd7ipHUjtC2xzW69zvYk
         63cWw8lMWwoRmRm5rOqYWJY6iH/3atXHFu/hn3p81Xmm1BmZL3+xuOwy0fTLcOFzN3uc
         D6AcM1r4C7l0HskX865L2z0iCa7P4j6vW1BOwydywDiVXSUBqk+UAL/F+h8VGryfdQ8G
         0TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JWn7AQ10KBK6fvTH/BDTQtj7AiCq8pG0QDOCUv5Y/H8=;
        b=sENLWNYjtRQwi0DKV4BfD9P+zedtHz8EQDf67F12fdZ7s7HfjXtKlgk/peULzsmWSn
         ryw5C5HNkVRpkMkZAdmxxM+kF3xXOqlJClHeYyz2tq2KoJWBoAmsXi7GmNefDl8ye7/u
         N7L0tHTiUNLGccGBP4ONzpCt46QvGEVpE30L2WmPELG/5VFHPJiVl6tKLg2KSFm/EaC5
         VUDi7EAdLMIvUrWDYooQHXcV53nItVOvOevXPMoE7JA3HjuEEsv/jkz+qSG6aLpUczfP
         UP0RLcABuO6cfm0FhQHkzBJZwulv69O9me/i0zf+Vi3BBsw7HvILTDxM/abJrwNzPevh
         d9rw==
X-Gm-Message-State: AOAM532gOzPymgtbPEIcN5UAZSXwmcdyvHPFkK7t/BZEbVJkRJReNhzQ
        ngs+EhqVC1gtrL7CBbospTo/HJBfBZ8=
X-Google-Smtp-Source: ABdhPJzzte4HXfhiWVsTwDVoRDjeDsLoNs2Jo9KqjUQ555CJLDthbU8UYObDxzMXyLCMoW3DAqCtcQ==
X-Received: by 2002:a92:c94c:: with SMTP id i12mr4776976ilq.145.1604004863306;
        Thu, 29 Oct 2020 13:54:23 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id d26sm3871547ill.83.2020.10.29.13.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 13:54:22 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Fix errors on DT overlay removal with devlinks
To:     Michael Auchter <michael.auchter@ni.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20201014193615.1045792-1-michael.auchter@ni.com>
 <d5f8a417-8db9-9385-dfea-9512b4680124@gmail.com>
 <CAGETcx_869kxKbgRO68Wp9Qq8vAp8fqpAe_Lkjx8vZdW9RNTsQ@mail.gmail.com>
 <20201028162540.GA2310713@xaphan>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9e8e7f6e-cebc-a99e-b883-b7555dc01ef6@gmail.com>
Date:   Thu, 29 Oct 2020 15:54:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028162540.GA2310713@xaphan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 11:25 AM, Michael Auchter wrote:
> Hey Saravana,
> 
> Thanks for taking the time to look into this!
> 
> On Mon, Oct 26, 2020 at 12:10:33PM -0700, Saravana Kannan wrote:
>> On Wed, Oct 21, 2020 at 2:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> Hi Saravana,
>>>
>>> Michael found an issue related to the removal of a devicetree node
>>> which involves devlinks:
>>>
>>> On 10/14/20 2:36 PM, Michael Auchter wrote:
>>>> After updating to v5.9, I've started seeing errors in the kernel log
>>>> when using device tree overlays. Specifically, the problem seems to
>>>> happen when removing a device tree overlay that contains two devices
>>>> with some dependency between them (e.g., a device that provides a clock
>>>> and a device that consumes that clock). Removing such an overlay results
>>>> in:
>>>>
>>>>   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
>>>>   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
>>>>
>>>> followed by hitting some REFCOUNT_WARNs in refcount.c
>>>>
>>>> In the first patch, I've included a unittest that can be used to
>>>> reproduce this when built with CONFIG_OF_UNITTEST [1].
>>>>
>>>> I believe the issue is caused by the cleanup performed when releasing
>>>> the devlink device that's created to represent the dependency between
>>>> devices. The devlink device has references to the consumer and supplier
>>>> devices, which it drops in device_link_free; the devlink device's
>>>> release callback calls device_link_free via call_srcu.
>>>>
>>>> When the overlay is being removed, all devices are removed, and
>>>> eventually the release callback for the devlink device run, and
>>>> schedules cleanup using call_srcu. Before device_link_free can and call
>>>> put_device on the consumer/supplier, the rest of the overlay removal
>>>> process runs, resulting in the error traces above.
>>>
>>> When a devicetree node in an overlay is removed, the remove code expects
>>> all previous users of the related device to have done the appropriate put
>>> of the device and to have no later references.
>>>
>>> As Michael described above, the devlink release callback defers the
>>> put_device().  The cleanup via srcu was implemented in commit
>>> 843e600b8a2b01463c4d873a90b2c2ea8033f1f6 "driver core: Fix sleeping
>>> in invalid context during device link deletion" to solve yet another
>>> issue.
>>>
>>>
>>>>
>>>> Patches 2 and 3 are an attempt at fixing this: call srcu_barrier to wait
>>>> for any pending device_link_free's to execute before continuing on with
>>>> the removal process.
>>>>
>>>> These patches resolve the issue, but probably not in the best way. In
>>>> particular, it seems strange to need to leak details of devlinks into
>>>> the device tree overlay code. So, I'd be curious to get some feedback or
>>>> hear any other ideas for how to resolve this issue.
>>>
>>> I agree with Michael that adding an indirect call of srcu_barrier(&device_links_srcu)
>>> into the devicetree overlay code is not an appropriate solution.
>>
>> I kind of see your point too. I wonder if the srcu_barrier() should
>> happen inside like so:
>> device_del() -> device_links_purge()->srcu_barrier()
>>
>> I don't know what contention the use of SRCUs in device links was
>> trying to avoid, but I think the srcu_barrier() call path I suggested
>> above shouldn't be a problem. If that fixes the issue, the best way to
>> know if it's an issue is to send out a patch and see if Rafael has any
>> problem with it :)
> 
> I was able to test this by adding the srcu_barrier() at the end of
> device_links_purge(), and that does seem to have fixed the issue.
> 
>>> Is there some other way to fix the problem that 843e600b8a2b solves without
>>> deferring the put_device() done by the devlink release callback?
>>
>> Ok I finally got some time to look into this closely.
>>
>> Even if you revert 843e600b8a2b, you'll see that device_link_free()
>> (which drops the reference to the consumer and supplier devices) was
>> scheduled to run when the SRCU clean up occurs. So I think this issue
>> was present even before 843e600b8a2b, but commit 843e600b8a2b just
>> made it more likely to hit this scenario because it introduces some
>> delay in dropping the ref count of the supplier and consumer by going
>> through the device link device's release path. So, I think this issue
>> isn't related to 843e600b8a2b.
>>
>> As to why 843e600b8a2b had to be written to call call_srcu() from the
>> device link device's release path, it's a mess of dependencies/delays:
>> 1. The device link device is part of the struct device_link. So we
>> can't free device_link before the device_link.link_dev refcount goes
>> to 0.
>> 2. But I can't assume device_link.link_dev's refcount will go to 0 as
>> soon as I call put_device() on it because of
>> CONFIG_DEBUG_KOBJECT_RELEASE which frees up the kobject after a random
>> delay.
>> 3. The use of SRCU also means I can't free device_link until the SRCU
>> is cleaned up.
>>
>> Because of (1), (2) and (3), when the device_link_del() (or any of the
>> other device link deletion APIs are called) I first have to do a
>> put_device(device_link.link_dev) to make sure the device memory is no
>> longer referenced, then trigger an SRCU clean up and then in the
>> scheduled SRCU cleanup I can free struct device_link. And obviously,
>> until struct device_link is ready to be freed up, I can't drop the
>> reference to the supplier and consumer devices (as that old copy of
>> device_link could be used by some code to refer to the supplier and
>> consumer devices).
>>
>> Hope that helps explain the SRCU and device link device release dependencies.
>>
>> Also, even if this patch series is applied as is, I wonder if the
>> current overlay code has a bug related to CONFIG_DEBUG_KOBJECT_RELEASE
>> delaying the actual freeing of the device. Something to look into?
> 
> I also tried enabling CONFIG_DEBUG_KOBJECT_RELEASE... with or without
> the addition of srcu_barrier() to device_links_purge(), I can't boot
> successfully when CONFIG_OF_UNITTEST=y &&
> CONFIG_DEBUG_KOBJECT_RELEASE=y: there are a ton of errors that result
> from this combo.

I'll add looking checking out booting with CONFIG_DEBUG_KOBJECT_RELEASE
enabled with CONFIG_OF_UNITTEST enabled to my todo list.

> 
> Disabling the unittests and booting with CONFIG_DEBUG_KOBJECT_RELEASE=y,
> I _do_ still see the errors mentioned in my original message when
> removing an overlay. So yeah, it does seem like there are some latent

Just to make sure I understand clearly, you are still seeing the
messages:

   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy

when the overlay is removed?  And if I apply patch 1/3 (the new unittest)
and also add srcu_barrier() at the end of device_links_purge()
then I will see these messages?

Can you add a reply to this email with the patch to add srcu_barrier() at
the end of device_links_purge() so that I am testing the same thing that
you are testing?  (If it makes life easier for you, you can just cut
and paste the patch into the reply, even if it results in a white
space damaged patch -- I'm assuming a one-line patch.)

-Frank

> issues here...
> 
> Cheers,
>  Michael
> 

