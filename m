Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE78274EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgIWByU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:54:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28697 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbgIWByT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600826057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRKTlS1GkMekcVpYm/+9Cj+hAa/FOrkhgmiuWKUjGJ0=;
        b=EcTSyThz6JtPShXRDuPcBr4Fvb8s1LBHXnxGb9tvmYImCFUy5VOwazj9+gcyrcmVUFjPw1
        t0UCunARfMB/HS02xjVDL4fuPYZdgmTKNuf0srD30M/5m+L/b2Dbfl/xgFPOH1zqJeMfsf
        mZGUXYxaLRS5AKid7A+vcCuWTtXBNzo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-f1GVuq4DOlesICYNujILag-1; Tue, 22 Sep 2020 21:54:15 -0400
X-MC-Unique: f1GVuq4DOlesICYNujILag-1
Received: by mail-oo1-f69.google.com with SMTP id h20so9517947oou.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QRKTlS1GkMekcVpYm/+9Cj+hAa/FOrkhgmiuWKUjGJ0=;
        b=sWPviV8cEREFyMHcewIZv6NbSNJsT9fxKtmDvt5KnY343N8XaaUkkaY1c/ylfDUg4p
         TsfJkqlOrOYNtRj4q6/7DwPRmjDjflnQ9MqP/ewckGKDz2OFQaIlRfcR5k9hKKWTypdo
         4in+Fk1h2swmiyAV/CEdSyrkHPLkTFqCh/INB0rE9IrBvneRzHzeUbNDAY67+FboSq/S
         nv0FlhuODD8xGZkSA6PlDMmoj1Fh6EBL6VbqdRXZXOpCrP/2v5TJblttMs3UVyaoNC6e
         1tipLHFyTPwRF2epR7vK0q6SpLcvgLvB/NmKiDQsozNhkmpn7P3yS1zDT8YqGylPFcJ/
         NRqg==
X-Gm-Message-State: AOAM531hM37cwdTCQS8TXymywfUe1Qguk4WNJX7wssvLL4fgjZhzuTkl
        hdW9rNGKkJMsMINk2EtzSnkXlvFdZhWjVh6xhNqUjFjNAVLuC8QDm+Vh5hqrmEF1bg5fshlga9R
        xKXHbSvY0sSiOw+EavRRmObwC
X-Received: by 2002:a05:6808:b03:: with SMTP id s3mr4504963oij.28.1600826054881;
        Tue, 22 Sep 2020 18:54:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp5yRb1cyomQTDywKdXsSKsT4fHQWipGvgYUwGOH6lQ2H5UBWpLGmX8zO1bB+lLxI1uL3rXA==
X-Received: by 2002:a05:6808:b03:: with SMTP id s3mr4504949oij.28.1600826054440;
        Tue, 22 Sep 2020 18:54:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w7sm9043705oon.2.2020.09.22.18.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 18:54:13 -0700 (PDT)
Subject: Re: [RFC] fpga: dfl: a prototype uio driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     alex.williamson@redhat.com, hao.wu@intel.com, mdf@kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20200919165113.5219-1-trix@redhat.com>
 <20200921085553.GA8796@yilunxu-OptiPlex-7050>
 <a95906c3-1960-e753-e306-74a90045269e@redhat.com>
 <20200922031837.GA8768@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7c1df84b-1a23-f8f6-cfea-0c744330e3f9@redhat.com>
