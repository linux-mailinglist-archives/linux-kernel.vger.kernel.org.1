Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2081F2F38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgFIAst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 20:48:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728780AbgFIAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591663708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xggwuU1S2eOYnC26D2q+uKaoVFXR4OD19Er/g/QRl6k=;
        b=ikKwBhXp4yFm4n31iCrJTQC3daF7s1eyEFbakwR2iyusSIEgCHmUGCldQvdzBzdgHnzy0A
        UcWKMJmVTijcBMzorm11d5X0MIHoAO0JYLBos9x4RrOXhiaHfDLTgHqqosHH1RulvWFvQf
        PDyP48YfLrbp8+Wnep4g9IUM30cHG6Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-hj4QYJpMOSOFjEv5DwePtw-1; Mon, 08 Jun 2020 20:48:26 -0400
X-MC-Unique: hj4QYJpMOSOFjEv5DwePtw-1
Received: by mail-qk1-f197.google.com with SMTP id d190so15829291qkc.20
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 17:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xggwuU1S2eOYnC26D2q+uKaoVFXR4OD19Er/g/QRl6k=;
        b=O38ZRuzutlNyNS+jvjTFo+Qz+NjRbSWBEOWAc+B0jRypcCDljG3DLROOk/z1hEjrbv
         gbmrt5nTbMHSAdUmoH35otKuP0Q3CjotCbotDXSAciIIrE4+CzqaIMS/1kwf7X5/1Hak
         dCdOu0ZiZ937ZNyszde4seHNi0wZAltuYepZS7Gd8iXAI04SNbPn+RTor6oQy4yR7Bz3
         GjVarrG8sIuFmCDFe140m2U2qMkXifmhtvYwDmmXlCSCFY0TcpJaj+nQDWXvOl2yAXtU
         hXi3lHNEa+q131X2P8Q/wDeQs0zWRFJ+HruDOgLhAHxY2/8d9PUfc+pfIkJrqpSMQFkO
         sMKQ==
X-Gm-Message-State: AOAM5331F7nXnHW38MEIKpkOITtHzPzUqnCNLiWa4eHxE6tKwiCM7BIh
        p3a4K6GhnT25ADbxQ795QeTF8dh73KCR+is7xF6p8Dnt/fCk2Mpbup3XDvcdPkT9g0ICX/s+mVE
        W8z7on6GZxsNOWe+3TCy8pQs6
X-Received: by 2002:ad4:4f23:: with SMTP id fc3mr1411548qvb.25.1591663706019;
        Mon, 08 Jun 2020 17:48:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBOFdLgc0KGvx6nAnZzVawKbNnBCiGxmwb1u69XCY+auQT9U2/HWLYXBtO/4PvHrPUQTF0jw==
X-Received: by 2002:ad4:4f23:: with SMTP id fc3mr1411514qvb.25.1591663705466;
        Mon, 08 Jun 2020 17:48:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a5sm8417545qtw.22.2020.06.08.17.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 17:48:24 -0700 (PDT)
Subject: Re: [PATCH v6 1/7] fpga: dfl: parse interrupt info for feature
 devices on enumeration
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhu@redhat.com, mtosatti@redhat.com,
        gregkh@linuxfoundation.org, Luwei Kang <luwei.kang@intel.com>,
        Wu Hao <hao.wu@intel.com>
References: <1591260737-15211-1-git-send-email-yilun.xu@intel.com>
 <1591260737-15211-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a9329161-f94f-7b79-f423-c8d49986dae8@redhat.com>
Date:   Mon, 8 Jun 2020 17:48:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1591260737-15211-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure about the use of parse_feature_irqs.

If the irq parse fails, the feature fails to be created.  So an old afu feature which loaded ok in an older kernel can fail.  This could surprise the user.

Below is a change that fails more gracefully.  Even if there is a problem in the parse, the feature will be created. because the nr_irq's is 0, the irq code should not execute.

Tom

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 125369c6c5b3..edba1e8410bd 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -708,11 +708,8 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
                break;
        }
 
-       if (!inr) {
-               *irq_base = 0;
-               *nr_irqs = 0;
+       if (!inr)
                return 0;
-       }
 
        dev_dbg(binfo->dev, "feature: 0x%llx, irq_base: %u, nr_irqs: %u\n",
                fid, ibase, inr);
