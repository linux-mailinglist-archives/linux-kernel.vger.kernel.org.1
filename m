Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BAF2C85B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgK3NiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbgK3NiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606743402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9JbBB2A7RKXT6r+Tdc668k94iLZr4WU1zIyHLKBU0Y=;
        b=iwbMzfMTwloyyGxi4Ch7V56/wM6z7uxXcEcUG8zXMlx3q1WEdBXtRXsbSC1YIT4tsFD/Lt
        2w+Xu/oGadvJ49Gq9ozsFVZK475dZwlQoo58Na88AriiFPVVUDXdPu20JSVGjkcvqe9t+I
        eQqfmMSV/7qUKNa5N/2tExdWAvjB5DI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-r9pGH-zXPiOfy8RX0eAaNA-1; Mon, 30 Nov 2020 08:36:41 -0500
X-MC-Unique: r9pGH-zXPiOfy8RX0eAaNA-1
Received: by mail-ej1-f72.google.com with SMTP id f2so5800026ejx.22
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q9JbBB2A7RKXT6r+Tdc668k94iLZr4WU1zIyHLKBU0Y=;
        b=YO9ETnZ8IpQX8UtWtTCKjtcCXcfyhd2/stkfNpL3lJxE2Ka947eGn+K839rmdBF+Nn
         PZvBQR+U/MrMuX0x6sHS6C6v/3JNKQZQxu95N54kOI6ktndVtk2tIMgc6BryXsFnsccX
         z14DpSamLF1DcTthuJKeA4ia+vni32WEi3SJDlb3IW2HWE40QtM/o5iHbyKA/ifwvve3
         amYeNs8RBfdKwCaV+0ElUlPT04WX5fQ9G/fNPmZhHotgIDudDugGOTV5n4tndkYgduSB
         e/mJUi82GA+Faer/fPg1B6RhxxxFUBhmZhyJTQq1W7hXMpixoW+FpxnHNAz/D3KuRYqD
         Rydg==
X-Gm-Message-State: AOAM530tInDARW7SaXE0buwNBT2QTVYr2PR6QLaQuSXIuSHUtjeHcjPs
        1oxeW5bx4XYwAC7wPyOAdeD2LmAzIajy/9GTHYASjrHKrtNqM9sY51LZZK68kakjeJ4hTAAhDNV
        rKJA2ZDXKRa0TLEkuwd4O0qNS
X-Received: by 2002:a17:906:5609:: with SMTP id f9mr8831121ejq.535.1606743399840;
        Mon, 30 Nov 2020 05:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5mfLtnxz7qBhLC9okDROTxfIFdoHVpU+wO1LzztHlLZ97RDP+W+0qNE61l1UYE22GzJnORQ==
X-Received: by 2002:a17:906:5609:: with SMTP id f9mr8831103ejq.535.1606743399647;
        Mon, 30 Nov 2020 05:36:39 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a12sm9009835edu.89.2020.11.30.05.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 05:36:38 -0800 (PST)
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to
 scsi_add_host()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tom Yan <tom.ty89@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com>
Date:   Mon, 30 Nov 2020 14:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8T0E2qvF2cgADl+@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/20 2:30 PM, Greg KH wrote:
> On Mon, Nov 30, 2020 at 02:23:48PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/30/20 1:58 PM, Tom Yan wrote:
>>> It's merely a moving of comment moving for/and a no-behavioral-change
>>> adaptation for the reversion.>
>>
>> IMHO the revert of the troublesome commit and the other/new changes really
>> should be 2 separate commits. But I will let Alan and Greg have the final
>> verdict on this.
> 
> I would prefer to just revert the commits and not do anything
> different/special here so late in the release cycle.
> 
> So, if Alan agrees, I'll be glad to do them on my end, I just need the
> commit ids for them.

The troublesome commit are (in reverse, so revert, order):

5df7ef7d32fe ("uas: bump hw_max_sectors to 2048 blocks for SS or faster drives")
558033c2828f ("uas: fix sdev->host->dma_dev")
0154012f8018 ("usb-storage: fix sdev->host->dma_dev")

Alan, the reason for reverting these is that using scsi_add_host_with_dma() as the
last 2 patches do, with the dmadev argument of that call pointing to the device
for the XHCI controller is causing changes to the DMA settings of the XHCI controller
itself which is causing regressions in 5.10, see this email thread:

https://lore.kernel.org/linux-usb/fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com/T/#t

Regards,

Hans

