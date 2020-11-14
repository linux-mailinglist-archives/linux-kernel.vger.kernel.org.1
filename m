Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C942B2B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 06:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKNFhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 00:37:13 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:36073 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgKNFhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 00:37:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605332232; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=V1Vk1nqcGogGt1/cvNpRXipVZxQuZhYYwU4lrEb3u+0=; b=Wk+UJSSeWoNZqAIZRxzaFrUgDYFPoek84UHQ1mxAly6Yichk7ulK712NZN8tXGoohAIMZHKt
 eWd7bhcq3EA2JjAy94UV97oumGjVw3h8Un3q6G7Cgml37TFM9F8zPDkGp/Sz1On88XaNBTsi
 ZmLmRYzCc3fbdTCntyjioTU/q7w=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5faf6cfce9dd187f53f048fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 14 Nov 2020 05:37:00
 GMT
Sender: tingweiz=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9901C433C9; Sat, 14 Nov 2020 05:37:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 338E3C433C6;
        Sat, 14 Nov 2020 05:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 338E3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Sat, 14 Nov 2020 13:36:50 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 06/11] coresight: ete: Detect ETE as one of the supported
 ETMs
Message-ID: <20201114053650.GA28964@codeaurora.org>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-7-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605012309-24812-7-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, Nov 10, 2020 at 08:45:04PM +0800, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Add ETE as one of the supported device types we support
> with ETM4x driver. The devices are named following the
> existing convention as ete<N>.
> 
> ETE mandates that the trace resource status register is programmed
> before the tracing is turned on. For the moment simply write to
> it indicating TraceActive.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          |  3 ++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 55 
> +++++++++++++++++-----
>  drivers/hwtracing/coresight/coresight-etm4x.h      |  7 +++
>  3 files changed, 52 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt 
> b/Documentation/devicetree/bindings/arm/coresight.txt
> index bff96a5..784cc1b 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -40,6 +40,9 @@ its hardware characteristcs.
>  		- Embedded Trace Macrocell with system register access only.
>  			"arm,coresight-etm-sysreg";
> 
> +		- Embedded Trace Extensions.
> +			"arm,ete"
> +
>  		- Coresight programmable Replicator :
>  			"arm,coresight-dynamic-replicator", "arm,primecell";
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 15b6e94..0fea349 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -331,6 +331,13 @@ static int etm4_enable_hw(struct etmv4_drvdata 
> *drvdata)
>  		etm4x_relaxed_write32(csa, trcpdcr | TRCPDCR_PU, TRCPDCR);
>  	}
> 
> +	/*
> +	 * ETE mandates that the TRCRSR is written to before
> +	 * enabling it.
> +	 */
> +	if (drvdata->arch >= ETM_ARCH_ETE)
> +		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
> +
>  	/* Enable the trace unit */
>  	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
> 
> @@ -763,13 +770,24 @@ static bool etm_init_sysreg_access(struct 
> etmv4_drvdata *drvdata,
>  	 * ETMs implementing sysreg access must implement TRCDEVARCH.
>  	 */
>  	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
> -	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
> +	switch (devarch & ETM_DEVARCH_ID_MASK) {
> +	case ETM_DEVARCH_ETMv4x_ARCH:
> +		*csa = (struct csdev_access) {
> +			.io_mem	= false,
> +			.read	= etm4x_sysreg_read,
> +			.write	= etm4x_sysreg_write,
> +		};
> +		break;
> +	case ETM_DEVARCH_ETE_ARCH:
> +		*csa = (struct csdev_access) {
> +			.io_mem	= false,
> +			.read	= ete_sysreg_read,
> +			.write	= ete_sysreg_write,
> +		};
> +		break;
> +	default:
>  		return false;
> -	*csa = (struct csdev_access) {
> -		.io_mem	= false,
> -		.read	= etm4x_sysreg_read,
> -		.write	= etm4x_sysreg_write,
> -	};
> +	}
> 
>  	drvdata->arch = etm_devarch_to_arch(devarch);
>  	return true;
> @@ -1698,6 +1716,8 @@ static int etm4_probe(struct device *dev, void __iomem 
> *base)
>  	struct etmv4_drvdata *drvdata;
>  	struct coresight_desc desc = { 0 };
>  	struct etm_init_arg init_arg = { 0 };
> +	u8 major, minor;
> +	char *type_name;
> 
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
> @@ -1724,10 +1744,6 @@ static int etm4_probe(struct device *dev, void 
> __iomem *base)
>  	if (drvdata->cpu < 0)
>  		return drvdata->cpu;
> 
> -	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
> -	if (!desc.name)
> -		return -ENOMEM;
> -
>  	init_arg.drvdata = drvdata;
>  	init_arg.csa = &desc.access;
> 
> @@ -1742,6 +1758,19 @@ static int etm4_probe(struct device *dev, void 
> __iomem *base)
>  	if (!desc.access.io_mem ||
>  	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>  		drvdata->skip_power_up = true;
> +	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
> +	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
> +	if (drvdata->arch >= ETM_ARCH_ETE) {
> +		type_name = "ete";
> +		major -= 4;
> +	} else {
> +		type_name = "etm";
> +	}
> +
When trace unit supports ETE, could it be still compatible with ETMv4.4?
Can use selectively use it as ETM instead of ETE?

Thanks,
Tingwei

> +	desc.name = devm_kasprintf(dev, GFP_KERNEL,
> +				   "%s%d", type_name, drvdata->cpu);
> +	if (!desc.name)
> +		return -ENOMEM;
> 
>  	etm4_init_trace_id(drvdata);
>  	etm4_set_default(&drvdata->config);
> @@ -1770,9 +1799,8 @@ static int etm4_probe(struct device *dev, void __iomem 
> *base)
> 
>  	etmdrvdata[drvdata->cpu] = drvdata;
> 
> -	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
> -		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
> -		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
> +	dev_info(&drvdata->csdev->dev, "CPU%d: %s v%d.%d initialized\n",
> +		 drvdata->cpu, type_name, major, minor);
> 
>  	if (boot_enable) {
>  		coresight_enable(drvdata->csdev);
> @@ -1892,6 +1920,7 @@ static struct amba_driver etm4x_amba_driver = {
> 
>  static const struct of_device_id etm_sysreg_match[] = {
>  	{ .compatible	= "arm,coresight-etm-sysreg" },
> +	{ .compatible	= "arm,ete" },
>  	{}
>  };
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h 
> b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 00c0367..05fd0e5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -127,6 +127,8 @@
>  #define TRCCIDR2			0xFF8
>  #define TRCCIDR3			0xFFC
> 
> +#define TRCRSR_TA			BIT(12)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> @@ -570,11 +572,14 @@
>  	((ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(major)) | 
> ETM_DEVARCH_ARCHID_ARCH_PART(0xA13))
> 
>  #define ETM_DEVARCH_ARCHID_ETMv4x		ETM_DEVARCH_MAKE_ARCHID(0x4)
> +#define ETM_DEVARCH_ARCHID_ETE			ETM_DEVARCH_MAKE_ARCHID(0x5)
> 
>  #define ETM_DEVARCH_ID_MASK						\
>  	(ETM_DEVARCH_ARCHITECT_MASK | ETM_DEVARCH_ARCHID_MASK | 
> ETM_DEVARCH_PRESENT)
>  #define ETM_DEVARCH_ETMv4x_ARCH						\
>  	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETMv4x | 
> ETM_DEVARCH_PRESENT)
> +#define ETM_DEVARCH_ETE_ARCH						\
> +	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETE | ETM_DEVARCH_PRESENT)
> 
>  #define TRCSTATR_IDLE_BIT		0
>  #define TRCSTATR_PMSTABLE_BIT		1
> @@ -661,6 +666,8 @@
>  #define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
> 
>  #define ETM_ARCH_V4	ETM_ARCH_VERSION(4, 0)
> +#define ETM_ARCH_ETE	ETM_ARCH_VERSION(5, 0)
> +
>  /* Interpretation of resource numbers change at ETM v4.3 architecture */
>  #define ETM_ARCH_V4_3	ETM_ARCH_VERSION(4, 3)
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
