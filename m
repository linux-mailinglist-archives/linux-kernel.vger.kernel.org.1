Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77152980FD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 10:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414820AbgJYJdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 05:33:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3428 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgJYJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 05:33:08 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f95465c0000>; Sun, 25 Oct 2020 02:33:16 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 25 Oct
 2020 09:32:43 +0000
Date:   Sun, 25 Oct 2020 11:32:39 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <rob.miller@broadcom.com>,
        <lingshan.zhu@intel.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        <shahafs@mellanox.com>, <hanand@xilinx.com>,
        <mhabets@solarflare.com>, <gdawar@xilinx.com>,
        <saugatm@xilinx.com>, <vmireyno@marvell.com>,
        <zhangweining@ruijie.com.cn>, <eli@mellanox.com>
Subject: Re: [PATCH V3 2/3] vhost: vdpa: report iova range
Message-ID: <20201025093239.GB189473@mtl-vdi-166.wap.labs.mlnx>
References: <20201023022454.24402-1-jasowang@redhat.com>
 <20201023022454.24402-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201023022454.24402-3-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603618396; bh=Eyl7fsMdnIftwHgp3OSxS7VtjJZre+idt3z1TdxFCcY=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=m+sg1QNNPik4ZOTQtAHTn8tNmohPPyubyfwpQY6cCTQYT95PkeEeC2c4jDI7btmOp
         N5O0LMfvFTPsVLf5yYsC19ZXYKLxKL4t+/8kemk1KY8RrAhmHBejDvTmlRlpgHJzYq
         phsRjQbsXHKq9OuiFhmU6L8dNhgW0+Ehm9z4JviGsqzjKsn/ikdGq1QwuBUpA1UgUp
         S0qx+vdKaRagCH+s6aDHoYlRJiC3PUhfZm2zwkQbTNLztDxdVwlKTFhPoiyVi3P6xn
         FUTKn0l7SB2Iurc2eAIKCb3JcGFb6nykZHd+szC2BemdlOpW2Kw21rVNiDQN+IrO+2
         1B2vvFv5lh0xw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 10:24:53AM +0800, Jason Wang wrote:
> This patch introduces a new ioctl for vhost-vdpa device that can
> report the iova range by the device.
> 
> For device that implements get_iova_range() method, we fetch it from
> the vDPA device. If device doesn't implement get_iova_range() but
> depends on platform IOMMU, we will query via DOMAIN_ATTR_GEOMETRY,
> otherwise [0, ULLONG_MAX] is assumed.
> 
> For safety, this patch also rules out the map request which is not in
> the valid range.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vdpa.c             | 40 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h       |  4 ++++
>  include/uapi/linux/vhost_types.h |  9 +++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index a2dbc85e0b0d..562ed99116d1 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -47,6 +47,7 @@ struct vhost_vdpa {
>  	int minor;
>  	struct eventfd_ctx *config_ctx;
>  	int in_batch;
> +	struct vdpa_iova_range range;
>  };
>  
>  static DEFINE_IDA(vhost_vdpa_ida);
> @@ -337,6 +338,16 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
>  	return 0;
>  }
>  
> +static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> +{
> +	struct vhost_vdpa_iova_range range = {
> +		.first = v->range.first,
> +		.last = v->range.last,
> +	};
> +
> +	return copy_to_user(argp, &range, sizeof(range));
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				   void __user *argp)
>  {
> @@ -470,6 +481,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	case VHOST_GET_BACKEND_FEATURES:
>  		features = VHOST_VDPA_BACKEND_FEATURES;
>  		r = copy_to_user(featurep, &features, sizeof(features));

missing break statement.

> +	case VHOST_VDPA_GET_IOVA_RANGE:
> +		r = vhost_vdpa_get_iova_range(v, argp);
>  		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> @@ -597,6 +610,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  	long pinned;
>  	int ret = 0;
>  
> +	if (msg->iova < v->range.first ||
> +	    msg->iova + msg->size - 1 > v->range.last)
> +		return -EINVAL;
> +
>  	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>  				    msg->iova + msg->size - 1))
>  		return -EEXIST;
> @@ -783,6 +800,27 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
>  	v->domain = NULL;
>  }
>  
> +static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
> +{
> +	struct vdpa_iova_range *range = &v->range;
> +	struct iommu_domain_geometry geo;
> +	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +
> +	if (ops->get_iova_range) {
> +		*range = ops->get_iova_range(vdpa);
> +	} else if (v->domain &&
> +		   !iommu_domain_get_attr(v->domain,
> +		   DOMAIN_ATTR_GEOMETRY, &geo) &&
> +		   geo.force_aperture) {
> +		range->first = geo.aperture_start;
> +		range->last = geo.aperture_end;
> +	} else {
> +		range->first = 0;
> +		range->last = ULLONG_MAX;
> +	}
> +}
> +
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  {
>  	struct vhost_vdpa *v;
> @@ -823,6 +861,8 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	if (r)
>  		goto err_init_iotlb;
>  
> +	vhost_vdpa_set_iova_range(v);
> +
>  	filep->private_data = v;
>  
>  	return 0;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 75232185324a..c998860d7bbc 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -146,4 +146,8 @@
>  
>  /* Set event fd for config interrupt*/
>  #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
> +
> +/* Get the valid iova range */
> +#define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
> +					     struct vhost_vdpa_iova_range)
>  #endif
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index 9a269a88a6ff..f7f6a3a28977 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -138,6 +138,15 @@ struct vhost_vdpa_config {
>  	__u8 buf[0];
>  };
>  
> +/* vhost vdpa IOVA range
> + * @first: First address that can be mapped by vhost-vDPA
> + * @last: Last address that can be mapped by vhost-vDPA
> + */
> +struct vhost_vdpa_iova_range {
> +	__u64 first;
> +	__u64 last;
> +};
> +
>  /* Feature bits */
>  /* Log all write descriptors. Can be changed while device is active. */
>  #define VHOST_F_LOG_ALL 26
> -- 
> 2.20.1
> 
