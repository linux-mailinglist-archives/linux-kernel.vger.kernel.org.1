Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207442E90A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbhADHAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:00:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbhADHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609743524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxdh5q0caEjSDWuCekQlHDQQh0mRUuamrqPDtKU99A0=;
        b=RkSz/Pk6tYDgO2MAkO+PVAetc0fw3CC7BISOf/LSvEX6IvohkoYPP3f8RtZFRret1PlDIY
        WMHcKTNDh23TN/2/kldOfj52GUvLSzhbx8jGsUYB3Bs83HEgH19ZEr35CXYoZ8puhkU2Te
        qB+8l+wHONqpEQR/cLPLbfdVVLYCiCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-SPEMtkpcMqCKWeZ2OvOlOQ-1; Mon, 04 Jan 2021 01:58:42 -0500
X-MC-Unique: SPEMtkpcMqCKWeZ2OvOlOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E940107ACE4;
        Mon,  4 Jan 2021 06:58:41 +0000 (UTC)
Received: from [10.72.13.91] (ovpn-13-91.pek2.redhat.com [10.72.13.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2618B60BE5;
        Mon,  4 Jan 2021 06:58:36 +0000 (UTC)
Subject: Re: [PATCH V2 00/19] vDPA driver for virtio-pci device
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
References: <20201204040353.21679-1-jasowang@redhat.com>
 <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
 <20210103073629-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5347a78d-fce4-f1dc-b4ed-9740e39ad56f@redhat.com>
Date:   Mon, 4 Jan 2021 14:58:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210103073629-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/3 下午8:37, Michael S. Tsirkin wrote:
> On Thu, Dec 31, 2020 at 11:52:14AM +0800, Jason Wang wrote:
>> On 2020/12/4 下午12:03, Jason Wang wrote:
>>> Hi all:
>>>
>>> This series tries to implement a vDPA driver for virtio-pci device
>>> which will bridge between vDPA bus and virtio-pci device.
>>>
>>> This could be used for future feature prototyping and testing.
>>>
>>> Please review
>>>
>>> Changes from V2:
>>>
>>> - don't try to use devres for virtio-pci core
>>> - tweak the commit log
>>> - split the patches furtherly to ease the reviewing
>>>
>>> Changes from V1:
>>>
>>> - Split common codes from virito-pci and share it with vDPA driver
>>> - Use dynamic id in order to be less confusing with virtio-pci driver
>>> - No feature whitelist, supporting any features (mq, config etc)
>>>
>>> Thanks
>>
>> Michael, any comment for this series?
>>
>> It's needed for testing doorbell mapping and config interrupt support.
>>
>> Thanks
> I saw you got some comments back in december so was expecting another
> version. If you'd rather I reviewed this one, let me know.


Right. So I've posted a new version that tries to address the previous 
comments.

Please review that version.

Thanks


>

