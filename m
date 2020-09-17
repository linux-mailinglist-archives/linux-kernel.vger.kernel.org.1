Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5AD26E106
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgIQQpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgIQQns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:43:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAC022228;
        Thu, 17 Sep 2020 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600361027;
        bh=LtQoYKH78ooQee43ALdFzQqua82BqvzlozkWok33nrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHIVqgvawXL57kVUfA9rzAe1FiqotLiMKwtm6P7ChEVzjtWQqYNO1aHnhiAjC9zBi
         WoHvqqD3U851tgH8iE8sgymdNpDKrjmqsAezplFhpunpKgolzYg1ARHjAgWPzFv1+3
         khoRw3UmW3UK6Thl0GTcbPwmDqNV9OI1yTmRsL6E=
Date:   Thu, 17 Sep 2020 18:44:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org
Subject: Re: [PATCH v6 4/4] bus: mhi: Add userspace client interface driver
Message-ID: <20200917164419.GC721081@kroah.com>
References: <1600286167-4432-1-git-send-email-hemantk@codeaurora.org>
 <1600286167-4432-5-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600286167-4432-5-git-send-email-hemantk@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:56:07PM -0700, Hemant Kumar wrote:
> This MHI client driver allows userspace clients to transfer
> raw data between MHI device and host using standard file operations.
> Device file node is created with format
> 
> /dev/mhi_<controller_name>_<mhi_device_name>
> 
> Currently it supports LOOPBACK channel.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> ---
>  drivers/bus/mhi/Kconfig  |  13 +
>  drivers/bus/mhi/Makefile |   4 +
>  drivers/bus/mhi/uci.c    | 657 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 674 insertions(+)
>  create mode 100644 drivers/bus/mhi/uci.c
> 
> diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
> index 6a217ff..8aebe8b 100644
> --- a/drivers/bus/mhi/Kconfig
> +++ b/drivers/bus/mhi/Kconfig
> @@ -20,3 +20,16 @@ config MHI_BUS_DEBUG
>  	 Enable debugfs support for use with the MHI transport. Allows
>  	 reading and/or modifying some values within the MHI controller
>  	 for debug and test purposes.
> +
> +config MHI_UCI
> +       tristate "MHI UCI"
> +       depends on MHI_BUS
> +       help
> +	 MHI based userspace client interface driver is used for transferring
> +	 raw data between host and device using standard file operations from
> +	 userspace. Open, read, write, and close operations are supported
> +	 by this driver. Please check mhi_uci_match_table for all supported
> +	 channels that are exposed to userspace.
> +
> +	 To compile this driver as a module, choose M here: the module will be
> +	 called mhi_uci.
> diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
> index 19e6443..80feefb 100644
> --- a/drivers/bus/mhi/Makefile
> +++ b/drivers/bus/mhi/Makefile
> @@ -1,2 +1,6 @@
>  # core layer
>  obj-y += core/
> +
> +# MHI client
> +mhi_uci-y := uci.o
> +obj-$(CONFIG_MHI_UCI) += mhi_uci.o
> diff --git a/drivers/bus/mhi/uci.c b/drivers/bus/mhi/uci.c
> new file mode 100644
> index 0000000..d6758f2
> --- /dev/null
> +++ b/drivers/bus/mhi/uci.c
> @@ -0,0 +1,657 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.*/
> +
> +#include <linux/kernel.h>
> +#include <linux/mhi.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +
> +#define DEVICE_NAME "mhi"
> +#define MHI_UCI_DRIVER_NAME "mhi_uci"
> +#define MAX_UCI_MINORS (128)
> +
> +static DEFINE_IDR(uci_idr);
> +static DEFINE_MUTEX(uci_idr_mutex);
> +static struct class *uci_dev_class;
> +static int uci_dev_major;
> +
> +/**
> + * struct uci_chan - MHI channel for a uci device
> + * @wq: wait queue for reader/writer
> + * @lock: spin lock
> + * @pending: list of rx buffers userspace is waiting to read
> + * @cur_buf: current buffer userspace is reading
> + * @rx_size: size of the current rx buffer userspace is reading
> + */
> +struct uci_chan {
> +	wait_queue_head_t wq;
> +
> +	/* protects pending and cur_buf members in bh context */
> +	spinlock_t lock;
> +
> +	struct list_head pending;
> +	struct uci_buf *cur_buf;
> +	size_t rx_size;
> +};
> +
> +/**
> + * struct uci_buf - uci buffer
> + * @data: data buffer
> + * @len: length of data buffer
> + * @node: list node of the uci buffer
> + */
> +struct uci_buf {
> +	void *data;
> +	size_t len;
> +	struct list_head node;
> +};
> +
> +/**
> + * struct uci_dev - MHI uci device
> + * @minor: uci device node minor number
> + * @mhi_dev: associated mhi device object
> + * @chan: MHI channel name
> + * @lock: mutex lock
> + * @ul_chan: uplink uci channel object
> + * @dl_chan: downlink uci channel object
> + * @mtu: max tx buffer length
> + * @actual_mtu: maximum size of incoming buffer
> + * @open: open called for device node
> + * @enabled: uci device probed
> + * @ref_count: uci_dev reference count
> + */
> +struct uci_dev {
> +	unsigned int minor;
> +	struct mhi_device *mhi_dev;
> +	const char *chan;
> +
> +	/* protects uci_dev struct members */
> +	struct mutex lock;
> +
> +	struct uci_chan ul_chan;
> +	struct uci_chan dl_chan;
> +	size_t mtu;
> +	size_t actual_mtu;
> +	bool enabled;
> +	struct kref ref_count;
> +};
> +
> +static int mhi_queue_inbound(struct uci_dev *udev)
> +{
> +	struct mhi_device *mhi_dev = udev->mhi_dev;
> +	struct device *dev = &mhi_dev->dev;
> +	size_t mtu = udev->mtu;
> +	size_t actual_mtu = udev->actual_mtu;
> +	int nr_trbs, i, ret = -EIO;
> +	void *buf;
> +	struct uci_buf *uci_buf;
> +
> +	nr_trbs = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
> +
> +	for (i = 0; i < nr_trbs; i++) {
> +		buf = kmalloc(mtu, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +
> +		uci_buf = buf + actual_mtu;
> +		uci_buf->data = buf;
> +
> +		dev_dbg(dev, "Allocated buf %d of %d size %ld\n", i, nr_trbs,
> +			actual_mtu);
> +
> +		ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, actual_mtu,
> +				    MHI_EOT);
> +		if (ret) {
> +			kfree(buf);
> +			dev_err(dev, "Failed to queue buffer %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void mhi_uci_dev_release(struct kref *ref)
> +{
> +	struct uci_dev *udev =
> +		container_of(ref, struct uci_dev, ref_count);
> +
> +	mutex_destroy(&udev->lock);
> +
> +	dev_set_drvdata(&udev->mhi_dev->dev, NULL);
> +
> +	kfree(udev);
> +}
> +
> +static int mhi_uci_release(struct inode *inode, struct file *file)
> +{
> +	struct uci_dev *udev = file->private_data;
> +	struct uci_buf *itr, *tmp;
> +	struct uci_chan *uchan;
> +
> +	if (kref_read(&udev->ref_count) > 2)
> +		goto exit_uci_release;
> +
> +	if (udev->enabled)
> +		mhi_unprepare_from_transfer(udev->mhi_dev);
> +
> +	/* clean inbound channel */
> +	uchan = &udev->dl_chan;
> +
> +	spin_lock_bh(&uchan->lock);
> +	list_for_each_entry_safe(itr, tmp, &uchan->pending, node) {
> +		list_del(&itr->node);
> +		kfree(itr->data);
> +	}
> +
> +	if (uchan->cur_buf)
> +		kfree(uchan->cur_buf->data);
> +
> +	uchan->cur_buf = NULL;
> +	spin_unlock_bh(&uchan->lock);
> +
> +exit_uci_release:
> +	kref_put(&udev->ref_count, mhi_uci_dev_release);
> +
> +	return 0;
> +}
> +
> +static __poll_t mhi_uci_poll(struct file *file, poll_table *wait)
> +{
> +	struct uci_dev *udev = file->private_data;
> +	struct mhi_device *mhi_dev = udev->mhi_dev;
> +	struct device *dev = &mhi_dev->dev;
> +	struct uci_chan *uchan;
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &udev->dl_chan.wq, wait);
> +	poll_wait(file, &udev->ul_chan.wq, wait);
> +
> +	if (!udev->enabled) {
> +		mask = EPOLLERR;
> +	} else {
> +		uchan = &udev->dl_chan;
> +		spin_lock_bh(&uchan->lock);
> +		if (!list_empty(&uchan->pending) || uchan->cur_buf) {
> +			dev_dbg(dev, "Client can read from node\n");
> +			mask |= EPOLLIN | EPOLLRDNORM;
> +		}
> +		spin_unlock_bh(&uchan->lock);
> +	}
> +
> +	if (!udev->enabled) {
> +		mask |= EPOLLERR;
> +	} else if (mhi_get_no_free_descriptors(mhi_dev, DMA_TO_DEVICE) > 0) {
> +		dev_dbg(dev, "Client can write to node\n");
> +		mask |= EPOLLOUT | EPOLLWRNORM;
> +	}
> +
> +	dev_dbg(dev, "Client attempted to poll, returning mask 0x%x\n", mask);
> +
> +	return mask;
> +}
> +
> +static ssize_t mhi_uci_write(struct file *file,
> +			     const char __user *buf,
> +			     size_t count,
> +			     loff_t *offp)
> +{
> +	struct uci_dev *udev = file->private_data;
> +	struct mhi_device *mhi_dev = udev->mhi_dev;
> +	struct device *dev = &mhi_dev->dev;
> +	struct uci_chan *uchan = &udev->ul_chan;
> +	size_t bytes_xfered = 0;
> +	int ret, nr_avail = 0;
> +
> +	if (!buf || !count)
> +		return -EINVAL;
> +
> +	/* confirm channel is active */
> +	mutex_lock(&udev->lock);
> +	if (!udev->enabled) {
> +		ret = -ENODEV;
> +		goto err_mtx_unlock;
> +	}
> +
> +	dev_dbg(dev, "%s: to xfer: %lu bytes\n", __func__, count);
> +
> +	while (count) {
> +		size_t xfer_size;
> +		void *kbuf;
> +		enum mhi_flags flags;
> +
> +		mutex_unlock(&udev->lock);
> +		/* wait for free descriptors */
> +		ret = wait_event_interruptible(uchan->wq,
> +					       (!udev->enabled) ||
> +				(nr_avail = mhi_get_no_free_descriptors(mhi_dev,
> +					       DMA_TO_DEVICE)) > 0);
> +
> +		mutex_lock(&udev->lock);
> +		if (ret == -ERESTARTSYS) {
> +			dev_dbg(dev, "Exit signal caught for node\n");
> +			goto err_mtx_unlock;
> +		}
> +
> +		if (!udev->enabled) {
> +			ret = -ENODEV;
> +			goto err_mtx_unlock;
> +		}
> +
> +		xfer_size = min_t(size_t, count, udev->mtu);
> +		kbuf = kmalloc(xfer_size, GFP_KERNEL);
> +		if (!kbuf) {
> +			ret = -ENOMEM;
> +			goto err_mtx_unlock;
> +		}
> +
> +		ret = copy_from_user(kbuf, buf, xfer_size);
> +		if (ret) {
> +			kfree(kbuf);
> +			ret = -EFAULT;
> +			goto err_mtx_unlock;
> +		}
> +
> +		/* if ring is full after this force EOT */
> +		if (nr_avail > 1 && (count - xfer_size))
> +			flags = MHI_CHAIN;
> +		else
> +			flags = MHI_EOT;
> +
> +		if (udev->enabled)
> +			ret = mhi_queue_buf(mhi_dev, DMA_TO_DEVICE, kbuf,
> +					    xfer_size, flags);
> +		else
> +			ret = -ENODEV;
> +
> +		if (ret) {
> +			kfree(kbuf);
> +			goto err_mtx_unlock;
> +		}
> +
> +		bytes_xfered += xfer_size;
> +		count -= xfer_size;
> +		buf += xfer_size;
> +	}
> +
> +	mutex_unlock(&udev->lock);
> +	dev_dbg(dev, "%s: bytes xferred: %lu\n", __func__, bytes_xfered);
> +
> +	return bytes_xfered;
> +
> +err_mtx_unlock:
> +	mutex_unlock(&udev->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t mhi_uci_read(struct file *file,
> +			    char __user *buf,
> +			    size_t count,
> +			    loff_t *ppos)
> +{
> +	struct uci_dev *udev = file->private_data;
> +	struct mhi_device *mhi_dev = udev->mhi_dev;
> +	struct uci_chan *uchan = &udev->dl_chan;
> +	struct device *dev = &mhi_dev->dev;
> +	struct uci_buf *ubuf;
> +	char *ptr;
> +	size_t to_copy;
> +	int ret = 0;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	mutex_lock(&udev->lock);
> +	/* confirm channel is active */
> +	if (!udev->enabled) {
> +		ret = -ENODEV;
> +		goto err_mtx_unlock;
> +	}
> +
> +	spin_lock_bh(&uchan->lock);
> +	/* No data available to read, wait */
> +	if (!uchan->cur_buf && list_empty(&uchan->pending)) {
> +		dev_dbg(dev, "No data available to read waiting\n");
> +
> +		spin_unlock_bh(&uchan->lock);
> +		mutex_unlock(&udev->lock);
> +		ret = wait_event_interruptible(uchan->wq,
> +					       (!udev->enabled ||
> +					      !list_empty(&uchan->pending)));
> +
> +		mutex_lock(&udev->lock);
> +		if (ret == -ERESTARTSYS) {
> +			dev_dbg(dev, "Exit signal caught for node\n");
> +			goto err_mtx_unlock;
> +		}
> +
> +		if (!udev->enabled) {
> +			ret = -ENODEV;
> +			goto err_mtx_unlock;
> +		}
> +		spin_lock_bh(&uchan->lock);
> +	}
> +
> +	/* new read, get the next descriptor from the list */
> +	if (!uchan->cur_buf) {
> +		ubuf = list_first_entry_or_null(&uchan->pending,
> +						struct uci_buf, node);
> +		if (!ubuf) {
> +			ret = -EIO;
> +			goto err_spin_unlock;
> +		}
> +
> +		list_del(&ubuf->node);
> +		uchan->cur_buf = ubuf;
> +		uchan->rx_size = ubuf->len;
> +		dev_dbg(dev, "Got pkt of size: %zu\n", uchan->rx_size);
> +	}
> +
> +	ubuf = uchan->cur_buf;
> +
> +	/* Copy the buffer to user space */
> +	to_copy = min_t(size_t, count, uchan->rx_size);
> +	ptr = ubuf->data + (ubuf->len - uchan->rx_size);
> +	spin_unlock_bh(&uchan->lock);
> +
> +	ret = copy_to_user(buf, ptr, to_copy);
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto err_mtx_unlock;
> +	}
> +
> +	spin_lock_bh(&uchan->lock);
> +
> +	dev_dbg(dev, "Copied %lu of %lu bytes\n", to_copy, uchan->rx_size);
> +	uchan->rx_size -= to_copy;
> +
> +	/* we finished with this buffer, queue it back to hardware */
> +	if (!uchan->rx_size) {
> +		uchan->cur_buf = NULL;
> +
> +		if (udev->enabled)
> +			ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE,
> +					    ubuf->data,
> +					    udev->actual_mtu, MHI_EOT);
> +		else
> +			ret = -ENODEV;
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to recycle element: %d\n", ret);
> +			kfree(ubuf->data);
> +			goto err_spin_unlock;
> +		}
> +	}
> +	spin_unlock_bh(&uchan->lock);
> +	mutex_unlock(&udev->lock);
> +
> +	dev_dbg(dev, "%s: Returning %lu bytes\n", __func__, to_copy);
> +
> +	return to_copy;
> +
> +err_spin_unlock:
> +	spin_unlock_bh(&uchan->lock);
> +err_mtx_unlock:
> +	mutex_unlock(&udev->lock);
> +	return ret;
> +}
> +
> +static int mhi_uci_open(struct inode *inode, struct file *filp)
> +{
> +	struct uci_dev *udev = NULL;
> +	unsigned int minor = iminor(inode);
> +	int ret = -EIO;
> +	struct uci_buf *buf_itr, *tmp;
> +	struct uci_chan *dl_chan;
> +	struct mhi_device *mhi_dev;
> +	struct device *dev;
> +
> +	mutex_lock(&uci_idr_mutex);
> +	udev = idr_find(&uci_idr, minor);
> +	mutex_unlock(&uci_idr_mutex);
> +	if (!udev) {
> +		pr_err("uci dev: minor %d not found\n", minor);

Don't spam the kernel log for things that users can do :(

> +		ret = -ENODEV;
> +		goto error_no_dev;
> +	}
> +
> +	kref_get(&udev->ref_count);

Why grab a reference?  What does that help with?

> +
> +	mhi_dev = udev->mhi_dev;
> +	dev = &mhi_dev->dev;
> +
> +	mutex_lock(&udev->lock);
> +	if (kref_read(&udev->ref_count) > 2) {
> +		dev_dbg(dev, "Node already opened\n");

Nope, this is NOT doing what you think it is doing.

I told you before, do not try to keep a device node from being opened
multiple times, as it will always fail (think about passing file handles
around between programs...)

If userspace wants to do this, it will do it.  If your driver can't
handle that, that's fine, userspace will learn not to do that.  But the
kernel can not prevent this from happening.

Also note that reading a kref value is a HUGE sign that the code is
incorrect, you should never care about the value of a reference.  Maybe
if it is 0, but that's a special case...

Anyway, given that you ignored my previous review comments here, I'm
loath to keep reviewing this patch series.  Please get others to review
it first before sending it back as I don't like being the only one doing
this type of work...

thanks,

greg k-h
