Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288A92F61E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbhANNYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbhANNX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:23:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26073C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:23:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m4so5731162wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w18EgFsICE9OM9Lgz5TZtzB0U3rL3q7eXbxHjw0SRmk=;
        b=wCenm0LTZXGohBZS2mhPOl3I6iU1HBg2g1hVyfM/8fvLnXC9LEvQ4jk0KxYydouyAK
         VIFLx127WDy9mxX8vrYC1l1Xa3WZ56lIzuI9aQTBI9zBF5TMmT4UlQZY7OLpKhdarkcC
         uJdHsxgURi5rw/LbfcguUHajtgyBxR4JDg0VC8RAkjv/yYM6ApbK83O2wAY6+/T/y+tT
         yo/P3/g4ldNPURMQayQbIobUYkc8DETmcJSxYkNZ2vaPS+hrgGVd3XYSIh3GHgMvbqC1
         mC8cXhkvFdlDMYKZBB9FhapMy9gqDSmAN8x1+9DvlswMkrf67H/VZ9vgkeXoLERoG/7o
         j8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w18EgFsICE9OM9Lgz5TZtzB0U3rL3q7eXbxHjw0SRmk=;
        b=XSWPoblql4npHpfN3P89G1Y8bva++Mian0mOKoiPIZ5WeOEZx4O1rEsqIWZ8yLko5P
         IFtck+YhiJ5TyKTpxxVlc7TkobnAkldiQ9lVHdLAj2BxcijkVqBV0X4VSJNZ5u5rS/uY
         q24HdmkpENPrKusmEJmDPk1G3Jk0FXrC7efkqSOPJ7mZegt/MXQL9ju8m1m1uFOASKpz
         UhTcdqb26MdQaZeHbmfUfLcwvr5jFhrg/IbUF9lQLuU9kjbVGR8m0WkOXb7EWwELdCBD
         tiwc3cvI4sgXlRFHGOYkfF/Ohg5rTxi92tfzTwIEVtI3j0wwfxFQapCZnTavCN8PIPGX
         eVBQ==
X-Gm-Message-State: AOAM533sdQK1CXMXI4enK4WkJPtVY8ZPa1QHDAgO7H4f92a6VVVocEaH
        aYMhr20/Wa+WBkxeVjOwEK7xig==
X-Google-Smtp-Source: ABdhPJynWdeB69P74lHrmCKDJaY9677JD3ZBTrVO4s+++6r/TNmyYHVdueAvSKeBzwehTjU/UYVi9w==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr8036892wrt.246.1610630591776;
        Thu, 14 Jan 2021 05:23:11 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id l16sm10100728wrx.5.2021.01.14.05.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:23:11 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:23:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v3 1/1] mfd: intel-m10-bmc: expose mac address and count
Message-ID: <20210114132309.GV3975472@dell>
References: <20210105225520.14473-1-russell.h.weight@intel.com>
 <20210105225520.14473-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105225520.14473-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jan 2021, Russ Weight wrote:

> Create two sysfs entries for exposing the MAC address
> and count from the MAX10 BMC register space. The MAC
> address is the first in a sequential block of MAC addresses
> reserved for the FPGA card. The MAC count is the number
> of MAC addresses in the reserved block.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v3:
>   - Updated Date and KernelVersion in ABI documentation
> v2:
>   - Updated the documentation for the mac_address and mac_count
>     sysfs nodes to clarify their usage.
>   - Changed sysfs _show() functions to use sysfs_emit() instead
>     of sprintf.
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc    | 21 +++++++++
>  drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h             |  9 ++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> index 979a2d62513f..9773925138af 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> @@ -13,3 +13,24 @@ Contact:	Xu Yilun <yilun.xu@intel.com>
>  Description:	Read only. Returns the firmware version of Intel MAX10
>  		BMC chip.
>  		Format: "0x%x".
> +
> +What:		/sys/bus/spi/devices/.../mac_address
> +Date:		January 2021
> +KernelVersion:  5.12
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the first MAC address in a block
> +		of sequential MAC addresses assigned to the board
> +		that is managed by the Intel MAX10 BMC. It is stored in
> +		FLASH storage and is mirrored in the MAX10 BMC register
> +		space.
> +		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
> +
> +What:		/sys/bus/spi/devices/.../mac_count
> +Date:		January 2021
> +KernelVersion:  5.12
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the number of sequential MAC
> +		addresses assigned to the board managed by the Intel
> +		MAX10 BMC. This value is stored in FLASH and is mirrored
> +		in the MAX10 BMC register space.
> +		Format: "%u".
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index b84579b7b4f0..751c0ecf95d6 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -60,9 +60,52 @@ static ssize_t bmcfw_version_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(bmcfw_version);
>  
> +static ssize_t mac_address_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	unsigned int macaddr1, macaddr2;

This naming convention is confusing.

It took me a minute to work it out.

Does 'high' and 'low' make sense?

> +	int ret;
> +
> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR1, &macaddr1);
> +	if (ret)
> +		return ret;
> +
> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr1),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr1),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr1),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr1),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr2),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr2));
> +}
> +static DEVICE_ATTR_RO(mac_address);
> +
> +static ssize_t mac_count_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	unsigned int macaddr2;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr2));
> +}
> +static DEVICE_ATTR_RO(mac_count);
> +
>  static struct attribute *m10bmc_attrs[] = {
>  	&dev_attr_bmc_version.attr,
>  	&dev_attr_bmcfw_version.attr,
> +	&dev_attr_mac_address.attr,
> +	&dev_attr_mac_count.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(m10bmc);
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index c8ef2f1654a4..2279e34f0814 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -15,6 +15,15 @@
>  
>  /* Register offset of system registers */
>  #define NIOS2_FW_VERSION		0x0
> +#define M10BMC_MACADDR1			0x10
> +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> +#define M10BMC_MACADDR2			0x14
> +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
>  #define M10BMC_TEST_REG			0x3c
>  #define M10BMC_BUILD_VER		0x68
>  #define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
