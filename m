Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A117227A8AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1HeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:34:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:6667 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgI1HeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:34:25 -0400
IronPort-SDR: CSpcl5wz0ntfKZ7PUbJiE/9Ez5Kh/9nxyEzaPzrWIQ4zf4oltcnUnIMcJRxf4Arn7fSvpJxX1w
 MWj6GZGOXAbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141344540"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="141344540"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 20:43:40 -0700
IronPort-SDR: pLSeS9KC0y29q+4R5/wwNNReQiLoWzQVzuLAY9dHJc6H+xJUNUMmgDbUede01DcLTWJ6I70P+a
 6VVOcv0e/6+w==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488393365"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 20:43:37 -0700
Date:   Mon, 28 Sep 2020 11:43:35 +0800
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
Subject: Re: [PATCH v4 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200928034335.GC1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-7-shuo.a.liu@intel.com>
 <20200927104538.GD88650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200927104538.GD88650@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun 27.Sep'20 at 12:45:38 +0200, Greg Kroah-Hartman wrote:
>On Tue, Sep 22, 2020 at 07:43:00PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> The VM management interfaces expose several VM operations to ACRN
>> userspace via ioctls. For example, creating VM, starting VM, destroying
>> VM and so on.
>>
>> The ACRN Hypervisor needs to exchange data with the ACRN userspace
>> during the VM operations. HSM provides VM operation ioctls to the ACRN
>> userspace and communicates with the ACRN Hypervisor for VM operations
>> via hypercalls.
>>
>> HSM maintains a list of User VM. Each User VM will be bound to an
>> existing file descriptor of /dev/acrn_hsm. The User VM will be
>> destroyed when the file descriptor is closed.
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
>>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>>  MAINTAINERS                                   |  1 +
>>  drivers/virt/acrn/Makefile                    |  2 +-
>>  drivers/virt/acrn/acrn_drv.h                  | 23 +++++-
>>  drivers/virt/acrn/hsm.c                       | 73 ++++++++++++++++-
>>  drivers/virt/acrn/hypercall.h                 | 78 +++++++++++++++++++
>>  drivers/virt/acrn/vm.c                        | 71 +++++++++++++++++
>>  include/uapi/linux/acrn.h                     | 56 +++++++++++++
>>  8 files changed, 301 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/virt/acrn/hypercall.h
>>  create mode 100644 drivers/virt/acrn/vm.c
>>  create mode 100644 include/uapi/linux/acrn.h
>>
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index 2a198838fca9..ac60efedb104 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -319,6 +319,7 @@ Code  Seq#    Include File                                           Comments
>>  0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
>>                                                                       <mailto:kenji@bitgate.com>
>>  0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
>> +0xA2  all    uapi/linux/acrn.h                                       ACRN hypervisor
>>  0xA3  80-8F                                                          Port ACL  in development:
>>                                                                       <mailto:tlewis@mindspring.com>
>>  0xA3  90-9F  linux/dtlk.h
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3030d0e93d02..d4c1ef303c2d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -443,6 +443,7 @@ S:	Supported
>>  W:	https://projectacrn.org
>>  F:	Documentation/virt/acrn/
>>  F:	drivers/virt/acrn/
>> +F:	include/uapi/linux/acrn.h
>>
>>  AD1889 ALSA SOUND DRIVER
>>  L:	linux-parisc@vger.kernel.org
>> diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
>> index 6920ed798aaf..cf8b4ed5e74e 100644
>> --- a/drivers/virt/acrn/Makefile
>> +++ b/drivers/virt/acrn/Makefile
>> @@ -1,3 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_ACRN_HSM)	:= acrn.o
>> -acrn-y := hsm.o
>> +acrn-y := hsm.o vm.o
>> diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
>> index 29eedd696327..72d92b60d944 100644
>> --- a/drivers/virt/acrn/acrn_drv.h
>> +++ b/drivers/virt/acrn/acrn_drv.h
>> @@ -3,16 +3,37 @@
>>  #ifndef __ACRN_HSM_DRV_H
>>  #define __ACRN_HSM_DRV_H
>>
>> +#include <linux/acrn.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/miscdevice.h>
>>  #include <linux/types.h>
>>
>> +#include "hypercall.h"
>> +
>> +extern struct miscdevice acrn_dev;
>
>Who else needs to get to this structure in your driver?