@@ -751,9 +748,9 @@ create_feature_instance(struct build_feature_devs_info *binfo,
                        struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
                        resource_size_t size, u64 fid)
 {
-       unsigned int irq_base, nr_irqs;
+       unsigned int irq_base = 0;
+       unsigned int nr_irqs = 0;
        struct dfl_feature_info *finfo;
-       int ret;
 
        /* read feature size and id if inputs are invalid */
        size = size ? size : feature_size(dfl->ioaddr + ofst);
@@ -762,9 +759,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
        if (dfl->len - ofst < size)
                return -EINVAL;
 
-       ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
-       if (ret)
-               return ret;
+       parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
 
        finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
        if (!finfo)

On 6/4/20 1:52 AM, Xu Yilun wrote:
> DFL based FPGA devices could support interrupts for different purposes,
> but current DFL framework only supports feature device enumeration with
> given MMIO resources information via common DFL headers. This patch
> introduces one new API dfl_fpga_enum_info_add_irq for low level bus
> drivers (e.g. PCIe device driver) to pass its interrupt resources
> information to DFL framework for enumeration, and also adds interrupt
> enumeration code in framework to parse and assign interrupt resources
> for enumerated feature devices and their own sub features.
>
> With this patch, DFL framework enumerates interrupt resources for core
> features, including PORT Error Reporting, FME (FPGA Management Engine)
> Error Reporting and also AFU User Interrupts.
>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: early validating irq table for each feature in parse_feature_irq().
>     Some code improvement and minor fix for Hao's comments.
> v3: put parse_feature_irqs() inside create_feature_instance()
>     some minor fixes and more comments
> v4: no need to include asm/irq.h.
>     fail the dfl enumeration when irq parsing error happens.
> v5: Some minor fix for Hao's comments
> v6: Remove unnecessary type casting.
>     Some comment fix for Moritz's comments.
> ---
>  drivers/fpga/dfl.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h |  40 ++++++++++++++
>  2 files changed, 193 insertions(+)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 9909948..02c1ec4 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -421,6 +421,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   *
>   * @dev: device to enumerate.
>   * @cdev: the container device for all feature devices.
> + * @nr_irqs: number of irqs for all feature devices.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
> + *	       this device.
>   * @feature_dev: current feature device.
>   * @ioaddr: header register region address of feature device in enumeration.
>   * @sub_features: a sub features linked list for feature device in enumeration.
> @@ -429,6 +432,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>  struct build_feature_devs_info {
>  	struct device *dev;
>  	struct dfl_fpga_cdev *cdev;
> +	unsigned int nr_irqs;
> +	int *irq_table;
> +
>  	struct platform_device *feature_dev;
>  	void __iomem *ioaddr;
>  	struct list_head sub_features;
> @@ -442,12 +448,16 @@ struct build_feature_devs_info {
>   * @mmio_res: mmio resource of this sub feature.
>   * @ioaddr: mapped base address of mmio resource.
>   * @node: node in sub_features linked list.
> + * @irq_base: start of irq index in this sub feature.
> + * @nr_irqs: number of irqs of this sub feature.
>   */
>  struct dfl_feature_info {
>  	u64 fid;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
> +	unsigned int irq_base;
> +	unsigned int nr_irqs;
>  };
>  
>  static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
> @@ -520,6 +530,8 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
>  		struct dfl_feature *feature = &pdata->features[index];
> +		struct dfl_feature_irq_ctx *ctx;
> +		unsigned int i;
>  
>  		/* save resource information for each feature */
>  		feature->id = finfo->fid;
> @@ -527,6 +539,20 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  		feature->ioaddr = finfo->ioaddr;
>  		fdev->resource[index++] = finfo->mmio_res;
>  
> +		if (finfo->nr_irqs) {
> +			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
> +					   sizeof(*ctx), GFP_KERNEL);
> +			if (!ctx)
> +				return -ENOMEM;
> +
> +			for (i = 0; i < finfo->nr_irqs; i++)
> +				ctx[i].irq =
> +					binfo->irq_table[finfo->irq_base + i];
> +
> +			feature->irq_ctx = ctx;
> +			feature->nr_irqs = finfo->nr_irqs;
> +		}
> +
>  		list_del(&finfo->node);
>  		kfree(finfo);
>  	}
> @@ -638,6 +664,78 @@ static u64 feature_id(void __iomem *start)
>  	return 0;
>  }
>  
> +static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> +			      resource_size_t ofst, u64 fid,
> +			      unsigned int *irq_base, unsigned int *nr_irqs)
> +{
> +	void __iomem *base = binfo->ioaddr + ofst;
> +	unsigned int i, ibase, inr = 0;
> +	int virq;
> +	u64 v;
> +
> +	/*
> +	 * Ideally DFL framework should only read info from DFL header, but
> +	 * current version DFL only provides mmio resources information for
> +	 * each feature in DFL Header, no field for interrupt resources.
> +	 * Interrupt resource information is provided by specific mmio
> +	 * registers of each private feature which supports interrupt. So in
> +	 * order to parse and assign irq resources, DFL framework has to look
> +	 * into specific capability registers of these private features.
> +	 *
> +	 * Once future DFL version supports generic interrupt resource
> +	 * information in common DFL headers, the generic interrupt parsing
> +	 * code will be added. But in order to be compatible to old version
> +	 * DFL, the driver may still fall back to these quirks.
> +	 */
> +	switch (fid) {
> +	case PORT_FEATURE_ID_UINT:
> +		v = readq(base + PORT_UINT_CAP);
> +		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +		break;
> +	case PORT_FEATURE_ID_ERROR:
> +		v = readq(base + PORT_ERROR_CAP);
> +		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +		break;
> +	case FME_FEATURE_ID_GLOBAL_ERR:
> +		v = readq(base + FME_ERROR_CAP);
> +		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		break;
> +	}
> +
> +	if (!inr) {
> +		*irq_base = 0;
> +		*nr_irqs = 0;
> +		return 0;
> +	}
> +
> +	dev_dbg(binfo->dev, "feature: 0x%llx, irq_base: %u, nr_irqs: %u\n",
> +		fid, ibase, inr);
> +
> +	if (ibase + inr > binfo->nr_irqs) {
> +		dev_err(binfo->dev,
> +			"Invalid interrupt number in feature 0x%llx\n", fid);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < inr; i++) {
> +		virq = binfo->irq_table[ibase + i];
> +		if (virq < 0 || virq > NR_IRQS) {
> +			dev_err(binfo->dev,
> +				"Invalid irq table entry for feature 0x%llx\n",
> +				fid);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*irq_base = ibase;
> +	*nr_irqs = inr;
> +
> +	return 0;
> +}
> +
>  /*
>   * when create sub feature instances, for private features, it doesn't need
>   * to provide resource size and feature id as they could be read from DFH
> @@ -650,7 +748,9 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
>  			resource_size_t size, u64 fid)
>  {
> +	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
> +	int ret;
>  
>  	/* read feature size and id if inputs are invalid */
>  	size = size ? size : feature_size(dfl->ioaddr + ofst);
> @@ -659,6 +759,10 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	if (dfl->len - ofst < size)
>  		return -EINVAL;
>  
> +	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> +	if (ret)
> +		return ret;
> +
>  	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
>  	if (!finfo)
>  		return -ENOMEM;
> @@ -667,6 +771,8 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	finfo->mmio_res.start = dfl->start + ofst;
>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
> +	finfo->irq_base = irq_base;
> +	finfo->nr_irqs = nr_irqs;
>  	finfo->ioaddr = dfl->ioaddr + ofst;
>  
>  	list_add_tail(&finfo->node, &binfo->sub_features);
> @@ -853,6 +959,10 @@ void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
>  		devm_kfree(dev, dfl);
>  	}
>  
> +	/* remove irq table */
> +	if (info->irq_table)
> +		devm_kfree(dev, info->irq_table);
> +
>  	devm_kfree(dev, info);
>  	put_device(dev);
>  }
> @@ -892,6 +1002,45 @@ int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_dfl);
>  
> +/**
> + * dfl_fpga_enum_info_add_irq - add irq table to enum info
> + *
> + * @info: ptr to dfl_fpga_enum_info
> + * @nr_irqs: number of irqs of the DFL fpga device to be enumerated.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
> + *	       this device.
> + *
> + * One FPGA device may have several interrupts. This function adds irq
> + * information of the DFL fpga device to enum info for next step enumeration.
> + * This function should be called before dfl_fpga_feature_devs_enumerate().
> + * As we only support one irq domain for all DFLs in the same enum info, adding
> + * irq table a second time for the same enum info will return error.
> + *
> + * If we need to enumerate DFLs which belong to different irq domains, we
> + * should fill more enum info and enumerate them one by one.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
> +			       unsigned int nr_irqs, int *irq_table)
> +{
> +	if (!nr_irqs || !irq_table)
> +		return -EINVAL;
> +
> +	if (info->irq_table)
> +		return -EEXIST;
> +
> +	info->irq_table = devm_kmemdup(info->dev, irq_table,
> +				       sizeof(int) * nr_irqs, GFP_KERNEL);
> +	if (!info->irq_table)
> +		return -ENOMEM;
> +
> +	info->nr_irqs = nr_irqs;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
> +
>  static int remove_feature_dev(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -959,6 +1108,10 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>  	binfo->dev = info->dev;
>  	binfo->cdev = cdev;
>  
> +	binfo->nr_irqs = info->nr_irqs;
> +	if (info->nr_irqs)
> +		binfo->irq_table = info->irq_table;
> +
>  	/*
>  	 * start enumeration for all feature devices based on Device Feature
>  	 * Lists.
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2f5d305..a3c9e4a 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -112,6 +112,13 @@
>  #define FME_PORT_OFST_ACC_VF	1
>  #define FME_PORT_OFST_IMP	BIT_ULL(60)
>  
> +/* FME Error Capability Register */
> +#define FME_ERROR_CAP		0x70
> +
> +/* FME Error Capability Register Bitfield */
> +#define FME_ERROR_CAP_SUPP_INT	BIT_ULL(0)		/* Interrupt Support */
> +#define FME_ERROR_CAP_INT_VECT	GENMASK_ULL(12, 1)	/* Interrupt vector */
> +
>  /* PORT Header Register Set */
>  #define PORT_HDR_DFH		DFH
>  #define PORT_HDR_GUID_L		GUID_L
> @@ -145,6 +152,20 @@
>  #define PORT_STS_PWR_STATE_AP2	2			/* 90% throttling */
>  #define PORT_STS_PWR_STATE_AP6	6			/* 100% throttling */
>  
> +/* Port Error Capability Register */
> +#define PORT_ERROR_CAP		0x38
> +
> +/* Port Error Capability Register Bitfield */
> +#define PORT_ERROR_CAP_SUPP_INT	BIT_ULL(0)		/* Interrupt Support */
> +#define PORT_ERROR_CAP_INT_VECT	GENMASK_ULL(12, 1)	/* Interrupt vector */
> +
> +/* Port Uint Capability Register */
> +#define PORT_UINT_CAP		0x8
> +
> +/* Port Uint Capability Register Bitfield */
> +#define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
> +#define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
> +
>  /**
>   * struct dfl_fpga_port_ops - port ops
>   *
> @@ -189,6 +210,15 @@ struct dfl_feature_driver {
>  };
>  
>  /**
> + * struct dfl_feature_irq_ctx - dfl private feature interrupt context
> + *
> + * @irq: Linux IRQ number of this interrupt.
> + */
> +struct dfl_feature_irq_ctx {
> +	int irq;
> +};
> +
> +/**
>   * struct dfl_feature - sub feature of the feature devices
>   *
>   * @id: sub feature id.
> @@ -196,6 +226,8 @@ struct dfl_feature_driver {
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s reources.
>   * @ioaddr: mapped mmio resource address.
> + * @irq_ctx: interrupt context list.
> + * @nr_irqs: number of interrupt contexts.
>   * @ops: ops of this sub feature.
>   * @priv: priv data of this feature.
>   */
> @@ -203,6 +235,8 @@ struct dfl_feature {
>  	u64 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
> +	struct dfl_feature_irq_ctx *irq_ctx;
> +	unsigned int nr_irqs;
>  	const struct dfl_feature_ops *ops;
>  	void *priv;
>  };
> @@ -390,10 +424,14 @@ static inline u8 dfl_feature_revision(void __iomem *base)
>   *
>   * @dev: parent device.
>   * @dfls: list of device feature lists.
> + * @nr_irqs: number of irqs for all feature devices.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by hw irq numbers.
>   */
>  struct dfl_fpga_enum_info {
>  	struct device *dev;
>  	struct list_head dfls;
> +	unsigned int nr_irqs;
> +	int *irq_table;
>  };
>  
>  /**
> @@ -417,6 +455,8 @@ struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev);
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
>  			       resource_size_t start, resource_size_t len,
>  			       void __iomem *ioaddr);
> +int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
> +			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
>  
>  /**

