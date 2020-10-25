Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B260C298100
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414860AbgJYJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 05:35:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13419 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414681AbgJYJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 05:35:13 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9546bb0000>; Sun, 25 Oct 2020 02:34:51 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 25 Oct
 2020 09:34:46 +0000
Date:   Sun, 25 Oct 2020 11:34:43 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <rob.miller@broadcom.com>,
        <lingshan.zhu@intel.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        <shahafs@mellanox.com>, <hanand@xilinx.com>,
        <mhabets@solarflare.com>, <gdawar@xilinx.com>,
        <saugatm@xilinx.com>, <vmireyno@marvell.com>,
        <zhangweining@ruijie.com.cn>, <eli@mellanox.com>
Subject: Re: [PATCH V4 3/3] vdpa_sim: implement get_iova_range()
Message-ID: <20201025093442.GD189473@mtl-vdi-166.wap.labs.mlnx>
References: <20201023090043.14430-1-jasowang@redhat.com>
 <20201023090043.14430-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201023090043.14430-4-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603618492; bh=stNXL2ug/knTeKu9ulfDtR8849WCFlPbe7OYw5ndaxs=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=eMkUOVr73hVRoPNsAmvwLm6Jg5VckgLLF8akHmIG5wtNX2Bzv1U1PU9SCgMj0n4Qa
         5qmzkHHDe2aNy4pc9015IdLw9iT9/WhPEOvbOP+K0BrmUljcvf7D/1wXn4yxNxPODB
         7ch9r3kKM4klHfA879AJA0azEayRHgkPthis+NyO9JnRMRYpw962PVXI5Gxc0GJ6Od
         kis9rcB+ve8cbiZT3PqmCwE+V16wXJkMnh2TairdeXoJkWBY5v0lWTtZw38/TPTXm7
         glVWC1z9mD8eEvznf3CRlIhmADuu6hz2AGNr7UdiCyxTnFDmCizP1Ur38RRz/98cgq
         mxaPnybs8tSMQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:00:43PM +0800, Jason Wang wrote:
> This implements a sample get_iova_range() for the simulator which
> advertise [0, ULLONG_MAX] as the valid range.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 62d640327145..ff6c9fd8d879 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -574,6 +574,16 @@ static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
>  	return vdpasim->generation;
>  }
>  
> +static struct vdpa_iova_range vdpasim_get_iova_range(struct vdpa_device *vdpa)
> +{
> +	struct vdpa_iova_range range = {
> +		.first = 0ULL,
> +		.last = ULLONG_MAX,
> +	};
> +
> +	return range;
> +}
> +
>  static int vdpasim_set_map(struct vdpa_device *vdpa,
>  			   struct vhost_iotlb *iotlb)
>  {
> @@ -657,6 +667,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
>  	.get_config             = vdpasim_get_config,
>  	.set_config             = vdpasim_set_config,
>  	.get_generation         = vdpasim_get_generation,
> +	.get_iova_range         = vdpasim_get_iova_range,
>  	.dma_map                = vdpasim_dma_map,
>  	.dma_unmap              = vdpasim_dma_unmap,
>  	.free                   = vdpasim_free,
> @@ -683,6 +694,7 @@ static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
>  	.get_config             = vdpasim_get_config,
>  	.set_config             = vdpasim_set_config,
>  	.get_generation         = vdpasim_get_generation,
> +	.get_iova_range         = vdpasim_get_iova_range,
>  	.set_map                = vdpasim_set_map,
>  	.free                   = vdpasim_free,
>  };
> -- 
> 2.20.1
> 
