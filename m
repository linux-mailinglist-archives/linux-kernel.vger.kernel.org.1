Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9BD275D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIWQN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:13:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72C7208E4;
        Wed, 23 Sep 2020 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877638;
        bh=dd0+QGUw7FYHGc2K0i1e3+Rp3pgyf5G2i5dUaqW9I7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Djr6D68kbgJ0nt+MBoJ2APEdkjvQKgSawR/DZ7ynvSBiu0P5KgYkieLFflb2CoTAD
         RLD+7nP6U8gx+njAc4NuwoNJiOCt8/Cqm6VOiquxngi9iJCwUAvgFpBKu+Hmw9re6e
         jbVx+Qh2IU5vtPqPDazQairLsoIFLHNMR80ebHWQ=
Date:   Wed, 23 Sep 2020 18:14:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
Message-ID: <20200923161416.GA3723109@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923151511.3842150-9-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:15:10PM +0200, Maximilian Luz wrote:
> Add a DebugFS device-file providing user-space access to the Surface
> Aggregator EC, intended for debugging, testing, and reverse-engineering.
> Specifically, this interface gives user-space applications the ability
> to send requests to the EC and receive the corresponding responses.

Did you just add an ioctl to a debugfs file?  Wow...

> The device-file is managed by a pseudo platform-device and corresponding
> driver to avoid dependence on the dedicated bus, allowing it to be
> loaded in a minimal configuration.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  .../surface_aggregator/clients/dbgdev.rst     | 130 ++++++++
>  .../surface_aggregator/clients/index.rst      |  12 +-
>  drivers/misc/surface_aggregator/Kconfig       |   2 +
>  drivers/misc/surface_aggregator/Makefile      |   1 +
>  .../misc/surface_aggregator/clients/Kconfig   |  18 ++
>  .../misc/surface_aggregator/clients/Makefile  |   3 +
>  .../clients/surface_aggregator_debugfs.c      | 281 ++++++++++++++++++
>  7 files changed, 446 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/driver-api/surface_aggregator/clients/dbgdev.rst
>  create mode 100644 drivers/misc/surface_aggregator/clients/Kconfig
>  create mode 100644 drivers/misc/surface_aggregator/clients/Makefile
>  create mode 100644 drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
> 
> diff --git a/Documentation/driver-api/surface_aggregator/clients/dbgdev.rst b/Documentation/driver-api/surface_aggregator/clients/dbgdev.rst
> new file mode 100644
> index 000000000000..e45d7e7fd13f
> --- /dev/null
> +++ b/Documentation/driver-api/surface_aggregator/clients/dbgdev.rst
> @@ -0,0 +1,130 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. |u8| replace:: :c:type:`u8 <u8>`
> +.. |u16| replace:: :c:type:`u16 <u16>`
> +.. |ssam_dbg_request| replace:: :c:type:`struct ssam_dbg_request <ssam_dbg_request>`
> +.. |ssam_request_flags| replace:: :c:type:`enum ssam_request_flags <ssam_request_flags>`
> +
> +=======================================
> +SSAM Debug Device and DebugFS Interface
> +=======================================
> +
> +The ``surface_aggregator_debugfs`` module provides a DebugFS interface for
> +the SSAM controller to allow for a (more or less) direct connection from
> +userspace to the SAM EC. It is intended to be used for development and
> +debugging, and therefore should not be used or relied upon in any other way.
> +Note that this module is not loaded automatically, but instead must be
> +loaded manually.
> +
> +The provided interface is accessible through the
> +``surface_aggregator/controller`` device-file in debugfs, so, if the
> +conventional mount path is being used,
> +``/sys/kernel/debug/surface_aggregator/controller``. All functionality of
> +this interface is provided via IOCTLs.
> +
> +
> +Controller IOCTLs
> +=================
> +
> +The following IOCTLs are provided:
> +
> +.. flat-table:: Controller IOCTLs
> +   :widths: 1 1 1 1 4
> +   :header-rows: 1
> +
> +   * - Type
> +     - Number
> +     - Direction
> +     - Name
> +     - Description
> +
> +   * - ``0xA5``
> +     - ``0``
> +     - ``R``
> +     - ``GETVERSION``
> +     - Get DebugFS controller interface version.
> +
> +   * - ``0xA5``
> +     - ``1``
> +     - ``WR``
> +     - ``REQUEST``
> +     - Perform synchronous SAM request.
> +
> +
> +``GETVERSION``
> +--------------
> +
> +Defined as ``_IOR(0xA5, 0, __u32)``.
> +
> +Gets the current interface version. This should be used to check for changes
> +in the interface and determine if certain functionality is available. While
> +the interface should under normal circumstances kept backward compatible, as
> +this is a debug interface, backwards compatibility is not guaranteed.
> +
> +The version number follows the semantic versioning scheme, roughly meaning
> +that an increment in the highest non-zero version number signals a breaking
> +change. It can be decomposed as follows:
> +
> +.. flat-table:: Version Number Format
> +   :widths: 2 1 3
> +   :header-rows: 1
> +
> +   * - Offset (bytes)
> +     - Type
> +     - Description
> +
> +   * - ``0``
> +     - |u8|
> +     - Major
> +
> +   * - ``1``
> +     - |u8|
> +     - Minor
> +
> +   * - ``2``
> +     - |u16|
> +     - Patch
> +
> +The interface version is currently ``0.1.0``, i.e. ``0x00010000``.
> +
> +
> +``REQUEST``
> +-----------
> +
> +Defined as ``_IOWR(0xA5, 1, struct ssam_dbg_request)``.
> +
> +Executes a synchronous SAM request. The request specification is passed in
> +as argument of type |ssam_dbg_request|, which is then written to/modified
> +by the IOCTL to return status and result of the request.
> +
> +Request payload data must be allocated separately and is passed in via the
> +``payload.data`` and ``payload.length`` members. If a response is required,
> +the response buffer must be allocated by the caller and passed in via the
> +``response.data`` member. The ``response.length`` member must be set to the
> +capacity of this buffer, or if no response is required, zero. Upon
> +completion of the request, the call will write the response to the response
> +buffer (if its capacity allows it) and overwrite the length field with the
> +actual size of the response, in bytes.
> +
> +Additionally, if the request has a response, this should be indicated via
> +the request flags, as is done with in-kernel requests. Request flags can be
> +set via the ``flags`` member and the values correspond to the values found
> +in |ssam_request_flags|.
> +
> +Finally, the status of the request itself is returned in the ``status``
> +member (a negative value indicating failure). Note that failure indication
> +of the IOCTL is separated from failure indication of the request: The IOCTL
> +returns a negative status code if anything failed during setup of the
> +request (``-EFAULT``) or if the provided argument or any of its fields are
> +invalid (``-EINVAL``). In this case, the status value of the request
> +argument may be set, providing more detail on what went wrong (e.g.
> +``-ENOMEM`` for out-of-memory), but this value may also be zero. The IOCTL
> +will return with a zero status code in case the request has been set up,
> +submitted, and completed (i.e. handed back to user-space) successfully from
> +inside the IOCTL, but the request ``status`` member may still be negative in
> +case the actual execution of the request failed after it has been submitted.
> +
> +A full definition of the argument struct is provided below:
> +
> +.. kernel-doc:: drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
> +   :functions: ssam_dbg_request
> diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
> index 680fa621dc9f..e47b752f298c 100644
> --- a/Documentation/driver-api/surface_aggregator/clients/index.rst
> +++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
> @@ -7,4 +7,14 @@ Client Driver Documentation
>  This is the documentation for client drivers themselves. Refer to
>  :doc:`../client` for documentation on how to write client drivers.
>  
> -.. Place documentation for individual client drivers here.
> +.. toctree::
> +   :maxdepth: 1
> +
> +   dbgdev
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/drivers/misc/surface_aggregator/Kconfig b/drivers/misc/surface_aggregator/Kconfig
> index 4d6fc3cd18aa..e0a9bb37d178 100644
> --- a/drivers/misc/surface_aggregator/Kconfig
> +++ b/drivers/misc/surface_aggregator/Kconfig
> @@ -61,3 +61,5 @@ config SURFACE_AGGREGATOR_ERROR_INJECTION
>  	  transport and communication problems, such as invalid data sent to or
>  	  received from the EC, dropped data, and communication timeouts.
>  	  Intended for development and debugging.
> +
> +source "drivers/misc/surface_aggregator/clients/Kconfig"
> diff --git a/drivers/misc/surface_aggregator/Makefile b/drivers/misc/surface_aggregator/Makefile
> index 59041511c04b..acf42597e6bb 100644
> --- a/drivers/misc/surface_aggregator/Makefile
> +++ b/drivers/misc/surface_aggregator/Makefile
> @@ -4,6 +4,7 @@
>  CFLAGS_core.o = -I$(src)
>  
>  obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
> +obj-$(CONFIG_SURFACE_AGGREGATOR) += clients/
>  
>  surface_aggregator-objs := core.o
>  surface_aggregator-objs += ssh_parser.o
> diff --git a/drivers/misc/surface_aggregator/clients/Kconfig b/drivers/misc/surface_aggregator/clients/Kconfig
> new file mode 100644
> index 000000000000..dcaa0706074e
> --- /dev/null
> +++ b/drivers/misc/surface_aggregator/clients/Kconfig
> @@ -0,0 +1,18 @@
> +config SURFACE_AGGREGATOR_DEBUGFS
> +	tristate "Surface System Aggregator Module DebugFS interface"
> +	depends on SURFACE_AGGREGATOR
> +	depends on DEBUG_FS
> +	default n

