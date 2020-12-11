Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4552D812C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404761AbgLKVcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391317AbgLKVcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:32:24 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F51C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:31:44 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n1so5290494pge.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOwudKi3c/sJJmdZte/owFpzWQE+oWQgZXymuZLUvFE=;
        b=fJ8vb9k5d5ih0Ew/8e6GpgyPz/qH+VxR4hoto6jF1IdyGvPy2r048XRP1tEl+SprVO
         RCfnP8Jq6xwT27xKmqPOhXzMEmutB4HMgxUlrtf00O1vO693bdvHnZIl2mJp8K65IYpD
         J/9eDXt9AKmEC4h3CPQX2e9FnsZufUcslge4k9M1vwQNoM41E28Ydt4377hdqJ9Mp0IC
         IjXmdm8QWgfabGs5QtZnb1p65jsdrXwUdvU5gYbj3+QbvcZ1b4Q9xsGXSzDc+aWeL/Uk
         jdb0RnaGO4VKNeSUdY5wTq+DEi1eplaeeItyr8WJQ9wbgd4YkjCEsz/nN6iMTXRXdToI
         894g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOwudKi3c/sJJmdZte/owFpzWQE+oWQgZXymuZLUvFE=;
        b=ucu5CgGTFxnoeyXQO6KxtyV04xv+3hlSmJ5q3AymnORp/K7iHp3dgR4YH1b5KUvpij
         677hfZZu5t9wgXdAlRSCYq3udSHmWvvE7pHGtXdKSt4acZDZHz2xsAcy+Ua7WXpesMEd
         MCjuIpdafF0Mh+85s4kQk4miYblmGTnnd1IqrztjGM+/s78g3dOXupr7gF+X9tgMcl55
         8VLu8jObrDFaj5h8axKPurvo7P9KvjX7mIfbBnLSGYq1AEdzBK7LCS0WRJapdLS8+3If
         eNATNAuNVcqeZ/lgXp1ZaWCLrD+OeS0H5Inz7FolEFV5xfbkA6N4awTl4kXoWb2Dq9op
         X7CA==
X-Gm-Message-State: AOAM531eTo3XlUyURTsMHUzrI5WKkNvBEl+5it3gk3i2ssmzHg6Fir4S
        qe1UQze9sFeGCSKCM79zNue5wg==
X-Google-Smtp-Source: ABdhPJzJU2ztbjBhJlS4dJPQ3mPqooHfOZ+TprKJpG+UBUYRmhLms2GXHxkjbUYWo3Yz6kMa+EfEfg==
X-Received: by 2002:a62:1a56:0:b029:19d:b6eb:291a with SMTP id a83-20020a621a560000b029019db6eb291amr13615938pfa.10.1607722303664;
        Fri, 11 Dec 2020 13:31:43 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a141sm11447988pfa.189.2020.12.11.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:31:42 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:31:41 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org
Subject: Re: [RFC 10/11] coresgith: etm-perf: Connect TRBE sink with ETE
 source
