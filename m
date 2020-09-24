Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB02778E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgIXTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728610AbgIXTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600974123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9mLFxNt8BdTHSmuFqr0fMLXeKKH7GA6Iah6wfpl6SY=;
        b=W5aC05zgewCdna/6/75V5LBVIJqe61ozk0QMdfIQ+MIILeTneYfANn1yF6HTDSTiviBJG4
        iA+ZRUKlxX5mzO4JgZuBnI+Bmf121mvnWCs+OhkvSQZ87b11JBJr1NIPI6D2s/Vne6CyQo
        l6paJ3s4hsDZJ/X8p0IAEdGV2JCzVcY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-SDRmwha5MgCRcu_PcBPAUw-1; Thu, 24 Sep 2020 15:02:00 -0400
X-MC-Unique: SDRmwha5MgCRcu_PcBPAUw-1
Received: by mail-oi1-f200.google.com with SMTP id l77so1199146oig.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V9mLFxNt8BdTHSmuFqr0fMLXeKKH7GA6Iah6wfpl6SY=;
        b=mtC0aSu1PVIVCFfjNCZ58HFAl3mOt48RLawYXNwmIpQkG1wcoUZNz81LLrANugxq4G
         HpN1fNjQE1sDYLPHuFToeEqEGk+30xWcwaP0yh1+psrzQ499pbgJ6kxxpwi0KnmdGznT
         ssVgBhq1Nfm7pwRZWbmF/SheMNm8DV18eerKNsLvwJGzaGZA6YBJE42gjAVcQ5FsJUbM
         mrq0cZL9pDDV3Mq38v9k4mq/ImCMbs3W7ZmnXM6U3U9nu2PGWRsfodyHRRA1A06kP3Uv
         8Wf7c8N7ONkGlfW0VgohKocdE2lh6xLmO6YkYfCSnM3B9FpudEvIbpkkQkz1A12sEUEJ
         cBGA==
X-Gm-Message-State: AOAM530PsuejH66d4JURyUCkixt5YgLfITyB80YAYEutPKl7XCBKPIqX
        rZG/g1+CGbKBb/IKtzPJFdL7fNyfdyt3+C9J9M3RRIxcUEh6ExSTstD4KpJbpKBjCmhrG0er+br
        BW3DHb0p0T4y2Pjai13hj1vVU
X-Received: by 2002:aca:f40a:: with SMTP id s10mr157319oih.126.1600974118600;
        Thu, 24 Sep 2020 12:01:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnP2/7FO/Th2/PXqqzr+tXWIBzjy4qIxFw5fo2TNuE1fej61VSiPFVx7LnxK6FGGe/C87ENw==
X-Received: by 2002:aca:f40a:: with SMTP id s10mr157272oih.126.1600974117848;
        Thu, 24 Sep 2020 12:01:57 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v20sm32366oiv.47.2020.09.24.12.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:01:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] fpga: dfl: rename the bus type "dfl" to "fpga-dfl"
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
 <1600966801-30586-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1c3e4af1-d44e-935c-f66c-85d3509c9d18@redhat.com>
Date:   Thu, 24 Sep 2020 12:01:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1600966801-30586-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/20 9:59 AM, Xu Yilun wrote:
> Now the DFL device drivers could be made as independent modules and put
> in different subsystems according to their functionalities. So the name
> should be descriptive and unique in the whole kernel.
>
> The patch changes the naming of dfl bus related structures, functions,
> APIs and documentations.

This set is largely a mechanical change, it looks ok.


The big thing i would recommend giving some thought is

include/uabi/linux/fpga-dfl.h uses the prefix DFL_FPGA

this change uses fpga_dfl.

I do not think it matters where 'fpga' is in the internal names,

so for consistency with the external interface the prefix should dfl_fpga.

