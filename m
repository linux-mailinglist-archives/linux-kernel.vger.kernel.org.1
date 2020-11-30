Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11312C7D19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgK3DGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:06:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbgK3DGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606705506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=na0VqByCBLwL2XYwDNtC+dq1b+zzL7qMGmJPR1qmUks=;
        b=N0NB20+2+OaxAkC1bCFozDOssgyXP5eezCaFmkn3HR7tgKxna8AVDl2Euxo/dqfzKA4AKq
        OfIyDoBFCu75CZ2f+Y1AEBBU6ecIWl+zD+Ujm/Jj0YIDtYDNF+zL6ixnDAY4xW1F5uP4gK
        KtST5Qv2i0FpkyOCA057W/89TZ3IdhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-y7BAwqydM9uuLIM8QSFasA-1; Sun, 29 Nov 2020 22:05:02 -0500
X-MC-Unique: y7BAwqydM9uuLIM8QSFasA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE771842142;
        Mon, 30 Nov 2020 03:05:00 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2DC1A88F;
        Mon, 30 Nov 2020 03:04:50 +0000 (UTC)
Subject: Re: [PATCH v2 02/17] vdpa_sim: remove unnecessary headers inclusion
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-3-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f900316d-a642-714e-65b6-5b6cc4b79b48@redhat.com>
Date:   Mon, 30 Nov 2020 11:04:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> Some headers are not necessary, so let's remove them to do
> some cleaning.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 -------------
>   1 file changed, 13 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 6a90fdb9cbfc..c6eaf62df8ec 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -7,24 +7,11 @@
>    *
>    */
>   
> -#include <linux/init.h>
>   #include <linux/module.h>
> -#include <linux/device.h>


I think the rule is to make sure e.g the structure definition can be via 
direct inclusion. E.g struct device {} is defined in this file.


> -#include <linux/kernel.h>
> -#include <linux/fs.h>
> -#include <linux/poll.h>
> -#include <linux/slab.h>
> -#include <linux/sched.h>
> -#include <linux/wait.h>
> -#include <linux/uuid.h>
> -#include <linux/iommu.h>
>   #include <linux/dma-map-ops.h>
> -#include <linux/sysfs.h>
> -#include <linux/file.h>
>   #include <linux/etherdevice.h>
>   #include <linux/vringh.h>
>   #include <linux/vdpa.h>
> -#include <linux/virtio_byteorder.h>


And the  __cpu_to_virtio16 is defined in this file.

Thanks


>   #include <linux/vhost_iotlb.h>
>   #include <uapi/linux/virtio_config.h>
>   #include <uapi/linux/virtio_net.h>

