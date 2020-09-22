Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71691273E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIVJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbgIVJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600766102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vn5swPQkcF9Fo/BaYOudv4sWPQMHmqAsZ8evmeA/deM=;
        b=OL0h0F7waAgniTEQHGxc77ERS5+Ty9i/pIcZCYiX6GvfcLOfN/hEL9HzGSxM4QPnZsZh6m
        flN4USpN3lsz7Y0qENeB/ZnJU6bPdIblRSUv5zPuJwDINotkQJ8B9n17fYPn8Pwco/fo5d
        1X+TsUbPttnCJzpLaEl8i1Dr7rdrHZo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-PHTJb-T7MzCcF1JM-FI3-g-1; Tue, 22 Sep 2020 05:15:00 -0400
X-MC-Unique: PHTJb-T7MzCcF1JM-FI3-g-1
Received: by mail-ed1-f72.google.com with SMTP id g16so5488912edy.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vn5swPQkcF9Fo/BaYOudv4sWPQMHmqAsZ8evmeA/deM=;
        b=UhkhDgD3cbc144z5ZCiRRsdFqW7h5IejK2U280QK3BswVTAqeRTveYKXxNys8wQXtV
         iBoAyinJSnkmpLIkGMGciEUIpSygk0zU4bM/40ny6Sc/BA22h5qKTEsAG9/U2M1ZLQFV
         IgToFmw4ORCSEnKOnjM1xEhAuqi0847XHKUFvaaqkqRFJ0CBzuR20NAMw4cH+5jYiaXo
         EJFZ7vgmMweeClF1c2ObSK58rF5tAV6cS9sJ0J+XfNidjNc22kqXJ8/i0odHsMq2EH7J
         DTKeAsM4dvOg3Jk+kQANPSbHe5cqXnpZbjC+iA2eFbCynAoIbuRHwNmQxcM5XNABINNb
         igKQ==
X-Gm-Message-State: AOAM531Cw2SLKxOMkjf7s2wfuE9DgUZvkuGn2/4ytzJydjL2B7s1Zqa5
        g1+VMPdSSauVprSgDi/CZJBNWFTUWRRI3G7RNvptcdC7yiBd3/AZyRTP/RJ1M4INnPQpTlwn+Hq
        tlZ2JTtrgX1LBf6AZOwEbMgou
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr3844997ejr.3.1600766099306;
        Tue, 22 Sep 2020 02:14:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLjoUuboj2r5nHlkoVus2Xce/d/5hlty3awbCCle9Cr3FHzisa4L+4msUwAwmadkURqUazwg==
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr3844985ejr.3.1600766099034;
        Tue, 22 Sep 2020 02:14:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o23sm10965632eju.17.2020.09.22.02.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 02:14:58 -0700 (PDT)
Subject: Re: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Richard Hughes <rhughes@redhat.com>,
        Jared Dominguez <jaredz@redhat.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <d3de1d27-25ac-be43-54d8-dcbfffa31e1d@redhat.com>
 <DM6PR19MB26364970D0981212E811E1B0FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <67ca316a-227f-80f6-ad22-7d08112b2584@redhat.com>
 <DM6PR19MB26368BB2B8C4D7CE58DF7C31FA230@DM6PR19MB2636.namprd19.prod.outlook.com>
 <5847917c-2c34-5d74-b5db-f33bb8fc9e13@redhat.com>
 <DM6PR19MB2636626A94385EDC7C0CACF9FA3E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <33666ec6-be47-2c33-d4c5-6b23b53f6185@redhat.com>
 <DM6PR19MB263615C1060108E5661AE615FA3A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <52fb287e-e683-63bc-3641-90abd78c605a@redhat.com>
