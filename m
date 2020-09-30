Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0181E27E9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgI3N2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730291AbgI3N2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:28:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601472513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwsmrlImp+czkMthhLY8nFtQJpZkIffNyd59jUo1WJM=;
        b=U5cxtpCsUErLhcQa1LwOXjM4O/g5nyhzZltkdA4eyZ37SaRp0quf22x1Qni2nsNJXW7+s1
        TgvxpsTgO+DHXSJEcC1pYCt6vXwrhU7xI3ryaIpSdCe+MjZT96xlP7KyJqYyUGz342nkr3
        zNEqK9JH5pQEVZBdhZBagbVdL6SprK0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-93yT87loMZ6EEOVipoZYNw-1; Wed, 30 Sep 2020 09:28:26 -0400
X-MC-Unique: 93yT87loMZ6EEOVipoZYNw-1
Received: by mail-ej1-f71.google.com with SMTP id i14so812806ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jwsmrlImp+czkMthhLY8nFtQJpZkIffNyd59jUo1WJM=;
        b=gfKPVop3QyRfS1JeiIyKxPlIdodD6Oze0oThSzt2rZRX/a4UNHxuW5fYuVVybnH6HP
         uf8x8USz28ipw2gtWHkUi18S9KvkBPEDRWQNOVuPmzvufd5pbHQv+iQQn0bN6DSLaoCB
         Pn0bJV/gyVwRXEXglTaTb1WRQKfYHFeMbTeSyRHEu9Gc1Bf0x2VjYhOQz/1eAsTyaV9P
         Q0uolZlm3aicC1Utxhm8m6ssqhK7o+tBzmxu1L0nSu42xXFEhjdI1Fc3ukbLenc4Ktlg
         QrmWWYDO5tvr1Uq3U6A/SJvnX69IfPECVlyKSVZp0Q0RzSKPw7/DzfgG4kw1BTPlNztQ
         eSqQ==
X-Gm-Message-State: AOAM5308xwIT822Mvc0oiQ5M2AkWu7z5pvNJ+42/VPmj8daQ779bxzwZ
        hfZQemcDwlEhsS5HliW5NhiLYf87eduOxiXx2owcBlxLpbHvk/X4C3glZXZ7UlybJiplXE1We5B
        ED6JoajQD8mGrQ+ywasyBhfdr
X-Received: by 2002:a17:907:70cb:: with SMTP id yk11mr2772001ejb.312.1601472504829;
        Wed, 30 Sep 2020 06:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymhuQX2sG+sxYzTgCQxPCAD4hXIxnUUvRY5D6DzKtz4gOpYp/UHbqMkil03xOmN+ZD4UvYrA==
X-Received: by 2002:a17:907:70cb:: with SMTP id yk11mr2771992ejb.312.1601472504665;
        Wed, 30 Sep 2020 06:28:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p17sm1613919edw.10.2020.09.30.06.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 06:28:23 -0700 (PDT)
Subject: Re: Keyboard regression by intel-vbtn
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
 <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <DM6PR19MB2636BD25C7C828D28CF27CC8FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fce9f346-5c02-0997-216a-14ab6c8b336d@redhat.com>
Date:   Wed, 30 Sep 2020 15:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636BD25C7C828D28CF27CC8FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/20 10:47 PM, Limonciello, Mario wrote:
>>
>> I requested on the Ubuntu bug for someone to provide these.
>>
> 
> Joe Barnett was kind enough to share two ACPI dumps to compare.
> Not affected:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/5415318/+files/1.2.0.acpidump
> 
> Affected:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/5415405/+files/1.13.0.acpidump

Thank you, I took a look at these (before completing my allow-list fix),
but there is not really much which stands out. The only related thing which
stands out is that the 1.13.0 dsdt.dsl has this new bit:


                             Case (0x08)
                             {
                                 Return (^^PCI0.LPCB.H_EC.VGBI.VGBS ())
                             }

Inside the _DSM of the HIDD / INT33D5 device.

             Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
             {
                 If ((Arg0 == ToUUID ("eeec56b3-4442-408f-a792-4edd4d758054")))


What is interesting here is that the PCI0.LPCB.H_EC.VGBI.VGBS object/method
does not actually exist the correct path is:

^^PCI0.LPCB.ECDV.VGBI.VGBS

So this does suggest that something around the VGBS handling changed
(and since it points to a non existing ACPI object, possibly broke)
in the newer BIOS version. But what exactly is going on on this XPS 2-in-1
cannot really be derived from the acpidumps.

Regards,

Hans

