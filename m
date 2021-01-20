Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0962FCE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbhATKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:19:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731055AbhATKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611137067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAdk/pvhgqfEVThJWQE5px+oTI2f6GAbmEr8AilhvWI=;
        b=FeT0Sl+LyMBP1ffZZBzewk3w1NBY17jTW7i9jTYtbL1KvSWB4dUUkTdjwX1XkVK0EnXluE
        bWWPOvg/n+amd+zRjCROIWkI9PRhcTPmZnI+hEI6temMeDULbMvlXHzYyUcg3kuiDSb23V
        g4Lc+ESsO26sFvRT1Y3nFN0YO907J9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-0TXQz0SNMQmaOrhQss8RVw-1; Wed, 20 Jan 2021 05:04:25 -0500
X-MC-Unique: 0TXQz0SNMQmaOrhQss8RVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB494107ACE8;
        Wed, 20 Jan 2021 10:04:23 +0000 (UTC)
Received: from [10.36.115.161] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7B719CA8;
        Wed, 20 Jan 2021 10:04:18 +0000 (UTC)
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
 <20210120045736-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
Date:   Wed, 20 Jan 2021 11:04:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210120045736-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 10:57, Michael S. Tsirkin wrote:
> On Wed, Jan 20, 2021 at 10:40:37AM +0100, David Hildenbrand wrote:
>> On 20.01.21 08:50, Jiapeng Zhong wrote:
>>> Fix the following coccicheck warnings:
>>>
>>> ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
>>> of 0/1 to bool variable.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
>>> ---
>>>  drivers/virtio/virtio_mem.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>>> index 9fc9ec4..85a272c 100644
>>> --- a/drivers/virtio/virtio_mem.c
>>> +++ b/drivers/virtio/virtio_mem.c
>>> @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>>>  	 * actually in use (e.g., trying to reload the driver).
>>>  	 */
>>>  	if (vm->plugged_size) {
>>> -		vm->unplug_all_required = 1;
>>> +		vm->unplug_all_required = true;
>>>  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
>>>  	}
>>>  
>>>
>>
>> Hi,
>>
>> we already had a fix on the list for quite a while:
>>
>> https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com
> 
> Can't find that one.

Looks like it was only on virtualization@ and a couple of people on cc.

https://lists.linuxfoundation.org/pipermail/virtualization/2020-December/051662.html

Interestingly, I cannot find the follow-up ("[PATCH] virtio-mem: use
boolean value when setting vm->unplug_all_required") in the mailing list
archives, even though it has virtualization@ on cc.

-- 
Thanks,

David / dhildenb