>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl      |  15 --
>  Documentation/ABI/testing/sysfs-bus-fpga-dfl |  15 ++
>  MAINTAINERS                                  |   2 +-
>  drivers/fpga/dfl.c                           | 254 ++++++++++++++-------------
>  drivers/fpga/dfl.h                           |  77 ++++----
>  5 files changed, 184 insertions(+), 179 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-fpga-dfl
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> deleted file mode 100644
> index 23543be..0000000
> --- a/Documentation/ABI/testing/sysfs-bus-dfl
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -What:		/sys/bus/dfl/devices/dfl_dev.X/type
> -Date:		Aug 2020
> -KernelVersion:	5.10
> -Contact:	Xu Yilun <yilun.xu@intel.com>
> -Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> -		supports 2 FIU types, 0 for FME, 1 for PORT.
> -		Format: 0x%x
> -
> -What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> -Date:		Aug 2020
> -KernelVersion:	5.10
> -Contact:	Xu Yilun <yilun.xu@intel.com>
> -Description:	Read-only. It returns feature identifier local to its DFL FIU
> -		type.
> -		Format: 0x%x
> diff --git a/Documentation/ABI/testing/sysfs-bus-fpga-dfl b/Documentation/ABI/testing/sysfs-bus-fpga-dfl
> new file mode 100644
> index 0000000..072decf
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-fpga-dfl
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/fpga-dfl/devices/fpga_dfl_dev.X/type
> +Date:		Aug 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns type of FPGA DFL FIU of the device. Now
> +		FPGA DFL supports 2 FIU types, 0 for FME, 1 for PORT.
> +		Format: 0x%x
> +
> +What:		/sys/bus/fpga-dfl/devices/fpga_dfl_dev.X/feature_id

fpga-dfl and fpga_dfl, the prefix needs to be consistent or..

sys/bus/fpga-dfl/ already has the fpga, dfl info and the second one is redundant so could be

/sys/bus/fpga-dfl/devices/dev.X/feature_id


re: mfd's comment.

This is a new, unreleased interface, now is the only we can change it, so lets do it now.

I'd even suggest splitting the patch to get the change into 5.10.

Tom

