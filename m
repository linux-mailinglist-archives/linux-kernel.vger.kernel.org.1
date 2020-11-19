Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224002B8B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKSGQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgKSGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605766585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlkXr7s48FDSqN7LK4mEk+UbmSZsrG7b5ixjGj4X+PA=;
        b=ODOLZRlRF4bdwnh00VPbWNIHBnc7GAUnpFmFOMJ0F2qZeeHqLeV+BJoDq8UC1TyQz+3Z2w
        Qgiinx9InHfKeMMR3ksNZWq+agtbjkmUCWOhCM6qWT5w09iwBC+whKXQpVsB/i7N3UOEMB
        IHtcnn+1O6s5xa8SIv02LlpbiR918KA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-gBdEjmyPNSyEQT-EZNqE8w-1; Thu, 19 Nov 2020 01:16:23 -0500
X-MC-Unique: gBdEjmyPNSyEQT-EZNqE8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 432AD80EDA8;
        Thu, 19 Nov 2020 06:16:22 +0000 (UTC)
Received: from [10.72.13.63] (ovpn-13-63.pek2.redhat.com [10.72.13.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46CC19728;
        Thu, 19 Nov 2020 06:16:07 +0000 (UTC)
Subject: Re: [PATCH RFC 02/12] vdpa: split vdpasim to core and net modules
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-3-sgarzare@redhat.com>
 <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
 <20201118131408.4denectqx3bvcmxq@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8d941b5d-f691-226c-b31f-c92c45fa0d2a@redhat.com>
Date:   Thu, 19 Nov 2020 14:16:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118131408.4denectqx3bvcmxq@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/18 下午9:14, Stefano Garzarella wrote:
> Hi Jason,
> I just discovered that I missed the other questions in this email,
> sorry for that!


No problem :)


>
> On Mon, Nov 16, 2020 at 12:00:11PM +0800, Jason Wang wrote:
>>
>> On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>
>>> Introduce new vdpa_sim_net and vdpa_sim (core) drivers. This is a
>>> preparation for adding a vdpa simulator module for block devices.
>>>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> [sgarzare: various cleanups/fixes]
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>> v1:
>>> - Removed unused headers
>>> - Removed empty module_init() module_exit()
>>> - Moved vdpasim_is_little_endian() in vdpa_sim.h
>>> - Moved vdpasim16_to_cpu/cpu_to_vdpasim16() in vdpa_sim.h
>>> - Added vdpasim*_to_cpu/cpu_to_vdpasim*() also for 32 and 64
>>> - Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>>>   option can not depend on other [Jason]
>>
>>
>> If possible, I would suggest to split this patch further:
>>
>> 1) convert to use void *config, and an attribute for setting config 
>> size during allocation
>> 2) introduce supported_features
>> 3) other attributes (#vqs)
>> 4) rename config ops (more generic one)
>> 5) introduce ops for set|get_config, set_get_features
>> 6) real split
>>
>>
>
> [...]
>
>>> -static const struct vdpa_config_ops vdpasim_net_config_ops;
>>> -static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
>>> +static const struct vdpa_config_ops vdpasim_config_ops;
>>> +static const struct vdpa_config_ops vdpasim_batch_config_ops;
>>> -static struct vdpasim *vdpasim_create(void)
>>> +struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>>>  {
>>>      const struct vdpa_config_ops *ops;
>>>      struct vdpasim *vdpasim;
>>> +    u32 device_id;
>>>      struct device *dev;
>>> -    int ret = -ENOMEM;
>>> +    int i, size, ret = -ENOMEM;
>>> -    if (batch_mapping)
>>> -        ops = &vdpasim_net_batch_config_ops;
>>> +    device_id = attr->device_id;
>>> +    /* Currently, we only accept the network and block devices. */
>>> +    if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
>>> +        return ERR_PTR(-EOPNOTSUPP);
>>> +
>>> +    if (attr->batch_mapping)
>>> +        ops = &vdpasim_batch_config_ops;
>>>      else
>>> -        ops = &vdpasim_net_config_ops;
>>> +        ops = &vdpasim_config_ops;
>>>      vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, 
>>> VDPASIM_VQ_NUM);
>>>      if (!vdpasim)
>>>          goto err_alloc;
>>> -    INIT_WORK(&vdpasim->work, vdpasim_work);
>>> +    if (device_id == VIRTIO_ID_NET)
>>> +        size = sizeof(struct virtio_net_config);
>>> +    else
>>> +        size = sizeof(struct virtio_blk_config);
>>
>>
>> It's better to avoid such if/else consider we may introduce more type 
>> of devices.
>>
>> Can we have an attribute of config size instead?
>
> Yes, I'll move the patch 7 before this.
>
> About config size and set/get_config ops, I'm not sure if it is better 
> to hidden everything under the new set/get_config ops, allocating the 
> config structure in each device, or leave the allocation in the core 
> and update it like now.


I think we'd better to avoid having any type specific codes in generic 
sim codes.


[...]


>>> +config VDPA_SIM_NET
>>> +    tristate "vDPA simulator for networking device"
>>> +    depends on VDPA_SIM
>>> +    default n
>>
>>
>> I remember somebody told me that if we don't enable a module it was 
>> disabled by default.
>
> So, should I remove "default n" from vdpa_sim* entries?


Yes, but please do that in another patch.

Thanks


>
> Thanks,
> Stefano
>