default is n, no need to add it.

> +	help
> +	  Provides a DebugFS interface to the Surface System Aggregator Module
> +	  (SSAM) controller.
> +
> +	  This option provides a module (called surface_aggregator_debugfs),
> +	  that, when loaded, will add a client device (and its respective
> +	  driver) to the SSAM controller. Said client device manages a DebugFS
> +	  interface (/sys/kernel/debug/surface_aggregator/controller), which can
> +	  be used by user-space tools to directly communicate with the SSAM EC
> +	  by sending requests and receiving the correspondign responses.
> +
> +	  The provided interface is intended for debugging and development only,
> +	  and should not be used otherwise.
> diff --git a/drivers/misc/surface_aggregator/clients/Makefile b/drivers/misc/surface_aggregator/clients/Makefile
> new file mode 100644
> index 000000000000..c49b2a183d3d
> --- /dev/null
> +++ b/drivers/misc/surface_aggregator/clients/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +obj-$(CONFIG_SURFACE_AGGREGATOR_DEBUGFS)	+= surface_aggregator_debugfs.o
> diff --git a/drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c b/drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
> new file mode 100644
> index 000000000000..b96ecb7c153a
> --- /dev/null
> +++ b/drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Are you sure about -or-later?  I have to ask.

And no copyright line?

