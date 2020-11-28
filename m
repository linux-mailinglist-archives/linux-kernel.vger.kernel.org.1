Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB02C719E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390772AbgK1Vvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730994AbgK1Sqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606589119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOG1PEw7cXjSDVLm0frOBHIziQMwzgcOSI2ySbmS6LQ=;
        b=XeMS5wqcizEyyR7oARieF1FDQSEaQ8JIrUSSiWwhGcRNjcFoLNYgZUhjuBPu8Om1zZqwIk
        feBpdfD2cDrLyvTgpQG0+EmGK/SD6Rr+d7wJo/qiFYVPcBLj44/9ioufE1fg0P8k9OHt4D
        4/FlS2Srpqe4yRWTwJQ2FF4y+IPOwSw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-n0ee6ktvP-SwrRtn6a6JAg-1; Sat, 28 Nov 2020 05:43:24 -0500
X-MC-Unique: n0ee6ktvP-SwrRtn6a6JAg-1
Received: by mail-ej1-f70.google.com with SMTP id y23so3099249ejp.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 02:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOG1PEw7cXjSDVLm0frOBHIziQMwzgcOSI2ySbmS6LQ=;
        b=krf3bwbuTACmlw0V6x+XTMPk0zKZJovnYuDVVXfzVKM2zGu0mVu5iQfxOkstYW2Lie
         CWBReNTpUDF+8gNkdtWMZWRS7IEBXcedIGYgxQK391ack3JFtcus5dtemrkOV703InXe
         ATif4mCVbXWw17FgUpJH6db127XlX1ZoZM540j1uF8aF6Kpu2WBCnkdutf/shXiihzAA
         4RrG16KxqyHOJrX58Z4H1I/bm0Xa5xkw9ImByoLHS1xIn9Yel2TROeAThwWuJrSvSmFh
         JkGkZEX8XlROMH7+FBgWbvQDx4CLHIIMNaqzu3w6sgQ9/VuSplb2Py+ubLHyotTgxcT2
         m0RA==
X-Gm-Message-State: AOAM5308W9FLItcS66GjW8vPMA1RrZ2kSSlx9Z2TEHnwDA3ugU4gxJ9A
        Mrnw7I3VjbhbkmLKXPsSu7eKVXP7zwEj3qafNc3RypniCSyFxEUmPfHG6JLxNib9eQEQpyGTcA+
        GaqhtX4CCl8nzFFxMycxVS9F6
X-Received: by 2002:a05:6402:1714:: with SMTP id y20mr12701517edu.306.1606560203174;
        Sat, 28 Nov 2020 02:43:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+U5XpbHLZUjMy5NtlxgvOGgJl2y1xXiCB0jHm13k7iQXRLvVbwaS3AVMB7MU3TDS324BvUQ==
X-Received: by 2002:a05:6402:1714:: with SMTP id y20mr12701494edu.306.1606560202843;
        Sat, 28 Nov 2020 02:43:22 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t11sm5992608ejx.68.2020.11.28.02.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 02:43:22 -0800 (PST)
Subject: Re: 5.10 regression caused by: "uas: fix sdev->host->dma_dev": many
 XHCI swiotlb buffer is full / DMAR: Device bounce map failed errors on
 thunderbolt connected XHCI controller
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com>
 <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com>
 <20201124102715.GA16983@lst.de>
 <fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com>
 <8a52e868-0ca1-55b7-5ad2-ddb0cbb5e45d@redhat.com>
 <20201127161900.GA10986@lst.de>
 <fded04e2-f2e9-de92-ab1f-5aa088904e90@redhat.com>
 <CAGnHSEmyrw=r56ocLCkia+sYT0tmcCScZitBi=G+DY=gRBy+sg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
Date:   Sat, 28 Nov 2020 11:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAGnHSEmyrw=r56ocLCkia+sYT0tmcCScZitBi=G+DY=gRBy+sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 11/28/20 2:25 AM, Tom Yan wrote:
> Should we still be clamping max_sectors to dma_max_mapping_size(dev)
> (for now)? with dev being us->pusb_dev->bus->sysdev and
> devinfo->udev->bus->sysdev respectively (i.e. revert only
> scsi_add_host_with_dma() to scsi_add_host())?

I would expect that to work / avoid the regression, so yes that is
a good option.

If you can provide me with a patch doing that, then I can test it to
make sure it does indeed fix the regression.

Regards,

Hans


> 
> On Sat, 28 Nov 2020 at 02:12, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11/27/20 5:19 PM, Christoph Hellwig wrote:
>>> On Fri, Nov 27, 2020 at 01:32:16PM +0100, Hans de Goede wrote:
>>>> I ran some more tests, I can confirm that reverting:
>>>>
>>>> 5df7ef7d32fe "uas: bump hw_max_sectors to 2048 blocks for SS or faster drives"
>>>> 558033c2828f "uas: fix sdev->host->dma_dev"
>>>>
>>>> Makes the problem go away while running a 5.10 kernel. I also tried doubling
>>>> the swiotlb size by adding: swiotlb=65536 to the kernel commandline but that
>>>> does not help.
>>>>
>>>> Some more observations:
>>>>
>>>> 1. The usb-storage driver does not cause this issue, even though it has a
>>>> very similar change.
>>>>
>>>> 2. The problem does not happen until I plug an UAS decvice into the dock.
>>>>
>>>> 3. The problem continues to happen even after I unplug the UAS device and
>>>> rmmod the uas module
>>>>
>>>> 3. made me take a bit closer look to the troublesome commit, it passes:
>>>> udev->bus->sysdev, which I assume is the XHCI controller itself as device
>>>> to scsi_add_host_with_dma, which in turn seems to cause permanent changes
>>>> to the dma settings for the XHCI controller. I'm not all that familiar with
>>>> the DMA APIs but I'm getting the feeling that passing the actual XHCI-controller's
>>>> device as dma-device to scsi_add_host_with_dma is simply the wrong thing to
>>>> do; and that the intended effects (honor XHCI dma limits, but do not cause
>>>> any changes the XHCI dma settings) should be achieved differently.
>>>>
>>>> Note that if this is indeed wrong, the matching usb-storage change should
>>>> likely also be dropped.
>>>
>>> One problem in this area is that the clamping of the DMA size through
>>> dma_max_mapping_size mentioned in the commit log doesn't work when
>>> swiotlb is called from intel-iommu. I think we need to wire up those
>>> calls there as well.
>>
>> Ok, but that does not sound like a quick last minute fix for 5.10, so maybe
>> for 5.10 we should just revert the uas and usb-storage changes which trigger
>> this problem and then retry those for 5.11 ?
>>
>> Regards,
>>
>> Hans
>>
> 