Message-ID: <20201211213141.GB1921322@xps15>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-11-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605012309-24812-11-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:15:08PM +0530, Anshuman Khandual wrote:
> Unlike traditional sink devices, individual TRBE instances are not detected
> via DT or ACPI nodes. Instead TRBE instances are detected during CPU online
> process. Hence a path connecting ETE and TRBE on a given CPU would not have
> been established until then. This adds two coresight helpers that will help
> modify outward connections from a source device to establish and terminate
> path to a given sink device. But this method might not be optimal and would
> be reworked later.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 30 ++++++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-etm-perf.h |  4 ++++
>  drivers/hwtracing/coresight/coresight-platform.c |  3 ++-
>  drivers/hwtracing/coresight/coresight-trbe.c     |  2 ++
>  include/linux/coresight.h                        |  2 ++
>  5 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 1a37991..b4ab1d4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -664,3 +664,33 @@ void __exit etm_perf_exit(void)
>  {
>  	perf_pmu_unregister(&etm_pmu);
>  }
> +
> +#ifdef CONFIG_CORESIGHT_TRBE
> +void coresight_trbe_connect_ete(struct coresight_device *csdev_trbe, int cpu)
> +{
> +	struct coresight_device *csdev_ete = per_cpu(csdev_src, cpu);

As Suzuki pointed out that won't work if the TRBE gets probed before the
ETMv4-ETE.  I also agree with Suzuki this situation should be better handled
with a per csdev_trbe that should be declared in the coresight-core.c file.
That way both sysfs and perf have access to it.  

> +
> +	if (!csdev_ete) {
> +		pr_err("Corresponding ETE device not present on cpu %d\n", cpu);
> +		return;
> +	}
> +	csdev_ete->def_sink = csdev_trbe;

That should be done in function coresight_find_default_sink().  If
per_cpu(csdev_trbe, cpu) exists then that's the what we pick.  If not then move
along with coresight_find_sink().


> +	csdev_ete->pdata->nr_outport++;
> +	if (!csdev_ete->pdata->conns)
> +		coresight_alloc_conns(&csdev_ete->dev, csdev_ete->pdata);
> +	csdev_ete->pdata->conns[csdev_ete->pdata->nr_outport - 1].child_dev = csdev_trbe;

I don't think we have to go through all that dance since the TRBE is directly
connected to the ETE.  With the above about coresight_find_default_sink() in
mind, all we need to do is fix coresight_build_path() to check if the sink
parameter is the same as csdev->def_sink.  If so then just add the sink to the
patch, no need to follow ports as we do for other classic components.

Thanks,
Mathieu

> +}
> +
> +void coresight_trbe_remove_ete(struct coresight_device *csdev_trbe, int cpu)
> +{
> +	struct coresight_device *csdev_ete = per_cpu(csdev_src, cpu);
> +
> +	if (!csdev_ete) {
> +		pr_err("Corresponding ETE device not present on cpu %d\n", cpu);
> +		return;
> +	}
> +	csdev_ete->pdata->conns[csdev_ete->pdata->nr_outport - 1].child_dev = NULL;
> +	csdev_ete->def_sink = NULL;
> +	csdev_ete->pdata->nr_outport--;
> +}
> +#endif
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 3e4f2ad..20386cf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -85,4 +85,8 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>  int __init etm_perf_init(void);
>  void __exit etm_perf_exit(void);
>  
> +#ifdef CONFIG_CORESIGHT_TRBE
> +void coresight_trbe_connect_ete(struct coresight_device *csdev, int cpu);
> +void coresight_trbe_remove_ete(struct coresight_device *csdev, int cpu);
> +#endif
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index c594f45..8fa7406 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -23,7 +23,7 @@
>   * coresight_alloc_conns: Allocate connections record for each output
>   * port from the device.
>   */
> -static int coresight_alloc_conns(struct device *dev,
> +int coresight_alloc_conns(struct device *dev,
>  				 struct coresight_platform_data *pdata)
>  {
>  	if (pdata->nr_outport) {
> @@ -35,6 +35,7 @@ static int coresight_alloc_conns(struct device *dev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(coresight_alloc_conns);
>  
>  static struct device *
>  coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 48a8ec3..afd1a1c 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -507,6 +507,7 @@ static void arm_trbe_probe_coresight_cpu(void *info)
>  	if (IS_ERR(cpudata->csdev))
>  		goto cpu_clear;
>  
> +	coresight_trbe_connect_ete(cpudata->csdev, cpudata->cpu);
>  	dev_set_drvdata(&cpudata->csdev->dev, cpudata);
>  	cpudata->trbe_dbm = get_trbe_flag_update();
>  	cpudata->trbe_align = 1ULL << get_trbe_address_align();
> @@ -586,6 +587,7 @@ static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>  
>  	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
>  		cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> +		coresight_trbe_remove_ete(cpudata->csdev, cpu);
>  		if (cpudata->csdev) {
>  			coresight_unregister(cpudata->csdev);
>  			cpudata->drvdata = NULL;
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index c2d0a2a..c657813 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -496,6 +496,8 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
>  			       u64 val, u32 offset);
>  void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
>  
> +int coresight_alloc_conns(struct device *dev,
> +			  struct coresight_platform_data *pdata);
>  
>  #else
>  static inline struct coresight_device *
> -- 
> 2.7.4
> 
