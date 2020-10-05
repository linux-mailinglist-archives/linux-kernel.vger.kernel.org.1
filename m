Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D116728328E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJEIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:51:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:21822 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJEIvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:51:00 -0400
IronPort-SDR: z+Fx/dibISAEjPm5kj+GmNz2Z0J/utniesi2n9H3YM+7tsAM9J68MGo9Y41qBy88fXdt1eE59l
 IWiSyPISO9gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="160664693"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="160664693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 01:50:55 -0700
IronPort-SDR: /rXJ0NVdpl3wjhvBXnEay4keEDbVBuVrYjAbwSw6Ra1x0d9MeoAf14Zp07zBChmqgF8/r7UYtf
 nc9IFqwaYNlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="515923347"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2020 01:50:55 -0700
Received: from [10.214.146.139] (rtanwar-MOBL.gar.corp.intel.com [10.214.146.139])
        by linux.intel.com (Postfix) with ESMTP id 2C38558088D;
        Mon,  5 Oct 2020 01:50:51 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] Add hardware monitoring driver for Moortec MR75203
 PVT controller
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rtanwar@maxlinear.com
References: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
 <e8c462ffc826d06c108aac45f8476083097cfa55.1601621983.git.rahul.tanwar@linux.intel.com>
 <20201002181135.GI3956970@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <f224391a-2e51-ec37-7045-4a16f04b5384@linux.intel.com>
Date:   Mon, 5 Oct 2020 16:50:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201002181135.GI3956970@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy

On 3/10/2020 2:11 am, Andy Shevchenko wrote:
> On Fri, Oct 02, 2020 at 03:04:27PM +0800, Rahul Tanwar wrote:
>> PVT controller (MR75203) is used to configure & control
>> Moortec embedded analog IP which contains temprature
>> sensor(TS), voltage monitor(VM) & process detector(PD)
>> modules. Add hardware monitoring driver to support
>> MR75203 PVT controller.
> Some nit-picks below.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/hwmon/Kconfig   |  10 +
>>  drivers/hwmon/Makefile  |   1 +
>>  drivers/hwmon/mr75203.c | 651 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 662 insertions(+)
>>  create mode 100644 drivers/hwmon/mr75203.c

[...]

>> +		pvt_temp.config = temp_config;
>> +
>> +		pvt_info[index++] = &pvt_temp;
>> +	}
>> +
>> +	if (pd_num) {
>> +		ret = pvt_get_regmap(pdev, "pd", pvt);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (vm_num) {
>> +		u32 num = vm_num;
>> +
>> +		ret = pvt_get_regmap(pdev, "vm", pvt);
>> +		if (ret)
>> +			return ret;
>> +
>> +		pvt->vm_idx = devm_kcalloc(dev, vm_num, sizeof(*pvt->vm_idx),
>> +					   GFP_KERNEL);
>> +		if (!pvt->vm_idx)
>> +			return -ENOMEM;
>> +		for (i = 0; i < vm_num; i++)
>> +			pvt->vm_idx[i] = i;
> What the point if you are replace them below in one case?
>
>> +		ret = device_property_read_u8_array(dev, "intel,vm-map",
>> +						    pvt->vm_idx, vm_num);
>> +		if (!ret)
> Misses {} and because of above
>
> 	if (ret) {
> 		for () ...
> 	} else {
> 		for () ...
> 	}
>
>> +			for (i = 0; i < vm_num; i++)
>> +				if (pvt->vm_idx[i] >= vm_num ||
>> +				    pvt->vm_idx[i] == 0xff) {
>> +					num = i;
>> +					break;
>> +				}
> Or looking in this, perhaps move the incremental for-loop here and start it
> with num which is 0.

Not able to understand what exactly you are suggesting here. Presently
it is like below:
1. Init vm_idx array with incremental values.
2. Read array from device property.
3. If success, figure out the last valid value and assign to num.

Can you please elaborate and explain more clearly? Thanks.

Regards,
Rahul