> +Date:		Aug 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns feature identifier local to its FPGA DFL
> +		FIU type.
> +		Format: 0x%x
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0924930..48c0859 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6839,7 +6839,7 @@ M:	Wu Hao <hao.wu@intel.com>
>  R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-bus-dfl
> +F:	Documentation/ABI/testing/sysfs-bus-fpga-dfl
>  F:	Documentation/fpga/dfl.rst
>  F:	drivers/fpga/dfl*
>  F:	include/uapi/linux/fpga-dfl.h
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b450870..f146cda 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -20,10 +20,10 @@ static DEFINE_MUTEX(dfl_id_mutex);
>  
>  /*
>   * when adding a new feature dev support in DFL framework, it's required to
> - * add a new item in enum dfl_id_type and provide related information in below
> - * dfl_devs table which is indexed by dfl_id_type, e.g. name string used for
> - * platform device creation (define name strings in dfl.h, as they could be
> - * reused by platform device drivers).
> + * add a new item in enum fpga_dfl_id_type and provide related information in
> + * below dfl_devs table which is indexed by fpga_dfl_id_type, e.g. name string
> + * used for platform device creation (define name strings in dfl.h, as they
> + * could be reused by platform device drivers).
>   *
>   * if the new feature dev needs chardev support, then it's required to add
>   * a new item in dfl_chardevs table and configure dfl_devs[i].devt_type as
> @@ -36,9 +36,9 @@ enum dfl_fpga_devt_type {
>  	DFL_FPGA_DEVT_MAX,
>  };
>  
> -static struct lock_class_key dfl_pdata_keys[DFL_ID_MAX];
> +static struct lock_class_key dfl_pdata_keys[FPGA_DFL_ID_MAX];
>  
> -static const char *dfl_pdata_key_strings[DFL_ID_MAX] = {
> +static const char *dfl_pdata_key_strings[FPGA_DFL_ID_MAX] = {
>  	"dfl-fme-pdata",
>  	"dfl-port-pdata",
>  };
> @@ -57,7 +57,7 @@ struct dfl_dev_info {
>  	enum dfl_fpga_devt_type devt_type;
>  };
>  
> -/* it is indexed by dfl_id_type */
> +/* it is indexed by fpga_dfl_id_type */
>  static struct dfl_dev_info dfl_devs[] = {
>  	{.name = DFL_FPGA_FEATURE_DEV_FME, .dfh_id = DFH_ID_FIU_FME,
>  	 .devt_type = DFL_FPGA_DEVT_FME},
> @@ -97,11 +97,11 @@ static void dfl_ids_destroy(void)
>  		idr_destroy(&dfl_devs[i].id);
>  }
>  
> -static int dfl_id_alloc(enum dfl_id_type type, struct device *dev)
> +static int dfl_id_alloc(enum fpga_dfl_id_type type, struct device *dev)
>  {
>  	int id;
>  
> -	WARN_ON(type >= DFL_ID_MAX);
> +	WARN_ON(type >= FPGA_DFL_ID_MAX);
>  	mutex_lock(&dfl_id_mutex);
>  	id = idr_alloc(&dfl_devs[type].id, dev, 0, 0, GFP_KERNEL);
>  	mutex_unlock(&dfl_id_mutex);
> @@ -109,15 +109,15 @@ static int dfl_id_alloc(enum dfl_id_type type, struct device *dev)
>  	return id;
>  }
>  
> -static void dfl_id_free(enum dfl_id_type type, int id)
> +static void dfl_id_free(enum fpga_dfl_id_type type, int id)
>  {
> -	WARN_ON(type >= DFL_ID_MAX);
> +	WARN_ON(type >= FPGA_DFL_ID_MAX);
>  	mutex_lock(&dfl_id_mutex);
>  	idr_remove(&dfl_devs[type].id, id);
>  	mutex_unlock(&dfl_id_mutex);
>  }
>  
> -static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
> +static enum fpga_dfl_id_type feature_dev_id_type(struct platform_device *pdev)
>  {
>  	int i;
>  
> @@ -125,10 +125,10 @@ static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
>  		if (!strcmp(dfl_devs[i].name, pdev->name))
>  			return i;
>  
> -	return DFL_ID_MAX;
> +	return FPGA_DFL_ID_MAX;
>  }
>  
> -static enum dfl_id_type dfh_id_to_type(u16 id)
> +static enum fpga_dfl_id_type dfh_id_to_type(u16 id)
>  {
>  	int i;
>  
> @@ -136,7 +136,7 @@ static enum dfl_id_type dfh_id_to_type(u16 id)
>  		if (dfl_devs[i].dfh_id == id)
>  			return i;
>  
> -	return DFL_ID_MAX;
> +	return FPGA_DFL_ID_MAX;
>  }
>  
>  /*
> @@ -244,28 +244,29 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>  
> -static DEFINE_IDA(dfl_device_ida);
> +static DEFINE_IDA(fpga_dfl_device_ida);
>  
> -static const struct dfl_device_id *
> -dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device *ddev)
> +static const struct fpga_dfl_device_id *
> +dfl_match_one_device(const struct fpga_dfl_device_id *id,
> +		     struct fpga_dfl_device *fddev)
>  {
> -	if (id->type == ddev->type && id->feature_id == ddev->feature_id)
> +	if (id->type == fddev->type && id->feature_id == fddev->feature_id)
>  		return id;
>  
>  	return NULL;
>  }
>  
> -static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +static int fpga_dfl_bus_match(struct device *dev, struct device_driver *drv)
>  {
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> -	struct dfl_driver *ddrv = to_dfl_drv(drv);
> -	const struct dfl_device_id *id_entry;
> +	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
> +	struct fpga_dfl_driver *fddrv = to_fpga_dfl_drv(drv);
> +	const struct fpga_dfl_device_id *id_entry;
>  
> -	id_entry = ddrv->id_table;
> +	id_entry = fddrv->id_table;
>  	if (id_entry) {
>  		while (id_entry->feature_id) {
> -			if (dfl_match_one_device(id_entry, ddev)) {
> -				ddev->id_entry = id_entry;
> +			if (dfl_match_one_device(id_entry, fddev)) {
> +				fddev->id_entry = id_entry;
>  				return 1;
>  			}
>  			id_entry++;
> @@ -275,215 +276,216 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>  
> -static int dfl_bus_probe(struct device *dev)
> +static int fpga_dfl_bus_probe(struct device *dev)
>  {
> -	struct dfl_driver *ddrv = to_dfl_drv(dev->driver);
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct fpga_dfl_driver *fddrv = to_fpga_dfl_drv(dev->driver);
> +	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
>  
> -	return ddrv->probe(ddev);
> +	return fddrv->probe(fddev);
>  }
>  
> -static int dfl_bus_remove(struct device *dev)
> +static int fpga_dfl_bus_remove(struct device *dev)
>  {
> -	struct dfl_driver *ddrv = to_dfl_drv(dev->driver);
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct fpga_dfl_driver *fddrv = to_fpga_dfl_drv(dev->driver);
> +	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
>  
> -	if (ddrv->remove)
> -		ddrv->remove(ddev);
> +	if (fddrv->remove)
> +		fddrv->remove(fddev);
>  
>  	return 0;
>  }
>  
> -static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> +static int fpga_dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
>  
>  	/* The type has 4 valid bits and feature_id has 12 valid bits */
> -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> -			      ddev->type, ddev->feature_id);
> +	return add_uevent_var(env, "MODALIAS=fpga-dfl:t%01Xf%03X",
> +			      fddev->type, fddev->feature_id);
>  }
>  
>  static ssize_t
>  type_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
>  
> -	return sprintf(buf, "0x%x\n", ddev->type);
> +	return sprintf(buf, "0x%x\n", fddev->type);
>  }
>  static DEVICE_ATTR_RO(type);
>  
>  static ssize_t
>  feature_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
>  
> -	return sprintf(buf, "0x%x\n", ddev->feature_id);
> +	return sprintf(buf, "0x%x\n", fddev->feature_id);
>  }
>  static DEVICE_ATTR_RO(feature_id);
>  
> -static struct attribute *dfl_dev_attrs[] = {
> +static struct attribute *fpga_dfl_dev_attrs[] = {
>  	&dev_attr_type.attr,
>  	&dev_attr_feature_id.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(dfl_dev);
> -
> -static struct bus_type dfl_bus_type = {
> -	.name		= "dfl",
> -	.match		= dfl_bus_match,
> -	.probe		= dfl_bus_probe,
> -	.remove		= dfl_bus_remove,
> -	.uevent		= dfl_bus_uevent,
> -	.dev_groups	= dfl_dev_groups,
> +ATTRIBUTE_GROUPS(fpga_dfl_dev);
> +
> +static struct bus_type fpga_dfl_bus_type = {
> +	.name		= "fpga-dfl",
> +	.match		= fpga_dfl_bus_match,
> +	.probe		= fpga_dfl_bus_probe,
> +	.remove		= fpga_dfl_bus_remove,
> +	.uevent		= fpga_dfl_bus_uevent,
> +	.dev_groups	= fpga_dfl_dev_groups,
>  };
>  
> -static void release_dfl_dev(struct device *dev)
> +static void release_fpga_dfl_dev(struct device *dev)
>  {
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
>  
> -	if (ddev->mmio_res.parent)
> -		release_resource(&ddev->mmio_res);
> +	if (fddev->mmio_res.parent)
> +		release_resource(&fddev->mmio_res);
>  
> -	ida_simple_remove(&dfl_device_ida, ddev->id);
> -	kfree(ddev->irqs);
> -	kfree(ddev);
> +	ida_simple_remove(&fpga_dfl_device_ida, fddev->id);
> +	kfree(fddev->irqs);
> +	kfree(fddev);
>  }
>  
> -static struct dfl_device *
> -dfl_dev_add(struct dfl_feature_platform_data *pdata,
> -	    struct dfl_feature *feature)
> +static struct fpga_dfl_device *
> +fpga_dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +		 struct dfl_feature *feature)
>  {
>  	struct platform_device *pdev = pdata->dev;
>  	struct resource *parent_res;
> -	struct dfl_device *ddev;
> +	struct fpga_dfl_device *fddev;
>  	int id, i, ret;
>  
> -	ddev = kzalloc(sizeof(*ddev), GFP_KERNEL);
> -	if (!ddev)
> +	fddev = kzalloc(sizeof(*fddev), GFP_KERNEL);
> +	if (!fddev)
>  		return ERR_PTR(-ENOMEM);
>  
> -	id = ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> +	id = ida_simple_get(&fpga_dfl_device_ida, 0, 0, GFP_KERNEL);
>  	if (id < 0) {
>  		dev_err(&pdev->dev, "unable to get id\n");
> -		kfree(ddev);
> +		kfree(fddev);
>  		return ERR_PTR(id);
>  	}
>  
>  	/* freeing resources by put_device() after device_initialize() */
> -	device_initialize(&ddev->dev);
> -	ddev->dev.parent = &pdev->dev;
> -	ddev->dev.bus = &dfl_bus_type;
> -	ddev->dev.release = release_dfl_dev;
> -	ddev->id = id;
> -	ret = dev_set_name(&ddev->dev, "dfl_dev.%d", id);
> +	device_initialize(&fddev->dev);
> +	fddev->dev.parent = &pdev->dev;
> +	fddev->dev.bus = &fpga_dfl_bus_type;
> +	fddev->dev.release = release_fpga_dfl_dev;
> +	fddev->id = id;
> +	ret = dev_set_name(&fddev->dev, "fpga_dfl_dev.%d", id);
>  	if (ret)
>  		goto put_dev;
>  
> -	ddev->type = feature_dev_id_type(pdev);
> -	ddev->feature_id = feature->id;
> -	ddev->cdev = pdata->dfl_cdev;
> +	fddev->type = feature_dev_id_type(pdev);
> +	fddev->feature_id = feature->id;
> +	fddev->cdev = pdata->dfl_cdev;
>  
>  	/* add mmio resource */
>  	parent_res = &pdev->resource[feature->resource_index];
> -	ddev->mmio_res.flags = IORESOURCE_MEM;
> -	ddev->mmio_res.start = parent_res->start;
> -	ddev->mmio_res.end = parent_res->end;
> -	ddev->mmio_res.name = dev_name(&ddev->dev);
> -	ret = insert_resource(parent_res, &ddev->mmio_res);
> +	fddev->mmio_res.flags = IORESOURCE_MEM;
> +	fddev->mmio_res.start = parent_res->start;
> +	fddev->mmio_res.end = parent_res->end;
> +	fddev->mmio_res.name = dev_name(&fddev->dev);
> +	ret = insert_resource(parent_res, &fddev->mmio_res);
>  	if (ret) {
>  		dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> -			dev_name(&ddev->dev), &ddev->mmio_res);
> +			dev_name(&fddev->dev), &fddev->mmio_res);
>  		goto put_dev;
>  	}
>  
>  	/* then add irq resource */
>  	if (feature->nr_irqs) {
> -		ddev->irqs = kcalloc(feature->nr_irqs,
> -				     sizeof(*ddev->irqs), GFP_KERNEL);
> -		if (!ddev->irqs) {
> +		fddev->irqs = kcalloc(feature->nr_irqs,
> +				      sizeof(*fddev->irqs), GFP_KERNEL);
> +		if (!fddev->irqs) {
>  			ret = -ENOMEM;
>  			goto put_dev;
>  		}
>  
>  		for (i = 0; i < feature->nr_irqs; i++)
> -			ddev->irqs[i] = feature->irq_ctx[i].irq;
> +			fddev->irqs[i] = feature->irq_ctx[i].irq;
>  
> -		ddev->num_irqs = feature->nr_irqs;
> +		fddev->num_irqs = feature->nr_irqs;
>  	}
>  
> -	ret = device_add(&ddev->dev);
> +	ret = device_add(&fddev->dev);
>  	if (ret)
>  		goto put_dev;
>  
> -	dev_dbg(&pdev->dev, "add dfl_dev: %s\n", dev_name(&ddev->dev));
> -	return ddev;
> +	dev_dbg(&pdev->dev, "add fpga_dfl_dev: %s\n", dev_name(&fddev->dev));
> +	return fddev;
>  
>  put_dev:
> -	/* calls release_dfl_dev() which does the clean up  */
> -	put_device(&ddev->dev);
> +	/* calls release_fpga_dfl_dev() which does the clean up  */
> +	put_device(&fddev->dev);
>  	return ERR_PTR(ret);
>  }
>  
> -static void dfl_devs_remove(struct dfl_feature_platform_data *pdata)
> +static void fpga_dfl_devs_remove(struct dfl_feature_platform_data *pdata)
>  {
>  	struct dfl_feature *feature;
>  
>  	dfl_fpga_dev_for_each_feature(pdata, feature) {
> -		if (feature->ddev) {
> -			device_unregister(&feature->ddev->dev);
> -			feature->ddev = NULL;
> +		if (feature->fddev) {
> +			device_unregister(&feature->fddev->dev);
> +			feature->fddev = NULL;
>  		}
>  	}
>  }
>  
> -static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
> +static int fpga_dfl_devs_add(struct dfl_feature_platform_data *pdata)
>  {
> +	struct fpga_dfl_device *fddev;
>  	struct dfl_feature *feature;
> -	struct dfl_device *ddev;
>  	int ret;
>  
>  	dfl_fpga_dev_for_each_feature(pdata, feature) {
>  		if (feature->ioaddr)
>  			continue;
>  
> -		if (feature->ddev) {
> +		if (feature->fddev) {
>  			ret = -EEXIST;
>  			goto err;
>  		}
>  
> -		ddev = dfl_dev_add(pdata, feature);
> -		if (IS_ERR(ddev)) {
> -			ret = PTR_ERR(ddev);
> +		fddev = fpga_dfl_dev_add(pdata, feature);
> +		if (IS_ERR(fddev)) {
> +			ret = PTR_ERR(fddev);
>  			goto err;
>  		}
>  
> -		feature->ddev = ddev;
> +		feature->fddev = fddev;
>  	}
>  
>  	return 0;
>  
>  err:
> -	dfl_devs_remove(pdata);
> +	fpga_dfl_devs_remove(pdata);
>  	return ret;
>  }
>  
> -int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
> +int __fpga_dfl_driver_register(struct fpga_dfl_driver *fddrv,
> +			       struct module *owner)
>  {
> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +	if (!fddrv || !fddrv->probe || !fddrv->id_table)
>  		return -EINVAL;
>  
> -	dfl_drv->drv.owner = owner;
> -	dfl_drv->drv.bus = &dfl_bus_type;
> +	fddrv->drv.owner = owner;
> +	fddrv->drv.bus = &fpga_dfl_bus_type;
>  
> -	return driver_register(&dfl_drv->drv);
> +	return driver_register(&fddrv->drv);
>  }
> -EXPORT_SYMBOL(__dfl_driver_register);
> +EXPORT_SYMBOL(__fpga_dfl_driver_register);
>  
> -void dfl_driver_unregister(struct dfl_driver *dfl_drv)
> +void fpga_dfl_driver_unregister(struct fpga_dfl_driver *fddrv)
>  {
> -	driver_unregister(&dfl_drv->drv);
> +	driver_unregister(&fddrv->drv);
>  }
> -EXPORT_SYMBOL(dfl_driver_unregister);
> +EXPORT_SYMBOL(fpga_dfl_driver_unregister);
>  
>  #define is_header_feature(feature) ((feature)->id == FEATURE_ID_FIU_HEADER)
>  
> @@ -496,7 +498,7 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct dfl_feature *feature;
>  
> -	dfl_devs_remove(pdata);
> +	fpga_dfl_devs_remove(pdata);
>  
>  	dfl_fpga_dev_for_each_feature(pdata, feature) {
>  		if (feature->ops) {
> @@ -585,7 +587,7 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>  		drv++;
>  	}
>  
> -	ret = dfl_devs_add(pdata);
> +	ret = fpga_dfl_devs_add(pdata);
>  	if (ret)
>  		goto exit;
>  
> @@ -745,11 +747,11 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	struct platform_device *fdev = binfo->feature_dev;
>  	struct dfl_feature_platform_data *pdata;
>  	struct dfl_feature_info *finfo, *p;
> -	enum dfl_id_type type;
> +	enum fpga_dfl_id_type type;
>  	int ret, index = 0, res_idx = 0;
>  
>  	type = feature_dev_id_type(fdev);
> -	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
> +	if (WARN_ON_ONCE(type >= FPGA_DFL_ID_MAX))
>  		return -EINVAL;
>  
>  	/*
> @@ -836,7 +838,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  
>  	ret = platform_device_add(binfo->feature_dev);
>  	if (!ret) {
> -		if (type == PORT_ID)
> +		if (type == FPGA_DFL_PORT_ID)
>  			dfl_fpga_cdev_add_port_dev(binfo->cdev,
>  						   binfo->feature_dev);
>  		else
> @@ -857,11 +859,11 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  
>  static int
>  build_info_create_dev(struct build_feature_devs_info *binfo,
> -		      enum dfl_id_type type)
> +		      enum fpga_dfl_id_type type)
>  {
>  	struct platform_device *fdev;
>  
> -	if (type >= DFL_ID_MAX)
> +	if (type >= FPGA_DFL_ID_MAX)
>  		return -EINVAL;
>  
>  	/*
> @@ -1072,7 +1074,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  	}
>  
>  	switch (feature_dev_id_type(binfo->feature_dev)) {
> -	case PORT_ID:
> +	case FPGA_DFL_PORT_ID:
>  		return parse_feature_port_afu(binfo, ofst);
>  	default:
>  		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
> @@ -1360,7 +1362,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
>  static int remove_feature_dev(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	enum dfl_id_type type = feature_dev_id_type(pdev);
> +	enum fpga_dfl_id_type type = feature_dev_id_type(pdev);
>  	int id = pdev->id;
>  
>  	platform_device_unregister(pdev);
> @@ -1526,7 +1528,7 @@ static int __init dfl_fpga_init(void)
>  {
>  	int ret;
>  
> -	ret = bus_register(&dfl_bus_type);
> +	ret = bus_register(&fpga_dfl_bus_type);
>  	if (ret)
>  		return ret;
>  
> @@ -1535,7 +1537,7 @@ static int __init dfl_fpga_init(void)
>  	ret = dfl_chardev_init();
>  	if (ret) {
>  		dfl_ids_destroy();
> -		bus_unregister(&dfl_bus_type);
> +		bus_unregister(&fpga_dfl_bus_type);
>  	}
>  
>  	return ret;
> @@ -1874,7 +1876,7 @@ static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
>  	dfl_ids_destroy();
> -	bus_unregister(&dfl_bus_type);
> +	bus_unregister(&fpga_dfl_bus_type);
>  }
>  
>  module_init(dfl_fpga_init);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5dc758f..ba930a7 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -236,7 +236,7 @@ struct dfl_feature_irq_ctx {
>   * @irq_ctx: interrupt context list.
>   * @nr_irqs: number of interrupt contexts.
>   * @ops: ops of this sub feature.
> - * @ddev: ptr to the dfl device of this sub feature.
> + * @fddev: ptr to the fpga dfl device of this sub feature.
>   * @priv: priv data of this feature.
>   */
>  struct dfl_feature {
> @@ -247,7 +247,7 @@ struct dfl_feature {
>  	struct dfl_feature_irq_ctx *irq_ctx;
>  	unsigned int nr_irqs;
>  	const struct dfl_feature_ops *ops;
> -	struct dfl_device *ddev;
> +	struct fpga_dfl_device *fddev;
>  	void *priv;
>  };
>  
> @@ -517,40 +517,42 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  			       unsigned long arg);
>  
>  /**
> - * enum dfl_id_type - define the DFL FIU types
> + * enum fpga_dfl_id_type - define the FPGA DFL FIU types
>   */
> -enum dfl_id_type {
> -	FME_ID,
> -	PORT_ID,
> -	DFL_ID_MAX,
> +enum fpga_dfl_id_type {
> +	FPGA_DFL_FME_ID,
> +	FPGA_DFL_PORT_ID,
> +	FPGA_DFL_ID_MAX,
>  };
>  
>  /**
> - * struct dfl_device_id -  dfl device identifier
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * struct fpga_dfl_device_id - fpga dfl device identifier
> + * @type: contains 4 bits FPGA DFL FIU type of the device, see
> + *	  enum fpga_dfl_id_type.
> + * @feature_id: contains 12 bits feature identifier local to its FPGA DFL FIU
> + *		type.
>   * @driver_data: driver specific data.
>   */
> -struct dfl_device_id {
> +struct fpga_dfl_device_id {
>  	u8 type;
>  	u16 feature_id;
>  	unsigned long driver_data;
>  };
>  
>  /**
> - * struct dfl_device - represent an dfl device on dfl bus
> + * struct fpga_dfl_device - represent an fpga dfl device on fpga dfl bus
>   *
>   * @dev: generic device interface.
> - * @id: id of the dfl device.
> - * @type: type of DFL FIU of the device. See enum dfl_id_type.
> - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> - * @mmio_res: mmio resource of this dfl device.
> - * @irqs: list of Linux IRQ numbers of this dfl device.
> - * @num_irqs: number of IRQs supported by this dfl device.
> - * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> - * @id_entry: matched id entry in dfl driver's id table.
> + * @id: id of the fpga dfl device.
> + * @type: FPGA DFL FIU type of the device, see enum fpga_dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its FPGA DFL FIU type.
> + * @mmio_res: mmio resource of this fpga dfl device.
> + * @irqs: list of Linux IRQ numbers of this fpga dfl device.
> + * @num_irqs: number of IRQs supported by this fpga dfl device.
> + * @cdev: pointer to DFL FPGA container device this fpga dfl device belongs to.
> + * @id_entry: matched id entry in fpga dfl driver's id table.
>   */
> -struct dfl_device {
> +struct fpga_dfl_device {
>  	struct device dev;
>  	int id;
>  	u8 type;
> @@ -559,11 +561,11 @@ struct dfl_device {
>  	int *irqs;
>  	unsigned int num_irqs;
>  	struct dfl_fpga_cdev *cdev;
> -	const struct dfl_device_id *id_entry;
> +	const struct fpga_dfl_device_id *id_entry;
>  };
>  
>  /**
> - * struct dfl_driver - represent an dfl device driver
> + * struct fpga_dfl_driver - represent a fpga dfl device driver
>   *
>   * @drv: driver model structure.
>   * @id_table: pointer to table of device IDs the driver is interested in.
> @@ -571,33 +573,34 @@ struct dfl_device {
>   * @probe: mandatory callback for device binding.
>   * @remove: callback for device unbinding.
>   */
> -struct dfl_driver {
> +struct fpga_dfl_driver {
>  	struct device_driver drv;
> -	const struct dfl_device_id *id_table;
> +	const struct fpga_dfl_device_id *id_table;
>  
> -	int (*probe)(struct dfl_device *dfl_dev);
> -	void (*remove)(struct dfl_device *dfl_dev);
> +	int (*probe)(struct fpga_dfl_device *fddev);
> +	void (*remove)(struct fpga_dfl_device *fddev);
>  };
>  
> -#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> -#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +#define to_fpga_dfl_dev(d) container_of(d, struct fpga_dfl_device, dev)
> +#define to_fpga_dfl_drv(d) container_of(d, struct fpga_dfl_driver, drv)
>  
>  /*
>   * use a macro to avoid include chaining to get THIS_MODULE.
>   */
> -#define dfl_driver_register(drv) \
> -	__dfl_driver_register(drv, THIS_MODULE)
> -int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> -void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +#define fpga_dfl_driver_register(drv) \
> +	__fpga_dfl_driver_register(drv, THIS_MODULE)
> +int __fpga_dfl_driver_register(struct fpga_dfl_driver *fddrv,
> +			       struct module *owner);
> +void fpga_dfl_driver_unregister(struct fpga_dfl_driver *fddrv);
>  
>  /*
> - * module_dfl_driver() - Helper macro for drivers that don't do
> + * module_fpga_dfl_driver() - Helper macro for drivers that don't do
>   * anything special in module init/exit.  This eliminates a lot of
>   * boilerplate.  Each module may only use this macro once, and
>   * calling it replaces module_init() and module_exit().
>   */
> -#define module_dfl_driver(__dfl_driver) \
> -	module_driver(__dfl_driver, dfl_driver_register, \
> -		      dfl_driver_unregister)
> +#define module_fpga_dfl_driver(__fpga_dfl_driver) \
> +	module_driver(__fpga_dfl_driver, fpga_dfl_driver_register, \
> +		      fpga_dfl_driver_unregister)
>  
>  #endif /* __FPGA_DFL_H */

