Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559572CC5CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbgLBSpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbgLBSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606934667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmhFvPXYha9e2jKykY/pXMNr4iXiJ5Kzh4WHcXPkr3o=;
        b=IhQ1h5SMJii1yjG9HoUSkslKLYc00qqnTyBPxQ7StWnhlsvP0FaG1ZeeScwf5f9eNET2Gx
        nAB7+vn7XPfn9rOp9uHp0pwlq1OLUD9PpUtF4gaimJG/e+9NYRnEp7EkW76qJ4eQdtAthR
        b+2D+X2OLDpfA3hzme/jCNKE3ZV4gso=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-aU3nSFeePJ6Mo4xf6RLNug-1; Wed, 02 Dec 2020 13:44:25 -0500
X-MC-Unique: aU3nSFeePJ6Mo4xf6RLNug-1
Received: by mail-qt1-f199.google.com with SMTP id o12so2107783qtw.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BmhFvPXYha9e2jKykY/pXMNr4iXiJ5Kzh4WHcXPkr3o=;
        b=bkZutHG5i+5ndcdd2d4b9CXCWYV/S4F/4+tYg00x+YQJPdR4AhsNr3QPYoQd84fjsH
         XFKZcOBpR+vsmCvV119RPtdtx61w1ltaK2cvARCjR4DcmW4jF5etSL9xnAEgsD6t0Otd
         TPMwuLngrB9LnuGEAHCYUPtHjgr/ttQIjybTBSRvaRmvaOaZj2OW77ZzEPPo5pQ4vck6
         GAO+eOEqMWhBJhOu+SzonBjA1kBdlFP8EnY2doemAaUChB7C8B37dY6dGtXDG2XY58oi
         VlsB24lF6FoG+cX19OBrk6+uokv0hqr0pi2gv74Rk968CMhtNAIs5xXLBcKsy9vlYIZs
         p/cg==
X-Gm-Message-State: AOAM532tXoV5DYU4IJshEAzg80CoKojzBvFlU9SpWVdvAWc1MXhRMCcg
        ibvrvpTDrLGVwwQ44NosJmD9KY9lXgDGgr8YeRyRW4IMhsUiiYaOclME37RKzhrZYvxVCMwZan/
        rHjPFrOrPMt1BtPYJGzonzh1R
X-Received: by 2002:a0c:e9c9:: with SMTP id q9mr3927719qvo.59.1606934665155;
        Wed, 02 Dec 2020 10:44:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxJg6V9g/nVuxHNaoCRyXgm+ZfRQwSQMjZ/Uu2adCF4Kw+MwlyG3AJgES9dyLEtj3teY05KQ==
X-Received: by 2002:a0c:e9c9:: with SMTP id q9mr3927700qvo.59.1606934664893;
        Wed, 02 Dec 2020 10:44:24 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z23sm2590472qtq.66.2020.12.02.10.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:44:24 -0800 (PST)
Subject: Re: [PATCH v1 1/1] mfd: intel-m10-bmc: expose mac address and count
To:     Russ Weight <russell.h.weight@intel.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201201203646.200907-1-russell.h.weight@intel.com>
 <20201201203646.200907-2-russell.h.weight@intel.com>
 <fcab13fb-127d-6f6e-2be8-e14cf0f2b2a4@redhat.com>
 <6783078e-2dc4-e261-61d6-148cb4f0e848@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <18cc3fa2-0285-f5f0-02b6-60c7267cca9e@redhat.com>
