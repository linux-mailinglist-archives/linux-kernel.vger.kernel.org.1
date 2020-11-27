Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA50A2C6BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgK0TN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgK0TLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:11:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1AC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:11:07 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so5330911pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z+LzqEyxHvSh1g2ao0/DArGUpo7IsnsnAyG1x14b+l4=;
        b=ZU2FNGXQe1XQgRqttFIqT9geb2X3MW6RvLQ129s3OoL5nQbYnD5v9f8dQGOOqYgITu
         IQ/9wGSd7TBu7MgN2vWySmFb2BBbCE717PI+D5Ba+IcMGsI4glK9bnv2S8ksnbPKHOnm
         4kYbDxitMTz8U4e7BkQev6dCziY2QYWqPlU5Fn2+6rLDPtZERDWzrR+/DW0Dt5fUJbc1
         hEnbAjlJTDBoEzGO7zHLkBsTZNpMywQBBe+rxwzj/AUoHmsvT96SnOqNsDDEyfA2pko1
         eX2RcjUyNRzTirnPU3PeUFuJ23t/7bo6LQdqz/WM7Bh5BP+i33yLWTWdOopLRmuRZMTi
         1gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+LzqEyxHvSh1g2ao0/DArGUpo7IsnsnAyG1x14b+l4=;
        b=ZOZTx6p914UNZihWLqIEfcHS87zjhYWgzDsn9rqMXJI3uqJzc0WDa8YVoTYVJpc8uB
         8phdeZQgHBoHoK1xF3cE6Bhnj4wGEiFyWbLDujopw2BUTj7iKDpNB8DvFmCBhBhEgV1t
         bspL+xuZkZDO3lUROw3fvWZLO2FFw7hLKzi/6G+AUEWPVvfM/P3rmfRhqBGjP0LSBHVn
         fjdf/bjNmwmENtdFpczXvlHT5y6NX25pPbgq0psSE4Sk283RJ/DJT4fLHx6X0URn7OXx
         60VIyoO+2hks7eaFlxid5gO8M7llY+C3pqOnZyHEzGGFO4QO53XAMK7V6aXBVTCe5zZj
         8i0g==
X-Gm-Message-State: AOAM531pfpkhounbbrphs1ymAn8VTWV1+IUtjy8csvDEXR73bNeqa9c4
        cAOQ1CTR00PXxelNIDF1SgPUkw==
X-Google-Smtp-Source: ABdhPJwC0PSRG5KnCMyRfvSFOdXS9bqpBe07ilwdUoRuju29QIKuIpsis3OClVIwex4xwK+SxCijmg==
X-Received: by 2002:a63:171b:: with SMTP id x27mr7834580pgl.70.1606504266606;
        Fri, 27 Nov 2020 11:11:06 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d22sm11553694pjw.11.2020.11.27.11.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:11:06 -0800 (PST)
Date:   Fri, 27 Nov 2020 12:11:04 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 03/25] coresight: Introduce device access abstraction
Message-ID: <20201127191104.GC1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-4-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:25PM +0000, Suzuki K Poulose wrote:
> We are about to introduce support for sysreg access to ETMv4.4+
> component. Since there are generic routines that access the
> registers (e.g, CS_LOCK/UNLOCK , claim/disclaim operations, timeout)
> and in order to preserve the logic of these operations at a
> single place we introduce an abstraction layer for the accesses
> to a given device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Change since v3
>  - Dropped csa argument to read()/write().
>  - Addressed comments on spacing and adding labels for the #if #else #endifs.
>    (Mathieu)

