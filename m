Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6E2EE661
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbhAGTty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbhAGTtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:49:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C7F823380;
        Thu,  7 Jan 2021 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610048952;
        bh=d0HqZHJJ0EwSwfSdLZviD98TEgHHoMQnG1g2LPjA1Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QasJAu8W1zvgLD9bp5a+83BDzlGp0/AFn96bstPzCVg2X8kSDQmCuu7MRNVllfI7+
         J3p8pilTYZ1yWDxKsdxZvblh7FnPrdNYYV71Pu2Z2bwMxBtwtVSC9tOp1GqMU9pcT6
         f/72NTW33HwOJtxMhnUN06AjzvxBDA2KTWxO2dMk=
Date:   Thu, 7 Jan 2021 20:50:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Ximing Chen <mike.ximing.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <X/dmB3q6QEd2aQdG@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105025839.23169-5-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:58:23PM -0600, Mike Ximing Chen wrote:
> Introduce the dlb device ioctl layer and the first three ioctls: query
> device version, query available resources, and create a scheduling domain.
> Also introduce the user-space interface file dlb_user.h.
> 
> The device version query is designed to allow each DLB device version/type
> to have its own unique ioctl API through the /dev/dlb%d node. Each such API
> would share in common the device version command as its first command, and
> all subsequent commands can be unique to the particular device.
> 
> The hardware operation for scheduling domain creation will be added in a
> subsequent commit.
> 
> Signed-off-by: Gage Eads <gage.eads@intel.com>
> Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
> Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/misc/dlb/Makefile                     |   2 +-
>  drivers/misc/dlb/dlb_bitmap.h                 |  32 ++++
>  drivers/misc/dlb/dlb_ioctl.c                  | 119 +++++++++++++
>  drivers/misc/dlb/dlb_ioctl.h                  |  11 ++
>  drivers/misc/dlb/dlb_main.c                   |   3 +
>  drivers/misc/dlb/dlb_main.h                   |   7 +
>  drivers/misc/dlb/dlb_pf_ops.c                 |  21 +++
>  drivers/misc/dlb/dlb_resource.c               |  63 +++++++
>  drivers/misc/dlb/dlb_resource.h               |   5 +
>  include/uapi/linux/dlb.h                      | 166 ++++++++++++++++++
>  11 files changed, 429 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/dlb/dlb_ioctl.c
>  create mode 100644 drivers/misc/dlb/dlb_ioctl.h
>  create mode 100644 include/uapi/linux/dlb.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 55a2d9b2ce33..afca043d59f8 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -241,6 +241,7 @@ Code  Seq#    Include File                                           Comments
>  'h'   00-7F                                                          conflict! Charon filesystem
>                                                                       <mailto:zapman@interlan.net>
>  'h'   00-1F  linux/hpet.h                                            conflict!
> +'h'   00-1F  uapi/linux/dlb.h                                        conflict!
>  'h'   80-8F  fs/hfsplus/ioctl.c
>  'i'   00-3F  linux/i2o-dev.h                                         conflict!
>  'i'   0B-1F  linux/ipmi.h                                            conflict!
> diff --git a/drivers/misc/dlb/Makefile b/drivers/misc/dlb/Makefile
> index 8a49ea5fd752..aaafb3086d8d 100644
> --- a/drivers/misc/dlb/Makefile
> +++ b/drivers/misc/dlb/Makefile
> @@ -7,4 +7,4 @@
>  obj-$(CONFIG_INTEL_DLB) := dlb.o
>  
>  dlb-objs := dlb_main.o
> -dlb-objs += dlb_pf_ops.o dlb_resource.o
> +dlb-objs += dlb_pf_ops.o dlb_resource.o dlb_ioctl.o
> diff --git a/drivers/misc/dlb/dlb_bitmap.h b/drivers/misc/dlb/dlb_bitmap.h
> index fb3ef52a306d..3ea78b42c79f 100644
> --- a/drivers/misc/dlb/dlb_bitmap.h
> +++ b/drivers/misc/dlb/dlb_bitmap.h
> @@ -73,4 +73,36 @@ static inline void dlb_bitmap_free(struct dlb_bitmap *bitmap)
>  	kfree(bitmap);
>  }
>  
> +/**
> + * dlb_bitmap_longest_set_range() - returns longest contiguous range of set
> + *				     bits
> + * @bitmap: pointer to dlb_bitmap structure.
> + *
> + * Return:
> + * Returns the bitmap's longest contiguous range of set bits upon success,
> + * <0 otherwise.
> + *
> + * Errors:
> + * EINVAL - bitmap is NULL or is uninitialized.
> + */
> +static inline int dlb_bitmap_longest_set_range(struct dlb_bitmap *bitmap)
> +{
> +	int max_len, len;
> +	int start, end;
> +
> +	if (!bitmap || !bitmap->map)
> +		return -EINVAL;
> +
> +	if (bitmap_weight(bitmap->map, bitmap->len) == 0)
> +		return 0;
> +
> +	max_len = 0;
> +	bitmap_for_each_set_region(bitmap->map, start, end, 0, bitmap->len) {
> +		len = end - start;
> +		if (max_len < len)
> +			max_len = len;
> +	}
> +	return max_len;
> +}
> +
>  #endif /*  __DLB_OSDEP_BITMAP_H */
> diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.c
> new file mode 100644
> index 000000000000..c072ed9b921c
> --- /dev/null
> +++ b/drivers/misc/dlb/dlb_ioctl.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
> +
> +#include <linux/uaccess.h>
> +#include <linux/nospec.h>
> +
> +#include <uapi/linux/dlb.h>
> +
> +#include "dlb_ioctl.h"
> +#include "dlb_main.h"
> +
> +/* [7:0]: device revision, [15:8]: device version */
> +#define DLB_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> +
> +static int
> +dlb_ioctl_get_device_version(struct dlb *dlb __attribute__((unused)),
> +			     void *karg)
> +{
> +	struct dlb_get_device_version_args *arg = karg;
> +
> +	arg->response.status = 0;
> +	arg->response.id = DLB_SET_DEVICE_VERSION(2, DLB_REV_A0);
> +
> +	return 0;
> +}
> +
> +static int dlb_ioctl_create_sched_domain(struct dlb *dlb,
> +					 void *karg)
> +{
> +	struct dlb_create_sched_domain_args *arg = karg;
> +	struct dlb_cmd_response *resp;
> +	int ret;
> +
> +	mutex_lock(&dlb->resource_mutex);
> +
> +	BUILD_BUG_ON(offsetof(typeof(*arg), response) != 0);
> +	resp = &arg->response;
> +
> +	ret = dlb->ops->create_sched_domain(&dlb->hw, arg, resp);
> +
> +	mutex_unlock(&dlb->resource_mutex);
> +
> +	return ret;
> +}
> +
> +static int dlb_ioctl_get_num_resources(struct dlb *dlb,
> +				       void *karg)
> +{
> +	struct dlb_get_num_resources_args *arg = karg;
> +	int ret;
> +
> +	mutex_lock(&dlb->resource_mutex);
> +	ret = dlb->ops->get_num_resources(&dlb->hw, arg);
> +	mutex_unlock(&dlb->resource_mutex);
> +
> +	return ret;
> +}
> +
> +typedef int (*dlb_ioctl_fn_t)(struct dlb *dlb,
> +			      void *karg);
> +
> +static dlb_ioctl_fn_t dlb_ioctl_fns[NUM_DLB_CMD] = {
> +	dlb_ioctl_get_device_version,
> +	dlb_ioctl_create_sched_domain,
> +	dlb_ioctl_get_num_resources

{sigh}

No, do NOT do this.  Have real function calls, where the compiler can
properly check the arguments and do the correct copying from memory and
all that mess.  That way you don't have to try to keep this list in sync
with:

> +};
> +
> +static int dlb_ioctl_arg_size[NUM_DLB_CMD] = {
> +	sizeof(struct dlb_get_device_version_args),
> +	sizeof(struct dlb_create_sched_domain_args),
> +	sizeof(struct dlb_get_num_resources_args)

That list.

Ugh, no.  that's no way to write maintainable code that you will be able
to understand in 2 years.

> +};
> +
> +long
> +dlb_ioctl(struct file *f,
> +	  unsigned int cmd,
> +	  unsigned long user_arg)