Other files of the driver need to use it for dev_*() log APIs.

>
>> +
>>  #define ACRN_INVALID_VMID (0xffffU)
>>
>> +#define ACRN_VM_FLAG_DESTROYED		0U
>> +extern struct list_head acrn_vm_list;
>> +extern rwlock_t acrn_vm_list_lock;
>>  /**
>>   * struct acrn_vm - Properties of ACRN User VM.
>> + * @list:	Entry within global list of all VMs
>>   * @vmid:	User VM ID
>> + * @vcpu_num:	Number of virtual CPUs in the VM
>> + * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
>> + *		in HSM which is different from the &acrn_vm_creation.vm_flag.
>>   */
>>  struct acrn_vm {
>> -	u16	vmid;
>> +	struct list_head	list;
>> +	u16			vmid;
>> +	int			vcpu_num;
>> +	unsigned long		flags;
>>  };
>>
>> +struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
>> +			       struct acrn_vm_creation *vm_param);
>> +int acrn_vm_destroy(struct acrn_vm *vm);
>> +
>>  #endif /* __ACRN_HSM_DRV_H */
>> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
>> index 28a3052ffa55..f3e6467b8723 100644
>> --- a/drivers/virt/acrn/hsm.c
>> +++ b/drivers/virt/acrn/hsm.c
>> @@ -9,7 +9,6 @@
>>   *	Yakui Zhao <yakui.zhao@intel.com>
>>   */
>>
>> -#include <linux/miscdevice.h>
>>  #include <linux/mm.h>
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>> @@ -38,10 +37,79 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
>>  	return 0;
>>  }
>>
>> +/*
>> + * HSM relies on hypercall layer of the ACRN hypervisor to do the
>> + * sanity check against the input parameters.
>> + */
>> +static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>> +			   unsigned long ioctl_param)
>> +{
>> +	struct acrn_vm *vm = filp->private_data;
>> +	struct acrn_vm_creation *vm_param;
>> +	int ret = 0;
>> +
>> +	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
>> +		dev_dbg(acrn_dev.this_device,
>> +			"ioctl 0x%x: Invalid VM state!\n", cmd);
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (cmd) {
>> +	case ACRN_IOCTL_CREATE_VM:
>> +		vm_param = memdup_user((void __user *)ioctl_param,
>> +				       sizeof(struct acrn_vm_creation));
>> +		if (IS_ERR(vm_param))
>> +			return PTR_ERR(vm_param);
>> +
>> +		vm = acrn_vm_create(vm, vm_param);
>> +		if (!vm) {
>> +			ret = -EINVAL;
>> +			kfree(vm_param);
>> +			break;
>> +		}
>> +
>> +		if (copy_to_user((void __user *)ioctl_param, vm_param,
>> +				 sizeof(struct acrn_vm_creation))) {
>> +			acrn_vm_destroy(vm);
>> +			ret = -EFAULT;
>> +		}
>> +
>> +		kfree(vm_param);
>> +		break;
>> +	case ACRN_IOCTL_START_VM:
>> +		ret = hcall_start_vm(vm->vmid);
>> +		if (ret < 0)
>> +			dev_err(acrn_dev.this_device,
>> +				"Failed to start VM %u!\n", vm->vmid);
>> +		break;
>> +	case ACRN_IOCTL_PAUSE_VM:
>> +		ret = hcall_pause_vm(vm->vmid);
>> +		if (ret < 0)
>> +			dev_err(acrn_dev.this_device,
>> +				"Failed to pause VM %u!\n", vm->vmid);
>> +		break;
>> +	case ACRN_IOCTL_RESET_VM:
>> +		ret = hcall_reset_vm(vm->vmid);
>> +		if (ret < 0)
>> +			dev_err(acrn_dev.this_device,
>> +				"Failed to restart VM %u!\n", vm->vmid);
>> +		break;
>> +	case ACRN_IOCTL_DESTROY_VM:
>> +		ret = acrn_vm_destroy(vm);
>> +		break;
>> +	default:
>> +		dev_warn(acrn_dev.this_device, "Unknown IOCTL 0x%x!\n", cmd);
>
>Do not let userspace spam kernel logs with invalid stuff, that's a sure
>way to cause a DoS.

OK. Got it. Will be dev_dbg().

Thanks
shuo