For patches 1 and 3:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |   1 +
>  drivers/hwtracing/coresight/coresight-core.c  |  43 ++++
>  .../hwtracing/coresight/coresight-cti-core.c  |   1 +
>  drivers/hwtracing/coresight/coresight-etb10.c |   1 +
>  .../coresight/coresight-etm3x-core.c          |   1 +
>  .../coresight/coresight-etm4x-core.c          |   1 +
>  .../hwtracing/coresight/coresight-funnel.c    |   1 +
>  .../coresight/coresight-replicator.c          |   1 +
>  drivers/hwtracing/coresight/coresight-stm.c   |   1 +
>  .../hwtracing/coresight/coresight-tmc-core.c  |   1 +
>  drivers/hwtracing/coresight/coresight-tpiu.c  |   1 +
>  include/linux/coresight.h                     | 198 +++++++++++++++++-
>  12 files changed, 248 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 99430f6cf5a5..5baf29510f1b 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -551,6 +551,7 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev->platform_data = pdata;
>  
>  	drvdata->base = base;
> +	catu_desc.access = CSDEV_ACCESS_IOMEM(base);
>  	catu_desc.pdata = pdata;
>  	catu_desc.dev = dev;
>  	catu_desc.groups = catu_groups;
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 29c83eac3106..0d6697f1d58f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1452,6 +1452,48 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
>  }
>  EXPORT_SYMBOL_GPL(coresight_timeout);
>  
> +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_relaxed_read32(&csdev->access, offset);
> +}
> +
> +u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_read32(&csdev->access, offset);
> +}
> +
> +void coresight_relaxed_write32(struct coresight_device *csdev,
> +			       u32 val, u32 offset)
> +{
> +	csdev_access_relaxed_write32(&csdev->access, val, offset);
> +}
> +
> +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> +{
> +	csdev_access_write32(&csdev->access, val, offset);
> +}
> +
> +u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_relaxed_read64(&csdev->access, offset);
> +}
> +
> +u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_read64(&csdev->access, offset);
> +}
> +
> +void coresight_relaxed_write64(struct coresight_device *csdev,
> +			       u64 val, u32 offset)
> +{
> +	csdev_access_relaxed_write64(&csdev->access, val, offset);
> +}
> +
> +void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> +{
> +	csdev_access_write64(&csdev->access, val, offset);
> +}
> +
>  /*
>   * coresight_release_platform_data: Release references to the devices connected
>   * to the output port of this device.
> @@ -1516,6 +1558,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  	csdev->type = desc->type;
>  	csdev->subtype = desc->subtype;
>  	csdev->ops = desc->ops;
> +	csdev->access = desc->access;
>  	csdev->orphan = false;
>  
>  	csdev->dev.type = &coresight_dev_type[desc->type];
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index d28eae93e55c..3bb0de97d66e 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -870,6 +870,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	cti_desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	dev_set_drvdata(dev, drvdata);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 1b320ab581ca..fec77a841f2c 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -757,6 +757,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 47f610b1c2b1..36c5b0ae1b43 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -839,6 +839,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index ea2e317ddb7d..6448ce69be63 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1530,6 +1530,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 39be46b74dfe..18c3e112a813 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -242,6 +242,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  		}
>  		drvdata->base = base;
>  		desc.groups = coresight_funnel_groups;
> +		desc.access = CSDEV_ACCESS_IOMEM(base);
>  	}
>  
>  	dev_set_drvdata(dev, drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 6772f23e5c4b..14781da6579e 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -254,6 +254,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  		}
>  		drvdata->base = base;
>  		desc.groups = replicator_groups;
> +		desc.access = CSDEV_ACCESS_IOMEM(base);
>  	}
>  
>  	if (fwnode_property_present(dev_fwnode(dev),
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index b0ad912651a9..315500b7763f 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -884,6 +884,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  	drvdata->base = base;
> +	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	ret = stm_get_stimulus_area(dev, &ch_res);
>  	if (ret)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 5653e0945c74..8fd640d41e1b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -456,6 +456,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	drvdata->base = base;
> +	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 566c57e03596..dfa3b91d0281 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -149,6 +149,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	/* Disable tpiu to support older devices */
>  	tpiu_disable_hw(drvdata);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 7d3c87e5b97c..d3aa328639cd 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -7,6 +7,7 @@
>  #define _LINUX_CORESIGHT_H
>  
>  #include <linux/device.h>
> +#include <linux/io.h>
>  #include <linux/perf_event.h>
>  #include <linux/sched.h>
>  
> @@ -114,6 +115,36 @@ struct coresight_platform_data {
>  	struct coresight_connection *conns;
>  };
>  
> +/**
> + * struct csdev_access - Abstraction of a CoreSight device access.
> + *
> + * @io_mem	: True if the device has memory mapped I/O
> + * @base	: When io_mem == true, base address of the component
> + * @read	: Read from the given "offset" of the given instance.
> + * @write	: Write "val" to the given "offset".
> + */
> +struct csdev_access {
> +	bool io_mem;
> +	union {
> +		void __iomem *base;
> +		struct {
> +			u64 (*read)(u32 offset,
> +				    bool relaxed,
> +				    bool _64bit);
> +			void (*write)(u64 val,
> +				      u32 offset,
> +				      bool relaxed,
> +				      bool _64bit);
> +		};
> +	};
> +};
> +
> +#define CSDEV_ACCESS_IOMEM(_addr)		\
> +	((struct csdev_access)	{		\
> +		.io_mem		= true,		\
> +		.base		= (_addr),	\
> +	})
> +
>  /**
>   * struct coresight_desc - description of a component required from drivers
>   * @type:	as defined by @coresight_dev_type.
> @@ -125,6 +156,7 @@ struct coresight_platform_data {
>   * @groups:	operations specific to this component. These will end up
>   *		in the component's sysfs sub-directory.
>   * @name:	name for the coresight device, also shown under sysfs.
> + * @access:	Describe access to the device
>   */
>  struct coresight_desc {
>  	enum coresight_dev_type type;
> @@ -134,6 +166,7 @@ struct coresight_desc {
>  	struct device *dev;
>  	const struct attribute_group **groups;
>  	const char *name;
> +	struct csdev_access access;
>  };
>  
>  /**
> @@ -173,7 +206,8 @@ struct coresight_sysfs_link {
>   * @type:	as defined by @coresight_dev_type.
>   * @subtype:	as defined by @coresight_dev_subtype.
>   * @ops:	generic operations for this component, as defined
> -		by @coresight_ops.
> + *		by @coresight_ops.
> + * @access:	Device i/o access abstraction for this device.
>   * @dev:	The device entity associated to this component.
>   * @refcnt:	keep track of what is in use.
>   * @orphan:	true if the component has connections that haven't been linked.
> @@ -195,6 +229,7 @@ struct coresight_device {
>  	enum coresight_dev_type type;
>  	union coresight_dev_subtype subtype;
>  	const struct coresight_ops *ops;
> +	struct csdev_access access;
>  	struct device dev;
>  	atomic_t *refcnt;
>  	bool orphan;
> @@ -326,6 +361,104 @@ struct coresight_ops {
>  };
>  
>  #if IS_ENABLED(CONFIG_CORESIGHT)
> +
> +static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
> +					      u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		return readl_relaxed(csa->base + offset);
> +
> +	return csa->read(offset, true, false);
> +}
> +
> +static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		return readl(csa->base + offset);
> +
> +	return csa->read(offset, false, false);
> +}
> +
> +static inline void csdev_access_relaxed_write32(struct csdev_access *csa,
> +						u32 val, u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		writel_relaxed(val, csa->base + offset);
> +	else
> +		csa->write(val, offset, true, false);
> +}
> +
> +static inline void csdev_access_write32(struct csdev_access *csa, u32 val, u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		writel(val, csa->base + offset);
> +	else
> +		csa->write(val, offset, false, false);
> +}
> +
> +#ifdef CONFIG_64BIT
> +
> +static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> +					      u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		return readq_relaxed(csa->base + offset);
> +
> +	return csa->read(offset, true, true);
> +}
> +
> +static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		return readq(csa->base + offset);
> +
> +	return csa->read(offset, false, true);
> +}
> +
> +static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
> +						u64 val, u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		writeq_relaxed(val, csa->base + offset);
> +	else
> +		csa->write(val, offset, true, true);
> +}
> +
> +static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
> +{
> +	if (likely(csa->io_mem))
> +		writeq(val, csa->base + offset);
> +	else
> +		csa->write(val, offset, false, true);
> +}
> +
> +#else	/* !CONFIG_64BIT */
> +
> +static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> +					   u32 offset)
> +{
> +	WARN_ON(1);
> +	return 0;
> +}
> +
> +static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
> +{
> +	WARN_ON(1);
> +	return 0;
> +}
> +
> +static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
> +						u64 val, u32 offset)
> +{
> +	WARN_ON(1);
> +}
> +
> +static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
> +{
> +	WARN_ON(1);
> +}
> +#endif	/* CONFIG_64BIT */
> +
>  extern struct coresight_device *
>  coresight_register(struct coresight_desc *desc);
>  extern void coresight_unregister(struct coresight_device *csdev);
> @@ -343,6 +476,20 @@ extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
>  					 struct device *dev);
>  
>  extern bool coresight_loses_context_with_cpu(struct device *dev);
> +
> +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset);
> +u32 coresight_read32(struct coresight_device *csdev, u32 offset);
> +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset);
> +void coresight_relaxed_write32(struct coresight_device *csdev,
> +			       u32 val,
> +			       u32 offset);
> +u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset);
> +u64 coresight_read64(struct coresight_device *csdev, u32 offset);
> +void coresight_relaxed_write64(struct coresight_device *csdev,
> +			       u64 val, u32 offset);
> +void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
> +
> +
>  #else
>  static inline struct coresight_device *
>  coresight_register(struct coresight_desc *desc) { return NULL; }
> @@ -369,10 +516,55 @@ static inline bool coresight_loses_context_with_cpu(struct device *dev)
>  {
>  	return false;
>  }
> -#endif
> +
> +static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> +{
> +}
> +
> +static inline void coresight_relaxed_write32(struct coresight_device *csdev,
> +					     u32 val, u32 offset)
> +{
> +}
> +
> +static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
> +					   u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline void coresight_relaxed_write64(struct coresight_device *csdev,
> +					     u64 val,
> +					     u32 offset)
> +{
> +}
> +
> +static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> +{
> +}
> +
> +#endif		/* IS_ENABLED(CONFIG_CORESIGHT) */
>  
>  extern int coresight_get_cpu(struct device *dev);
>  
>  struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
>  
> -#endif
> +#endif		/* _LINUX_COREISGHT_H */
> -- 
> 2.24.1
> 
