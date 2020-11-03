Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154942A4CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgKCRZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:25:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:25:47 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so3973329pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wF5A94mVpEhZA1fcza47cS55LFv8aa08dvNXYsNl8sI=;
        b=VUoGTIO1KJXXilqSc4tXtnFEqV2PzHzz+nT2NHx2IlWEHrPprkN3Nwu9J+F9GCEorG
         5Bqnm6ZYZe3UD6Cpl8XAfmLpxB4Gg4JZlz7AwJr8DfqAmdxF8vHoNhYlUCBd6NKgNXF5
         wo/sWwhy8A7a5F7JD/uJsBrzW+976LB9vmT9JOAv2BD9zpH2VDAIWM58+xmdjs8PiaGB
         NnybigzhPLYbTP9ehesyaAey8MQlrTwj5MXeUAFTT9DgMBvuJDM80cGAiuiCyBGmUc1c
         aWew4rpef+l2jFRprMP6EIvlmBPivbUuxAojRiRMYUogrBe2Ia1oM3bWoek9qsgC6Qcn
         TS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wF5A94mVpEhZA1fcza47cS55LFv8aa08dvNXYsNl8sI=;
        b=EPdORp8e10aQ+rr5g7KKVTx8NogoYshDXDT142XRf+z4Y1vZBweLjGG1Fn3RYhxdVm
         nYU2bUTu/wpaLxDAll+K3olZzixz2Y2Ia6TPhNGOrvy0AWiF8zc52JikgbtIIfG0nA7t
         GBDAgvZAn5KVTP6oLDrJJlsL4m8I7+HZtYl8qCpxQvJ1f0NwuTQDqoKVbwKFGqUrVb4K
         H5lZklXIvQN5ElDfINhueQZCYrot/2aSDsX8yRzHDf5YG+Aoq9zLKb0VdUsA7WeyMFfB
         JnDKzHRnqOZKpcCpVH/CHt2Mww4KZlH0pbvTKCtUAqmZ+vhVCTsXd5Na3poaHd9OoN9U
         2RdA==
X-Gm-Message-State: AOAM5301Xst9SskzMix83SsV02QXr0RXDWoNt8BBTWz2/f+NAfQ+fmwW
        ZUSErExbOTWywSwNGKlRexRSbA==
X-Google-Smtp-Source: ABdhPJzzFwQNEf1idcFtd/Q5kEsmucWbZGfhYH7Gj9b8++qstw5QXU6eDunYYFhOwYn44AdiGNM5WA==
X-Received: by 2002:a62:6dc2:0:b029:152:637c:4cf5 with SMTP id i185-20020a626dc20000b0290152637c4cf5mr26463513pfc.15.1604424347287;
        Tue, 03 Nov 2020 09:25:47 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j184sm7090108pfg.207.2020.11.03.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:25:46 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:25:44 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/26] coresight: Introduce device access abstraction
Message-ID: <20201103172544.GA2855763@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-9-suzuki.poulose@arm.com>
 <20201103171417.GA2854467@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103171417.GA2854467@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 10:14:17AM -0700, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Wed, Oct 28, 2020 at 10:09:26PM +0000, Suzuki K Poulose wrote:
