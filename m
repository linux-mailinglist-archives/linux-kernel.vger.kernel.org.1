Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE082F05BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 07:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbhAJGkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 01:40:41 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19563 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbhAJGkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 01:40:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffaa1400001>; Sat, 09 Jan 2021 22:40:00 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Sun, 10 Jan 2021 06:39:58 +0000
Date:   Sun, 10 Jan 2021 08:39:55 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mlx5: vdpa: fix possible uninitialized var
Message-ID: <20210110063955.GA115874@mtl-vdi-166.wap.labs.mlnx>
References: <20210108082443.5609-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210108082443.5609-1-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610260800; bh=JTT7LraeNZwxgbWXZ93S3R16J1s+M871mksvKda7ArA=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=Fzf7hRVqwqvu/A9pHll5tOrNbH/WNIVqCySWEFcLLm3avVzqILnqgCZT+wjeWi/I6
         J2WWGYBqQb1IWRUwj/TlaUP3vKHBwRB/f+AWaLy1+v8XSMWEKJwjEpijkcB5S21DDu
         utB73fLfQ6hhpKb3YrIBBnsKAhwfjKBauPbQ13gHxMrP5HcwZAXBuTT4eCeea8cMRH
         kh+dzudzDV7Njid8sQwLbgyfZvBf35bEQ7KXHch9kZppVL/vR0s75iyBHFl6HiaeeN
         jT/J7CWaN9YTcqT1vRQ908b3G0mJoLQpAJD7cFxZhknlcTIXKYjzzTWZ38dAxoMwck
         bJYLZ7uuBQV6Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:24:43PM +0800, Jason Wang wrote:
> Upstream: posted
> 
> When compiling with -Werror=maybe-uninitialized, gcc may complains the
> possible uninitialized umem. Fix that.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f1d54814db97..a6ad83d8d8e2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -706,6 +706,9 @@ static void umem_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
>  	case 3:
>  		umem = &mvq->umem3;
>  		break;
> +	default:
> +		WARN(1, "unsupported umem num %d\n", num);
> +		return;
>  	}
>  
>  	MLX5_SET(destroy_umem_in, in, opcode, MLX5_CMD_OP_DESTROY_UMEM);

Since the "default" case will never be executed, maybe it's better to
just change "case 3:" to "default:" and avoid the WARN().

> -- 
> 2.25.1
> 
