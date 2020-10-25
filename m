Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DA2980FE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 10:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414834AbgJYJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 05:34:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8140 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414827AbgJYJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 05:34:33 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9546ad0000>; Sun, 25 Oct 2020 02:34:37 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 25 Oct
 2020 09:34:07 +0000
Date:   Sun, 25 Oct 2020 11:34:04 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rob.miller@broadcom.com" <rob.miller@broadcom.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "saugatm@xilinx.com" <saugatm@xilinx.com>,
        "vmireyno@marvell.com" <vmireyno@marvell.com>,
        "zhangweining@ruijie.com.cn" <zhangweining@ruijie.com.cn>,
        "eli@mellanox.com" <eli@mellanox.com>
Subject: Re: [PATCH V4 1/3] vdpa: introduce config op to get valid iova range
Message-ID: <20201025093404.GC189473@mtl-vdi-166.wap.labs.mlnx>
References: <20201023090043.14430-1-jasowang@redhat.com>
 <20201023090043.14430-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201023090043.14430-2-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603618478; bh=o/uG0K7rIUGrVC3mPxjGqi4veKvDNBJAsJoTCKUSR1o=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=T3BJ71oc5UWOaDW78oYSOGiTl44kZDpJo2zRelIYRU+bG/EvQlw+4V4UPNqcDnx30
         thRguF2rH4uS4O2WF2K0M3wZeikCpoBg+GIiCrT9q8GKKn7Zz4iXYdaE3ICy8Bmm2W
         B0WNYR7c3Tz1Q/QNqZmVVHMnAUI3lqDykGMmVoMiQ2L/pJ1Gz5H+plBhl58GuRwDh/
         LqFdrW6HD06fukfHc4A/YUOv+ZeYgcb+qvrCzAYJMO/n+TVJLolRhAFFV1dIlBbSUP
         MUxteVsYGhGefvtU9AWDSsWosv6Jxmq7oJpVh8WIqOGmJ8BKsT5Y98Uc+NrsS8EpjR
         g+oHkqpwv9VTQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 09:00:41AM +0000, Jason Wang wrote:
> This patch introduce a config op to get valid iova range from the vDPA
> device.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  include/linux/vdpa.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index eae0bfd87d91..30bc7a7223bb 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -52,6 +52,16 @@ struct vdpa_device {
>  	int nvqs;
>  };
>  
> +/**
> + * vDPA IOVA range - the IOVA range support by the device
> + * @first: start of the IOVA range
> + * @last: end of the IOVA range
> + */
> +struct vdpa_iova_range {
> +	u64 first;
> +	u64 last;
> +};
> +
>  /**
>   * vDPA_config_ops - operations for configuring a vDPA device.
>   * Note: vDPA device drivers are required to implement all of the
> @@ -151,6 +161,10 @@ struct vdpa_device {
>   * @get_generation:		Get device config generation (optional)
>   *				@vdev: vdpa device
>   *				Returns u32: device generation
> + * @get_iova_range:		Get supported iova range (optional)
> + *				@vdev: vdpa device
> + *				Returns the iova range supported by
> + *				the device.
>   * @set_map:			Set device memory mapping (optional)
>   *				Needed for device that using device
>   *				specific DMA translation (on-chip IOMMU)
> @@ -216,6 +230,7 @@ struct vdpa_config_ops {
>  	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
>  			   const void *buf, unsigned int len);
>  	u32 (*get_generation)(struct vdpa_device *vdev);
> +	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
>  
>  	/* DMA ops */
>  	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> -- 
> 2.20.1
> 