> > We are about to introduce support for sysreg access to ETMv4.4+
> > component. Since there are generic routines that access the
> > registers (e.g, CS_LOCK/UNLOCK , claim/disclaim operations, timeout)
> > and in order to preserve the logic of these operations at a
> > single place we introduce an abstraction layer for the accesses
> > to a given device.
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-catu.c  |   1 +
> >  drivers/hwtracing/coresight/coresight-core.c  |  49 +++++
> >  .../hwtracing/coresight/coresight-cti-core.c  |   1 +
> >  drivers/hwtracing/coresight/coresight-etb10.c |   1 +
> >  .../coresight/coresight-etm3x-core.c          |   1 +
> >  .../coresight/coresight-etm4x-core.c          |   1 +
> >  .../hwtracing/coresight/coresight-funnel.c    |   1 +
> >  .../coresight/coresight-replicator.c          |   1 +
> >  drivers/hwtracing/coresight/coresight-stm.c   |   1 +
> >  .../hwtracing/coresight/coresight-tmc-core.c  |   1 +
> >  drivers/hwtracing/coresight/coresight-tpiu.c  |   1 +
> >  include/linux/coresight.h                     | 197 ++++++++++++++++++
> >  12 files changed, 256 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> > index 99430f6cf5a5..5baf29510f1b 100644
> > --- a/drivers/hwtracing/coresight/coresight-catu.c
> > +++ b/drivers/hwtracing/coresight/coresight-catu.c
> > @@ -551,6 +551,7 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
> >  	dev->platform_data = pdata;
> >  
> >  	drvdata->base = base;
> > +	catu_desc.access = CSDEV_ACCESS_IOMEM(base);
> 
> Ok for those
> 
> >  	catu_desc.pdata = pdata;
> >  	catu_desc.dev = dev;
> >  	catu_desc.groups = catu_groups;
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index cc9e8025c533..e96deaca8cab 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -1452,6 +1452,54 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
> >  }
> >  EXPORT_SYMBOL_GPL(coresight_timeout);
> >  
> > +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> > +{
> > +	return csdev_access_relaxed_read32(&csdev->access, offset);
> 
> This really doesn't give us much other than another jump.  I would give function
> csdev_access_relaxed_read32() a coresight_device argument instead of a csdev_access
> and rename it to coresight_relaxed_read32().  The same for the other access functions.
>

Ignore the above, TPIU just gave me the logic behind what you did.
 
> > +}
> > +
> > +u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> > +{
> > +	return csdev_access_read32(&csdev->access, offset);
> > +}
> > +
> > +void coresight_relaxed_write32(struct coresight_device *csdev,
> > +			       u32 val,
> > +			       u32 offset)
> > +{
> > +
> 
> Extra new line
> 
> > +	csdev_access_relaxed_write32(&csdev->access, val, offset);
> > +}
> > +
> > +
> > +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> > +{
> > +	csdev_access_write32(&csdev->access, val, offset);
> > +}
> > +
> > +u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset)
> > +{
> > +	return csdev_access_relaxed_read64(&csdev->access, offset);
> > +}
> > +
> > +u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> > +{
> > +	return csdev_access_read64(&csdev->access, offset);
> > +}
> > +
> > +void coresight_relaxed_write64(struct coresight_device *csdev,
> > +			       u64 val,
> > +			       u32 offset)
> > +{
> > +
> 
> Extra new line
> 
> > +	csdev_access_relaxed_write64(&csdev->access, val, offset);
> > +}
> > +
> > +
> > +void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> > +{
> > +	csdev_access_write64(&csdev->access, val, offset);
> > +}
> > +
> >  /*
> >   * coresight_release_platform_data: Release references to the devices connected
> >   * to the output port of this device.
> > @@ -1516,6 +1564,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
> >  	csdev->type = desc->type;
> >  	csdev->subtype = desc->subtype;
> >  	csdev->ops = desc->ops;
> > +	csdev->access = desc->access;
> >  	csdev->orphan = false;
> >  
> >  	csdev->dev.type = &coresight_dev_type[desc->type];
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> > index d28eae93e55c..3bb0de97d66e 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> > @@ -870,6 +870,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
> >  		return PTR_ERR(base);
> >  
> >  	drvdata->base = base;
> > +	cti_desc.access = CSDEV_ACCESS_IOMEM(base);
> >  
> >  	dev_set_drvdata(dev, drvdata);
> >  
> > diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> > index 248cc82c838e..b91633c6c9b4 100644
> > --- a/drivers/hwtracing/coresight/coresight-etb10.c
> > +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> > @@ -755,6 +755,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
> >  		return PTR_ERR(base);
> >  
> >  	drvdata->base = base;
> > +	desc.access = CSDEV_ACCESS_IOMEM(base);
> >  
> >  	spin_lock_init(&drvdata->spinlock);
> >  
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > index 47f610b1c2b1..36c5b0ae1b43 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > @@ -839,6 +839,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
> >  		return PTR_ERR(base);
> >  
> >  	drvdata->base = base;
> > +	desc.access = CSDEV_ACCESS_IOMEM(base);
> >  
> >  	spin_lock_init(&drvdata->spinlock);
> >  
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 0310eac9dc16..c5cb93f1b80c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1512,6 +1512,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
> >  		return PTR_ERR(base);
> >  
> >  	drvdata->base = base;
> > +	desc.access = CSDEV_ACCESS_IOMEM(base);
> >  
> >  	spin_lock_init(&drvdata->spinlock);
> >  
> > diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> > index af40814ce560..f77466aea26f 100644
> > --- a/drivers/hwtracing/coresight/coresight-funnel.c
> > +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> > @@ -242,6 +242,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
> >  		}
> >  		drvdata->base = base;
> >  		desc.groups = coresight_funnel_groups;
> > +		desc.access = CSDEV_ACCESS_IOMEM(base);
> >  	}
> >  
> >  	dev_set_drvdata(dev, drvdata);
> > diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> > index 62afdde0e5ea..fcf25740116c 100644
> > --- a/drivers/hwtracing/coresight/coresight-replicator.c
> > +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> > @@ -254,6 +254,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
> >  		}
> >  		drvdata->base = base;
> >  		desc.groups = replicator_groups;
> > +		desc.access = CSDEV_ACCESS_IOMEM(base);
> >  	}
> >  
> >  	if (fwnode_property_present(dev_fwnode(dev),
> > diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> > index b0ad912651a9..315500b7763f 100644
> > --- a/drivers/hwtracing/coresight/coresight-stm.c
> > +++ b/drivers/hwtracing/coresight/coresight-stm.c
> > @@ -884,6 +884,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
> >  	if (IS_ERR(base))
> >  		return PTR_ERR(base);
> >  	drvdata->base = base;
> > +	desc.access = CSDEV_ACCESS_IOMEM(base);
> >  
> >  	ret = stm_get_stimulus_area(dev, &ch_res);
> >  	if (ret)
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > index 5653e0945c74..8fd640d41e1b 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > @@ -456,6 +456,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
> >  	}
> >  
> >  	drvdata->base = base;
> > +	desc.access = CSDEV_ACCESS_IOMEM(base);
> >  
> >  	spin_lock_init(&drvdata->spinlock);
> >  
> > diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> > index 566c57e03596..dfa3b91d0281 100644
> > --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> > +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> > @@ -149,6 +149,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
> >  		return PTR_ERR(base);
> >  
> >  	drvdata->base = base;
> > +	desc.access = CSDEV_ACCESS_IOMEM(base);
> >  
> >  	/* Disable tpiu to support older devices */
> >  	tpiu_disable_hw(drvdata);
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 7d3c87e5b97c..5a34c2f2debc 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -7,6 +7,7 @@
> >  #define _LINUX_CORESIGHT_H
> >  
> >  #include <linux/device.h>
> > +#include <linux/io.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/sched.h>
> >  
> > @@ -114,6 +115,38 @@ struct coresight_platform_data {
> >  	struct coresight_connection *conns;
> >  };
> >  
> > +/**
> > + * struct csdev_access - Abstraction of a CoreSight device access.
> > + *
> > + * @io_mem	: True if the device has memory mapped I/O
> > + * @base	: When io_mem == true, base address of the component
> > + * @read	: Read from the given "offset" of the given instance.
> > + * @write	: Write "val" to the given "offset".
> > + */
> > +struct csdev_access {
> > +	bool io_mem;
> > +	union {
> > +		void __iomem *base;
> > +		struct {
> > +			u64 (*read)(struct csdev_access *csa,
> > +				    u32 offset,
> > +				    bool relaxed,
> > +				    bool _64bit);
> > +			void (*write)(struct csdev_access *csa,
> > +				      u64 val,
> > +				      u32 offset,
> > +				      bool relaxed,
> > +				      bool _64bit);
> > +		};
> > +	};
> > +};
> > +
> > +#define CSDEV_ACCESS_IOMEM(_addr)		\
> > +	((struct csdev_access)	{		\
> > +		.io_mem		= true,		\
> > +		.base		= (_addr),	\
> > +	})
> > +
> >  /**
> >   * struct coresight_desc - description of a component required from drivers
> >   * @type:	as defined by @coresight_dev_type.
> > @@ -125,6 +158,7 @@ struct coresight_platform_data {
> >   * @groups:	operations specific to this component. These will end up
> >   *		in the component's sysfs sub-directory.
> >   * @name:	name for the coresight device, also shown under sysfs.
> > + * @access:	Describe access to the device
> >   */
> >  struct coresight_desc {
> >  	enum coresight_dev_type type;
> > @@ -134,6 +168,7 @@ struct coresight_desc {
> >  	struct device *dev;
> >  	const struct attribute_group **groups;
> >  	const char *name;
> > +	struct csdev_access access;
> >  };
> >  
> >  /**
> > @@ -186,6 +221,7 @@ struct coresight_sysfs_link {
> >   * @def_sink:	cached reference to default sink found for this device.
> >   * @ect_dev:	Associated cross trigger device. Not part of the trace data
> >   *		path or connections.
> > + * @access:	Device i/o access abstraction for this device.
> >   * @nr_links:   number of sysfs links created to other components from this
> >   *		device. These will appear in the "connections" group.
> >   * @has_conns_grp: Have added a "connections" group for sysfs links.
> > @@ -205,6 +241,7 @@ struct coresight_device {
> >  	struct coresight_device *def_sink;
> >  	/* cross trigger handling */
> >  	struct coresight_device *ect_dev;
> > +	struct csdev_access access;
> 
> Access should be part of the generic section of the structure rather than under
> CTI.
> 
> >  	/* sysfs links between components */
> >  	int nr_links;
> >  	bool has_conns_grp;
> > @@ -326,6 +363,107 @@ struct coresight_ops {
> >  };
> >  
> >  #if IS_ENABLED(CONFIG_CORESIGHT)
> > +
> > +static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
> > +					      u32 offset)
> > +{
> > +	if (likely(csa->io_mem))
> > +		return readl_relaxed(csa->base + offset);
> > +
> > +	return csa->read(csa, offset, true, false);
> > +}
> > +
> > +static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
> > +{
> > +	if (likely(csa->io_mem))
> > +		return readl(csa->base + offset);
> > +
> > +	return csa->read(csa, offset, false, false);
> > +}
> > +
> > +static inline void csdev_access_relaxed_write32(struct csdev_access *csa,
> > +						u32 val,
> 
> No need for a new line.
> 
> > +						u32 offset)
> > +{
> > +	if (likely(csa->io_mem))
> > +		writel_relaxed(val, csa->base + offset);
> > +	else
> > +		csa->write(csa, val, offset, true, false);
> > +}
> > +
> > +static inline void csdev_access_write32(struct csdev_access *csa, u32 val, u32 offset)
> > +{
> > +	if (likely(csa->io_mem))
> > +		writel(val, csa->base + offset);
> > +	else
> > +		csa->write(csa, val, offset, false, false);
> > +}
> > +
> > +#ifdef CONFIG_64BIT
> > +
> > +static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> > +					   u32 offset)
> 
> Indentation
> 
> > +{
> > +	if (likely(csa->io_mem))
> > +		return readq_relaxed(csa->base + offset);
> > +
> > +	return csa->read(csa, offset, true, true);
> > +}
> > +
> > +static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
> > +{
> > +	if (likely(csa->io_mem))
> > +		return readq(csa->base + offset);
> > +
> > +	return csa->read(csa, offset, false, true);
> > +}
> > +
> > +static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
> > +						u64 val,
> 
> No need for a new line.
> 
> > +						u32 offset)
> > +{
> > +	if (likely(csa->io_mem))
> > +		writeq_relaxed(val, csa->base + offset);
> > +	else
> > +		csa->write(csa, val, offset, true, true);
> > +}
> > +
> > +static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
> > +{
> > +	if (likely(csa->io_mem))
> > +		writeq(val, csa->base + offset);
> > +	else
> > +		csa->write(csa, val, offset, false, true);
> > +}
> > +
> > +#else
> 
> #else /* CONFIG_64BIT */
> 
> > +
> > +static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> > +					   u32 offset)
> > +{
> > +	WARN_ON(1);
> > +	return 0;
> > +}
> > +
> > +static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
> > +{
> > +	WARN_ON(1);
> > +	return 0;
> > +}
> > +
> > +static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
> > +						u64 val,
> 
> No need for a new line.
> 
> > +						u32 offset)
> > +{
> > +	WARN_ON(1);
> > +}
> > +
> > +static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
> > +{
> > +	WARN_ON(1);
> > +}
> > +#endif
> > +
> 
> #endif /* CONFIG_64BIT */
> 
> >  extern struct coresight_device *
> >  coresight_register(struct coresight_desc *desc);
> >  extern void coresight_unregister(struct coresight_device *csdev);
> > @@ -343,6 +481,20 @@ extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
> >  					 struct device *dev);
> >  
> >  extern bool coresight_loses_context_with_cpu(struct device *dev);
> > +
> > +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset);
> > +u32 coresight_read32(struct coresight_device *csdev, u32 offset);
> > +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset);
> > +void coresight_relaxed_write32(struct coresight_device *csdev,
> > +			       u32 val,
> > +			       u32 offset);
> 
> No need for an new line
> 
> > +u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset);
> > +u64 coresight_read64(struct coresight_device *csdev, u32 offset);
> > +void coresight_relaxed_write64(struct coresight_device *csdev,
> > +			       u64 val, u32 offset);
> > +void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
> > +
> > +
> >  #else
> >  static inline struct coresight_device *
> >  coresight_register(struct coresight_desc *desc) { return NULL; }
> > @@ -369,6 +521,51 @@ static inline bool coresight_loses_context_with_cpu(struct device *dev)
> >  {
> >  	return false;
> >  }
> > +
> > +static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> > +{
> > +	WARN_ON_ONCE(1);
> > +	return 0;
> > +}
> > +
> > +static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> > +{
> > +	WARN_ON_ONCE(1);
> > +	return 0;
> > +}
> > +
> > +static inline void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> > +{
> > +}
> > +
> > +static inline void coresight_relaxed_write32(struct coresight_device *csdev,
> > +					      u32 val, u32 offset);
> 
> Indentation
> 
> > +{
> > +}
> > +
> > +static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
> > +					   u32 offset)
> > +{
> > +	WARN_ON_ONCE(1);
> > +	return 0;
> > +}
> > +
> > +static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> > +{
> > +	WARN_ON_ONCE(1);
> > +	return 0;
> > +}
> > +
> > +static inline void coresight_relaxed_write64(struct coresight_device *csdev,
> > +					     u64 val,
> > +					     u32 offset)
> > +{
> > +}
> > +
> > +static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> > +{
> > +}
> > +
> >  #endif
> 
> #endif /* IS_ENABLED(CONFIG_CORESIGHT) */
> 
> Otherwise it is quite confusing.
> 
> >  
> >  extern int coresight_get_cpu(struct device *dev);
> > -- 
> > 2.24.1
> > 
