Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063002B3519
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgKONov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgKONot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605447887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AlAMNtD74YjT/rjpnNjzT//DRG+bFcq+PfVYbskjbI=;
        b=OcNGDEAFC9atVvLCdtRbyeG7M0paU4w7livuAKWTPPFw9j16i7Bu4yY6e+3kTBVNNfwqJf
        3/OgdsicH8Ls+mpuwSNpB/3IsrXI3yyWUmnRNy1sli3SFt4JmlgvRIYRKrq4rtMONGV3kX
        z8DB9TK9RJ/LeE+7c7gZfwesHOA3pxQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-vn38RquVOeuRMlCcM-zGug-1; Sun, 15 Nov 2020 08:44:45 -0500
X-MC-Unique: vn38RquVOeuRMlCcM-zGug-1
Received: by mail-qv1-f69.google.com with SMTP id dp12so3307517qvb.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 05:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/AlAMNtD74YjT/rjpnNjzT//DRG+bFcq+PfVYbskjbI=;
        b=Oe1+5CSA60HZTYzZS7eGLxRTunG6O2XoF04FAGd2LkwBoGS2sVRI8TO5XTdtDunv3M
         HBlGWomW2NoBMyTK1oxqC4XQlcfeKDoX+Xqcr5PAsxuDaw+POBSzPO7RFMj3TYUs8b2q
         LpXFV8vuAyNnMk00mJEC3OFaVloyZIBjb/AXs+xDCGWUJp2r6zEcGYQ55n9rHvusIidq
         p+oEhovoJV9MHEhmquJo7nqdTCiqN+iwgN3L2NmlnAgjdYwXFq3merHhQ9gDdJvC+ZXM
         sjdY4JIxPYb+p2Pm9J5vuh/2i9fPdGDv7ULVEfYr4uhlW7tY/VItDoVRXcxzfdyuz4e8
         2Dbw==
X-Gm-Message-State: AOAM531vld6o9nwOiAxeq8Yt8wNfK7QrtHGlYAhmRqQuvXfVl1vADUyc
        kshMkN9pPyMuIwqQSGsZ6V8otwCx/KV/6rX4RsVoQSCeRa+L/dXEd0uDfB8M1vJp/fz4B6l0xth
        0YGgA/uOxB3swcBIKk49D0znk
X-Received: by 2002:a05:620a:140d:: with SMTP id d13mr10650464qkj.470.1605447884933;
        Sun, 15 Nov 2020 05:44:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwh0p0YZXgO380IGoC1uZUQybygH3fPFTfj0d1CdP4JKAzkkb9SXTcE2PilUChkV9RYFvn9xg==
X-Received: by 2002:a05:620a:140d:: with SMTP id d13mr10650443qkj.470.1605447884616;
        Sun, 15 Nov 2020 05:44:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k4sm1743516qtp.5.2020.11.15.05.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 05:44:44 -0800 (PST)
Subject: Re: [PATCH v5 2/6] fpga: m10bmc-sec: create max10 bmc secure update
 driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-3-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9b42ad34-84bf-7409-414b-925c143c7959@redhat.com>
