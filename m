Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2372D44CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbgLIOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732284AbgLIOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607525456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/+i4KmxoQqXfLLBEFO3mQ6k5XviPXoDjA9RlLeyut0=;
        b=a3R40L3rt5+VhlTkE1BEW1ixsVvvnAhIl9F2UDhNU6d8UVBK+NE36oqRumRPYEllc/+3z5
        /7G2Pyo4g/FY9kuLpqj5sz2Z3Czkgz4qloRRvIUssxSfAIInUOfg34V/PxINbWy3T7sFpj
        XTRngN+/yW3d5qrTPmXww/8PrDSJics=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-7d_VzPCJMiS_dhTrB41z-w-1; Wed, 09 Dec 2020 09:50:55 -0500
X-MC-Unique: 7d_VzPCJMiS_dhTrB41z-w-1
Received: by mail-qt1-f197.google.com with SMTP id f17so1338719qtl.15
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 06:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A/+i4KmxoQqXfLLBEFO3mQ6k5XviPXoDjA9RlLeyut0=;
        b=A8Tp3EpvzScQ5XwMu3NyMZqQ2xN9WOYao7w+lfcmI7hC+iEOzBINAD+99ErMyMuOVb
         90tCTEQwRAB1+U7axTirCftYkU5b/qP7NA/QKhmHjuUSlRWFhvm/p0G9kW3R3DtC+BlW
         y6v7DXa1t1aY5Olsb8ZtKXAUG5tYL7ovIophpi1DlwzzwVvOogFj40MFyz5je6iZAES4
         4+UndXJ0YqmatMZWebIL6VlhylaL9PBrjW1nE6SPC+Uxe67Iq1Lj4ILFkY+tEoDYJiXo
         SATNjZZm+VsidTDN3nZM/qNDtu2w+0Bhb+nSnJC19DN7xO6Pi9WcKHxf0R10lpWYwu9Q
         fQSw==
X-Gm-Message-State: AOAM533Pp5+9s1yIgYYkpvte3Vq35hmC8ScQiJ9+kspjX3mb008vxBev
        tThbzWPvEl++bB12ge+4L4dQP29yOg5aNUN6B8mumTjRB7aQUNzmaVEGH0vwUYWjYCFEVd4ovIa
        75UM54ILQCz3mtRHa8gRda4AF
X-Received: by 2002:a05:6214:2b4:: with SMTP id m20mr3333361qvv.34.1607525455023;
        Wed, 09 Dec 2020 06:50:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwInUKbfhwFGoUZ7ie/v36Wsd8QKVRkbziiz7UxvxQFONYNkUocg/3+CnvBSY5/cLFj5gsV2w==
X-Received: by 2002:a05:6214:2b4:: with SMTP id m20mr3333338qvv.34.1607525454712;
        Wed, 09 Dec 2020 06:50:54 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y6sm1115556qki.115.2020.12.09.06.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 06:50:54 -0800 (PST)
Subject: Re: [RFC] fpga: dfl: a prototype uio driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, hao.wu@intel.com,
        mdf@kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20201206215554.350230-1-trix@redhat.com>
 <X83hkdgrMysGuUdL@kroah.com>
 <53097eaf-02ee-8e41-9738-107115dc9dcd@redhat.com>
 <20201209085634.GC29754@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6442d1b8-55b2-47ed-0fa1-e58edd9a8f5e@redhat.com>
Date:   Wed, 9 Dec 2020 06:50:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209085634.GC29754@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/20 12:56 AM, Xu Yilun wrote:
> Hi Tom:
>
> On Mon, Dec 07, 2020 at 05:07:05AM -0800, Tom Rix wrote:
>> On 12/7/20 12:02 AM, Greg KH wrote:
>>> On Sun, Dec 06, 2020 at 01:55:54PM -0800, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> >From [PATCH 0/2] UIO support for dfl devices
>>>> https://lore.kernel.org/linux-fpga/1602828151-24784-1-git-send-email-yilun.xu@intel.com/
>>> Why is this here?
>> As reference, Yilun's work has precedence for a uio driver and this rfc is trying to address what i believe is a sticking point of the driver override.Ã‚Â  This rfc is some code i hacked out to show the idea and move uio support along.Ã‚Â  I would like to see uio support for at least the unclaimed feature id's because this would make it easier for them to be developed.
> I see there is concern about sharing DFL devices for both UIO and kernel
> drivers. Even if a lock could be created to serialize the accesses of
> both interfaces, they could potentially impact each other without notice
> on hardware level.
>
> Maybe it is better we split the uio driver for unclaimed features. But
> how we could know it is an unclaimed feature, may be for simplicity we
> list the feature ids in device id table for dfl uio driver? We should
> change the code of dfl uio when we want to use uio for a new dfl device,
> is that acceptable?