Please stop wrapping lines where they are not needed.  Use the whole
line whenever you can.  You do that a LOT in this patch series.


> +{
> +	struct dlb *dlb;
> +	dlb_ioctl_fn_t fn;
> +	u32 cmd_nr;
> +	void *karg;
> +	int size;
> +	int ret;
> +
> +	dlb = f->private_data;
> +
> +	if (!dlb) {
> +		pr_err("dlb: [%s()] Invalid DLB data\n", __func__);
> +		return -EFAULT;

This error value is only allowed if you really do have a memory fault.

Hint, you do not here.

How can that value ever be NULL?

> +	}
> +
> +	if (_IOC_NR(cmd) >= NUM_DLB_CMD) {
> +		dev_err(dlb->dev, "[%s()] Unexpected DLB command %d\n",
> +			__func__, _IOC_NR(cmd));
> +		return -EINVAL;

Wrong error value.

And now you have a simple way to cause a DoS on your kernel error log.
Don't log foolish errors like this that a user can cause.

> +	}
> +
> +	/* Block potential speculation on invalid command numbers.
> +	 */
> +	cmd_nr = array_index_nospec(_IOC_NR(cmd), NUM_DLB_CMD);

Really?  Why?  If you do this correctly it is not an issue at all.

> +
> +	size = dlb_ioctl_arg_size[cmd_nr];
> +	fn = dlb_ioctl_fns[cmd_nr];
> +
> +	karg = kzalloc(size, GFP_KERNEL);
> +	if (!karg)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(karg, (void __user *)user_arg, size))
> +		return -EFAULT;
> +
> +	ret = fn(dlb, karg);
> +
> +	if (copy_to_user((void __user *)user_arg, karg, size))
> +		return -EFAULT;

