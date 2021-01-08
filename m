Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B322EF4CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbhAHP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbhAHP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610119582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d03zzoK0AP7+qCnRqk4XgaLdD3Fz2REpjExGQLDAxDw=;
        b=eyVRhjo5+sb9TOtbNSA12Ry6ZZcarQDNfs8xndrG+dES2TnbpgGzUHwKtuPBiRiEu79sG/
        PYd1mWaUqqawoKFhL1RJzT54PM7DCKJ80EMI80JmjQEx6+SoJr3mn24Kd++7v9qkwSW4sS
        xcaYfZw6Cq8UiOKhB3GK1MPF8nuMi1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-X8x85T71NY-aJGLKbBZIUQ-1; Fri, 08 Jan 2021 10:26:20 -0500
X-MC-Unique: X8x85T71NY-aJGLKbBZIUQ-1
Received: by mail-wr1-f69.google.com with SMTP id q18so4294425wrc.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 07:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d03zzoK0AP7+qCnRqk4XgaLdD3Fz2REpjExGQLDAxDw=;
        b=uImorCzXBQWhzW3t6xCWByd85fRlMaAtxqY9tKDVzgCo4jPOpaIkCFidoK5Ve6ss2J
         NHQjBKKFv2x5RvbU4QeFeEx1rhpZWmFbRpT+bTbzu+VaXosXvmH52ZcriuDdfYx2mGsK
         ABzVf4lmZudiHQD0DBnzTAGry7FfPAjvZZ/v2OUT6i7UtKYQCL1H2BnAWATjBlh50cWe
         WcAc4i2h3HkCTzu+b72u5yoWUWfYlTIR4XSSTz7zERdtAdvZ+Cai+NGc7cEDsAL/Cf+N
         FqpEspOJG0ZXesMVJXL2SlJvuPci8tg2ZzXBqchrtUlzcpeS1YB+3zg4y6yEmIwSggHd
         0/Qw==
X-Gm-Message-State: AOAM533UW9qXX6QcxZ+xtaknafDlhPp80EyCsLEZlTfM0gRziHasp8Be
        eGglhk028sM/Tr6kJ94rcYlaDEMLsckTNJkN4YUojzCzZpXaK3sdH50+wa88SCnbvhGiFF927Qb
        NGxWU6LH5fdoR/Bl9suEJ/z2N34DyJk/onGEaTYgzwWvxTcx8ZYhRcNi8tsZex/ntRItO33B5Mg
        a5
X-Received: by 2002:adf:9506:: with SMTP id 6mr4152796wrs.172.1610119579057;
        Fri, 08 Jan 2021 07:26:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOg7EK2k3qZTFesKem/W1prShdoue3owWxOQeEeYtngiInCTcSpC3RBqhm2eqwJwESXofK3Q==
X-Received: by 2002:adf:9506:: with SMTP id 6mr4152769wrs.172.1610119578754;
        Fri, 08 Jan 2021 07:26:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q1sm13689647wrj.8.2021.01.08.07.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:26:18 -0800 (PST)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-3-pizhenwei@bytedance.com>
 <X/hnF0W+TMj36LDN@kroah.com>
 <58eca97c-f72e-66a7-2696-611124ce0943@redhat.com>
 <X/h3BAdea48p+L+p@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/2] misc: pvpanic: introduce module parameter 'events'
Message-ID: <2729803e-c9b2-abc9-e93f-ace19f521945@redhat.com>
Date:   Fri, 8 Jan 2021 16:26:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/h3BAdea48p+L+p@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 16:15, Greg KH wrote:
> On Fri, Jan 08, 2021 at 04:04:24PM +0100, Paolo Bonzini wrote:
>> On 08/01/21 15:07, Greg KH wrote:
>>>>    static void __iomem *base;
>>>> +static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>>>> +module_param(events, uint, 0644);
>>>> +MODULE_PARM_DESC(events, "set event limitation of pvpanic device");
>>> I do not understand you wanting a module parameter as well as a sysfs
>>> file.  Why is this needed?  Why are you spreading this information out
>>> across different apis and locations?
>>
>> It can be useful to disable some functionality, for example in case you want
>> to fake running on an older virtualization host.  This can be done for
>> debugging reasons, or to keep uniform handling across a fleet that is
>> running different versions of QEMU.
> 
> And where is this all going to be documented?

I don't disagree.

> And what's wrong with just making the sysfs attribute writable?

Isn't it harder to configure it at boot?  Also the sysfs attribute added 
by patch 1 is documenting what is supported by the device, while the 
module parameter can be set to any value (you can think of the module 
parameter as of a "what to log" option, except the logging happens on 
another machine).

Therefore, if you make the sysfs attribute writable, you would actually 
need _two_ attributes, one for the in-use capabilities and one for the 
device capabilities.  And sysfs files are runtime values, which is 
different concept than 0444 module parameters (which are more like just 
configuration).  So you would have to decide whether it's valid to write 
2 to the in-use capabilities file when the device capabilities are "1", 
and I don't really have a good answer for that.

Also considering that there will not be more than one copy of this 
device (it doesn't make sense as they would all do exactly the same 
thing), in this case a module parameter really seems to be the simplest 
way to configure it.

Paolo

