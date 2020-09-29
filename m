Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC86B27CE28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgI2Myf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728215AbgI2Mye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:54:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601384073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/euw2NTbhZNRcWonnu8YvB8q1SIMEfhGdmuOhO+OdUM=;
        b=G/nLZ0C/UXuGVoJZ/yMRC6JU8f08F9H4dyv4ZrKEEAESfa69r3uFMSNVDfhpHepWXGzWMo
        14wafb64HZmqpAPdwqntrHcWpE2Gi0TlYc3Z2QJAsot8x4EIZ64J3gt97ksknQHiHNXUuO
        ldwlTeviG7H+gIFpl35zMkyWt4f5Cfo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-lerg4RA7NKe9SuGAvQfolQ-1; Tue, 29 Sep 2020 08:54:28 -0400
X-MC-Unique: lerg4RA7NKe9SuGAvQfolQ-1
Received: by mail-ed1-f70.google.com with SMTP id x23so2116249eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/euw2NTbhZNRcWonnu8YvB8q1SIMEfhGdmuOhO+OdUM=;
        b=tC3xJGVwLbzqk+nWaVMDfVEmEoRgwbWIidgRO0s23F16ekeYs7/umt7XkNfPR9auiu
         Rj6ksss0tBKNmb1VgtesV+Z5nLlVe5P20/7f3DVbqYDyX7ZMTZKgRthGYsN3mViRvWX3
         kz2WUwRL7kLQy3HrUSBads8u5SP2PF/SL0GRogwBkIFHN4HeLkrYJ6qe+rLKq2DRIzQS
         2/YTuYlzo/+nO5pR1i6MltxI2+L89PPigLUb4QJmVQ768YrGZROsDx3rIoCx3QkiJTCZ
         wJW9wtc3xhiHV6xVqnieeDlE2z8zYDxABLNPjeJcVXJo8YbkEoXXnmsJfRB5jvAIXlZt
         jGHQ==
X-Gm-Message-State: AOAM5321BYo4IuL2lrqxoDZ932w1vh52bI1rwWZ2mBgsezmWxu9+89ou
        nB5dXQ8Gggcj2A6yQfOJe8d1QcuFXWZkyCpuenKv912ezPWMHHHNziYaFSOJSqpp7F6/zK69AIW
        +LNNqzIspSJ11F/hQSXybd9wN
X-Received: by 2002:a17:907:40c1:: with SMTP id nv1mr3887116ejb.318.1601384067250;
        Tue, 29 Sep 2020 05:54:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6HEZ2mer/Q5NIMsWzHR0huSfLY3vDGmC202vgbVvdQsdoG6QdmtdLwmyG/nrqtBkr/X1GzA==
X-Received: by 2002:a17:907:40c1:: with SMTP id nv1mr3887096ejb.318.1601384067073;
        Tue, 29 Sep 2020 05:54:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id bc18sm5861651edb.66.2020.09.29.05.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 05:54:26 -0700 (PDT)
Subject: Re: Keyboard regression by intel-vbtn
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
Date:   Tue, 29 Sep 2020 14:54:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/20 2:27 PM, Limonciello, Mario wrote:
>> I'm afraid that the only answer which I have to these questions
>> is not helpful, but in my experience it is true: "firmware sucks".
> 
> So FWIW there is a Dell 2-in-1 that has been conflated into this same issue.
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394

That is what a somewhat old kernel (5.0.0) which I guess may
lack your fix to check the chassis-type.

Interesting that this actually is a 2-in-1 though.

Also interesting that according to the reporter this was
triggered by a BIOS update.

If you by any chance can provide an acpidump with both the
1.2.0 and 1.4.0 BIOS versions that would be very interesting.

> Something that is confusing to me is that on the Windows side all these
> machines use the same Intel driver for this infrastructure no matter the
> OEM.
> So they can't possibly be putting in quirk specific stuff in the driver side
> can they?
> 
> It has to make you wonder if some baseline assumptions made in the
> driver early on around tablet mode support are completely false.

I'm not saying your wrong. If you can get Intel to provide
us with some documentation, or Windows driver source code
for this, then that would be great.

AFAICT the Linux driver currently is entirely based on
reverse engineering.

Regards,

Hans