Date:   Sun, 15 Nov 2020 05:44:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201114005559.90860-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/13/20 4:55 PM, Russ Weight wrote:
> Create a platform driver that can be invoked as a sub
> driver for the Intel MAX10 BMC in order to support
> secure updates. This sub-driver will invoke an
> instance of the FPGA Security Manager class driver
> in order to expose sysfs interfaces for managing and
> monitoring secure updates to FPGA and BMC images.
>
> This patch creates the MAX10 BMC Secure Update driver and
> provides sysfs files for displaying the current root entry hashes
> for the FPGA static region, the FPGA PR region, and the MAX10
> BMC.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v5:
>   - No change
> v4:
>   - Moved sysfs files for displaying the root entry hashes (REH)
>     from the FPGA Security Manager class driver to here. The
>     m10bmc_reh() and m10bmc_reh_size() functions are removed and
>     the functionality from these functions is moved into a
>     show_root_entry_hash() function for displaying the REHs.
>   - Added ABI documentation for the new sysfs entries:
>     sysfs-driver-intel-m10-bmc-secure
>   - Updated the MAINTAINERS file to add the new ABI documentation
>     file: sysfs-driver-intel-m10-bmc-secure
>   - Removed unnecessary ret variable from m10bmc_secure_probe()
>   - Incorporated new devm_fpga_sec_mgr_register() function into
>     m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>     function.
> v3:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>     Update driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
>   - Changed "_root_entry_hash" to "_reh", with a comment explaining
>     what reh is.
> v2:
>   - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>   - Switched to GENMASK(31, 16) for a couple of mask definitions.
>   - Moved MAX10 BMC address and function definitions to a separate
>     patch.
>   - Replaced small function-creation macros with explicit function
>     declarations.
>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>     the single call to ifpga_sec_mgr_register() into two function
>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
> ---
>  .../testing/sysfs-driver-intel-m10-bmc-secure |  29 ++++
>  MAINTAINERS                                   |   2 +
>  drivers/fpga/Kconfig                          |  11 ++
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/intel-m10-bmc-secure.c           | 134 ++++++++++++++++++
>  5 files changed, 179 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> new file mode 100644
> index 000000000000..2992488b717a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> @@ -0,0 +1,29 @@
> +What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/sr_root_entry_hash
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the static
> +		region if one is programmed, else it returns the
> +		string: "hash not programmed".  This file is only
> +		visible if the underlying device supports it.
> +		Format: "0x%x".
> +
> +What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/pr_root_entry_hash
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the partial
> +		reconfiguration region if one is programmed, else it
> +		returns the string: "hash not programmed".  This file
> +		is only visible if the underlying device supports it.
> +		Format: "0x%x".
> +
> +What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/bmc_root_entry_hash
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the BMC image
> +		if one is programmed, else it returns the string:
> +		"hash not programmed".  This file is only visible if the
> +		underlying device supports it.
> +		Format: "0x%x".
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23c655fc0001..bbd2366280de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6941,8 +6941,10 @@ M:	Russ Weight <russell.h.weight@intel.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>  F:	Documentation/fpga/fpga-sec-mgr.rst
>  F:	drivers/fpga/fpga-sec-mgr.c
> +F:	drivers/fpga/intel-m10-bmc-secure.c
>  F:	include/linux/fpga/fpga-sec-mgr.h
>  
>  FPU EMULATOR
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 03e9a3b16e3e..a102ab1df7ae 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -235,4 +235,15 @@ config FPGA_SEC_MGR
>  	  region and for the BMC. Select this option to enable
>  	  updates for secure FPGA devices.
>  
> +config IFPGA_M10_BMC_SECURE
> +	tristate "Intel MAX10 BMC Secure Update driver"
> +	depends on MFD_INTEL_M10_BMC && FPGA_SEC_MGR
> +	help
> +	  Secure update support for the Intel MAX10 board management
> +	  controller.
> +
> +	  This is a subdriver of the Intel MAX10 board management controller
> +	  (BMC) and provides support for secure updates for the BMC image,
> +	  the FPGA image, the Root Entry Hashes, etc.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 22576d1a3996..7259f1ab2531 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -24,6 +24,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>  # FPGA Security Manager Framework
>  obj-$(CONFIG_FPGA_SEC_MGR)		+= fpga-sec-mgr.o
>  
> +# FPGA Secure Update Drivers
> +obj-$(CONFIG_IFPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
> +
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> new file mode 100644
> index 000000000000..198bc8273d6b
> --- /dev/null
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Max10 Board Management Controller Secure Update Driver
> + *
> + * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/fpga/fpga-sec-mgr.h>
> +#include <linux/mfd/intel-m10-bmc.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +struct m10bmc_sec {
> +	struct device *dev;
> +	struct intel_m10bmc *m10bmc;
> +};
> +
> +/* Root Entry Hash (REH) support */
> +#define REH_SHA256_SIZE		32
> +#define REH_SHA384_SIZE		48
> +#define REH_MAGIC		GENMASK(15, 0)
> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
> +
> +static ssize_t
> +show_root_entry_hash(struct device *dev, u32 exp_magic,
> +		     u32 prog_addr, u32 reh_addr, char *buf)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	int sha_num_bytes, i, cnt, ret;
> +	u8 hash[REH_SHA384_SIZE];
> +	u32 magic;
> +
> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(dev, "%s magic 0x%08x\n", __func__, magic);
> +
> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
> +		return sysfs_emit(buf, "hash not programmed\n");
> +
> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
> +	if (sha_num_bytes != REH_SHA256_SIZE &&
> +	    sha_num_bytes != REH_SHA384_SIZE)   {
> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
> +			sha_num_bytes);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
> +			       hash, sha_num_bytes / stride);

Assumes !(sha_num_bytes % stride)

Maybe add an assert.

Tom

> +	if (ret) {
> +		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
> +			reh_addr, sha_num_bytes / stride, ret);
> +		return ret;
> +	}
> +
> +	cnt = sprintf(buf, "0x");
> +	for (i = 0; i < sha_num_bytes; i++)
> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
> +	cnt += sprintf(buf + cnt, "\n");
> +
> +	return cnt;
> +}
> +
> +#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
> +					    struct device_attribute *attr, \
> +					    char *buf) \
> +{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
> +
> +DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
> +DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
> +DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
> +
> +static struct attribute *m10bmc_security_attrs[] = {
> +	&dev_attr_bmc_root_entry_hash.attr,
> +	&dev_attr_sr_root_entry_hash.attr,
> +	&dev_attr_pr_root_entry_hash.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group m10bmc_security_attr_group = {
> +	.name = "security",
> +	.attrs = m10bmc_security_attrs,
> +};
> +
> +static const struct attribute_group *m10bmc_sec_attr_groups[] = {
> +	&m10bmc_security_attr_group,
> +	NULL,
> +};
> +
> +static const struct fpga_sec_mgr_ops m10bmc_sops = { };
> +
> +static int m10bmc_secure_probe(struct platform_device *pdev)
> +{
> +	struct fpga_sec_mgr *smgr;
> +	struct m10bmc_sec *sec;
> +
> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
> +	if (!sec)
> +		return -ENOMEM;
> +
> +	sec->dev = &pdev->dev;
> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
> +	dev_set_drvdata(&pdev->dev, sec);
> +
> +	smgr = devm_fpga_sec_mgr_create(sec->dev, "Max10 BMC Secure Update",
> +					&m10bmc_sops, sec);
> +	if (!smgr) {
> +		dev_err(sec->dev, "Security manager failed to start\n");
> +		return -ENOMEM;
> +	}
> +
> +	return devm_fpga_sec_mgr_register(sec->dev, smgr);
> +}
> +
> +static struct platform_driver intel_m10bmc_secure_driver = {
> +	.probe = m10bmc_secure_probe,
> +	.driver = {
> +		.name = "n3000bmc-secure",
> +		.dev_groups = m10bmc_sec_attr_groups,
> +	},
> +};
> +module_platform_driver(intel_m10bmc_secure_driver);
> +
> +MODULE_ALIAS("platform:n3000bmc-secure");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
> +MODULE_LICENSE("GPL v2");

