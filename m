Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39F25C1A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgICN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 09:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbgICNCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:02:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECA120758;
        Thu,  3 Sep 2020 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599138135;
        bh=OjiaxZtk9Jflly1tinzaNuJ6FwngWepF//WDUXfRupI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7l+iOoHRvxRsySOl4ywsOJLan//QfOj+stEJR2+XlvMYVM3sQkOasfnYpjjt61RV
         0vCYLEG2OYtII5wqGnBsqAGePUa8LgZy3ThksUrOUid9ABS2tVcWAM0TmOBE2IQSzr
         XkGlOO8zKz9TosSoPFtYLRB5Q9GDp6N45EAsmqMY=
Date:   Thu, 3 Sep 2020 15:02:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v2 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200903130239.GB2778029@kroah.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
 <20200903124201.17275-7-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903124201.17275-7-shuo.a.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:41:50PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The VM management interfaces expose several VM operations to ACRN
> userspace via ioctls. For example, creating VM, starting VM, destroying
> VM and so on.
> 
> The ACRN Hypervisor needs to exchange data with the ACRN userspace
> during the VM operations. HSM provides VM operation ioctls to the ACRN
> userspace and communicates with the ACRN Hypervisor for VM operations
> via hypercalls.
> 
> HSM maintains a list of User VM. Each User VM will be bound to an
> existing file descriptor of /dev/acrn_hsm. The User VM will be
> destroyed when the file descriptor is closed.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/virt/acrn/Makefile    |  2 +-
>  drivers/virt/acrn/acrn_drv.h  | 21 +++++++++-
>  drivers/virt/acrn/hsm.c       | 62 +++++++++++++++++++++++++++-
>  drivers/virt/acrn/hypercall.h | 78 +++++++++++++++++++++++++++++++++++
>  drivers/virt/acrn/vm.c        | 67 ++++++++++++++++++++++++++++++
>  include/uapi/linux/acrn.h     | 39 ++++++++++++++++++
>  6 files changed, 266 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/virt/acrn/hypercall.h
>  create mode 100644 drivers/virt/acrn/vm.c
> 
> diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
> index 6920ed798aaf..cf8b4ed5e74e 100644
> --- a/drivers/virt/acrn/Makefile
> +++ b/drivers/virt/acrn/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_ACRN_HSM)	:= acrn.o
> -acrn-y := hsm.o
> +acrn-y := hsm.o vm.o
> diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
> index 0b8e4fdc168a..043ae6840995 100644
> --- a/drivers/virt/acrn/acrn_drv.h
> +++ b/drivers/virt/acrn/acrn_drv.h
> @@ -4,16 +4,35 @@
>  #define __ACRN_HSM_DRV_H
>  
>  #include <linux/acrn.h>
> +#include <linux/dev_printk.h>
>  #include <linux/types.h>
>  
> +#include "hypercall.h"
> +
>  #define ACRN_INVALID_VMID (0xffffU)
>  
> +#define ACRN_VM_FLAG_DESTROYED		0U
> +extern struct list_head acrn_vm_list;
> +extern rwlock_t acrn_vm_list_lock;
>  /**
>   * struct acrn_vm - Properties of ACRN User VM.
> + * @dev:	The struct device this VM belongs to
> + * @list:	Entry within global list of all VMs
>   * @vmid:	User VM ID
> + * @vcpu_num:	Number of virtual CPUs in the VM
> + * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
> + *		in HSM which is different from the &acrn_vm_creation.vm_flag.
>   */
>  struct acrn_vm {
> -	u16	vmid;
> +	struct device		*dev;
> +	struct list_head	list;
> +	u16			vmid;
> +	int			vcpu_num;
> +	unsigned long		flags;
>  };
>  
> +struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
> +			       struct acrn_vm_creation *vm_param);
> +int acrn_vm_destroy(struct acrn_vm *vm);
> +
>  #endif /* __ACRN_HSM_DRV_H */
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index 549c7f8d6b5f..6ec6aa9053d3 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #define pr_fmt(fmt) "acrn: " fmt
> +#define dev_fmt(fmt) "acrn: " fmt

This should not be needed anywhere, what is wrong with the default
prefix given to you by the dev_*() calls?



>  
>  #include <linux/miscdevice.h>
>  #include <linux/mm.h>
> @@ -21,6 +22,8 @@
>  
>  #include "acrn_drv.h"
>  
> +static struct device *dev;

Um, why?  This feels really odd...

