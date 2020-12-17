Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD22DD213
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLQNYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727385AbgLQNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608211387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlVf+FHlKW5NSk9hq2l37/fFa7FHsGlOWn1DRV6wf4o=;
        b=Dr6c1ybIzEKs6FWkGfSXlM99dVCw/bUNo2CvoOFiq/UDAuJ3je8tVMZkggwCuMynetfRH9
        1B4yajRYbj6uR4DVlC+mzXSd1xTi5ZasX8wBZlZq0kbqFxivJAUOgaOBP5tJoah1J3bHB0
        /CxAc2CyH3I7I4/7q+efsfT7KEzIWyw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-hPF8a_KsNeyWYfcfEv10Vg-1; Thu, 17 Dec 2020 08:23:05 -0500
X-MC-Unique: hPF8a_KsNeyWYfcfEv10Vg-1
Received: by mail-qt1-f198.google.com with SMTP id z43so20687890qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VlVf+FHlKW5NSk9hq2l37/fFa7FHsGlOWn1DRV6wf4o=;
        b=RfUFmzoDj37z/YlkEeOjwpxNF+YPK+FcNSo3C/QlOvdUbluVzfQ63FrLaU/wyMUSF/
         xNxqJE1/U9vsRY+ftZ2dCtIkc7NRpDPVhm5UgwXibrFORolHcFztgSJoCxH1518juktK
         qSmQd6KOsoYnNIwB9sOUuMQyaRoh8feOwW1qP80YyR2YEcejfvvk/m1Jywxt5esrd9sh
         uVNRkyy7YphzLxi4dVyDrLC0szmhQ152rjF7XDnN+RcNeb04i4kQskgyeg005Bsqx7Xw
         /OZO6UJ02aJ/K9VWMpBh7sgYSZpgfaqOAXfqljGKVjJWkbAT+GHdNVqpefONnXxuzXlE
         pwiA==
X-Gm-Message-State: AOAM531MI4gdAg0gyZYwv0DcWUWWhxSepqzunc4qN8EtPEy6pwyQKNqb
        eeEOQTdAkQLOMI3SAHRIluKdk9xG7ht8JC9UYSPFvfXqIMvO7jQDl8HXEKwd65LLHbw2wilY1mt
        NzQxDu57fcn1E70/AOCysfDFY
X-Received: by 2002:a0c:d403:: with SMTP id t3mr689533qvh.4.1608211385318;
        Thu, 17 Dec 2020 05:23:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYVSnHnGs6evLAnR4tS3yXheybtLYXtZ9atG/KqoIuyrRH82prh428jtyp6E1TXAFuQEHUug==
X-Received: by 2002:a0c:d403:: with SMTP id t3mr689519qvh.4.1608211385133;
        Thu, 17 Dec 2020 05:23:05 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i18sm3360997qkg.66.2020.12.17.05.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 05:23:04 -0800 (PST)
Subject: Re: [PATCH v3 1/3] fpga: dfl: add the match() ops for dfl driver
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <1608183881-18692-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3d9f02d0-5937-1cce-db70-9c3e90d32ec3@redhat.com>
Date:   Thu, 17 Dec 2020 05:23:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608183881-18692-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/20 9:44 PM, Xu Yilun wrote:
> The match ops allows dfl drivers have their own matching algorithem
> instead of the standard id_table matching.
>
> This is to support the DFL UIO driver. It intends to match any DFL
> device which could not be handled by other DFL drivers.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
> v3: this patch is splited out from DFL UIO patch.
>     move the declarations of exported symbols from include/linux/dfl.h
>      to driver/fpga/dfl.h
>     fix some comments.
> ---
>  drivers/fpga/dfl.c  | 22 +++++++++++++++++-----
>  drivers/fpga/dfl.h  |  5 +++++
>  include/linux/dfl.h |  3 +++
>  3 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 511b20f..dd90111 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -256,12 +256,13 @@ dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device *ddev)
>  	return NULL;
>  }
>  
> -static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv)
>  {
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> -	struct dfl_driver *ddrv = to_dfl_drv(drv);
>  	const struct dfl_device_id *id_entry;
>  
> +	if (ddrv->match)
> +		return ddrv->match(ddev);
> +
>  	id_entry = ddrv->id_table;
>  	if (id_entry) {
>  		while (id_entry->feature_id) {
> @@ -275,6 +276,15 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dfl_match_device);
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct dfl_driver *ddrv = to_dfl_drv(drv);
> +
> +	return dfl_match_device(ddev, ddrv);
> +}
>  
>  static int dfl_bus_probe(struct device *dev)
>  {
> @@ -328,7 +338,7 @@ static struct attribute *dfl_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(dfl_dev);
>  
> -static struct bus_type dfl_bus_type = {
> +struct bus_type dfl_bus_type = {
>  	.name		= "dfl",
>  	.match		= dfl_bus_match,
>  	.probe		= dfl_bus_probe,
> @@ -336,6 +346,7 @@ static struct bus_type dfl_bus_type = {
>  	.uevent		= dfl_bus_uevent,
>  	.dev_groups	= dfl_dev_groups,
>  };
> +EXPORT_SYMBOL_GPL(dfl_bus_type);
>  
>  static void release_dfl_dev(struct device *dev)
>  {
> @@ -469,7 +480,8 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
>  
>  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
>  {
> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +	if (!dfl_drv || !dfl_drv->probe ||
> +	    (!dfl_drv->id_table && !dfl_drv->match))
>  		return -EINVAL;
>  
>  	dfl_drv->drv.owner = owner;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96..01c43d8 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -17,6 +17,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/cdev.h>
>  #include <linux/delay.h>
> +#include <linux/dfl.h>
>  #include <linux/eventfd.h>
>  #include <linux/fs.h>
>  #include <linux/interrupt.h>
> @@ -517,4 +518,8 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>  
> +extern struct bus_type dfl_bus_type;
> +
> +int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv);
> +
>  #endif /* __FPGA_DFL_H */
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 6cc1098..cfd98a4 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -51,6 +51,8 @@ struct dfl_device {
>   * @drv: driver model structure.
>   * @id_table: pointer to table of device IDs the driver is interested in.
>   *	      { } member terminated.
> + * @match: returns one if given device can be handled by the driver and zero
> + *	   otherwise. If NULL, matching is based on id_table.
>   * @probe: mandatory callback for device binding.
>   * @remove: callback for device unbinding.
>   */
> @@ -58,6 +60,7 @@ struct dfl_driver {
>  	struct device_driver drv;
>  	const struct dfl_device_id *id_table;
>  
> +	int (*match)(struct dfl_device *dfl_dev);
>  	int (*probe)(struct dfl_device *dfl_dev);
>  	void (*remove)(struct dfl_device *dfl_dev);
>  };