Date:   Wed, 2 Dec 2020 10:44:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6783078e-2dc4-e261-61d6-148cb4f0e848@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/20 10:26 AM, Russ Weight wrote:
>
> On 12/2/20 5:44 AM, Tom Rix wrote:
>> On 12/1/20 12:36 PM, Russ Weight wrote:
>>> Create two sysfs entries for exposing the MAC address
>>> and count from the MAX10 BMC register space.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> ---
>>>  .../ABI/testing/sysfs-driver-intel-m10-bmc    | 20 +++++++++
>>>  drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
>>>  include/linux/mfd/intel-m10-bmc.h             |  9 ++++
>>>  3 files changed, 72 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>>> index 979a2d62513f..c4febaefe0a7 100644
>>> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>>> @@ -13,3 +13,23 @@ Contact:	Xu Yilun <yilun.xu@intel.com>
>>>  Description:	Read only. Returns the firmware version of Intel MAX10
>>>  		BMC chip.
>>>  		Format: "0x%x".
>>> +
>>> +What:		/sys/bus/spi/devices/.../mac_address
>>> +Date:		December 2020
>>> +KernelVersion:  5.11
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Read only. Returns the base mac address assigned to
>>> +		the board managed by the Intel MAX10 BMC. It is
>>> +		stored in flash and is mirrored in the MAX10 BMC
>>> +		register space.
>>> +		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
>>> +
>>> +What:		/sys/bus/spi/devices/.../mac_count
>>> +Date:		December 2020
>>> +KernelVersion:  5.11
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Read only. Returns the number of mac addresses
>>> +		assigned to the board managed by the Intel MAX10
>>> +		BMC. This value is stored in flash and is mirrored
>>> +		in the MAX10 BMC register space.
>>> +		Format: "%u".
>>> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
>>> index b84579b7b4f0..90720e84900e 100644
>>> --- a/drivers/mfd/intel-m10-bmc.c
>>> +++ b/drivers/mfd/intel-m10-bmc.c
>>> @@ -60,9 +60,52 @@ static ssize_t bmcfw_version_show(struct device *dev,
>>>  }
>>>  static DEVICE_ATTR_RO(bmcfw_version);
>>>  
>>> +static ssize_t mac_address_show(struct device *dev,
>>> +				struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
>>> +	unsigned int macaddr1, macaddr2;
>>> +	int ret;
>>> +
>>> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR1, &macaddr1);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
>>> +	if (ret)
>>> +		return ret;
>>> +
>> The mac_count implies there are more than 1 mac address.
>>
>> This logic looks like could only do one.
>>
>> How are the 2nd, 3rd  etc. mac addresses found ?
> The MAC addresses assigned to the card are sequential. The base MAC
> address is exposed through the mac_address sysfs entry. Add 1 to
> that MAC address for the second MAC address, etc.

Ok.

Please capture this in the docs section above.

>>> +	return sprintf(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
>>> +		       (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr1),
>>> +		       (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr1),
>>> +		       (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr1),
>>> +		       (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr1),
>>> +		       (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr2),
>>> +		       (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr2));
>> consider using sysfs_emit over sprintf
> Yes. I'll change to sysfs_emit and resubmit.
>
> Thanks,
> - Russ
>> Tom
>>
>>> +}
>>> +static DEVICE_ATTR_RO(mac_address);
>>> +
>>> +static ssize_t mac_count_show(struct device *dev,
>>> +			      struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
>>> +	unsigned int macaddr2;
>>> +	int ret;
>>> +
>>> +	ret = m10bmc_sys_read(max10, M10BMC_MACADDR2, &macaddr2);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return sprintf(buf, "%u\n",
>>> +		       (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr2));
>>> +}
>>> +static DEVICE_ATTR_RO(mac_count);
>>> +
>>>  static struct attribute *m10bmc_attrs[] = {
>>>  	&dev_attr_bmc_version.attr,
>>>  	&dev_attr_bmcfw_version.attr,
>>> +	&dev_attr_mac_address.attr,
>>> +	&dev_attr_mac_count.attr,
>>>  	NULL,
>>>  };
>>>  ATTRIBUTE_GROUPS(m10bmc);
>>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>>> index c8ef2f1654a4..2279e34f0814 100644
>>> --- a/include/linux/mfd/intel-m10-bmc.h
>>> +++ b/include/linux/mfd/intel-m10-bmc.h
>>> @@ -15,6 +15,15 @@
>>>  
>>>  /* Register offset of system registers */
>>>  #define NIOS2_FW_VERSION		0x0
>>> +#define M10BMC_MACADDR1			0x10
>>> +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
>>> +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
>>> +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
>>> +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
>>> +#define M10BMC_MACADDR2			0x14
>>> +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
>>> +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
>>> +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
>>>  #define M10BMC_TEST_REG			0x3c
>>>  #define M10BMC_BUILD_VER		0x68
>>>  #define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)

