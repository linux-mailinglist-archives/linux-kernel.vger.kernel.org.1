Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1D27A61E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1EKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:10:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:11284 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgI1EKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:10:13 -0400
IronPort-SDR: 39O/Q2Hh1/3r+eDKq6EUgDHtOxA02A7OaSBYhhcsy9iEhv3Z/6/SzZ9okSNnlW/soPsUj4Qjhf
 Yd2KqxXtHHBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141953080"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="141953080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:10:12 -0700
IronPort-SDR: yXPXqBj5ErjSsiOLOwSN8E7noqdlfJn8LnTrAnEihpwqAeyFI9/X48kJ2sXxDm8tR6fiEdRTSR
 RmlJ+ew78VVg==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488401054"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:10:09 -0700
Date:   Mon, 28 Sep 2020 12:10:07 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 17/17] virt: acrn: Introduce an interface for Service
 VM to control vCPU
Message-ID: <20200928041006.GE1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-18-shuo.a.liu@intel.com>
 <20200927104414.GC88650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200927104414.GC88650@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun 27.Sep'20 at 12:44:14 +0200, Greg Kroah-Hartman wrote:
>On Tue, Sep 22, 2020 at 07:43:11PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> ACRN supports partition mode to achieve real-time requirements. In
>> partition mode, a CPU core can be dedicated to a vCPU of User VM. The
>> local APIC of the dedicated CPU core can be passthrough to the User VM.
>> The Service VM controls the assignment of the CPU cores.
>>
>> Introduce an interface for the Service VM to remove the control of CPU
>> core from hypervisor perspective so that the CPU core can be a dedicated
>> CPU core of User VM.
>>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  drivers/virt/acrn/hsm.c       | 50 +++++++++++++++++++++++++++++++++++
>>  drivers/virt/acrn/hypercall.h | 14 ++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
>> index aaf4e76d27b4..ef5f77a38d1f 100644
>> --- a/drivers/virt/acrn/hsm.c
>> +++ b/drivers/virt/acrn/hsm.c
>> @@ -9,6 +9,7 @@
>>   *	Yakui Zhao <yakui.zhao@intel.com>
>>   */
>>
>> +#include <linux/cpu.h>
>>  #include <linux/io.h>
>>  #include <linux/mm.h>
>>  #include <linux/module.h>
>> @@ -354,6 +355,47 @@ struct miscdevice acrn_dev = {
>>  	.fops	= &acrn_fops,
>>  };
>>
>> +static ssize_t remove_cpu_store(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf, size_t count)
>> +{
>> +	u64 cpu, lapicid;
>> +	int ret;
>> +
>> +	if (kstrtoull(buf, 0, &cpu) < 0)
>> +		return -EINVAL;
>> +
>> +	if (cpu >= num_possible_cpus() || cpu == 0 || !cpu_is_hotpluggable(cpu))
>> +		return -EINVAL;
>> +
>> +	if (cpu_online(cpu))
>> +		remove_cpu(cpu);
>> +
>> +	lapicid = cpu_data(cpu).apicid;
>> +	dev_dbg(dev, "Try to remove cpu %lld with lapicid %lld\n", cpu, lapicid);
>> +	ret = hcall_sos_remove_cpu(lapicid);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to remove cpu %lld!\n", cpu);
>> +		goto fail_remove;
>> +	}
>> +
>> +	return count;
>> +
>> +fail_remove:
>> +	add_cpu(cpu);
>> +	return ret;
>> +}
>> +static DEVICE_ATTR_WO(remove_cpu);
>> +
>> +static struct attribute *acrn_attrs[] = {
>> +	&dev_attr_remove_cpu.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group acrn_attr_group = {
>> +	.attrs = acrn_attrs,
>> +};
>
>You create a sysfs attribute without any Documentation/ABI/ update as
>well?  That's not good.

Sorry, i will add it in the ABI/testing.

>
>And why are you trying to emulate CPU hotplug here and not using the
>existing CPU hotplug mechanism?

The interface introduced here includes:
  1) The Service VM virtual CPU hotplug
  2) hypercall to the hypervisor to remove one virtual CPU from the
    Service VM
The 1) just do the CPU hotplug with kernel API remove_cpu(), and can be
resume back (by CPU online interface) if only 1) is done.
If 2) is done, then the physical CPU will be removed from the Service
VM's CPU pool. The ACRN hypervisor supports passthrough a physical CPU
to a VM. The precondition is that the physical CPU cannot be occupied by
any other VM. This interface intends to do that.


>
>> +
>>  static int __init hsm_init(void)
>>  {
>>  	int ret;
>> @@ -370,13 +412,21 @@ static int __init hsm_init(void)
>>  		return ret;
>>  	}
>>
>> +	ret = sysfs_create_group(&acrn_dev.this_device->kobj, &acrn_attr_group);
>> +	if (ret) {
>> +		dev_warn(acrn_dev.this_device, "sysfs create failed\n");
>> +		misc_deregister(&acrn_dev);
>> +		return ret;
>> +	}
>
>You just raced with userspace and lost.  If you want to add attribute
>files to a device, use the default attribute group list, and it will be
>managed properly for you by the driver core.
>
>Huge hint, if a driver every has to touch a kobject, or call sysfs_*,
>then it is probably doing something wrong.

Do you mean use .groups of struct miscdevice directly ?

If yes, let me follow drivers/char/hw_random/s390-trng.c to do this.
BTW, few driver use the .groups directly. :)

Thanks
shuo