Date:   Tue, 22 Sep 2020 18:54:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200922031837.GA8768@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/21/20 8:18 PM, Xu Yilun wrote:
> On Mon, Sep 21, 2020 at 12:32:16PM -0700, Tom Rix wrote:
>> On 9/21/20 1:55 AM, Xu Yilun wrote:
>>> On Sat, Sep 19, 2020 at 09:51:13AM -0700, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> I following up on Moritz asking for early RFC's by showing how this
>>>> could be done with the concrete example of around
>>>>
>>>> [PATCH 0/3] add VFIO mdev support for DFL devices
>>>>
>>>> I hacked this together, it barely works. Do not expect that this
>>>> patch to apply anywhere.  It has enough to show where I want
>>>> to go and people can comment without me having invested a lot of
>>>> effort.  I am not expecting to carry this forward, it only
>>>> addresses the issues I had with the origin patch.
>>>>
>>>> This change adds a uio driver for any unclaimed dfl feature
>>>>
>>>> During the normal matching of feature id's to drivers, some
>>>> of the features are not claimed because there neither a
>>>> builtin driver nor a module driver that matches the feature
>>>> id.  For these unclaimed features, provide a uio driver to a
>>>> possible user space driver.
>>> I think we don't have to setup UIO interfaces for all unclaimed 
>>> features. It could be the decision of the user whether the UIO
>>> device is needed for a feature. My opinion is that, the
>>> driver_override sysfs is still generic enough for user's to switch
>>> between kernel device drivers and dfl uio driver.
>> Instead of a string, could there just be a 'use_uio' flag ?
>>
>> How does the 'driver_override' work when there is no starting driver ?
> Now we have a dfl bus_type, we could add the 'driver_override' to each
> dfl device on dfl bus. It is the same as 'feature_id' & 'type'.
>
> Actually the 'driver_override' also exists in various bus type (platform,
> pci ...).
>
>>> There may be cases the dfl device driver modules are not inserted
>>> during dfl-fme/port initialization, but they are to be inserted
>>> manually. If the features are all registered to uio, then there will
>>> be problems when dfl device drivers module are inserted.
>> How does this manual loading work ? The driver list for the features
>>
>> seems to only be used during the card probe time.
>>
>> To change the order the dfl-pci needs to be unloaded and that will
>>
>> destroy all the uio devices as well as usual feature drivers attached to
>>
>> the pci driver.
> After we have introduced the dfl bus patches. The initialization flow
> is:
>
> 1. dfl-fme/port initializes its core private features (listed in
>    fme/port_feature_drvs array), these private features are part of
>    the dfl-fme/port module. They cannot be exposed as uio devices cause
>    they are managed by the dfl-fme/afu kernel driver.
>
>
> 2. The rest of the private features are added as dfl devices. They can
>    be matched by independent dfl driver modules. dfl-n3000-nios is the
>    first use case. The dfl-n3000-nios.ko may not be loaded when dfl-fme
>    probe, but later user loads the module manually by
>    "insmod drivers/fpga/dfl-n3000-nios.ko".
>
>    If we create uio interfaces for all unclaimed features on
>    dfl-fme/port probe, then I can see problem when user insmod
>    dfl-n3000-nios.ko
>
>
> For these dfl devices, we could give users an option to manage them
> by userspace I/O access. The flow I suggest is like:
> a) load the uio-dfl.ko, it will not match any dfl device now.
>    # modprobe uio-dfl   
>
> b) unbind the kernel driver for the specific dfl device
>    # echo dfl_dev.0 > /sys/bus/dfl/drivers/n3000-nios/unbind
>
> c) assign the uio driver for the dfl device. Please note this will
>    not trigger any driver matching.
>    # echo uio-dfl > /sys/bus/dfl/devices/dfl_dev.0/driver_override
>
> d) actually trigger the driver matching, then the uio-dfl module takes
>    function.
>    # echo dfl_dev.0 > /sys/bus/dfl/drivers_probe
>
>>
>>>
>>>> I have doubts that a uio for an afu feature is approptiate as these
>>>> can be any device.
>>> I think generally afu could also be as uio device if we don't concern
>>> about dma isolation.
>> I am thinking about afu with its own pci id.
>>
>> So there could be a conflict with some other driver that responds to the pci id.
> I think 'driver_override' mechanism solves the problem, it ensures no
> other driver could be matched to the device except your assigned one.
>
>>> But now seems not possible to match afu to uio driver, cause now in DFL
>>> framework AFU is managed by dfl-afu.ko
>>>
>>>> Another possible problem is if the number of interrupts for the
>>>> feature is greater than 1.  Uio seems to only support 1. My guess
>>>> is this would need some hackery in the open() to add to the
>>>> interrupt handler.
>>> I think it may not possible for UIO to support multiple interrupts if
>>> user cannot access the interrupt enable/pending registers. The uio
>>> device have just one /dev/uioX node for interrupt. So I tend to
>>> accept the limitation. And for now we don't have board specific
>>> features that needs multiple interrupts. For PAC N3000, no interrupt is
>>> needed.
>> Maybe uio needs to change to support multiple interrupts ?
> I could expect a big change for uio, especially the change of APIs to
> userspace, which would make much impact.
>
> For now I didn't see the demand of multiple interrupts for dfl. And for
> PAC N3000, no interrupt is needed. So this could be considered later.
>
> Actually, to meet our current need, the only changes for dfl framework could
> be the common 'driver_override'. We could try to improve the other part
> if there is a clear request.
>
>>>> It is for this type of reason I think a dfl-uio driver is needed
>>>> rather than reusing an existing generic uio driver.
>>> So if we don't try to change interrupt, the implementation of dfl-uio is
>>> just a subset of generic uio platform driver, so why not we just use it?
>> Its a toss up.
> I agree. I also hesitate at this for sometime.
>
>> Maybe there some dfl only constraints like write/read is a multiple 4 bytes
> When you mmap your IO to users, you cannot limit the way they access the
> registers. It is the user's responsibility to keep it right.
>
>> Or just why have another layer in the setup.
> It's mainly about reusing the code. DFL devices are mainly the same as
> platform devices (except the way they are enumerated). Actually people
> may integrates IP blocks in FPGA which are already widely used on other
> systems and implemented as platform devices. So I think we may get more
> benifit leveraging uio platform.
>
> Thanks,
> Yilun

