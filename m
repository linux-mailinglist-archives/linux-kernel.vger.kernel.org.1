Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363392EF4DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbhAHPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbhAHPcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:32:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 434BD239A1;
        Fri,  8 Jan 2021 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610119924;
        bh=yhe0rnFtjmqGCTUZ6htTfilIcdE7g++8VG3Lv+Lg/6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cp8PRRCqBEFL/xk7TfWqq28+MYYc3OYShJFEcSDqN0srEvpPDZ93+agRpP2PttGq/
         0dP8wfWXpQ3zW4G+lprJl3q3QmASy/CVT4v6uExhhSS+tMnSQK+7Vj3CqzPfsJ1bOi
         C0msy4gCDXrBeaAAegfrEg9EpPQCm0loBoM4s8QY=
Date:   Fri, 8 Jan 2021 16:33:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 07/18] virt: acrn: Introduce an ioctl to set vCPU
 registers state
Message-ID: <X/h7QoSqRw2Anfvo@kroah.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-8-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106075055.47226-8-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:50:44PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> A virtual CPU of User VM has different context due to the different
> registers state. ACRN userspace needs to set the virtual CPU
> registers state (e.g. giving a initial registers state to a virtual
> BSP of a User VM).
> 
> HSM provides an ioctl ACRN_IOCTL_SET_VCPU_REGS to do the virtual CPU
> registers state setting. The ioctl passes the registers state from ACRN
> userspace to the hypervisor directly.
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
>  drivers/virt/acrn/hsm.c       | 21 ++++++++++-
>  drivers/virt/acrn/hypercall.h | 13 +++++++
>  include/uapi/linux/acrn.h     | 69 +++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index 5fd933471683..2d04ebaa43f8 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -9,6 +9,7 @@
>   *	Yakui Zhao <yakui.zhao@intel.com>
>   */
>  
> +#include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -46,7 +47,8 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  {
>  	struct acrn_vm *vm = filp->private_data;
>  	struct acrn_vm_creation *vm_param;
> -	int ret = 0;
> +	struct acrn_vcpu_regs *cpu_regs;
> +	int i, ret = 0;
>  
>  	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
>  		dev_dbg(acrn_dev.this_device,
> @@ -100,6 +102,23 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  	case ACRN_IOCTL_DESTROY_VM:
>  		ret = acrn_vm_destroy(vm);
>  		break;
> +	case ACRN_IOCTL_SET_VCPU_REGS:
> +		cpu_regs = memdup_user((void __user *)ioctl_param,
> +				       sizeof(struct acrn_vcpu_regs));
> +		if (IS_ERR(cpu_regs))
> +			return PTR_ERR(cpu_regs);
> +
> +		for (i = 0; i < ARRAY_SIZE(cpu_regs->reserved); i++)
> +			if (cpu_regs->reserved[i])
> +				return -EINVAL;
> +
> +		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
> +		if (ret < 0)
> +			dev_dbg(acrn_dev.this_device,
> +				"Failed to set regs state of VM%u!\n",
> +				vm->vmid);
> +		kfree(cpu_regs);
> +		break;
>  	default:
>  		dev_dbg(acrn_dev.this_device, "Unknown IOCTL 0x%x!\n", cmd);
>  		ret = -ENOTTY;
> diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
> index 426b66cadb1f..f29cfae08862 100644
> --- a/drivers/virt/acrn/hypercall.h
> +++ b/drivers/virt/acrn/hypercall.h
> @@ -19,6 +19,7 @@
>  #define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
>  #define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
>  #define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
> +#define HC_SET_VCPU_REGS		_HC_ID(HC_ID, HC_ID_VM_BASE + 0x06)
>  
>  /**
>   * hcall_create_vm() - Create a User VM
> @@ -75,4 +76,16 @@ static inline long hcall_reset_vm(u64 vmid)
>  	return acrn_hypercall1(HC_RESET_VM, vmid);
>  }
>  
> +/**
> + * hcall_set_vcpu_regs() - Set up registers of virtual CPU of a User VM
> + * @vmid:	User VM ID
> + * @regs_state:	Service VM GPA of registers state
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_set_vcpu_regs(u64 vmid, u64 regs_state)
> +{
> +	return acrn_hypercall2(HC_SET_VCPU_REGS, vmid, regs_state);
> +}
> +
>  #endif /* __ACRN_HSM_HYPERCALL_H */
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> index e1608b8a50a2..d5d66b93586e 100644
> --- a/include/uapi/linux/acrn.h
> +++ b/include/uapi/linux/acrn.h
> @@ -35,6 +35,73 @@ struct acrn_vm_creation {
>  	__u64	cpu_affinity;
>  };
>  
> +struct acrn_gp_regs {
> +	__le64	rax;
> +	__le64	rcx;
> +	__le64	rdx;
> +	__le64	rbx;
> +	__le64	rsp;
> +	__le64	rbp;
> +	__le64	rsi;
> +	__le64	rdi;
> +	__le64	r8;
> +	__le64	r9;
> +	__le64	r10;
> +	__le64	r11;
> +	__le64	r12;
> +	__le64	r13;
> +	__le64	r14;
> +	__le64	r15;
> +};
> +
> +struct acrn_descriptor_ptr {
> +	__le16	limit;
> +	__le64	base;
> +	__le16	reserved[3];
> +} __attribute__ ((__packed__));
> +
> +struct acrn_regs {
> +	struct acrn_gp_regs		gprs;
> +	struct acrn_descriptor_ptr	gdt;
> +	struct acrn_descriptor_ptr	idt;
> +
> +	__le64				rip;
> +	__le64				cs_base;
> +	__le64				cr0;
> +	__le64				cr4;
> +	__le64				cr3;
> +	__le64				ia32_efer;
> +	__le64				rflags;
> +	__le64				reserved_64[4];
> +
> +	__le32				cs_ar;
> +	__le32				cs_limit;
> +	__le32				reserved_32[3];
> +
> +	__le16				cs_sel;
> +	__le16				ss_sel;
> +	__le16				ds_sel;
> +	__le16				es_sel;
> +	__le16				fs_sel;
> +	__le16				gs_sel;
> +	__le16				ldt_sel;
> +	__le16				tr_sel;
> +};

No documentation of what these variables are anywhere?

What about the reserved slots, what must they be set to?

> +
> +/**
> + * struct acrn_vcpu_regs - Info of vCPU registers state
> + * @vcpu_id:	vCPU ID
> + * @reserved:	Reserved and must be 0

You actually checked this, nice!


thanks,

greg k-h
