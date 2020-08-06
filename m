Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4023D5BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 05:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgHFDX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 23:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26836 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726817AbgHFDX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596684235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6EdwxxPxToRlRVjg4VjqE/IKz5jwoBOjp4Hl0tx224=;
        b=TJnh3Px5WXR2jUl5y1F9KZkkWQxFjdp+dnm961O+JhlxCyKLz9t7BNhm0Mmx4y5YvMRx3s
        /xsbeYvkCX+Pb6d2VFPksWVPH1i0C8OZV/v0u/XHKB0UcowkCVEoHL/CyMD8JrpuCuM4Uk
        iudAasKqKSCDC8yHyMSu5mh4o2KClEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-q58d4V6iNR67iVGqe8xPng-1; Wed, 05 Aug 2020 23:23:52 -0400
X-MC-Unique: q58d4V6iNR67iVGqe8xPng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3023358;
        Thu,  6 Aug 2020 03:23:51 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB2335D9E2;
        Thu,  6 Aug 2020 03:23:46 +0000 (UTC)
Subject: Re: [PATCH v2 22/24] vdpa_sim: fix endian-ness of config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-23-mst@redhat.com>
 <dd24f2e6-4aef-4a26-374c-2349fe1e6a66@redhat.com>
 <20200805080434-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0ad1b5e6-52a8-aa4c-ec5f-a44a5727d84d@redhat.com>
Date:   Thu, 6 Aug 2020 11:23:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805080434-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 下午8:06, Michael S. Tsirkin wrote:
> On Wed, Aug 05, 2020 at 02:21:07PM +0800, Jason Wang wrote:
>> On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
>>> VDPA sim accesses config space as native endian - this is
>>> wrong since it's a modern device and actually uses LE.
>>>
>>> It only supports modern guests so we could punt and
>>> just force LE, but let's use the full virtio APIs since people
>>> tend to copy/paste code, and this is not data path anyway.
>>>
>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>> ---
>>>    drivers/vdpa/vdpa_sim/vdpa_sim.c | 31 ++++++++++++++++++++++++++-----
>>>    1 file changed, 26 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> index a9bc5e0fb353..fa05e065ff69 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> @@ -24,6 +24,7 @@
>>>    #include <linux/etherdevice.h>
>>>    #include <linux/vringh.h>
>>>    #include <linux/vdpa.h>
>>> +#include <linux/virtio_byteorder.h>
>>>    #include <linux/vhost_iotlb.h>
>>>    #include <uapi/linux/virtio_config.h>
>>>    #include <uapi/linux/virtio_net.h>
>>> @@ -72,6 +73,23 @@ struct vdpasim {
>>>    	u64 features;
>>>    };
>>> +/* TODO: cross-endian support */
>>> +static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
>>> +{
>>> +	return virtio_legacy_is_little_endian() ||
>>> +		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
>>> +}
>>> +
>>> +static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
>>> +{
>>> +	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
>>> +}
>>> +
>>> +static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
>>> +{
>>> +	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
>>> +}
>>> +
>>>    static struct vdpasim *vdpasim_dev;
>>>    static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>>> @@ -306,7 +324,6 @@ static const struct vdpa_config_ops vdpasim_net_config_ops;
>>>    static struct vdpasim *vdpasim_create(void)
>>>    {
>>> -	struct virtio_net_config *config;
>>>    	struct vdpasim *vdpasim;
>>>    	struct device *dev;
>>>    	int ret = -ENOMEM;
>>> @@ -331,10 +348,7 @@ static struct vdpasim *vdpasim_create(void)
>>>    	if (!vdpasim->buffer)
>>>    		goto err_iommu;
>>> -	config = &vdpasim->config;
>>> -	config->mtu = 1500;
>>> -	config->status = VIRTIO_NET_S_LINK_UP;
>>> -	eth_random_addr(config->mac);
>>> +	eth_random_addr(vdpasim->config.mac);
>>>    	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
>>>    	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>>> @@ -448,6 +462,7 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>>>    static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>>    {
>>>    	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>> +	struct virtio_net_config *config = &vdpasim->config;
>>>    	/* DMA mapping must be done by driver */
>>>    	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>>> @@ -455,6 +470,12 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>>    	vdpasim->features = features & vdpasim_features;
>>> +	/* We only know whether guest is using the legacy interface here, so
>>> +	 * that's the earliest we can set config fields.
>>> +	 */
>> We check whether or not ACCESS_PLATFORM is set before which is probably a
>> hint that only modern device is supported. So I wonder just force LE and
>> fail if VERSION_1 is not set is better?
>>
>> Thanks
> So how about I add a comment along the lines of
>
> /*
>   * vdpasim ATM requires VIRTIO_F_ACCESS_PLATFORM, so we don't need to
>   * support legacy guests. Keep transitional device code around for
>   * the benefit of people who might copy-and-paste this into transitional
>   * device code.
>   */


That's fine.

Thanks


>
>