> +
>  /*
>   * When /dev/acrn_hsm is opened, a 'struct acrn_vm' object is created to
>   * represent a VM instance and continues to be associated with the opened file
> @@ -36,6 +39,7 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
>  		return -ENOMEM;
>  
>  	vm->vmid = ACRN_INVALID_VMID;
> +	vm->dev = dev;
>  	filp->private_data = vm;
>  	return 0;
>  }
> @@ -43,13 +47,68 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
>  static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  			   unsigned long ioctl_param)
>  {
> -	return 0;
> +	struct acrn_vm *vm = filp->private_data;
> +	struct acrn_vm_creation *vm_param;
> +	int ret = 0;
> +
> +	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
> +		dev_err(dev, "ioctl 0x%x: Invalid VM state!\n", cmd);
> +		return -EFAULT;
> +	}
> +
> +	switch (cmd) {
> +	case ACRN_IOCTL_CREATE_VM:
> +		vm_param = memdup_user((void __user *)ioctl_param,
> +				       sizeof(struct acrn_vm_creation));
> +		if (IS_ERR(vm_param))
> +			return PTR_ERR(vm_param);
> +
> +		vm = acrn_vm_create(vm, vm_param);
> +		if (!vm) {
> +			ret = -EFAULT;
> +			kfree(vm_param);
> +			break;
> +		}
> +
> +		if (copy_to_user((void __user *)ioctl_param, vm_param,
> +				 sizeof(struct acrn_vm_creation))) {
> +			acrn_vm_destroy(vm);
> +			ret = -EFAULT;
> +		}
> +
> +		kfree(vm_param);
> +		break;
> +	case ACRN_IOCTL_START_VM:
> +		ret = hcall_start_vm(vm->vmid);
> +		if (ret < 0)
> +			dev_err(dev, "Failed to start VM %u!\n", vm->vmid);
> +		break;
> +	case ACRN_IOCTL_PAUSE_VM:
> +		ret = hcall_pause_vm(vm->vmid);
> +		if (ret < 0)
> +			dev_err(dev, "Failed to pause VM %u!\n", vm->vmid);
> +		break;
> +	case ACRN_IOCTL_RESET_VM:
> +		ret = hcall_reset_vm(vm->vmid);
> +		if (ret < 0)
> +			dev_err(dev, "Failed to restart VM %u!\n", vm->vmid);
> +		break;
> +	case ACRN_IOCTL_DESTROY_VM:
> +		ret = acrn_vm_destroy(vm);
> +		break;
> +	default:
> +		dev_warn(dev, "Unknown IOCTL 0x%x!\n", cmd);
> +		ret = -ENOTTY;
> +	}
> +
> +	return ret;
>  }
>  
>  static int acrn_dev_release(struct inode *inode, struct file *filp)
>  {
>  	struct acrn_vm *vm = filp->private_data;
>  
> +	acrn_vm_destroy(vm);
>  	kfree(vm);
>  	return 0;
>  }
> @@ -83,6 +142,7 @@ static int __init hsm_init(void)
>  		return ret;
>  	}
>  
> +	dev = acrn_dev.this_device;

Oh wow.  No, please no.  You just broke reference counting rules.

Put this in your file-handle-specific structure, not in a global
structure, that's going to break into loads of tiny pieces if you ever
glance wrong at it...

And as always, when you save a pointer to something, you HAVE TO
REFERENCE COUNT IT!  Otherwise it will go away from you without you
noticing and bad thigns will happen.

There's a reason we have the functions get_device(), don't ignore it
please...

> +#define HC_ID_VM_BASE			0x10UL

Why 10?

> +#define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
> +#define HC_DESTROY_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x01)
> +#define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
> +#define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
> +#define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
> +
> +/**
> + * hcall_create_vm() - Create a User VM
> + * @vminfo:	Service VM GPA of info of User VM creation
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_create_vm(u64 vminfo)
> +{
> +	return acrn_hypercall1(HC_CREATE_VM, vminfo);
> +}
> +
> +/**
> + * hcall_start_vm() - Start a User VM
> + * @vmid:	User VM ID
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_start_vm(u64 vmid)
> +{
> +	return acrn_hypercall1(HC_START_VM, vmid);
> +}
> +
> +/**
> + * hcall_pause_vm() - Pause a User VM
> + * @vmid:	User VM ID
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_pause_vm(u64 vmid)
> +{
> +	return acrn_hypercall1(HC_PAUSE_VM, vmid);
> +}
> +
> +/**
> + * hcall_destroy_vm() - Destroy a User VM
> + * @vmid:	User VM ID
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_destroy_vm(u64 vmid)
> +{
> +	return acrn_hypercall1(HC_DESTROY_VM, vmid);
> +}
> +
> +/**
> + * hcall_reset_vm() - Reset a User VM
> + * @vmid:	User VM ID
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_reset_vm(u64 vmid)
> +{
> +	return acrn_hypercall1(HC_RESET_VM, vmid);
> +}

Why are you putting these as inline functions?  ANd not using the acrn_*
prefix for them?

> +#endif /* __ACRN_HSM_HYPERCALL_H */
> diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
> new file mode 100644
> index 000000000000..770322904fcc
> --- /dev/null
> +++ b/drivers/virt/acrn/vm.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACRN_HSM: Virtual Machine management
> + *
> + * Copyright (C) 2020 Intel Corporation. All rights reserved.
> + *
> + * Authors:
> + *	Jason Chen CJ <jason.cj.chen@intel.com>
> + *	Yakui Zhao <yakui.zhao@intel.com>
> + */
> +#define pr_fmt(fmt) "acrn: " fmt
> +#define dev_fmt(fmt) "acrn: " fmt