> +/*
> + * DebugFS interface for Surface System Aggregator Module (SSAM) controller
> + * access from user-space. Intended for debugging and development.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +
> +#define SSAM_DBG_DEVICE_NAME		"surface_aggregator_dbg"
> +#define SSAM_DBG_IF_VERSION		0x010000

kernel files/apis are not versioned, drop this please.

> +
> +/**
> + * struct ssam_debug_request - Controller request IOCTL argument.
> + * @target_category: Target category of the SAM request.
> + * @target_id:       Target ID of the SAM request.
> + * @command_id:      Command ID of the SAM request.
> + * @instance_id:     Instance ID of the SAM request.
> + * @flags:           SAM Request flags.
> + * @status:          Request status (output).
> + * @payload:         Request payload (input data).
> + * @payload.data:    Pointer to request payload data.
> + * @payload.length:  Length of request payload data (in bytes).
> + * @response:        Request response (output data).
> + * @response.data:   Pointer to response buffer.
> + * @response.length: On input: Capacity of response buffer (in bytes).
> + *                   On output: Length of request response (number of bytes
> + *                   in the buffer that are actually used).
> + */
> +struct ssam_dbg_request {
> +	__u8 target_category;
> +	__u8 target_id;
> +	__u8 command_id;
> +	__u8 instance_id;
> +	__u16 flags;
> +	__s16 status;
> +
> +	struct {
> +		const __u8 __user *data;
> +		__u16 length;
> +		__u8 __pad[6];
> +	} payload;
> +
> +	struct {
> +		__u8 __user *data;
> +		__u16 length;
> +		__u8 __pad[6];
> +	} response;
> +};
> +
> +#define SSAM_DBG_IOCTL_GETVERSION  _IOR(0xA5, 0, __u32)
> +#define SSAM_DBG_IOCTL_REQUEST     _IOWR(0xA5, 1, struct ssam_dbg_request)
> +
> +struct ssam_dbg_data {
> +	struct ssam_controller *ctrl;
> +	struct dentry *dentry_dir;
> +	struct dentry *dentry_dev;
> +};
> +
> +static int ssam_dbg_device_open(struct inode *inode, struct file *filp)
> +{
> +	filp->private_data = inode->i_private;
> +	return nonseekable_open(inode, filp);
> +}
> +
> +static long ssam_dbg_if_request(struct file *file, unsigned long arg)
> +{
> +	struct ssam_dbg_data *data = file->private_data;
> +	struct ssam_dbg_request __user *r;
> +	struct ssam_dbg_request rqst;
> +	struct ssam_request spec;
> +	struct ssam_response rsp;
> +	int status = 0, ret = 0, tmp;
> +
> +	r = (struct ssam_dbg_request __user *)arg;
> +	ret = copy_struct_from_user(&rqst, sizeof(rqst), r, sizeof(*r));
> +	if (ret)
> +		goto out;
> +
> +	// setup basic request fields
> +	spec.target_category = rqst.target_category;
> +	spec.target_id = rqst.target_id;
> +	spec.command_id = rqst.command_id;
> +	spec.instance_id = rqst.instance_id;
> +	spec.flags = rqst.flags;
> +	spec.length = rqst.payload.length;
> +	spec.payload = NULL;
> +
> +	rsp.capacity = rqst.response.length;
> +	rsp.length = 0;
> +	rsp.pointer = NULL;
> +
> +	// get request payload from user-space
> +	if (spec.length) {
> +		if (!rqst.payload.data) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		spec.payload = kzalloc(spec.length, GFP_KERNEL);
> +		if (!spec.payload) {
> +			status = -ENOMEM;
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		if (copy_from_user((void *)spec.payload, rqst.payload.data,
> +				   spec.length)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +	// allocate response buffer
> +	if (rsp.capacity) {
> +		if (!rqst.response.data) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		rsp.pointer = kzalloc(rsp.capacity, GFP_KERNEL);
> +		if (!rsp.pointer) {
> +			status = -ENOMEM;
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +	// perform request
> +	status = ssam_request_sync(data->ctrl, &spec, &rsp);
> +	if (status)
> +		goto out;
> +
> +	// copy response to user-space
> +	if (rsp.length) {
> +		if (copy_to_user(rqst.response.data, rsp.pointer, rsp.length)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	// always try to set response-length and status
> +	tmp = put_user(rsp.length, &r->response.length);
> +	if (!ret)
> +		ret = tmp;

Is that the correct error to return if put_user() fails?  Hint, I don't
think so...

> +
> +	tmp = put_user(status, &r->status);
> +	if (!ret)
> +		ret = tmp;
> +
> +	// cleanup
> +	kfree(spec.payload);
> +	kfree(rsp.pointer);
> +
> +	return ret;
> +}
> +
> +static long ssam_dbg_if_getversion(struct file *file, unsigned long arg)
> +{
> +	put_user(SSAM_DBG_IF_VERSION, (u32 __user *)arg);
> +	return 0;
> +}
> +
> +static long ssam_dbg_device_ioctl(struct file *file, unsigned int cmd,
> +				    unsigned long arg)
> +{
> +	switch (cmd) {
> +	case SSAM_DBG_IOCTL_GETVERSION:
> +		return ssam_dbg_if_getversion(file, arg);

Not needed, please drop.

> +
> +	case SSAM_DBG_IOCTL_REQUEST:
> +		return ssam_dbg_if_request(file, arg);
> +
> +	default:
> +		return -ENOIOCTLCMD;

Wrong error value.

> +	}
> +}
> +
> +const struct file_operations ssam_dbg_device_fops = {
> +	.owner          = THIS_MODULE,
> +	.open           = ssam_dbg_device_open,
> +	.unlocked_ioctl = ssam_dbg_device_ioctl,
> +	.compat_ioctl   = ssam_dbg_device_ioctl,
> +	.llseek         = noop_llseek,
> +};
> +
> +static int ssam_dbg_device_probe(struct platform_device *pdev)
> +{
> +	struct ssam_dbg_data *data;
> +	struct ssam_controller *ctrl;
> +	int status;
> +
> +	status = ssam_client_bind(&pdev->dev, &ctrl);
> +	if (status)
> +		return status == -ENXIO ? -EPROBE_DEFER : status;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ctrl = ctrl;
> +
> +	data->dentry_dir = debugfs_create_dir("surface_aggregator", NULL);
> +	if (IS_ERR(data->dentry_dir))
> +		return PTR_ERR(data->dentry_dir);

No need to check this, just keep moving.

> +
> +	data->dentry_dev = debugfs_create_file("controller", 0600,
> +					       data->dentry_dir, data,
> +					       &ssam_dbg_device_fops);

Why save this value at all?  No need to check it.

> +	if (IS_ERR(data->dentry_dev)) {
> +		debugfs_remove(data->dentry_dir);
> +		return PTR_ERR(data->dentry_dev);
> +	}

Listen, I'm all for doing whatever you want in debugfs, but why are you
doing random ioctls here?  Why not just read/write a file to do what you
need/want to do here instead?

And again, no versioning, that is never needed.

> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +}
> +
> +static int ssam_dbg_device_remove(struct platform_device *pdev)
> +{
> +	struct ssam_dbg_data *data = platform_get_drvdata(pdev);
> +
> +	debugfs_remove(data->dentry_dev);
> +	debugfs_remove(data->dentry_dir);

debugfs_remove_recursive() on the directory is all that is needed

> +
> +	return 0;
> +}
> +
> +static void ssam_dbg_device_release(struct device *dev)
> +{
> +	// nothing to do

That's a lie, and the old documentation would allow me to make fun of
you for trying to work around the kernel's error messages here.

But I'll be nice and just ask, why do you think it is ok to work around
a message that someone has spent a lot of time and energy to provide to
you, saying that you are doing something wrong, by ignoring that and
providing an empty function?  Not kind...

> +}
> +
> +static struct platform_device ssam_dbg_device = {
> +	.name = SSAM_DBG_DEVICE_NAME,
> +	.id = PLATFORM_DEVID_NONE,
> +	.dev.release = ssam_dbg_device_release,
> +};

Dynamic structures that are static are, well, wrong :)



> +
> +static struct platform_driver ssam_dbg_driver = {
> +	.probe = ssam_dbg_device_probe,
> +	.remove = ssam_dbg_device_remove,
> +	.driver = {
> +		.name = SSAM_DBG_DEVICE_NAME,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +
> +static int __init ssam_debug_init(void)
> +{
> +	int status;
> +
> +	status = platform_device_register(&ssam_dbg_device);
> +	if (status)
> +		return status;
> +
> +	status = platform_driver_register(&ssam_dbg_driver);
> +	if (status)
> +		platform_device_unregister(&ssam_dbg_device);
> +
> +	return status;
> +}
> +module_init(ssam_debug_init);

I appreciate the initiative by creating a fake platform device and
driver to bind to that device.  But I don't think any of it is needed at
all, you have made your work a lot harder than you needed to here.  This
whole file can be _much_ smaller and simpler and not abuse the kernel
apis so badly :)

thanks,

greg k-h
