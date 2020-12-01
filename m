Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325562C95FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgLADqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgLADqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606794275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CWW1JLoXpWoDMFBvVdgTwSzj5uqoC7xuW42mruGNxg=;
        b=LQqgYsSxL26oEdA8kc8wyhDVrRRugBOs9cdD2tqSQPwqKPtyZtOheEYuipIQUC4bon2Rjb
        4le76XXtMEf3FBcLCw3C+Q67ZDn5CmzCs7xAw396o7UtMTIkTK2uTqyuWQrKJZX7ogJXvy
        i0n9qacIZXLiuxkv5zlLcctgcKhosXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-WoS6MIudNkCiRRcUcqVleA-1; Mon, 30 Nov 2020 22:44:31 -0500
X-MC-Unique: WoS6MIudNkCiRRcUcqVleA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 329B1817B9F;
        Tue,  1 Dec 2020 03:44:30 +0000 (UTC)
Received: from [10.72.13.167] (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 407755C1A3;
        Tue,  1 Dec 2020 03:44:21 +0000 (UTC)
Subject: Re: [PATCH v2 12/17] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-13-sgarzare@redhat.com>
 <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
 <20201130141453.jobe76loyfy4qrdw@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c2158059-6509-7702-f52a-e497ce899293@redhat.com>
Date:   Tue, 1 Dec 2020 11:44:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130141453.jobe76loyfy4qrdw@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/30 下午10:14, Stefano Garzarella wrote:
> On Mon, Nov 30, 2020 at 11:25:31AM +0800, Jason Wang wrote:
>>
>> On 2020/11/26 下午10:49, Stefano Garzarella wrote:
>>> The get_config callback can be used by the device to fill the
>>> config structure.
>>> The callback will be invoked in vdpasim_get_config() before copying
>>> bytes into caller buffer.
>>>
>>> Move vDPA-net config updates from vdpasim_set_features() in the
>>> new vdpasim_net_get_config() callback.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 33 +++++++++++++++++++-------------
>>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c 
>>> b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> index c07ddf6af720..8b87ce0485b6 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> @@ -58,6 +58,8 @@ struct vdpasim_virtqueue {
>>>  #define VDPASIM_NET_FEATURES    (VDPASIM_FEATURES | \
>>>                   (1ULL << VIRTIO_NET_F_MAC))
>>> +struct vdpasim;
>>> +
>>>  struct vdpasim_dev_attr {
>>>      u64 supported_features;
>>>      size_t config_size;
>>> @@ -65,6 +67,7 @@ struct vdpasim_dev_attr {
>>>      u32 id;
>>>      work_func_t work_fn;
>>> +    void (*get_config)(struct vdpasim *vdpasim, void *config);
>>>  };
>>>  /* State of each vdpasim device */
>>> @@ -520,8 +523,6 @@ static u64 vdpasim_get_features(struct 
>>> vdpa_device *vdpa)
>>>  static int vdpasim_set_features(struct vdpa_device *vdpa, u64 
>>> features)
>>>  {
>>>      struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>> -    struct virtio_net_config *config =
>>> -        (struct virtio_net_config *)vdpasim->config;
>>>      /* DMA mapping must be done by driver */
>>>      if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>>> @@ -529,15 +530,6 @@ static int vdpasim_set_features(struct 
>>> vdpa_device *vdpa, u64 features)
>>>      vdpasim->features = features & 
>>> vdpasim->dev_attr.supported_features;
>>> -    /* We generally only know whether guest is using the legacy 
>>> interface
>>> -     * here, so generally that's the earliest we can set config 
>>> fields.
>>> -     * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
>>> -     * implies VIRTIO_F_VERSION_1, but let's not try to be clever 
>>> here.
>>> -     */
>>> -
>>> -    config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>>> -    config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>>> -    memcpy(config->mac, macaddr_buf, ETH_ALEN);
>>>      return 0;
>>>  }
>>> @@ -593,8 +585,12 @@ static void vdpasim_get_config(struct 
>>> vdpa_device *vdpa, unsigned int offset,
>>>  {
>>>      struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>> -    if (offset + len < vdpasim->dev_attr.config_size)
>>> -        memcpy(buf, vdpasim->config + offset, len);
>>> +    if (offset + len > vdpasim->dev_attr.config_size)
>>> +        return;
>>> +
>>> +    vdpasim->dev_attr.get_config(vdpasim, vdpasim->config);
>>> +
>>> +    memcpy(buf, vdpasim->config + offset, len);
>>>  }
>>
>>
>> I wonder how much value we can get from vdpasim->config consider 
>> we've already had get_config() method.
>>
>> Is it possible to copy to the buffer directly here?
>
> I had thought of eliminating it too, but then I wanted to do something 
> similar to what we do in QEMU (hw/virtio/virtio.c), leaving in the 
> simulator core the buffer, the memory copy (handling offset and len), 
> and the boundary checks.
>
> In this way each device should simply fill the entire configuration 
> and we can avoid code duplication.
>
> Storing the configuration in the core may also be useful if some 
> device needs to support config writes.


I think in that way we need should provide config_write().


>
> Do you think it makes sense, or is it better to move everything in the 
> device?


I prefer to do that in the device but it's also fine keep what the patch 
has done.

Thanks


>
> Thanks,
> Stefano
>