Both of these should not be needed, right?

> +
> +#include <linux/io.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +
> +#include "acrn_drv.h"
> +
> +LIST_HEAD(acrn_vm_list);

static?

> +DEFINE_RWLOCK(acrn_vm_list_lock);

static?

What is this locking?  Documentation please...

> +
> +struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
> +			       struct acrn_vm_creation *vm_param)
> +{
> +	int ret;
> +
> +	ret = hcall_create_vm(virt_to_phys(vm_param));
> +	if (ret < 0 || vm_param->vmid == ACRN_INVALID_VMID) {
> +		dev_err(vm->dev, "Failed to create VM! Error: %d\n", ret);
> +		return NULL;
> +	}
> +
> +	vm->vmid = vm_param->vmid;
> +	vm->vcpu_num = vm_param->vcpu_num;
> +
> +	write_lock_bh(&acrn_vm_list_lock);
> +	list_add(&vm->list, &acrn_vm_list);
> +	write_unlock_bh(&acrn_vm_list_lock);
> +
> +	dev_dbg(vm->dev, "VM %u created.\n", vm->vmid);
> +	return vm;
> +}
> +
> +int acrn_vm_destroy(struct acrn_vm *vm)
> +{
> +	int ret;
> +
> +	if (vm->vmid == ACRN_INVALID_VMID ||
> +	    test_and_set_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags))
> +		return 0;
> +
> +	/* Remove from global VM list */
> +	write_lock_bh(&acrn_vm_list_lock);
> +	list_del_init(&vm->list);
> +	write_unlock_bh(&acrn_vm_list_lock);
> +
> +	ret = hcall_destroy_vm(vm->vmid);
> +	if (ret < 0) {
> +		dev_err(vm->dev, "Failed to destroy VM %u\n", vm->vmid);
> +		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
> +		return ret;
> +	}
> +	dev_dbg(vm->dev, "VM %u destroyed.\n", vm->vmid);
> +	vm->vmid = ACRN_INVALID_VMID;
> +	return 0;
> +}
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> index 4ae34f86e2be..364b1a783074 100644
> --- a/include/uapi/linux/acrn.h
> +++ b/include/uapi/linux/acrn.h
> @@ -11,7 +11,46 @@
>  
>  #include <linux/types.h>
>  
> +/**
> + * struct acrn_vm_creation - Info to create a User VM
> + * @vmid:		User VM ID returned from the hypervisor
> + * @reserved0:		Reserved
> + * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
> + * @reserved1:		Reserved
> + * @uuid:		UUID of the VM. Pass to hypervisor directly.
> + * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
> + * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
> + *			hypervisor directly.
> + * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
> + * @reserved2:		Reserved
> + */
> +struct acrn_vm_creation {
> +	__u16	vmid;
> +	__u16	reserved0;
> +	__u16	vcpu_num;
> +	__u16	reserved1;
> +	__u8	uuid[16];

Don't we have a uuid type?

> +	__u64	vm_flag;
> +	__u64	ioreq_buf;
> +	__u64	cpu_affinity;
> +	__u8	reserved2[8];
> +} __attribute__((aligned(8)));

For "reserved" fields, are you ensuring that they are set to 0 now?  If
not, please do so, otherwise things will break in the future...

thanks,

greg k-h
