Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5827F5C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbgI3XPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:15:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:64574 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730528AbgI3XPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:15:05 -0400
IronPort-SDR: u1vZVQlWz7HZynlifmOg5/NMGYoxmoRR5JE0x7dSc9h5n+0l8BSawKWKu4oYaUpBOwA+bfYg+G
 84SIYkTNDbIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="141979532"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="141979532"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:15:00 -0700
IronPort-SDR: FZOqjJpvoRQ6lNxSfQC3MwU1qu3Y/XWGAsjC2Ks/rtMvSN1W0pvAYKQ2SeDV7HHMu4eM6dMrr2
 HJ1ydeTEmQFQ==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457854717"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.91.128])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:14:59 -0700
Subject: Re: [PATCH v1 02/12] fpga: create intel max10 bmc security engine
To:     Moritz Fischer <mdf@kernel.org>
Cc:     lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-3-russell.h.weight@intel.com>
 <20200916203320.GB1076460@epycbox.lan>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <46e190e6-88cc-6d76-0078-441faa6c8b9f@intel.com>
Date:   Wed, 30 Sep 2020 16:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916203320.GB1076460@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

On 9/16/20 1:33 PM, Moritz Fischer wrote:
> Russ,
>
> On Fri, Sep 04, 2020 at 04:52:55PM -0700, Russ Weight wrote:
>> Create a platform driver that can be invoked as a sub
>> driver for the Intel MAX10 BMC in order to support
>> secure updates. This sub-driver will invoke an
>> instance of the Intel FPGA Security Manager class driver
>> in order to expose sysfs interfaces for managing and
>> monitoring secure updates to FPGA and BMC images.
>>
>> This patch creates the MAX10 BMC Security Engine driver and
>> provides support for displaying the current root entry hashes
>> for the FPGA static region, the FPGA PR region, and the MAX10
>> BMC.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Wu Hao <hao.wu@intel.com>
>> ---
>>  drivers/fpga/Kconfig                |  11 ++
>>  drivers/fpga/Makefile               |   3 +
>>  drivers/fpga/intel-m10-bmc-secure.c | 170 ++++++++++++++++++++++++++++
>>  include/linux/mfd/intel-m10-bmc.h   |  15 +++
>>  4 files changed, 199 insertions(+)
>>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 97c0a6cc2ba7..0f0bed68e618 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -244,4 +244,15 @@ config IFPGA_SEC_MGR
>>  	  region and for the BMC. Select this option to enable
>>  	  updates for secure FPGA devices.
>>  
>> +config IFPGA_M10_BMC_SECURE
>> +        tristate "Intel MAX10 BMC security engine"
>> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
>> +        help
>> +          Secure update support for the Intel MAX10 board management
>> +	  controller.
>> +
>> +	  This is a subdriver of the Intel MAX10 board management controller
>> +	  (BMC) and provides support for secure updates for the BMC image,
>> +	  the FPGA image, the Root Entry Hashes, etc.
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index ec9fbacdedd8..451a23ec3168 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -24,6 +24,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>  # Intel FPGA Security Manager Framework
>>  obj-$(CONFIG_IFPGA_SEC_MGR)		+= ifpga-sec-mgr.o
>>  
>> +# Intel Security Manager Drivers
>> +obj-$(CONFIG_IFPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
>> +
>>  # FPGA Bridge Drivers
>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> new file mode 100644
>> index 000000000000..1f86bfb694b4
>> --- /dev/null
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -0,0 +1,170 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel Max10 Board Management Controller Security Engine Driver
>> + *
>> + * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
>> + *
>> + */
>> +#include <linux/device.h>
>> +#include <linux/fpga/ifpga-sec-mgr.h>
>> +#include <linux/mfd/intel-m10-bmc.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/vmalloc.h>
>> +
>> +struct m10bmc_sec {
>> +	struct device *dev;
>> +	struct intel_m10bmc *m10bmc;
>> +	struct ifpga_sec_mgr *imgr;
>> +};
>> +
>> +#define SHA256_REH_SIZE		32
>> +#define SHA384_REH_SIZE		48
>> +
>> +static int get_reh_size(struct ifpga_sec_mgr *imgr,
>> +			u32 exp_magic, u32 prog_addr)
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	int sha_num_bytes, ret;
>> +	u32 magic;
>> +
>> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(sec->dev, "%s magic 0x%08x\n", __func__, magic);
>> +
>> +	if ((magic & 0xffff) != exp_magic)
> Consider using GENMASK() here.
Yes - will do.
>> +		return 0;
>> +
>> +	sha_num_bytes = ((magic >> 16) & 0xffff) / 8;
> And here.
Yes
>> +
>> +	if (sha_num_bytes != SHA256_REH_SIZE &&
>> +	    sha_num_bytes != SHA384_REH_SIZE)   {
>> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>> +			sha_num_bytes);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return sha_num_bytes;
>> +}
>> +
>> +#define BMC_REH_ADDR 0x17ffc004
>> +#define BMC_PROG_ADDR 0x17ffc000
>> +#define BMC_PROG_MAGIC 0x5746
>> +
>> +#define SR_REH_ADDR 0x17ffd004
>> +#define SR_PROG_ADDR 0x17ffd000
>> +#define SR_PROG_MAGIC 0x5253
>> +
>> +#define PR_REH_ADDR 0x17ffe004
>> +#define PR_PROG_ADDR 0x17ffe000
>> +#define PR_PROG_MAGIC 0x5250
>> +
>> +#define SYSFS_GET_REH_SIZE(_name, _exp_magic, _prog_addr) \
>> +static int get_##_name##_reh_size(struct ifpga_sec_mgr *imgr) \
>> +{ \
>> +	return get_reh_size(imgr, _exp_magic, _prog_addr); \
>> +}
>> +
>> +SYSFS_GET_REH_SIZE(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR)
>> +SYSFS_GET_REH_SIZE(sr, SR_PROG_MAGIC, SR_PROG_ADDR)
>> +SYSFS_GET_REH_SIZE(pr, PR_PROG_MAGIC, PR_PROG_ADDR)
>> +
>> +static int get_root_entry_hash(struct ifpga_sec_mgr *imgr,
>> +			       u32 hash_addr, u8 *hash,
>> +			       unsigned int size)
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	int ret;
>> +
>> +	ret = m10bmc_raw_bulk_read(sec->m10bmc, hash_addr,
>> +				   hash, size / stride);
>> +	if (ret)
>> +		dev_err(sec->dev, "bulk_read of 0x%x failed %d",
>> +			hash_addr, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +#define SYSFS_GET_REH(_name, _hash_addr) \
>> +static int get_##_name##_root_entry_hash(struct ifpga_sec_mgr *imgr, \
>> +					 u8 *hash, unsigned int size) \
>> +{ \
>> +	return get_root_entry_hash(imgr, _hash_addr, hash, size); \
>> +}
>> +
>> +SYSFS_GET_REH(bmc, BMC_REH_ADDR)
>> +SYSFS_GET_REH(sr, SR_REH_ADDR)
>> +SYSFS_GET_REH(pr, PR_REH_ADDR)
> Tbh, I'd drop the macro and just have the functions as one liners,
> and yes, please add the prefix.
OK - I'll drop the macros and add the prefixes.

