Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B962D0972
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 04:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgLGDbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 22:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728561AbgLGDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 22:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607311780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXUkdR17CT0/PFeXaHlete1OGprY+UB5Y5Uzoc4vxP8=;
        b=B1mhJO1p4VM8lXA7jll7+cPnkBpAe0r688HFHUJ8PJZM00WP6r1A/vz5ZvbnTfSK19I7c2
        7aR8N01guDtcTgT2D/bsPZPH/YzcpcyuFCBzbpIjKHDy+GXYVufHwO5wKfXDvYuPNQso2M
        09wJDz6rajwLU+T5Fu9XSlKG71GLMyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-2EmvEE_XM2SYGv0V3U7eKg-1; Sun, 06 Dec 2020 22:29:38 -0500
X-MC-Unique: 2EmvEE_XM2SYGv0V3U7eKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53571107ACE4;
        Mon,  7 Dec 2020 03:29:37 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8C7860CED;
        Mon,  7 Dec 2020 03:29:31 +0000 (UTC)
Subject: Re: [PATCH V2 19/19] vdpa: introduce virtio pci driver
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-20-jasowang@redhat.com>
 <20201204152043.ewqlwviaf33wwiyx@steredhat>
 <73a1c314-7398-6182-146f-cd2012646736@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d7ae5645-9437-2f03-b0c8-35c1812747d2@redhat.com>
Date:   Mon, 7 Dec 2020 11:29:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <73a1c314-7398-6182-146f-cd2012646736@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/5 上午1:12, Randy Dunlap wrote:
> On 12/4/20 7:20 AM, Stefano Garzarella wrote:
>> On Fri, Dec 04, 2020 at 12:03:53PM +0800, Jason Wang wrote:
>>> This patch introduce a vDPA driver for virtio-pci device. It bridges
>>> the virtio-pci control command to the vDPA bus. This will be used for
>>> features prototyping and testing.
>>>
>>> Note that get/restore virtqueue state is not supported which needs
>>> extension on the virtio specification.
>>>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>> drivers/vdpa/Kconfig              |   6 +
>>> drivers/vdpa/Makefile             |   1 +
>>> drivers/vdpa/virtio_pci/Makefile  |   2 +
>>> drivers/vdpa/virtio_pci/vp_vdpa.c | 455 ++++++++++++++++++++++++++++++
>>> 4 files changed, 464 insertions(+)
>>> create mode 100644 drivers/vdpa/virtio_pci/Makefile
>>> create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
>>>
>>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>>> index 358f6048dd3c..18cad14f533e 100644
>>> --- a/drivers/vdpa/Kconfig
>>> +++ b/drivers/vdpa/Kconfig
>>> @@ -48,4 +48,10 @@ config MLX5_VDPA_NET
>>>        be executed by the hardware. It also supports a variety of stateless
>>>        offloads depending on the actual device used and firmware version.
>>>
>>> +config VP_VDPA
>>> +    tristate "Virtio PCI bridge vDPA driver"
>>> +    depends on PCI_MSI && VIRTIO_PCI_MODERN
>>> +    help
>>> +      This kernel module that bridges virtio PCI device to vDPA bus.
>>                               ^
>> Without 'that' maybe sound better, but I'm not a native speaker :-)
> Yes, drop 'that', please.


Will fix.

Thanks


>
>>> +
>>> endif # VDPA

