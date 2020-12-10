Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1F2D5654
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgLJJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729811AbgLJJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607591476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gb3SbnRTo+3pkXXdNLxcd5ljhhUyYYdpcGHBH8tC1V0=;
        b=ZZbUb9Ue/CRtXFx/SakRKa3/fp+9zpKu9Zuuq7RM2KRUc3NDyAcsHmCYTC/h1QpgegMbTM
        r649zVtTVBlNmrLGBTUdRV6oWIahL41XT65mniWtLrSBoKPJ5uu+8CkO3HNtgunmseD8RE
        EqaULq5KRgF7Ox6wyIuA47UvMn91nZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-8hJn_FKvPdSa1KjmAx1-Xg-1; Thu, 10 Dec 2020 04:11:14 -0500
X-MC-Unique: 8hJn_FKvPdSa1KjmAx1-Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF953802B49;
        Thu, 10 Dec 2020 09:11:13 +0000 (UTC)
Received: from [10.72.12.50] (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD8E160BF1;
        Thu, 10 Dec 2020 09:11:03 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Use write memory barrier after updating CQ
 index
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     lulu@redhat.com, maxime.coquelin@redhat.com
References: <20201209140004.15892-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <26dd1676-ff63-4940-9b0d-d7097950c1e5@redhat.com>
Date:   Thu, 10 Dec 2020 17:11:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209140004.15892-1-elic@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/9 下午10:00, Eli Cohen wrote:
> Make sure to put dma write memory barrier after updating CQ consumer
> index so the hardware knows that there are available CQE slots in the
> queue.
>
> Failure to do this can cause the update of the RX doorbell record to get
> updated before the CQ consumer index resulting in CQ overrun.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V0 -> V1
> Use dma_wmb() instead of wmb()


Acked-by: Jason Wang <jasowang@redhat.com>


>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index db87abc3cb60..43b0069ff8b1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -479,6 +479,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
>   static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
>   {
>   	mlx5_cq_set_ci(&mvq->cq.mcq);
> +
> +	/* make sure CQ cosumer update is visible to the hardware before updating
> +	 * RX doorbell record.
> +	 */
> +	dma_wmb();
>   	rx_post(&mvq->vqqp, num);
>   	if (mvq->event_cb.callback)
>   		mvq->event_cb.callback(mvq->event_cb.private);

