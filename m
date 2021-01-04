Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FAF2E8F93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 04:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbhADDYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 22:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbhADDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 22:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609730584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZSEcMV6HrgwioULaRsP1a/F6QmzsKsD5eRpNgK39q0=;
        b=ZCxf5enU6U0bGJR9lAOTuwn+ZSiz/Ges7n1Aerw8Hfp2vfRnJgIFdU1nyo6Tm4MLQCAXTT
        m9NTUVWKK8Zhs3lI4ckug4VgqyZerzGZUcgCG4AagGSO5qeBFK3oiMDHqhFps66887mie3
        qxJWTbnQiyKsxcj3+znKvaRssLMeLqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-EPvtJQvVOqWZOgwKIvY9pw-1; Sun, 03 Jan 2021 22:23:02 -0500
X-MC-Unique: EPvtJQvVOqWZOgwKIvY9pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A886800D55;
        Mon,  4 Jan 2021 03:23:01 +0000 (UTC)
Received: from [10.72.13.221] (ovpn-13-221.pek2.redhat.com [10.72.13.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572B16F7EB;
        Mon,  4 Jan 2021 03:22:56 +0000 (UTC)
Subject: Re: [PATCH V2 16/19] virtio-pci: introduce modern device module
To:     Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-17-jasowang@redhat.com>
 <a325b57b-817f-b96e-76fc-dba4415fe6b0@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9ea86f91-0ca5-bfd6-4489-93a726455c41@redhat.com>
Date:   Mon, 4 Jan 2021 11:22:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a325b57b-817f-b96e-76fc-dba4415fe6b0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/5 上午1:10, Randy Dunlap wrote:
> Hi Jason--
>
> On 12/3/20 8:03 PM, Jason Wang wrote:
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 7b41130d3f35..d1a6bd2a975f 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -12,6 +12,14 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>   	  This option is selected if the architecture may need to enforce
>>   	  VIRTIO_F_ACCESS_PLATFORM
>>   
>> +config VIRTIO_PCI_MODERN
>> +	tristate "Modern Virtio PCI Device"
>> +	depends on PCI
>> +	help
>> +	  Modern PCI device implementation. This module implement the
> 	                                                implements
>
>> +	  basic probe and control for devices which is based on modern
> 	                                            are
>
>> +	  PCI device with possible vendor specific extensions.
> 	      devices
>> +
>
> cheers.


All fixed.

Thanks


