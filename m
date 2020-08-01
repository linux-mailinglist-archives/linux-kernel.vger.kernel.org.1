Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9486E235314
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHAPro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 11:47:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726534AbgHAPrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596296859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TrpsRAqI1Qi7vP33TLS3beeOWj9mCMIwhrm586wYXU=;
        b=dHdQXh/val2X7Fhdxdxa5UQHqbM1Y3YHuHMaKesydCGj7ZELMKhCFYEi+dgwqtRRnzro7x
        AF/8KxorKsHPxSAQTABK1NRb0+WTlJaq9qPtoSUhC2GjoETHKvYSo8FZ3N2qiX1SNJO9t4
        u/gItHW6YtH/H8A+P0NVjuwhoHQ17fM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-LyNOGBUmPiKn5v6A4BL9rg-1; Sat, 01 Aug 2020 11:47:38 -0400
X-MC-Unique: LyNOGBUmPiKn5v6A4BL9rg-1
Received: by mail-qk1-f198.google.com with SMTP id v22so7069195qkg.15
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 08:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3TrpsRAqI1Qi7vP33TLS3beeOWj9mCMIwhrm586wYXU=;
        b=o5JgV7+he5BWVCTyCWuGh5LG8zgBjFFRl684MxjXdMTtDZz/xatuEXgr9MM3ZVdFH1
         UMTvVvFqfp2Sk22Gf24rhIDuXkSr/DNPXDNn7iTRqQ3zrj8yeBwBeGiQOIWz1o2XpiN3
         A1u35W48olGOr/4euZycVNXO1HWyygfFOn+RV+NdQUxa7dkffnd+C00xJ53GbxUE1C/p
         1S2vaBy2LrY669VCtaBjNqqA8xWYntAcdw3pGxCAYLajMNdan1gJyBYXjpze4phjp5BD
         T//t5EfxTDVpPbs3ApuLfn0GIaopqr53rIOJpnIFoRSiGtvLDYgI7tf7kha/4MIgNE8E
         tOYA==
X-Gm-Message-State: AOAM531E1SsSLl/QEn0StcfHIaVGYGw6mGYRbr7iu9iGze49B84ZWmcD
        d6fOYqTCDrVxLKKZlUrwItg7WLd3LL5843Fsszf2D+iNC0D2ZzvEpzFWt9VAe7rh7aV8YSnW4IL
        NYy/G+mqBrVduYtRspwWDbvmM
X-Received: by 2002:a37:3c1:: with SMTP id 184mr8913961qkd.312.1596296857809;
        Sat, 01 Aug 2020 08:47:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4bo66LBratv6aXBdVwckH+fKWSKZle1J40Q+Rw3nOmtYgzpaA30ahdg3yiwzaAfPl7QIJjQ==
X-Received: by 2002:a37:3c1:: with SMTP id 184mr8913941qkd.312.1596296857426;
        Sat, 01 Aug 2020 08:47:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x5sm13123296qtp.76.2020.08.01.08.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 08:47:36 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] fpga: dfl: create a dfl bus type to support DFL
 devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-4-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d1e4aa0a-608f-5131-fc8c-12621e0759a9@redhat.com>
Date:   Sat, 1 Aug 2020 08:47:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1595556555-9903-4-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is fine.

Please add.

Reviewed-by: Tom Rix <trix@redhat.com>

Thanks

Tom

