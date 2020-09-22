Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB461273DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIVI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgIVI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600765059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0oVV0fojO69JgJ5jRZtGVqDd85RbY/OL+2VLqFLwOgg=;
        b=CcC3UVCV2pv9qRg1/Yw+DoTM9BJqjr//HfvyXcUMMNnkJsV3d1jXDa5nAE/aAgS38weI1R
        XauxwJpfKSL+OULBE5psZiB6VY4O3t4KAZTwZ3fMCON1k74atWZRTEXa+3kba4Ge1wdjOD
        Ph6q2tv1KbCEgEVSnhZukmW8T6mYKZI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-u-ZpzqgoNLi8kbjgcy8jaQ-1; Tue, 22 Sep 2020 04:57:37 -0400
X-MC-Unique: u-ZpzqgoNLi8kbjgcy8jaQ-1
Received: by mail-ej1-f70.google.com with SMTP id j2so5937242ejm.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 01:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0oVV0fojO69JgJ5jRZtGVqDd85RbY/OL+2VLqFLwOgg=;
        b=FTErw97nGIbipndL17LBjBU+X87dZ3fIEYz4GNNmgl87MOR3V/6ESTGhWl3FvlXmzW
         +FU6bdqv9gLElGoSVbPASPAFVccL0iBEG/AYZb5Cb3mt3j5Kb6C89rQqraicre3qhx8a
         +F+flauKHTUDTRlLJ+u3jCw0b7KXz3X7fd408gKTiD5NoitU8uvL/0KsQ06LxQ2wJyJs
         wOAmQClgoEQL8HCuuKNkY38mio5Fhalz+WonGmB/YLO4l0cW6zrvpptyRGVcm+lWNNmc
         QBiR0cOOcAWcnTA30oYdv1pa8KuOYWDABjN8kDlR92Rnr1bySPMTgezrWItlDHGmy/J+
         iGDQ==
X-Gm-Message-State: AOAM533TKUYLRq+2eJgDQBLvrOQK+jg6KESyaTWE1h+FJm3VOJbnDjT2
        Y/KzG1THJo4TbCKElAv8AurhWeROjm0RMu2lghqfI6xz2+eI4wOif7Xu/Ihjyx3VQKHq0CWyeFW
        rEN8ayglXwCIZia2RquejHWsx
X-Received: by 2002:aa7:d648:: with SMTP id v8mr2894643edr.159.1600765055947;
        Tue, 22 Sep 2020 01:57:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuxQXjI9QlbRwMjIZdysB07FPwhUX4B5mTN4FFl5kOQFFOiWTxYH9zzy+6YvjGrinto7sYSg==
X-Received: by 2002:aa7:d648:: with SMTP id v8mr2894628edr.159.1600765055721;
        Tue, 22 Sep 2020 01:57:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r10sm7407795ejb.99.2020.09.22.01.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 01:57:34 -0700 (PDT)
Subject: Re: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <52fb287e-e683-63bc-3641-90abd78c605a@redhat.com>
Date:   Tue, 22 Sep 2020 10:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB263615C1060108E5661AE615FA3A0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/20 5:26 PM, Limonciello, Mario wrote:

<snip>

I will do another more detailed reply in another email, but I would like to focus
at the main pain point here, which is the using a generic sysfs-ABI/class vs using
a Dell specific sysfs-ABI.

>> I guess a could way to look at the generic sysfs firmware attributes
>> class I'm proposing is looking at it as a lowest common denominator
>> solution. With the addition of vendor specific extensions so that
>> vendors (e.g. Dell) are not limited to only offering functionality
>> offered by the generic, shared ABI. Does that make sense ?
>>
>> Regards,
>>
> 
> I really think that trying to fit all the vendors into the same interface is going
> to stifle areas for innovation in the firmware and kernel space in the name of
> "simplicity" which really only goes as far as the kernel side.  Userspace has
> to carry delta between vendors no matter what, so why introduce a LCD then?
> 
> Just as easily we could have:
> /sys/devices/platform/dell-wmi-sysman/attributes/
> 
> Which works 90% the same as:
> /sys/devices/platform/lenovo-wmi-sysman/attributes/

So the reason why I want a class interface for this is to allow say
FleetCommander to have a generic plugin implementing that 90%, so
no deps, only support plain admin-password authentication.

Allowing such a generic plugin requires 2 things:

1) Ensuring that the 90% overlapping functionality offers a 100%
identical userspace ABI, thus a shared sysfs ABI definition

2) That userspace has a generic way to enumerate devices/drivers
implementing this shared sysfs ABI, and we have a standard
mechanism for enumerating drivers which implement a standard ABI,
that is we make them register class devices under /sys/class/<abi-name>.

I have not heard any convincing arguments against why would
should not or can not have these 2 things. All I'm hearing is
a vague fear that this may "stifle areas for innovation in the firmware
and kernel space".

Honestly I have the feeling we are going in circles in this discussion
and I really do not understand why you are so dead set against having
a common sysfs ABI/class for this?

In part of the snipped text you write "Having to de-feature the sysfs
interface", but I have not asked you to remove any features anywhere in
this thread!

So I really do not understand where this fear of not being able to
implement certain, possibly Dell specific, features comes from?

You mentioned that the way the dependencies are expressed are
highly Dell specific, so I suggested allowing having vendor
extensions like dell-modifiers and dell-value_modifiers. The whole
idea behind allowing vendor-extensions is actually the exact
opposite of de-featuring the sysfs interface.

Regards,

Hans

