Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B61A4279
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 08:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDJGVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 02:21:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24977 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725816AbgDJGVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586499671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLUdw7D/EcbCC4PhngbwYSwRK7VO2nDFahJzRTXLZAM=;
        b=TFFrSyPoUCnUp6hzx0dGjuASu5xVSHh6Z1chCX7WBeJc0arRHh3Fu79Ces/7pQtwLJs/kQ
        5+i/HxvMefdm1/4RIau4L9upJk6Wu+n6Jb9I2vpAzk/9lSDGBkBTxzpb5PEROQfL2+5hdG
        Leo5CZ9T+s+FVLiB+Rb3c9TyasjVdTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Wi1lpvTxPdOy0zhbrDjSmg-1; Fri, 10 Apr 2020 02:21:09 -0400
X-MC-Unique: Wi1lpvTxPdOy0zhbrDjSmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C15D1005513;
        Fri, 10 Apr 2020 06:21:08 +0000 (UTC)
Received: from [10.72.12.205] (ovpn-12-205.pek2.redhat.com [10.72.12.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA521272A6;
        Fri, 10 Apr 2020 06:21:03 +0000 (UTC)
Subject: Re: [PATCH] vdpa: allow a 32 bit vq alignment
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20200409202825.10115-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <bed03b3a-ebc0-2a93-7e6b-8f884eab747b@redhat.com>
Date:   Fri, 10 Apr 2020 14:21:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200409202825.10115-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Ling Shan.

On 2020/4/10 =E4=B8=8A=E5=8D=884:28, Michael S. Tsirkin wrote:
> get_vq_align returns u16 now, but that's not enough for
> systems/devices with 64K pages. All callers assign it to
> a u32 variable anyway, so let's just change the return
> value type to u32.
>
> Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c  | 2 +-
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>   include/linux/vdpa.h             | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf=
_main.c
> index 28d9e5de5675..abf6a061cab6 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -226,7 +226,7 @@ static u32 ifcvf_vdpa_get_vendor_id(struct vdpa_dev=
ice *vdpa_dev)
>   	return IFCVF_SUBSYS_VENDOR_ID;
>   }
>  =20
> -static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
> +static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>   {
>   	return IFCVF_QUEUE_ALIGNMENT;
>   }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> index 72863d01a12a..7957d2d41fc4 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -435,7 +435,7 @@ static u64 vdpasim_get_vq_state(struct vdpa_device =
*vdpa, u16 idx)
>   	return vrh->last_avail_idx;
>   }
>  =20
> -static u16 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> +static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>   {
>   	return VDPASIM_QUEUE_ALIGN;
>   }
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 733acfb7ef84..5453af87a33e 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -164,7 +164,7 @@ struct vdpa_config_ops {
>   	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
>  =20
>   	/* Device ops */
> -	u16 (*get_vq_align)(struct vdpa_device *vdev);
> +	u32 (*get_vq_align)(struct vdpa_device *vdev);
>   	u64 (*get_features)(struct vdpa_device *vdev);
>   	int (*set_features)(struct vdpa_device *vdev, u64 features);
>   	void (*set_config_cb)(struct vdpa_device *vdev,