On 7/23/20 7:09 PM, Xu Yilun wrote:
> A new bus type "dfl" is introduced for private features which are not
> initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> private features could be handled by separate driver modules.
>
> DFL feature drivers (dfl-fme, dfl-port) will create DFL devices on
> enumeration. DFL drivers could be registered on this bus to match these
> DFL devices. They are matched by dfl type & feature_id.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ----
> v2: change the bus uevent format.
>     change the dfl device's sysfs name format.
>     refactor dfl_dev_add().
>     minor fixes for comments from Hao and Tom.
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl.c                      | 254 +++++++++++++++++++++++++++++++-
>  drivers/fpga/dfl.h                      |  84 +++++++++++
>  3 files changed, 345 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> new file mode 100644
> index 0000000..b1eea30
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/dfl/devices/.../type
> +Date:		July 2020
> +KernelVersion:	5.9
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> +		supports 2 FIU types, 0 for FME, 1 for PORT.
> +		Format: 0x%x
> +
> +What:		/sys/bus/dfl/devices/.../feature_id
> +Date:		July 2020
> +KernelVersion:	5.9
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns feature identifier local to its DFL FIU
> +		type.
> +		Format: 0x%x
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b675957..c437053 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -30,12 +30,6 @@ static DEFINE_MUTEX(dfl_id_mutex);
>   * index to dfl_chardevs table. If no chardev support just set devt_type
>   * as one invalid index (DFL_FPGA_DEVT_MAX).
>   */
> -enum dfl_id_type {
> -	FME_ID,		/* fme id allocation and mapping */
> -	PORT_ID,	/* port id allocation and mapping */
> -	DFL_ID_MAX,
> -};
> -
>  enum dfl_fpga_devt_type {
>  	DFL_FPGA_DEVT_FME,
>  	DFL_FPGA_DEVT_PORT,
> @@ -250,6 +244,236 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>  
> +static DEFINE_IDA(dfl_device_ida);
> +
> +static const struct dfl_device_id *
> +dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device *ddev)
> +{
> +	if (id->type == ddev->type && id->feature_id == ddev->feature_id)
> +		return id;
> +
> +	return NULL;
> +}
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct dfl_driver *ddrv = to_dfl_drv(drv);
> +	const struct dfl_device_id *id_entry = ddrv->id_table;
> +
> +	if (id_entry) {
> +		while (id_entry->feature_id) {
> +			if (dfl_match_one_device(id_entry, ddev)) {
> +				ddev->id_entry = id_entry;
> +				return 1;
> +			}
> +			id_entry++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_probe(struct device *dev)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct dfl_driver *ddrv = to_dfl_drv(dev->driver);
> +
> +	return ddrv->probe(ddev);
> +}
> +
> +static int dfl_bus_remove(struct device *dev)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct dfl_driver *ddrv = to_dfl_drv(dev->driver);
> +
> +	if (ddrv->remove)
> +		ddrv->remove(ddev);
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +
> +	return add_uevent_var(env, "MODALIAS=dfl:t%08Xf%04X",
> +			      ddev->type, ddev->feature_id);
> +}
> +
> +/* show dfl info fields */
> +#define dfl_info_attr(field, format_string)				\
> +static ssize_t								\
> +field##_show(struct device *dev, struct device_attribute *attr,		\
> +	     char *buf)							\
> +{									\
> +	struct dfl_device *ddev = to_dfl_dev(dev);			\
> +									\
> +	return sprintf(buf, format_string, ddev->field);		\
> +}									\
> +static DEVICE_ATTR_RO(field)
> +
> +dfl_info_attr(type, "0x%x\n");
> +dfl_info_attr(feature_id, "0x%x\n");
> +
> +static struct attribute *dfl_dev_attrs[] = {
> +	&dev_attr_type.attr,
> +	&dev_attr_feature_id.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(dfl_dev);
> +
> +static struct bus_type dfl_bus_type = {
> +	.name		= "dfl",
> +	.match		= dfl_bus_match,
> +	.probe		= dfl_bus_probe,
> +	.remove		= dfl_bus_remove,
> +	.uevent		= dfl_bus_uevent,
> +	.dev_groups	= dfl_dev_groups,
> +};
> +
> +static void release_dfl_dev(struct device *dev)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +
> +	if (ddev->mmio_res.parent)
> +		release_resource(&ddev->mmio_res);
> +
> +	ida_simple_remove(&dfl_device_ida, ddev->id);
> +	kfree(ddev->irqs);
> +	kfree(ddev);
> +}
> +
> +static struct dfl_device *
> +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +	    struct dfl_feature *feature)
> +{
> +	struct platform_device *pdev = pdata->dev;
> +	struct resource *parent_res;
> +	struct dfl_device *ddev;
> +	int id, i, ret;
> +
> +	ddev = kzalloc(sizeof(*ddev), GFP_KERNEL);
> +	if (!ddev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id = ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		dev_err(&pdev->dev, "unable to get id\n");
> +		kfree(ddev);
> +		return ERR_PTR(id);
> +	}
> +
> +	/* freeing resources by put_device() after device_initialize() */
> +	device_initialize(&ddev->dev);
> +	ddev->dev.parent = &pdev->dev;
> +	ddev->dev.bus = &dfl_bus_type;
> +	ddev->dev.release = release_dfl_dev;
> +	ddev->id = id;
> +	ret = dev_set_name(&ddev->dev, "dfl_dev.%d", id);
> +	if (ret)
> +		goto put_dev;
> +
> +	ddev->type = feature_dev_id_type(pdev);
> +	ddev->feature_id = feature->id;
> +	ddev->cdev = pdata->dfl_cdev;
> +
> +	/* add mmio resource */
> +	parent_res = &pdev->resource[feature->resource_index];
> +	ddev->mmio_res.flags = IORESOURCE_MEM;
> +	ddev->mmio_res.start = parent_res->start;
> +	ddev->mmio_res.end = parent_res->end;
> +	ddev->mmio_res.name = dev_name(&ddev->dev);
> +	ret = insert_resource(parent_res, &ddev->mmio_res);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> +			dev_name(&ddev->dev), &ddev->mmio_res);
> +		goto put_dev;
> +	}
> +
> +	/* then add irq resource */
> +	if (feature->nr_irqs) {
> +		ddev->irqs = kcalloc(feature->nr_irqs,
> +				     sizeof(*ddev->irqs), GFP_KERNEL);
> +		if (!ddev->irqs) {
> +			ret = -ENOMEM;
> +			goto put_dev;
> +		}
> +
> +		for (i = 0; i < feature->nr_irqs; i++)
> +			ddev->irqs[i] = feature->irq_ctx[i].irq;
> +
> +		ddev->num_irqs = feature->nr_irqs;
> +	}
> +
> +	ret = device_add(&ddev->dev);
> +	if (ret)
> +		goto put_dev;
> +
> +	dev_info(&pdev->dev, "add dfl_dev: %s\n", dev_name(&ddev->dev));
> +	return ddev;
> +
> +put_dev:
> +	/* calls release_dfl_dev() which does the clean up  */
> +	put_device(&ddev->dev);
> +	return ERR_PTR(ret);
> +}
> +
> +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> +{
> +	struct dfl_device *ddev;
> +	struct dfl_feature *feature;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (!feature->ioaddr && feature->priv) {
> +			ddev = feature->priv;
> +			device_unregister(&ddev->dev);
> +			feature->priv = NULL;
> +		}
> +	}
> +}
> +
> +static int dfl_devs_init(struct platform_device *pdev)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct dfl_feature *feature;
> +	struct dfl_device *ddev;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (feature->ioaddr || feature->priv)
> +			continue;
> +
> +		ddev = dfl_dev_add(pdata, feature);
> +		if (IS_ERR(ddev)) {
> +			dfl_devs_uinit(pdata);
> +			return PTR_ERR(ddev);
> +		}
> +
> +		feature->priv = ddev;
> +	}
> +
> +	return 0;
> +}
> +
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
> +{
> +	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +		return -EINVAL;
> +
> +	dfl_drv->drv.owner = owner;
> +	dfl_drv->drv.bus = &dfl_bus_type;
> +
> +	return driver_register(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(__dfl_driver_register);
> +
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv)
> +{
> +	driver_unregister(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(dfl_driver_unregister);
> +
>  #define is_header_feature(feature) ((feature)->id == FEATURE_ID_FIU_HEADER)
>  
>  /**
> @@ -261,12 +485,15 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct dfl_feature *feature;
>  
> -	dfl_fpga_dev_for_each_feature(pdata, feature)
> +	dfl_devs_uinit(pdata);
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>  		if (feature->ops) {
>  			if (feature->ops->uinit)
>  				feature->ops->uinit(pdev, feature);
>  			feature->ops = NULL;
>  		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
>  
> @@ -347,6 +574,10 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>  		drv++;
>  	}
>  
> +	ret = dfl_devs_init(pdev);
> +	if (ret)
> +		goto exit;
> +
>  	return 0;
>  exit:
>  	dfl_fpga_dev_feature_uinit(pdev);
> @@ -1285,11 +1516,17 @@ static int __init dfl_fpga_init(void)
>  {
>  	int ret;
>  
> +	ret = bus_register(&dfl_bus_type);
> +	if (ret)
> +		return ret;
> +
>  	dfl_ids_init();
>  
>  	ret = dfl_chardev_init();
> -	if (ret)
> +	if (ret) {
>  		dfl_ids_destroy();
> +		bus_unregister(&dfl_bus_type);
> +	}
>  
>  	return ret;
>  }
> @@ -1627,6 +1864,7 @@ static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
>  	dfl_ids_destroy();
> +	bus_unregister(&dfl_bus_type);
>  }
>  
>  module_init(dfl_fpga_init);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 704efec..7b196867 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -520,4 +520,88 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>  
> +/**
> + * enum dfl_id_type - define the DFL FIU types
> + */
> +enum dfl_id_type {
> +	FME_ID,
> +	PORT_ID,
> +	DFL_ID_MAX,
> +};
> +
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @driver_data: Driver specific data
> + */
> +struct dfl_device_id {
> +	unsigned int type;
> +	u16 feature_id;
> +	unsigned long driver_data;
> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: Generic device interface.
> + * @id: id of the dfl device
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: MMIO resource of this dfl device.
> + * @irqs: List of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	int id;
> +	unsigned int type;
> +	u16 feature_id;
> +	struct resource mmio_res;
> +	int *irqs;
> +	unsigned int num_irqs;
> +	struct dfl_fpga_cdev *cdev;
> +	const struct dfl_device_id *id_entry;
> +};
> +
> +/**
> + * struct dfl_driver - represent an dfl device driver
> + *
> + * @drv: Driver model structure.
> + * @id_table: Pointer to table of device IDs the driver is interested in.
> + *	      { } member terminated.
> + * @probe: Callback for device binding.
> + * @remove: Callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	void (*remove)(struct dfl_device *dfl_dev);
> +};
> +
> +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE
> + */
> +#define dfl_driver_register(drv) \
> +	__dfl_driver_register(drv, THIS_MODULE)
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +
> +/*
> + * module_dfl_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
>  #endif /* __FPGA_DFL_H */