What happens if your ioctl command did not want anything copied back?

That's why you don't do the crazy list of ioctl function pointers.  This
is Linux, spell out the code obviously please.


> +
> +	return ret;
> +}
> diff --git a/drivers/misc/dlb/dlb_ioctl.h b/drivers/misc/dlb/dlb_ioctl.h
> new file mode 100644
> index 000000000000..0737676f4208
> --- /dev/null
> +++ b/drivers/misc/dlb/dlb_ioctl.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __DLB_IOCTL_H
> +#define __DLB_IOCTL_H
> +
> +#include "dlb_main.h"
> +
> +long dlb_ioctl(struct file *f, unsigned int cmd, unsigned long user_arg);

A .h file for a single function?  No.  It's a simple driver, you only
need 1 .h file for it.


> +
> +#endif /* __DLB_IOCTL_H */
> diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
> index daa5eb75380f..787610bf6b20 100644
> --- a/drivers/misc/dlb/dlb_main.c
> +++ b/drivers/misc/dlb/dlb_main.c
> @@ -10,6 +10,7 @@
>  #include <linux/pci.h>
>  #include <linux/uaccess.h>
>  
> +#include "dlb_ioctl.h"
>  #include "dlb_main.h"
>  #include "dlb_resource.h"
>  
> @@ -68,6 +69,8 @@ static int dlb_device_create(struct dlb *dlb, struct pci_dev *pdev)
>  
>  static const struct file_operations dlb_fops = {
>  	.owner   = THIS_MODULE,
> +	.unlocked_ioctl = dlb_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,

Why do you need a compat ioctl for a brand new ioctl you are creating
now?



>  };
>  
>  /**********************************/
> diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
> index aaa806be66af..b3be39397fa2 100644
> --- a/drivers/misc/dlb/dlb_main.h
> +++ b/drivers/misc/dlb/dlb_main.h
> @@ -12,6 +12,8 @@
>  #include <linux/pci.h>
>  #include <linux/types.h>
>  
> +#include <uapi/linux/dlb.h>
> +
>  #include "dlb_hw_types.h"
>  
>  /*
> @@ -37,6 +39,11 @@ struct dlb_device_ops {
>  	int (*init_driver_state)(struct dlb *dlb);
>  	void (*enable_pm)(struct dlb *dlb);
>  	int (*wait_for_device_ready)(struct dlb *dlb, struct pci_dev *pdev);
> +	int (*create_sched_domain)(struct dlb_hw *hw,
> +				   struct dlb_create_sched_domain_args *args,
> +				   struct dlb_cmd_response *resp);
> +	int (*get_num_resources)(struct dlb_hw *hw,
> +				 struct dlb_get_num_resources_args *args);
>  };
>  
>  extern struct dlb_device_ops dlb_pf_ops;
> diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
> index a88f9519ac60..67d4300ca093 100644
> --- a/drivers/misc/dlb/dlb_pf_ops.c
> +++ b/drivers/misc/dlb/dlb_pf_ops.c
> @@ -100,6 +100,25 @@ dlb_pf_wait_for_device_ready(struct dlb *dlb, struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +/*****************************/
> +/****** IOCTL callbacks ******/
> +/*****************************/
> +
> +static int
> +dlb_pf_create_sched_domain(struct dlb_hw *hw,
> +			   struct dlb_create_sched_domain_args *args,
> +			   struct dlb_cmd_response *resp)
> +{
> +	return 0;

Why have an empty function?  Just don't define it until you need it.



> +}
> +
> +static int
> +dlb_pf_get_num_resources(struct dlb_hw *hw,
> +			 struct dlb_get_num_resources_args *args)
> +{
> +	return dlb_hw_get_num_resources(hw, args, false, 0);
> +}
> +
>  /********************************/
>  /****** DLB PF Device Ops ******/
>  /********************************/
> @@ -110,4 +129,6 @@ struct dlb_device_ops dlb_pf_ops = {
>  	.init_driver_state = dlb_pf_init_driver_state,
>  	.enable_pm = dlb_pf_enable_pm,
>  	.wait_for_device_ready = dlb_pf_wait_for_device_ready,
> +	.create_sched_domain = dlb_pf_create_sched_domain,
> +	.get_num_resources = dlb_pf_get_num_resources,
>  };
> diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
> index 3c60b704f3d6..93936611027b 100644
> --- a/drivers/misc/dlb/dlb_resource.c
> +++ b/drivers/misc/dlb/dlb_resource.c
> @@ -200,6 +200,69 @@ int dlb_resource_init(struct dlb_hw *hw)
>  	return ret;
>  }
>  
> +/**
> + * dlb_hw_get_num_resources() - query the PCI function's available resources
> + * @hw: dlb_hw handle for a particular device.
> + * @arg: pointer to resource counts.
> + * @vdev_req: indicates whether this request came from a vdev.
> + * @vdev_id: If vdev_req is true, this contains the vdev's ID.
> + *
> + * This function returns the number of available resources for the PF or for a
> + * VF.
> + *
> + * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
> + * device.
> + *
> + * Return:
> + * Returns 0 upon success, -EINVAL if vdev_req is true and vdev_id is
> + * invalid.
> + */
> +int dlb_hw_get_num_resources(struct dlb_hw *hw,
> +			     struct dlb_get_num_resources_args *arg,
> +			     bool vdev_req,
> +			     unsigned int vdev_id)
> +{
> +	struct dlb_function_resources *rsrcs;
> +	struct dlb_bitmap *map;
> +	int i;
> +
> +	if (vdev_req && vdev_id >= DLB_MAX_NUM_VDEVS)
> +		return -EINVAL;
> +
> +	if (vdev_req)
> +		rsrcs = &hw->vdev[vdev_id];
> +	else
> +		rsrcs = &hw->pf;
> +
> +	arg->num_sched_domains = rsrcs->num_avail_domains;
> +
> +	arg->num_ldb_queues = rsrcs->num_avail_ldb_queues;
> +
> +	arg->num_ldb_ports = 0;
> +	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++)
> +		arg->num_ldb_ports += rsrcs->num_avail_ldb_ports[i];
> +
> +	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++)
> +		arg->num_cos_ldb_ports[i] = rsrcs->num_avail_ldb_ports[i];
> +
> +	arg->num_dir_ports = rsrcs->num_avail_dir_pq_pairs;
> +
> +	arg->num_atomic_inflights = rsrcs->num_avail_aqed_entries;
> +
> +	map = rsrcs->avail_hist_list_entries;
> +
> +	arg->num_hist_list_entries = bitmap_weight(map->map, map->len);
> +
> +	arg->max_contiguous_hist_list_entries =
> +		dlb_bitmap_longest_set_range(map);
> +
> +	arg->num_ldb_credits = rsrcs->num_avail_qed_entries;
> +
> +	arg->num_dir_credits = rsrcs->num_avail_dqed_entries;
> +
> +	return 0;
> +}
> +
>  /**
>   * dlb_clr_pmcsr_disable() - power on bulk of DLB 2.0 logic
>   * @hw: dlb_hw handle for a particular device.
> diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_resource.h
> index 2229813d9c45..752645900f34 100644
> --- a/drivers/misc/dlb/dlb_resource.h
> +++ b/drivers/misc/dlb/dlb_resource.h
> @@ -12,6 +12,11 @@ int dlb_resource_init(struct dlb_hw *hw);
>  
>  void dlb_resource_free(struct dlb_hw *hw);
>  
> +int dlb_hw_get_num_resources(struct dlb_hw *hw,
> +			     struct dlb_get_num_resources_args *arg,
> +			     bool vdev_req,
> +			     unsigned int vdev_id);
> +
>  void dlb_clr_pmcsr_disable(struct dlb_hw *hw);
>  
>  #endif /* __DLB_RESOURCE_H */
> diff --git a/include/uapi/linux/dlb.h b/include/uapi/linux/dlb.h
> new file mode 100644
> index 000000000000..956d5e9d1ddc
> --- /dev/null
> +++ b/include/uapi/linux/dlb.h
> @@ -0,0 +1,166 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + * Copyright(c) 2016-2020 Intel Corporation
> + */