>> +
>> +static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>> +	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>> +	.sr_root_entry_hash = get_sr_root_entry_hash,
>> +	.pr_root_entry_hash = get_pr_root_entry_hash,
>> +	.bmc_reh_size = get_bmc_reh_size,
>> +	.sr_reh_size = get_sr_reh_size,
>> +	.pr_reh_size = get_pr_reh_size,
>> +};
>> +
>> +static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
>> +{
>> +	ifpga_sec_mgr_unregister(sec->imgr);
>> +}
> Consider dropping this function (see below).
Sure - I can drop the init and uinit functions.
>> +
>> +static int ifpga_sec_mgr_init(struct m10bmc_sec *sec)
>> +{
>> +	struct ifpga_sec_mgr *imgr;
>> +
>> +	imgr = ifpga_sec_mgr_register(sec->dev, "Max10 BMC Security Manager",
>> +				      &m10bmc_iops, sec);
>> +	if (IS_ERR(imgr))
>> +		return PTR_ERR(imgr);
>> +
>> +	sec->imgr = imgr;
>> +	return 0;
>> +}
>> +
>> +static int m10bmc_secure_probe(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_sec *sec;
>> +	int ret;
>> +
>> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>> +	if (!sec)
>> +		return -ENOMEM;
>> +
>> +	sec->dev = &pdev->dev;
>> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>> +	dev_set_drvdata(&pdev->dev, sec);
> If you implement the devm_ versions then this could be:
>
> 	imgr = devm_ifpga_sec_mgr_create(&pdev->dev, "Max10 BMC Security
> 					Manager", &m10bmc_ips, sec);
> 	if (IS_ERR(imgr))
> 		return PTR_ERR(imgr);
> 	sec->imgr = imgr;
>
> 	return ifpga_sec_mgr_register(imgr);
If ifpga_sec_mgr_register fails, I think it would be necessary to call
"put_device(&imgr->dev)" here to release the device created by
devm_ifpga_sec_mgr_create()?

Thanks,
- Russ
>
>> +
>> +	ret = ifpga_sec_mgr_init(sec);
>> +	if (ret)
>> +		dev_err(&pdev->dev,
>> +			"Security manager failed to start: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int m10bmc_secure_remove(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>> +
>> +	ifpga_sec_mgr_uinit(sec);
> If you drop the above:
> 	ifpga_sec_mgr_remove(sec->imgr);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver intel_m10bmc_secure_driver = {
>> +	.probe = m10bmc_secure_probe,
>> +	.remove = m10bmc_secure_remove,
>> +	.driver = {
>> +		.name = "n3000bmc-secure",
>> +	},
>> +};
>> +module_platform_driver(intel_m10bmc_secure_driver);
>> +
>> +MODULE_ALIAS("platform:n3000bmc-secure");
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_DESCRIPTION("Intel MAX10 BMC secure engine");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>> index d4cb01b73357..7fe465c320c2 100644
>> --- a/include/linux/mfd/intel-m10-bmc.h
>> +++ b/include/linux/mfd/intel-m10-bmc.h
>> @@ -63,6 +63,7 @@ struct intel_m10bmc {
>>   * register access helper functions.
>>   *
>>   * m10bmc_raw_read - read m10bmc register per addr
>> + * m10bmc_raw_bulk_read - bulk_read max10 registers per addr
>>   * m10bmc_sys_read - read m10bmc system register per offset
>>   */
>>  static inline int
>> @@ -79,6 +80,20 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>>  	return ret;
>>  }
>>  
>> +static inline int
>> +m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>> +		     void *val, size_t cnt)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(m10bmc->regmap, addr, val, cnt);
>> +	if (ret)
>> +		dev_err(m10bmc->dev, "fail to read raw reg %x cnt %zx: %d\n",
>> +			addr, cnt, ret);
>> +
>> +	return ret;
>> +}
>> +
>>  #define m10bmc_sys_read(m10bmc, offset, val) \
>>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
>>  
>> -- 
>> 2.17.1
>>
> Thanks,
> Moritz

