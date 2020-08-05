Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA723C59A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 08:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHEGOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 02:14:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53413 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgHEGOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596608056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aaWmcHGY7Cv+glGIbRLTWs4HjQHo9NpEf8CpRt6EP8g=;
        b=BGS9a+BdMejA82D1I3on4hV1LuDfRZKaXXVZechw+EdlSmXHhccrXJLY9f05UODzLYi48O
        VBQ7NihObijhVSprw2LEhhmgxEsCi7+8vYxROg9iEeRnBv0I3UoWcfshIm7mSnndwnrfGe
        xHPtYkrYRUvFq1jm74jbqpCYALd9RjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-fHKCIQLmNaat0cgWcRBf1Q-1; Wed, 05 Aug 2020 02:14:14 -0400
X-MC-Unique: fHKCIQLmNaat0cgWcRBf1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1942D1902EA0;
        Wed,  5 Aug 2020 06:14:13 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1799A71D1D;
        Wed,  5 Aug 2020 06:14:08 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
Date:   Wed, 5 Aug 2020 14:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-20-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
> Some legacy guests just assume features are 0 after reset.
> We detect that config space is accessed before features are
> set and set features to 0 automatically.
> Note: some legacy guests might not even access config space, if this is
> reported in the field we might need to catch a kick to handle these.


I wonder whether it's easier to just support modern device?

Thanks


>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/vdpa/vdpa.c  |  1 +
>   include/linux/vdpa.h | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index de211ef3738c..7105265e4793 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -96,6 +96,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   	vdev->dev.release = vdpa_release_dev;
>   	vdev->index = err;
>   	vdev->config = config;
> +	vdev->features_valid = false;
>   
>   	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
>   	if (err)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 239db794357c..29b8296f1414 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -33,12 +33,14 @@ struct vdpa_notification_area {
>    * @dma_dev: the actual device that is performing DMA
>    * @config: the configuration ops for this device.
>    * @index: device index
> + * @features_valid: were features initialized? for legacy guests
>    */
>   struct vdpa_device {
>   	struct device dev;
>   	struct device *dma_dev;
>   	const struct vdpa_config_ops *config;
>   	unsigned int index;
> +	bool features_valid;
>   };
>   
>   /**
> @@ -266,4 +268,36 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>   {
>   	return vdev->dma_dev;
>   }
> +
> +static inline void vdpa_reset(struct vdpa_device *vdev)
> +{
> +        const struct vdpa_config_ops *ops = vdev->config;
> +
> +	vdev->features_valid = false;
> +        ops->set_status(vdev, 0);
> +}
> +
> +static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> +{
> +        const struct vdpa_config_ops *ops = vdev->config;
> +
> +	vdev->features_valid = true;
> +        return ops->set_features(vdev, features);
> +}
> +
> +
> +static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
> +				   void *buf, unsigned int len)
> +{
> +        const struct vdpa_config_ops *ops = vdev->config;
> +
> +	/*
> +	 * Config accesses aren't supposed to trigger before features are set.
> +	 * If it does happen we assume a legacy guest.
> +	 */
> +	if (!vdev->features_valid)
> +		vdpa_set_features(vdev, 0);
> +	ops->get_config(vdev, offset, buf, len);
> +}
> +
>   #endif /* _LINUX_VDPA_H */