Use the correct comment line for SPDX please.


> +
> +#ifndef __DLB_H
> +#define __DLB_H
> +
> +#include <linux/types.h>
> +
> +struct dlb_cmd_response {
> +	__u32 status; /* Interpret using enum dlb_error */
> +	__u32 id;
> +};
> +
> +/********************************/
> +/* 'dlb' device file commands  */
> +/********************************/
> +
> +#define DLB_DEVICE_VERSION(x) (((x) >> 8) & 0xFF)
> +#define DLB_DEVICE_REVISION(x) ((x) & 0xFF)
> +
> +enum dlb_revisions {
> +	DLB_REV_A0 = 0,

What is a "revision" and why do you care about it?

> +};
> +
> +/*
> + * DLB_CMD_GET_DEVICE_VERSION: Query the DLB device version.
> + *
> + *	Each DLB device version has its own unique ioctl API, but all share
> + *	this as the first command in their interface, which tells user-space
> + *	which API to use. The device revision is provided in case of any
> + *	hardware errata.
> + *
> + * Output parameters:
> + * - response.status: Detailed error code. In certain cases, such as if the
> + *	ioctl request arg is invalid, the driver won't set status.
> + * - response.id[7:0]: Device revision.
> + * - response.id[15:8]: Device version.

So userspace has to do different things depending on what the hardware
type is?  Why not make a totally different driver for new hardware
types if things are going to change in the future?



> + */
> +
> +struct dlb_get_device_version_args {
> +	/* Output parameters */
> +	struct dlb_cmd_response response;
> +};
> +
> +/*
> + * DLB_CMD_CREATE_SCHED_DOMAIN: Create a DLB 2.0 scheduling domain and reserve
> + *	its hardware resources. This command returns the newly created domain
> + *	ID and a file descriptor for accessing the domain.
> + *
> + * Input parameters:
> + * - num_ldb_queues: Number of load-balanced queues.
> + * - num_ldb_ports: Number of load-balanced ports that can be allocated from
> + *	any class-of-service with available ports.
> + * - num_cos_ldb_ports[4]: Number of load-balanced ports from
> + *	classes-of-service 0-3.
> + * - num_dir_ports: Number of directed ports. A directed port has one directed
> + *	queue, so no num_dir_queues argument is necessary.
> + * - num_atomic_inflights: This specifies the amount of temporary atomic QE
> + *	storage for the domain. This storage is divided among the domain's
> + *	load-balanced queues that are configured for atomic scheduling.
> + * - num_hist_list_entries: Amount of history list storage. This is divided
> + *	among the domain's CQs.
> + * - num_ldb_credits: Amount of load-balanced QE storage (QED). QEs occupy this
> + *	space until they are scheduled to a load-balanced CQ. One credit
> + *	represents the storage for one QE.
> + * - num_dir_credits: Amount of directed QE storage (DQED). QEs occupy this
> + *	space until they are scheduled to a directed CQ. One credit represents
> + *	the storage for one QE.
> + * - cos_strict: If set, return an error if there are insufficient ports in
> + *	class-of-service N to satisfy the num_ldb_ports_cosN argument. If
> + *	unset, attempt to fulfill num_ldb_ports_cosN arguments from other
> + *	classes-of-service if class N does not contain enough free ports.
> + * - padding1: Reserved for future use.
> + *
> + * Output parameters:
> + * - response.status: Detailed error code. In certain cases, such as if the
> + *	ioctl request arg is invalid, the driver won't set status.
> + * - response.id: domain ID.
> + * - domain_fd: file descriptor for performing the domain's ioctl operations
> + * - padding0: Reserved for future use.

These are upside down as per the structure definition below.

And insist that your "padding" must be set to 0 and enforce it,
otherwise it is useless.

I'm stopping reviewing here...

greg k-h
