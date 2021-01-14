Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C172F5B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbhANHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:24:23 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2290 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbhANHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:24:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffff17e0004>; Wed, 13 Jan 2021 23:23:42 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 14 Jan 2021 07:23:41 +0000
Date:   Thu, 14 Jan 2021 09:23:37 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mlx5: vdpa: fix possible uninitialized var
Message-ID: <20210114072337.GA56040@mtl-vdi-166.wap.labs.mlnx>
References: <20210114070904.9981-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210114070904.9981-1-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610609022; bh=Y+O0Q1SZHPJB/4t0JH9sbkNndxD681hAnv3lrZlmtNE=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=jpcmxxhLgmqggmWy5TJxy5bixku+rjmQ50b2X1SfVCgVuhc3wtEVFa5jbIW9reRd2
         /r29k5xYRcF49kaUGBavuE6MCbOonlyvMvShbQjucMruulQqkmGf8po7zh+7LcVZpy
         5Ss6S8movsyge8H82QQSROcfVqp033OLWdANUKEM7hN3mxGL+jYQxdntiEh+ChCafA
         1QVFHn3EU/8vRMvEttfhoTK+MgVzxpNcdCB2EFcMflGpCDo9yLdxIV19eirVxpTR8b
         B0ggP9hC5+ESwfg4vd8fxnOrLpUrNylZWOQNUvl3zB5Fxmo7EOpcxA0488wyE+nHfl
         mdZ7uyByu1BZA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 03:09:04PM +0800, Jason Wang wrote:
> When compiling with -Werror=maybe-uninitialized, gcc may complains the
Maybe you want to fix to: gcc may complain about possible...

Other than that:
Acked-by: Eli Cohen <elic@nvidia.com>

> possible uninitialized umem. Since the callers won't pass value other
> than 1 to 3, making 3 as default to fix the compiler warning.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f1d54814db97..07ccc61cd6f6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -703,7 +703,7 @@ static void umem_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
>  	case 2:
>  		umem = &mvq->umem2;
>  		break;
> -	case 3:
> +	default:
>  		umem = &mvq->umem3;
>  		break;
>  	}
> -- 
> 2.25.1
> 
