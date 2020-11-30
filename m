Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6122C8C91
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgK3SUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729604AbgK3SUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606760347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpk6I40VopO59OgCMYgesz1THx7bQXJvIwP+xEc7HEQ=;
        b=h3k08JvwLZunGGFGNPjsnbRenBLbom/wjIZmjz8+DYFVrrNYB7b0vbvUiV4cBZAb+Uhz+C
        AEUCviMWb7ofpU88fQFVw2KrphVXCrEoz+rbEBOeh98ffS/ZKS9F6odxjeUgnw6uLLNiaR
        X7FdBea05PIQKTDE6nK2UepDxFhjyJ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-5W237G14O6iJ1wa2yxNFYw-1; Mon, 30 Nov 2020 13:19:05 -0500
X-MC-Unique: 5W237G14O6iJ1wa2yxNFYw-1
Received: by mail-ej1-f70.google.com with SMTP id y10so6181414ejg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vpk6I40VopO59OgCMYgesz1THx7bQXJvIwP+xEc7HEQ=;
        b=N+3xJERqPREnmjM1C6LNYu1nk/wetQ4OQjc4In9jx9D4dzzj9bioStwDWrn3gJpD/f
         ocSHBzp4isaY4NnTLj4i6JzNquZoiexXW8jcrJoV38N4ADFDHEuSZQRMZpPPyA3LjQud
         4MMf66/WXHBwdSL5Bj84kwU8Ao5IUMV+gGIfBi+8AtpDmDqrqspBpqiaspz0xRX66cP2
         eAkqKff6mIY3rK3Cen7u6SPyBF19fGu6MhJS9cuOhh4h2r1NeswfUkiLSWI4eHuz8V4n
         7ShMOCQ1fheWVUhFqBuTYUecfJf83jj1BKyjbHZy6mc+0uVvD5yBEcqMy77EXqxBPJOr
         Wykg==
X-Gm-Message-State: AOAM5309tAZNNIKv0p0jzNiK/NFUIsJalBXec4IXotwcagLIq8/rLHBt
        +Uhl6Kk436aGNaDBcKRVFxwaJQzbGt9W2mELZ9tHy7IZC0+FP8isUKXWX67k5s/0FN/xVjZ9bie
        gdFuUZjMzCRPrsA0FhdacQNym
X-Received: by 2002:a50:da84:: with SMTP id q4mr22690800edj.377.1606760339752;
        Mon, 30 Nov 2020 10:18:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7e7Ny+dw3Vzt5jfmMjutla+i8r+BmbQoRbN9bFKPNsr2tG0kTRoVsYpfwnF7+UlTe+2pGXg==
X-Received: by 2002:a50:da84:: with SMTP id q4mr22690625edj.377.1606760337762;
        Mon, 30 Nov 2020 10:18:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id pj5sm6029636ejb.60.2020.11.30.10.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:18:56 -0800 (PST)
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to
 scsi_add_host()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Tom Yan <tom.ty89@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com>
 <20201128154849.3193-2-tom.ty89@gmail.com>
 <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com>
 <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com>
 <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com>
 <X8T0E2qvF2cgADl+@kroah.com>
 <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com>
 <20201130172004.GA966032@rowland.harvard.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <abb0a79d-63a0-6f3d-4812-f828283cd47c@redhat.com>
Date:   Mon, 30 Nov 2020 19:18:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130172004.GA966032@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/20 6:20 PM, Alan Stern wrote:
> On Mon, Nov 30, 2020 at 02:36:38PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/30/20 2:30 PM, Greg KH wrote:
>>> On Mon, Nov 30, 2020 at 02:23:48PM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 11/30/20 1:58 PM, Tom Yan wrote:
>>>>> It's merely a moving of comment moving for/and a no-behavioral-change
>>>>> adaptation for the reversion.>
>>>>
>>>> IMHO the revert of the troublesome commit and the other/new changes really
>>>> should be 2 separate commits. But I will let Alan and Greg have the final
>>>> verdict on this.
>>>
>>> I would prefer to just revert the commits and not do anything
>>> different/special here so late in the release cycle.
>>>
>>> So, if Alan agrees, I'll be glad to do them on my end, I just need the
>>> commit ids for them.
>>
>> The troublesome commit are (in reverse, so revert, order):
>>
>> 5df7ef7d32fe ("uas: bump hw_max_sectors to 2048 blocks for SS or faster drives")
>> 558033c2828f ("uas: fix sdev->host->dma_dev")
>> 0154012f8018 ("usb-storage: fix sdev->host->dma_dev")
>>
>> Alan, the reason for reverting these is that using scsi_add_host_with_dma() as the
>> last 2 patches do, with the dmadev argument of that call pointing to the device
>> for the XHCI controller is causing changes to the DMA settings of the XHCI controller
>> itself which is causing regressions in 5.10, see this email thread:
>>
>> https://lore.kernel.org/linux-usb/fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com/T/#t
> 
> It's hard to go wrong with reverting, so it's okay with me.
> 
> Still, Hans, have you checked out the difference between the 
> scsi_add_host() and scsi_add_host_with_dma() calls?  It's just a matter 
> of using dev vs. sysdev.  In particular, have you checked to see what 
> those two devices are on your system?

Its not just dev vs sysdev, its iface->dev vs bus->sysdev, and I assume
that the latter is actually the XHCI controller.

my vote goes to reverting to avoid the regression for 5.10, esp. since
this is a clean revert of 3 patches with nothing depending / building
on top of the reverted commits.

Then for 5.11 we can retry to introduce similar changes. I would be happy
to try a new patch-set for 5.11.

> It seems likely that if one of those calls messes up some DMA settings, 
> the other one does too -- just maybe not settings that matter much.

I'm not very familiar with all the DMA mapping / mask code, but AFAIK making
changes to the DMA settings of a child will not influence the parent.

Where as when passing bus->sysdev, then changes are made to a device
which is shared with other devices on the bus, which is why we see
a regression in an USB NIC driver being triggered by the UAS driver
binding to a device (on the same bus).

At least that is my interpretation of this. I bisected the regression
and that pointed at the UAS DMA change and reverting it fixes things,
confirming that I did not make any mistakes during the bisect.

Regards,

Hans