No entry in the device id table would mean there would never be a conflict, so this is good.

This set could be expanded if the platform device driver was checked, and then uio could also used whose platform drivers were disabled in the configury.  There would be this problem: on the module case, disabling uio per feature so the platform driver kmod could be used.

I think we could do your the device id table suggestion now since it is simple and will help almost all developers.

Tom

>
> Thanks,
> Yilun
>
>>>> Here is an idea to have uio support with no driver override.
>>>>
>>>> This makes UIO the primary driver interface because every feature
>>>> will have one and makes the existing platform driver interface
>>>> secondary.  There will be a new burden for locking write access when
>>>> they compete.
>>>>
>>>> Example shows finding the fpga's temperture.
>>>>
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>  drivers/fpga/dfl-fme-main.c |  9 +++-
>>>>  drivers/fpga/dfl-uio.c      | 96 +++++++++++++++++++++++++++++++++++++
>>>>  drivers/fpga/dfl.c          | 44 ++++++++++++++++-
>>>>  drivers/fpga/dfl.h          |  9 ++++
>>>>  uio.c                       | 56 ++++++++++++++++++++++
>>>>  5 files changed, 212 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/fpga/dfl-uio.c
>>>>  create mode 100644 uio.c
>>>>
>>>> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
>>>> index 037dc4f946f0..3323e90a18c4 100644
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
>>>> index 000000000000..7610ee0b19dc
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/dfl-uio.c
>>>> @@ -0,0 +1,96 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * prototype dfl uio driver
>>>> + *
>>>> + * Copyright Tom Rix 2020
>>>> + */
>>>> +#include <linux/module.h>
>>>> +#include "dfl.h"
>>>> +
>>>> +static irqreturn_t dfl_uio_handler(int irq, struct uio_info *info)
>>>> +{
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
>>>> +{
>>>> +	int ret = -ENODEV;
>>>> +	return ret;
>>> Did you run this through checkpatch?
>>>
>>> Does the code make sense?
>>>
>>>> +}
>>>> +
>>>> +static int dfl_uio_open(struct uio_info *info, struct inode *inode)
>>>> +{
>>>> +	int ret = -ENODEV;
>>>> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
>>>> +	if (feature->dev)
>>>> +		mutex_lock(&feature->lock);
>>>> +
>>>> +	ret = 0;
>>>> +	return ret;
>>> Same here, does this make sense?
>>>
>>> And wait, you are having userspace grab a kernel lock?  What could go
>>> wrong?  :(
>>>
>> Yes, this is the bad part of this idea.
>>
>> Tom
>>
>>
>>>> +}
>>>> +
>>>> +static int dfl_uio_release(struct uio_info *info, struct inode *inode)
>>>> +{
>>>> +	int ret = -ENODEV;
>>>> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
>>>> +	if (feature->dev)
>>>> +		mutex_unlock(&feature->lock);
>>>> +
>>>> +	ret = 0;
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
>>>> +{
>>>> +	int ret = -ENODEV;
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +int dfl_uio_add(struct dfl_feature *feature)
>>>> +{
>>>> +	struct uio_info *uio = &feature->uio;
>>>> +	struct resource *res =
>>>> +		&feature->dev->resource[feature->resource_index];
>>>> +	int ret = 0;
>>>> +
>>>> +	uio->name = kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
>>>> +	if (!uio->name) {
>>>> +		ret = -ENOMEM;
>>>> +		goto exit;
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
>>>> +	//uio->mmap = dfl_uio_mmap;
>>> ???
>>>
>>> I don't understand what this patch is trying to show...
>>> thanks,
>>>
>>> greg k-h
>>>

