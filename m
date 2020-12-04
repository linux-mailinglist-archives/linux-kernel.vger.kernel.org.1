Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63F92CF2E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgLDRNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgLDRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:13:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D9EC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Uudat3NMCrNIXj1FEuY9SUz/r7syzJ3sbnmnSODxAJg=; b=gIHWQ/mbkOj0QUxq4EXZ66shiW
        IkpsaN4EDANDPQ2SbTsuPA2/NsLd8l6BKwyAabcflmOWv+pZxHqFz0nGS3Xzt236S2IKjMyXbfndg
        B7QgVbWkNpreXf14D4nlCDrv6llYjiHV2bdssCKvmK65JRMicxO3gDcvTnBxx8qzhIrmSzw+ios4g
        w4jQRQPbhmcUVgNV4t1x7yMvIASZZKE5hiwRfbq291Y5kn+BFWh1S0gfksj7VnSCuNaFk4evm+9RE
        6Pb9fdkJLSR5mvTg5GMexDd3kSLtHPoa0+Ni+vv5nXaDyNA6tIWUMH+M4w3Ehcr+OMsCl4VMNJNY5
        DEgP0/Eg==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klEdi-0003Dt-Vh; Fri, 04 Dec 2020 17:13:03 +0000
Subject: Re: [PATCH V2 19/19] vdpa: introduce virtio pci driver
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-20-jasowang@redhat.com>
 <20201204152043.ewqlwviaf33wwiyx@steredhat>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <73a1c314-7398-6182-146f-cd2012646736@infradead.org>
Date:   Fri, 4 Dec 2020 09:12:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204152043.ewqlwviaf33wwiyx@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/20 7:20 AM, Stefano Garzarella wrote:
> On Fri, Dec 04, 2020 at 12:03:53PM +0800, Jason Wang wrote:
>> This patch introduce a vDPA driver for virtio-pci device. It bridges
>> the virtio-pci control command to the vDPA bus. This will be used for
>> features prototyping and testing.
>>
>> Note that get/restore virtqueue state is not supported which needs
>> extension on the virtio specification.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> drivers/vdpa/Kconfig              |   6 +
>> drivers/vdpa/Makefile             |   1 +
>> drivers/vdpa/virtio_pci/Makefile  |   2 +
>> drivers/vdpa/virtio_pci/vp_vdpa.c | 455 ++++++++++++++++++++++++++++++
>> 4 files changed, 464 insertions(+)
>> create mode 100644 drivers/vdpa/virtio_pci/Makefile
>> create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
>>
>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>> index 358f6048dd3c..18cad14f533e 100644
>> --- a/drivers/vdpa/Kconfig
>> +++ b/drivers/vdpa/Kconfig
>> @@ -48,4 +48,10 @@ config MLX5_VDPA_NET
>>       be executed by the hardware. It also supports a variety of stateless
>>       offloads depending on the actual device used and firmware version.
>>
>> +config VP_VDPA
>> +    tristate "Virtio PCI bridge vDPA driver"
>> +    depends on PCI_MSI && VIRTIO_PCI_MODERN
>> +    help
>> +      This kernel module that bridges virtio PCI device to vDPA bus.
>                              ^
> Without 'that' maybe sound better, but I'm not a native speaker :-)

Yes, drop 'that', please.

>> +
>> endif # VDPA

-- 
~Randy