Thanks for the detailed explanation!

I look forward to your next rev.

Tom


>
>> Tom
>>
>>> Thanks,
>>> Yilun
>>>
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>  drivers/fpga/dfl-fme-main.c |   9 ++-
>>>>  drivers/fpga/dfl-uio.c      | 107 ++++++++++++++++++++++++++++++++++++
>>>>  drivers/fpga/dfl.c          |  47 +++++++++++++++-
>>>>  drivers/fpga/dfl.h          |   8 +++
>>>>  4 files changed, 169 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/fpga/dfl-uio.c
>>>>
>>>> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
>>>> index 037dc4f..3323e90 100644
>>>> --- a/drivers/fpga/dfl-fme-main.c
>>>> +++ b/drivers/fpga/dfl-fme-main.c
>>>> @@ -709,12 +709,18 @@ static int fme_probe(struct platform_device *pdev)
>>>>  	if (ret)
>>>>  		goto dev_destroy;
>>>>  
>>>> -	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
>>>> +	ret = dfl_fpga_dev_feature_init_uio(pdev, DFH_TYPE_FIU);
>>>>  	if (ret)
>>>>  		goto feature_uinit;
>>>>  
>>>> +	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
>>>> +	if (ret)
>>>> +		goto feature_uinit_uio;
>>>> +
>>>>  	return 0;
>>>>  
>>>> +feature_uinit_uio:
>>>> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>>>>  feature_uinit:
>>>>  	dfl_fpga_dev_feature_uinit(pdev);
>>>>  dev_destroy:
>>>> @@ -726,6 +732,7 @@ exit:
>>>>  static int fme_remove(struct platform_device *pdev)
>>>>  {
>>>>  	dfl_fpga_dev_ops_unregister(pdev);
>>>> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>>>>  	dfl_fpga_dev_feature_uinit(pdev);
>>>>  	fme_dev_destroy(pdev);
>>>>  
>>>> diff --git a/drivers/fpga/dfl-uio.c b/drivers/fpga/dfl-uio.c
>>>> new file mode 100644
>>>> index 0000000..185fbab
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/dfl-uio.c
>>>> @@ -0,0 +1,107 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * prototype dfl uio driver
>>>> + *
>>>> + * Copyright Tom Rix 2020
>>>> + */
>>>> +#include <linux/module.h>
>>>> +#include "dfl.h"
>>>> +
>>>> +static irqreturn_t dfl_uio_handler(int irq, struct uio_info *dev_info)
>>>> +{
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int dfl_uio_open(struct uio_info *info, struct inode *inode)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int dfl_uio_release(struct uio_info *info, struct inode *inode)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int dfl_uio_add(struct dfl_feature *feature)
>>>> +{
>>>> +	struct uio_info *uio;
>>>> +	struct resource *res =
>>>> +		&feature->dev->resource[feature->resource_index];
>>>> +	int ret = 0;
>>>> +
>>>> +	uio = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
>>>> +	if (!uio) {
>>>> +		ret = -ENOMEM;
>>>> +		goto exit;
>>>> +	}
>>>> +
>>>> +	uio->name = kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
>>>> +	if (!uio->name) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err_name;
>>>> +	}
>>>> +
>>>> +	uio->version = "0.1";
>>>> +	uio->mem[0].memtype = UIO_MEM_PHYS;
>>>> +	uio->mem[0].addr = res->start & PAGE_MASK;
>>>> +	uio->mem[0].offs = res->start & ~PAGE_MASK;
>>>> +	uio->mem[0].size = (uio->mem[0].offs + resource_size(res)
>>>> +			    + PAGE_SIZE - 1) & PAGE_MASK;
>>>> +	/* How are nr_irqs > 1 handled ??? */
>>>> +	if (feature->nr_irqs == 1)
>>>> +		uio->irq = feature->irq_ctx[0].irq;
>>>> +	uio->handler = dfl_uio_handler;
>>>> +	uio->mmap = dfl_uio_mmap;
>>>> +	uio->open = dfl_uio_open;
>>>> +	uio->release = dfl_uio_release;
>>>> +	uio->irqcontrol = dfl_uio_irqcontrol;
>>>> +
>>>> +	ret = uio_register_device(&feature->dev->dev, uio);
>>>> +	if (ret)
>>>> +		goto err_register;
>>>> +
>>>> +	feature->uio = uio;
>>>> +exit:
>>>> +	return ret;
>>>> +err_register:
>>>> +	kfree(uio->name);
>>>> +err_name:
>>>> +	kfree(uio);
>>>> +	goto exit;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dfl_uio_add);
>>>> +
>>>> +int dfl_uio_remove(struct dfl_feature *feature)
>>>> +{
>>>> +	uio_unregister_device(feature->uio);
>>>> +	kfree(feature->uio->name);
>>>> +	kfree(feature->uio);
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dfl_uio_remove);
>>>> +
>>>> +static int __init dfl_uio_init(void)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void __exit dfl_uio_exit(void)
>>>> +{
>>>> +}
>>>> +
>>>> +module_init(dfl_uio_init);
>>>> +module_exit(dfl_uio_exit);
>>>> +
>>>> +MODULE_DESCRIPTION("DFL UIO prototype driver");
>>>> +MODULE_AUTHOR("Tom");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>>>> index 1305be4..26de8e1 100644
>>>> --- a/drivers/fpga/dfl.c
>>>> +++ b/drivers/fpga/dfl.c
>>>> @@ -663,10 +664,57 @@ exit:
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init);
>>>>  
>>>> +int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int dfh_type)
>>>> +{
>>>> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>>> +	struct dfl_feature *feature;
>>>> +	int ret;
>>>> +
>>>> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>>>> +		if (dfh_type == DFH_TYPE_FIU) {
>>>> +			if (feature->id == FEATURE_ID_FIU_HEADER ||
>>>> +			    feature->id == FEATURE_ID_AFU)
>>>> +			continue;
>>>> +
>>>> +			/* give the unclamined feature to uio */
>>>> +			if (!feature->ioaddr) {
>>>> +				ret = dfl_uio_add(feature);
>>>> +				if (ret)
>>>> +					goto exit;
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +exit:
>>>> +	dfl_fpga_dev_feature_uinit_uio(pdev, dfh_type);
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init_uio);
>>>> +
>>>> +int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int dfh_type)
>>>> +{
>>>> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>>> +	struct dfl_feature *feature;
>>>> +	int ret = 0;
>>>> +
>>>> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>>>> +		if (dfh_type == DFH_TYPE_FIU) {
>>>> +			if (feature->id == FEATURE_ID_FIU_HEADER ||
>>>> +			    feature->id == FEATURE_ID_AFU)
>>>> +				continue;
>>>> +
>>>> +			if (feature->uio)
>>>> +				ret |= dfl_uio_remove(feature);
>>>> +		}
>>>> +	}
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit_uio);
>>>> +
>>>>  static void dfl_chardev_uinit(void)
>>>>  {
>>>>  	int i;
>>>> -
>>>>  	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
>>>>  		if (MAJOR(dfl_chrdevs[i].devt)) {
>>>>  			unregister_chrdev_region(dfl_chrdevs[i].devt,
>>>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>>>> index a85d1cd..6e37aef 100644
>>>> --- a/drivers/fpga/dfl.h
>>>> +++ b/drivers/fpga/dfl.h
>>>> @@ -26,6 +26,7 @@
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/uuid.h>
>>>> +#include <linux/uio_driver.h>
>>>>  #include <linux/fpga/fpga-region.h>
>>>>  
>>>>  /* maximum supported number of ports */
>>>> @@ -232,6 +233,7 @@ struct dfl_feature_irq_ctx {
>>>>   * struct dfl_feature - sub feature of the feature devices
>>>>   *
>>>>   * @dev: ptr to pdev of the feature device which has the sub feature.
>>>> + * @uio: for fallback uio driver.
>>>>   * @id: sub feature id.
>>>>   * @index: unique identifier for an sub feature within the feature device.
>>>>   *	   It is possible that multiply sub features with same feature id are
>>>> @@ -248,6 +250,7 @@ struct dfl_feature_irq_ctx {
>>>>   */
>>>>  struct dfl_feature {
>>>>  	struct platform_device *dev;
>>>> +	struct uio_info *uio;
>>>>  	u64 id;
>>>>  	int index;
>>>>  	int resource_index;
>>>> @@ -360,6 +363,11 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev);
>>>>  int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>>>>  			      struct dfl_feature_driver *feature_drvs);
>>>>  
>>>> +int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int dfh_type);
>>>> +int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int dfh_type);
>>>> +int dfl_uio_add(struct dfl_feature *feature);
>>>> +int dfl_uio_remove(struct dfl_feature *feature);
>>>> +
>>>>  int dfl_fpga_dev_ops_register(struct platform_device *pdev,
>>>>  			      const struct file_operations *fops,
>>>>  			      struct module *owner);
>>>> -- 
>>>> 2.18.1