Message-ID: <01c6632a-4e21-dfc0-c5d8-42a7016bfa16@redhat.com>
Date:   Tue, 22 Sep 2020 11:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <52fb287e-e683-63bc-3641-90abd78c605a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/22/20 10:57 AM, Hans de Goede wrote:
> Hi,
> 
> On 9/21/20 5:26 PM, Limonciello, Mario wrote:
> 
> <snip>
> 
> I will do another more detailed reply in another email, but I would like to focus
> at the main pain point here, which is the using a generic sysfs-ABI/class vs using
> a Dell specific sysfs-ABI.
> 
>>> I guess a could way to look at the generic sysfs firmware attributes
>>> class I'm proposing is looking at it as a lowest common denominator
>>> solution. With the addition of vendor specific extensions so that
>>> vendors (e.g. Dell) are not limited to only offering functionality
>>> offered by the generic, shared ABI. Does that make sense ?
>>>
>>> Regards,
>>>
>>
>> I really think that trying to fit all the vendors into the same interface is going
>> to stifle areas for innovation in the firmware and kernel space in the name of
>> "simplicity" which really only goes as far as the kernel side.  Userspace has
>> to carry delta between vendors no matter what, so why introduce a LCD then?
>>
>> Just as easily we could have:
>> /sys/devices/platform/dell-wmi-sysman/attributes/
>>
>> Which works 90% the same as:
>> /sys/devices/platform/lenovo-wmi-sysman/attributes/
> 
> So the reason why I want a class interface for this is to allow say
> FleetCommander to have a generic plugin implementing that 90%, so
> no deps, only support plain admin-password authentication.
> 
> Allowing such a generic plugin requires 2 things:
> 
> 1) Ensuring that the 90% overlapping functionality offers a 100%
> identical userspace ABI, thus a shared sysfs ABI definition
> 
> 2) That userspace has a generic way to enumerate devices/drivers
> implementing this shared sysfs ABI, and we have a standard
> mechanism for enumerating drivers which implement a standard ABI,
> that is we make them register class devices under /sys/class/<abi-name>.
> 
> I have not heard any convincing arguments against why would
> should not or can not have these 2 things. All I'm hearing is
> a vague fear that this may "stifle areas for innovation in the firmware
> and kernel space".
> 
> Honestly I have the feeling we are going in circles in this discussion
> and I really do not understand why you are so dead set against having
> a common sysfs ABI/class for this?
> 
> In part of the snipped text you write "Having to de-feature the sysfs
> interface", but I have not asked you to remove any features anywhere in
> this thread!
> 
> So I really do not understand where this fear of not being able to
> implement certain, possibly Dell specific, features comes from?
> 
> You mentioned that the way the dependencies are expressed are
> highly Dell specific, so I suggested allowing having vendor
> extensions like dell-modifiers and dell-value_modifiers. The whole
> idea behind allowing vendor-extensions is actually the exact
> opposite of de-featuring the sysfs interface.


So I've been thinking more about this and to me this whole argument
sounds a lot like we just want to have our own little corner to
play in, without needing to worry about what other vendors do.

And then Lenovo, and HP and who knows else will all want the same
and we and up with at least 5 different interfaces.

It is bad enough that we already have to deal with having 5+
different firmware interfaces for this and worse even for silly
things like setting the brightness level for the kbd backlight,
which is such a trivial thing that you would think PC vendors
should be able to sit down and agree on a single ACPI API for it.

We are NOT going to take this lets all do our own thing approach and
also let this trickle up in the stack to the kernel <-> userspace API!

One of the tasks of the kernel is to act as a HAL and this clearly
falls under that. Imagine if userspace code would need to use different
kernel APIs for storage/filesystem accesses depending on if they were
running on a Dell or a Lenovo machines. Or having different APIs to
access the network depending on the machine vendor...

So I'm sorry, but I'm drawing a line in the sand here, unless you can
come up with some really convincing NEW arguments why this needs to
be a Dell specific interface, the Dell firmware-attributes code must
use a generic sysfs-ABI/class to get accepted upstream.

Note that I think the currently suggested private Dell ABI is actually
pretty suitable for such a generic sysfs-ABI/class, so I'm not asking
you to make a lot of changes here.

Regards,

Hans

