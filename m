Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DA2F6ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbhANXPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:15:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:16389 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbhANXPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:15:07 -0500
IronPort-SDR: bgglitiUtoS5rI1O6/yGLn086Ji6W4CKIJvJ076DMduCJYg4Soh9dwmH0jpiSwn+FnIUBKYn8L
 pW/zIQ5WGHPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263252937"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="263252937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:14:26 -0800
IronPort-SDR: SqBT2P4M8Mo3C9IZUnT+xObEH5DppQZnzLQ8tFhO3q5VcOYJ5Xo3sxAdnLCogmG+XSeyrS4bX4
 Znq9zcE/nD6w==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="465399673"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.60.253])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:14:26 -0800
Subject: Re: [PATCH v3 1/1] mfd: intel-m10-bmc: expose mac address and count
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210105225520.14473-1-russell.h.weight@intel.com>
 <20210105225520.14473-2-russell.h.weight@intel.com>
 <20210114132309.GV3975472@dell>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <6fa738bf-63f2-488a-9a1d-688c3c2e2777@intel.com>
Date:   Thu, 14 Jan 2021 15:14:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114132309.GV3975472@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/21 5:23 AM, Lee Jones wrote:
> On Tue, 05 Jan 2021, Russ Weight wrote:
>
>> Create two sysfs entries for exposing the MAC address
>> and count from the MAX10 BMC register space. The MAC
>> address is the first in a sequential block of MAC addresses
>> reserved for the FPGA card. The MAC count is the number
>> of MAC addresses in the reserved block.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>> ---
>> v3:
>>   - Updated Date and KernelVersion in ABI documentation
>> v2:
>>   - Updated the documentation for the mac_address and mac_count
>>     sysfs nodes to clarify their usage.
>>   - Changed sysfs _show() functions to use sysfs_emit() instead
>>     of sprintf.
>> ---
>>  .../ABI/testing/sysfs-driver-intel-m10-bmc    | 21 +++++++++
>>  drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
>>  include/linux/mfd/intel-m10-bmc.h             |  9 ++++
>>  3 files changed, 73 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>> index 979a2d62513f..9773925138af 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>> @@ -13,3 +13,24 @@ Contact:	Xu Yilun <yilun.xu@intel.com>
>>  Description:	Read only. Returns the firmware version of Intel MAX10
>>  		BMC chip.
>>  		Format: "0x%x".
>> +
>> +What:		/sys/bus/spi/devices/.../mac_address
>> +Date:		January 2021
>> +KernelVersion:  5.12
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the first MAC address in a block
>> +		of sequential MAC addresses assigned to the board
>> +		that is managed by the Intel MAX10 BMC. It is stored in
>> +		FLASH storage and is mirrored in the MAX10 BMC register
>> +		space.
>> +		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
>> +
>> +What:		/sys/bus/spi/devices/.../mac_count
>> +Date:		January 2021
>> +KernelVersion:  5.12
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the number of sequential MAC
>> +		addresses assigned to the board managed by the Intel
>> +		MAX10 BMC. This value is stored in FLASH and is mirrored
>> +		in the MAX10 BMC register space.
>> +		Format: "%u".
>> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
>> index b84579b7b4f0..751c0ecf95d6 100644
>> --- a/drivers/mfd/intel-m10-bmc.c
>> +++ b/drivers/mfd/intel-m10-bmc.c
>> @@ -60,9 +60,52 @@ static ssize_t bmcfw_version_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(bmcfw_version);
>>  
>> +static ssize_t mac_address_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
>> +	unsigned int macaddr1, macaddr2;
> This naming convention is confusing.
>
> It took me a minute to work it out.
>
> Does 'high' and 'low' make sense!

Yes - that is more descriptive. I'll make the change and resubmit.

Thanks!
- Russ
>
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR1, &macaddr1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
>> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr1),
>> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr1),
>> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr1),
>> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr1),
>> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr2),
>> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr2));
>> +}
>> +static DEVICE_ATTR_RO(mac_address);
>> +
>> +static ssize_t mac_count_show(struct device *dev,
>> +			      struct device_attribute *attr, char *buf)
>> +{
>> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
>> +	unsigned int macaddr2;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%u\n",
>> +			  (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr2));
>> +}
>> +static DEVICE_ATTR_RO(mac_count);
>> +
>>  static struct attribute *m10bmc_attrs[] = {
>>  	&dev_attr_bmc_version.attr,
>>  	&dev_attr_bmcfw_version.attr,
>> +	&dev_attr_mac_address.attr,
>> +	&dev_attr_mac_count.attr,
>>  	NULL,
>>  };
>>  ATTRIBUTE_GROUPS(m10bmc);
>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>> index c8ef2f1654a4..2279e34f0814 100644
>> --- a/include/linux/mfd/intel-m10-bmc.h
>> +++ b/include/linux/mfd/intel-m10-bmc.h
>> @@ -15,6 +15,15 @@
>>  
>>  /* Register offset of system registers */
>>  #define NIOS2_FW_VERSION		0x0
>> +#define M10BMC_MACADDR1			0x10
>> +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
>> +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
>> +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
>> +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
>> +#define M10BMC_MACADDR2			0x14
>> +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
>> +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
>> +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
>>  #define M10BMC_TEST_REG			0x3c
>>  #define M10BMC_BUILD_VER		0x68
>>  #define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)

