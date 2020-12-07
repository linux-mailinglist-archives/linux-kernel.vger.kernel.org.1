Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690F42D093F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgLGCxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgLGCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607309513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LK1gkUDCVU2wXhLmdo9y4e2VFlC9AyfBMYWVi3JTuH0=;
        b=TT23swG/ZLhdn2bQM4s5FcY9hj/Qjt55Ae6s5mZdaut8q2QG3gZjoldTGVerlJXcnYvtDK
        DPOWOVuaUzpiJNHOgsUJVNJd8HNWv+Fk6FjVx0IJ8i3cliJBCzQJPYu8bO0F47S/lKHTm/
        MsF65oSC5J62Gf/PrcaKh15xboEDaa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-qTtKdB2CO4-FOUQ3lhPbRQ-1; Sun, 06 Dec 2020 21:51:51 -0500
X-MC-Unique: qTtKdB2CO4-FOUQ3lhPbRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52ECC801B12;
        Mon,  7 Dec 2020 02:51:50 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8164E5D9DC;
        Mon,  7 Dec 2020 02:51:45 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     lulu@redhat.com
References: <20201206105719.123753-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <dd7cde10-2e75-1bd3-68ad-f4988274b37d@redhat.com>
Date:   Mon, 7 Dec 2020 10:51:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201206105719.123753-1-elic@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/6 下午6:57, Eli Cohen wrote:
> Make sure to put write memory barrier after updating CQ consumer index
> so the hardware knows that there are available CQE slots in the queue.
>
> Failure to do this can cause the update of the RX doorbell record to get
> updated before the CQ consumer index resulting in CQ overrun.
>
> Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1f4089c6f9d7..295f46eea2a5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
>   static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
>   {
>   	mlx5_cq_set_ci(&mvq->cq.mcq);
> +
> +	/* make sure CQ cosumer update is visible to the hardware before updating
> +	 * RX doorbell record.
> +	 */
> +	wmb();
>   	rx_post(&mvq->vqqp, num);
>   	if (mvq->event_cb.callback)
>   		mvq->event_cb.callback(mvq->event_cb.private);


Acked-by: Jason Wang <jasowang@redhat.com>


