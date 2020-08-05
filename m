Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0514123C77D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgHEILO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 04:11:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32100 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728198AbgHEILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596615061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54CekOq5nyKMM7BtMGAhsULPFpA9SluWl2e7PxuQNBc=;
        b=Ldy/ymRaMF+GbqTSDAJvtNZubbdF1WWy1BF53vDNEY+UdgHFwFlTSHDZ2pak6Fxv2ziA50
        /vF/ZukogEh07qpvaOzyXzfwcjxzIAvIrXTwQ7CCANANu6OEhUl4H8Y7SFQ/rfOzOvgFvy
        k/97+vi5BXmCnBoBtrQ+aaDsiEUdIVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-jW_6k5W0NICd4wdnZXdEJA-1; Wed, 05 Aug 2020 04:10:59 -0400
X-MC-Unique: jW_6k5W0NICd4wdnZXdEJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA748B4279;
        Wed,  5 Aug 2020 08:10:51 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2765719C4F;
        Wed,  5 Aug 2020 08:10:47 +0000 (UTC)
Subject: Re: [PATCH V4 linux-next 08/12] vdpa: Modify get_vq_state() to return
 error code
To:     Eli Cohen <eli@mellanox.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804162048.22587-9-eli@mellanox.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <972bc164-0d9d-a7fa-6929-daee843f04d7@redhat.com>
Date:   Wed, 5 Aug 2020 16:10:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804162048.22587-9-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 上午12:20, Eli Cohen wrote:
> Modify get_vq_state() so it returns an error code. In case of hardware
> acceleration, the available index may be retrieved from the device, an
> operation that can possibly fail.
>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Eli Cohen <eli@mellanox.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c  | 5 +++--
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 5 +++--
>   drivers/vhost/vdpa.c             | 5 ++++-
>   include/linux/vdpa.h             | 4 ++--
>   4 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index dc311e972b9e..076d7ac5e723 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -237,12 +237,13 @@ static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
>   	return IFCVF_QUEUE_MAX;
>   }
>   
> -static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> -				    struct vdpa_vq_state *state)
> +static int ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> +				   struct vdpa_vq_state *state)
>   {
>   	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>   
>   	state->avail_index = ifcvf_get_vq_state(vf, qid);
> +	return 0;
>   }
>   
>   static int ifcvf_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index f1c351d5959b..c68741363643 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -464,14 +464,15 @@ static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
>   	return 0;
>   }
>   
> -static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> -				 struct vdpa_vq_state *state)
> +static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> +				struct vdpa_vq_state *state)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>   	struct vringh *vrh = &vq->vring;
>   
>   	state->avail_index = vrh->last_avail_idx;
> +	return 0;
>   }
>   
>   static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index c2e1e2d55084..a0b7c91948e1 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -392,7 +392,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>   		ops->set_vq_ready(vdpa, idx, s.num);
>   		return 0;
>   	case VHOST_GET_VRING_BASE:
> -		ops->get_vq_state(v->vdpa, idx, &vq_state);
> +		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
> +		if (r)
> +			return r;
> +
>   		vq->last_avail_idx = vq_state.avail_index;
>   		break;
>   	case VHOST_GET_BACKEND_FEATURES:
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 8f412620071d..fd6e560d70f9 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -192,8 +192,8 @@ struct vdpa_config_ops {
>   	bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
>   	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx,
>   			    const struct vdpa_vq_state *state);
> -	void (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
> -			     struct vdpa_vq_state *state);
> +	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
> +			    struct vdpa_vq_state *state);
>   	struct vdpa_notification_area
>   	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>   	int (*get_vq_irq)(struct vdpa_device *vdv, u16 idx);

