Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41712C5ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 03:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392267AbgK0CyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 21:54:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728340AbgK0CyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 21:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606445663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGZK39FnAHCfDZOGE7x+2RX5gE8a4CIozSMLiIymFQw=;
        b=NGr9JCuwKxPhC5Dp0taNmAAW6ll+3E7Wm+pES+S/xZJucx7jd/+zjFyQ5PVDOfzyMXG36u
        U5Qhb5WvdqFbgILYsP68ruoPBxbmWkE2RBPxSmIMPRtmcNFBHsXrvox4bXLhN7q14kP7hI
        5dtufOSyW7waRV74zakXcvYLjTL87h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-bMBfN4IPOHKgvLpWNJBV5A-1; Thu, 26 Nov 2020 21:54:21 -0500
X-MC-Unique: bMBfN4IPOHKgvLpWNJBV5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 090301005E42;
        Fri, 27 Nov 2020 02:54:20 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABDAA5D6AC;
        Fri, 27 Nov 2020 02:54:15 +0000 (UTC)
Subject: Re: [PATCH V2 02/14] virtio-pci: switch to use devres for modern
 devices
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
References: <20201126092604.208033-1-jasowang@redhat.com>
 <20201126092604.208033-3-jasowang@redhat.com>
 <20201126084708-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9638da54-394c-98f1-ad0e-12f3f0ddf17e@redhat.com>
Date:   Fri, 27 Nov 2020 10:54:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126084708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午9:57, Michael S. Tsirkin wrote:
> On Thu, Nov 26, 2020 at 05:25:52PM +0800, Jason Wang wrote:
>> This patch tries to convert the modern device to use devres to manage
>> its resources (iomaps). Before this patch the IO address is mapped
>> individually according to the capability. After this patch, we simply
>> map the whole BAR.
> I think the point of mapping capability was e.g. for devices with
> huge BARs. We don't want to waste virtual memory for e.g. 32 bit guests.
>
> And in particular the spec says:
>
> 	The drivers SHOULD only map part of configuration structure large enough for device operation. The drivers
> 	MUST handle an unexpectedly large length, but MAY check that length is large enough for device operation.


Good point, so I will stick to devres but not use the shortcut like 
whole BAR mapping.


>
> I also wonder how would this interact with cases where device memory is
> mapped for different reasons, such as for MSI table access, into userspace
> as it has resources such as virtio mem, etc.


I think it depends on the driver, e.g for virtio-pci and vDPA, the upper 
layer driver (virtio bus or vDPA bus) know nothing about transport 
specific thing. It should be ok.


> E.g. don't e.g. intel CPUs disallow mapping the same address twice
> with different attributes?


Do you mean it doesn't allow one VA is mapped as UC but the other is 
not? I don't know. But anyhow my understanding is that 
virtio-pci/vp_vdpa tries to hide the details so we can not have two 
mappings here.

Thanks


>

