Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A782B6795
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgKQOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727473AbgKQOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605623586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FZvUH2HZR1j9AWlmRfDoE5NQCnlGVtxpdam0CDlxdg=;
        b=KlC+1XQL0Fe3s/BtQpPLM2ZFg0HWwqs/sFzzcCsxSg05dF85AoR+K73J+8jxMss68OXILZ
        ymwIpvk7a0OOR1G50Wo/tk7apKtLINFOWTzIcdMESjr9j2vlHvYqcmAd3oCKcDBcJLsI7M
        jyDWlKo7iutU/AWs9zpHIoxaibcqmXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-o6e6BGXoNN6nSywKw4KNuA-1; Tue, 17 Nov 2020 09:33:03 -0500
X-MC-Unique: o6e6BGXoNN6nSywKw4KNuA-1
Received: by mail-wm1-f70.google.com with SMTP id q17so1631675wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4FZvUH2HZR1j9AWlmRfDoE5NQCnlGVtxpdam0CDlxdg=;
        b=AdUZdR0x5KoUh94fJaPBd0/mSgzYcS00F4U0KpMYFLzfwK356KMoYI1tPARUDVg9tu
         p8iLdSElZMctfKOMpMlqXME08IcV6/KioE9RV37Q8f3UwJdLrsjU1WWG+/tOsBSlVHI0
         WnksBvm92jwjZ9deMf7Ei6cV6WR6Csxe+vaGuUuRJrdfVmtSqMZhNW0w3/iODVkM0ZPZ
         D2bL1fx9IFQlaWeSknAc/jZOAVq5E74CL5apO+Qz/hJXTUsQrj4+tV9wXTEZ65To7Te5
         NDf6TMakoLkNeW8a1efqaDuxswju34EwkYC2R9MfAbeF4p+elmDM0uIqcaffQh8wLRYS
         ks8g==
X-Gm-Message-State: AOAM532O9oCzUhVluvULYkKWsRR4CmYf17bWoBF+uT64wwoVYB8+ulXj
        zmqV3JLOSt9NwmD4IRmtnyd0SfS+Pm0G4dissx0Lb6Ua8949h2afFJTCjciEa1SRvJ26iYUYkeD
        u7u45E/+Bf5OD5HGBDpaLf9wB
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr4880158wmh.110.1605623581860;
        Tue, 17 Nov 2020 06:33:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzelJd9YzCnQ6HlAkPG0dYJhRmCRZ5mnkDM4NfpaGFovbOgWp0v59ANAyM7wHvxfIF0qlRi4Q==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr4880133wmh.110.1605623581660;
        Tue, 17 Nov 2020 06:33:01 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id f18sm14045497wru.42.2020.11.17.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:33:01 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:32:58 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201117143258.kfm7jhkofwavq6p6@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
 <20201117113636.GG131917@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201117113636.GG131917@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:36:36AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:12PM +0100, Stefano Garzarella wrote:
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> index 8e41b3ab98d5..68e74383322f 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> @@ -7,6 +7,7 @@
>>   */
>>
>>  #include <linux/module.h>
>> +#include <linux/blkdev.h>
>>  #include <uapi/linux/virtio_blk.h>
>>
>>  #include "vdpa_sim.h"
>> @@ -24,10 +25,137 @@
>>
>>  static struct vdpasim *vdpasim_blk_dev;
>>
>> +static int vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>> +				  struct vdpasim_virtqueue *vq)
>
>This function has a non-standard int return value. Please document it.

Yes, I'll do.

>
>> +{
>> +	size_t wrote = 0, to_read = 0, to_write = 0;
>> +	struct virtio_blk_outhdr hdr;
>> +	uint8_t status;
>> +	uint32_t type;
>> +	ssize_t bytes;
>> +	loff_t offset;
>> +	int i, ret;
>> +
>> +	vringh_kiov_cleanup(&vq->riov);
>> +	vringh_kiov_cleanup(&vq->wiov);
>> +
>> +	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
>> +				   &vq->head, GFP_ATOMIC);
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	for (i = 0; i < vq->wiov.used; i++)
>> +		to_write += vq->wiov.iov[i].iov_len;
>> +	to_write -= 1; /* last byte is the status */
>
>What if vq->wiov.used == 0?

Right, we should discard the descriptor.

>
>> +
>> +	for (i = 0; i < vq->riov.used; i++)
>> +		to_read += vq->riov.iov[i].iov_len;
>> +
>> +	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov, &hdr, sizeof(hdr));
>> +	if (bytes != sizeof(hdr))
>> +		return 0;
>> +
>> +	to_read -= bytes;
>> +
>> +	type = le32_to_cpu(hdr.type);
>> +	offset = le64_to_cpu(hdr.sector) << SECTOR_SHIFT;
>> +	status = VIRTIO_BLK_S_OK;
>> +
>> +	switch (type) {
>> +	case VIRTIO_BLK_T_IN:
>> +		if (offset + to_write > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {
>
>Integer overflow is not handled.

I'll fix.

Thanks,
Stefano

