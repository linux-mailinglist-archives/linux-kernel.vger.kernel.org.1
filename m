Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3690287C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgJHTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgJHTne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602186212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOtFHzdgOPYEPQlpsFHGlFvhk+BmuqanWqZYZHmYBJ4=;
        b=ZOhME7pdSpml+cznn8821LrxOwS60jN3dVAeMpHx/ZrV6X3/RheiEOkgwBbaPDmfOCqgq0
        IKzaujcepjRKuP1LNnCpAccRSbxVWyRUXXpNFGWuuyP88obHr51VoJygtlDYf+8nyovyHA
        LIfJpoUBTi9KlU6Vq3GbnRZHGnR2PL8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Xx4BIQm8M5GJyG4MMH4Njg-1; Thu, 08 Oct 2020 15:43:30 -0400
X-MC-Unique: Xx4BIQm8M5GJyG4MMH4Njg-1
Received: by mail-ej1-f72.google.com with SMTP id k23so2655069ejx.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NOtFHzdgOPYEPQlpsFHGlFvhk+BmuqanWqZYZHmYBJ4=;
        b=pHNlt2rB8qaq82NJTUrofwyrNSXwjpKbAZxUN9df2hsPWUIwQST5bbDANroT882Ah9
         ScnLa1bmtkHWEHqfJR642wKd9LUnz7FRC4Iz/HOu+rSi0XWDtBU5UhsoH7v4frH2VyCJ
         ofZMzud/Ufsr/OInNBViLxg0NmgJ3W1Hdkf3NhuGrdSAKEbBKhDMNidEiRNAqWcwYLYq
         7VwmEqWnITxGzCoi4pdxaa/e/qM0udqcUa8VIpI8NVIpgIupkmH6eaPlOE63P97RnIcV
         oVmbQUEIfZIxY3qLGeR/Pso4feLcr8thZ5SLm5z1hBD4Ztkmj/ep1+DXJA3VHLR/4oHV
         WSNw==
X-Gm-Message-State: AOAM530hKNE1iM/nhm5IE5b2LygwQ1PH+6BJwLI10muyFO1KA7fm9HFm
        mEMmG85MsTOHY1X8jI3w/inCA8HWuZuuadcjWZZsb9US/BGj6BfoORZvNqVBaKRpqtrfpKSCzgm
        mJluW3FjLtb68lqacIWpRkjtq
X-Received: by 2002:a17:906:5613:: with SMTP id f19mr10253877ejq.441.1602186209033;
        Thu, 08 Oct 2020 12:43:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZD/2+q+cwyMjqyHZTVAEzHh9PzliQ1g6A79cs0ikR6wi+vFb7Sl1H62w4QH+L0aTf2IXAew==
X-Received: by 2002:a17:906:5613:: with SMTP id f19mr10253856ejq.441.1602186208806;
        Thu, 08 Oct 2020 12:43:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id f20sm4668479ejc.90.2020.10.08.12.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 12:43:28 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] platform: Add Surface platform directory
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
 <20201008143455.340599-2-luzmaximilian@gmail.com>
 <CAHp75Vd61qnLMUbted_ohqEtMdVFbqKhKf3kKh0ombAwhf8dCA@mail.gmail.com>
 <9711c3c9-63ed-8c9f-b77b-d1feb2c07f78@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a76d53a7-4489-fac2-443b-2dfccc2ea802@redhat.com>
Date:   Thu, 8 Oct 2020 21:43:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9711c3c9-63ed-8c9f-b77b-d1feb2c07f78@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/20 5:18 PM, Maximilian Luz wrote:
> On 10/8/20 4:52 PM, Andy Shevchenko wrote:
>> On Thu, Oct 8, 2020 at 5:35 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>
>>> It may make sense to split the Microsoft Surface hardware platform
>>> drivers out to a separate subdirectory, since some of it may be shared
>>> between ARM and x86 in the future (regarding devices like the Surface
>>> Pro X).
>>>
>>> Further, newer Surface devices will require additional platform drivers
>>> for fundamental support (mostly regarding their embedded controller),
>>> which may also warrant this split from a size perspective.
>>>
>>> This commit introduces a new platform/surface subdirectory for the
>>> Surface device family, with subsequent commits moving existing Surface
>>> drivers over from platform/x86.
>>>
>>> A new MAINTAINERS entry is added for this directory. Patches to files in
>>> this directory will be taken up by the platform-drivers-x86 team (i.e.
>>> Hans de Goede and Mark Gross) after they have been reviewed by
>>> Maximilian Luz.
>>
>> Thanks for the patch, my minor comments below.
>>
>> ...
>>
>>> +MICROSOFT SURFACE PLATFORM DRIVERS
>>
>> (1)
>>
>>> +M:     Hans de Goede <hdegoede@redhat.com>
>>> +M:     Mark Gross <mgross@linux.intel.com>
>>> +M:     Maximilian Luz <luzmaximilian@gmail.com>
>>> +L:     platform-driver-x86@vger.kernel.org
>>> +S:     Maintained
>>
>>> +T:     git git://git.infradead.org/linux-platform-drivers-x86.git
>>
>> It's now on kernel.org.
>> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> 
> Thank you, will update this. FYI: The entry was mostly copied from the
> X86 PLATFORM DRIVERS entry, so it should probably be updated there, too.

That is a good point I've pushed a commit fixing this to the for-next
branch of: git://git.infradead.org/linux-platform-drivers-x86.git

Please base the next version of this patch-set on top of that.

Regards,

Hans



> 
>>> +F:     drivers/platform/surface/
>>
>>> @@ -9,3 +9,4 @@ obj-$(CONFIG_MIPS)              += mips/
>>>   obj-$(CONFIG_OLPC_EC)          += olpc/
>>>   obj-$(CONFIG_GOLDFISH)         += goldfish/
>>>   obj-$(CONFIG_CHROME_PLATFORMS) += chrome/
>>> +obj-$(CONFIG_SURFACE_PLATFORM) += surface/
>>
>> (2)
>>
>>> +menuconfig SURFACE_PLATFORM
>>
>> (3a)
>>
>>> +if SURFACE_PLATFORM
>>
>> (3b)
>>
>>> +endif # SURFACE_PLATFORM
>>
>> (3c)
>>
>> I think in (1), (2) and (3) it makes sense to mimic Chrome, i.e. use
>> plural: PLATFORMS.
> 
> I agree with (2) and (3), but I'm not so sure about (1). For Chrome, the
> entry is CHROME HARDWARE PLATFORM SUPPORT, so should I change it to
> MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT?
> 
> Thanks,
> Max
> 

