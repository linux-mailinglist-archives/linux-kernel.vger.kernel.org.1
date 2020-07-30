Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D1C232A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 05:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgG3DGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 23:06:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13053 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgG3DGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:06:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596078390; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=LAmZ0bB7CCLwxyHg+/MvuNv5ChyAl2B4evfUsXrcpYI=; b=oevA0LQLcDL0V3pfEscguVYEbXSCWvHbuxFRUEDk+DEmBDlwpsns/aGlj7cOOsApxvarhAdW
 vnaL9hqjlvoeGnT+/D5PmSiABDnxPI+ajxMR8Ip788h+CUvVeSIQSSXFBkn7TE+FjglVab56
 +4QQlOr6xs9ayhMDzba64RQP5Tc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5f2239261db0b33fd8e8e16a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 03:06:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 797AFC43391; Thu, 30 Jul 2020 03:06:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D38CBC433C6;
        Thu, 30 Jul 2020 03:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D38CBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v4 4/4] bus: mhi: clients: Add userspace client interface
 driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
References: <1595994395-20143-1-git-send-email-hemantk@codeaurora.org>
 <1595994395-20143-5-git-send-email-hemantk@codeaurora.org>
 <20200729061754.GA461347@kroah.com>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <07b409d2-eedc-9016-2cc9-6c153e3c0982@codeaurora.org>
Date:   Wed, 29 Jul 2020 20:06:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200729061754.GA461347@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 7/28/20 11:17 PM, Greg KH wrote:
> On Tue, Jul 28, 2020 at 08:46:35PM -0700, Hemant Kumar wrote:
>> This MHI client driver allows userspace clients to transfer
>> raw data between MHI device and host using standard file operations.
>> Device file node is created with format
>>
>> /dev/mhi_<controller_name>_<mhi_device_name>
>>
>> Currently it supports LOOPBACK channel.
>>
>> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
>> ---
>>   drivers/bus/mhi/Kconfig          |   6 +
>>   drivers/bus/mhi/Makefile         |   1 +
>>   drivers/bus/mhi/clients/Kconfig  |  15 +
>>   drivers/bus/mhi/clients/Makefile |   3 +
>>   drivers/bus/mhi/clients/uci.c    | 690 +++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 715 insertions(+)
>>   create mode 100644 drivers/bus/mhi/clients/Kconfig
>>   create mode 100644 drivers/bus/mhi/clients/Makefile
>>   create mode 100644 drivers/bus/mhi/clients/uci.c
>>
>> diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
>> index 6a217ff..927c392 100644
>> --- a/drivers/bus/mhi/Kconfig
>> +++ b/drivers/bus/mhi/Kconfig
>> @@ -20,3 +20,9 @@ config MHI_BUS_DEBUG
>>   	 Enable debugfs support for use with the MHI transport. Allows
>>   	 reading and/or modifying some values within the MHI controller
>>   	 for debug and test purposes.
>> +
>> +if MHI_BUS
>> +
>> +source "drivers/bus/mhi/clients/Kconfig"
>> +
>> +endif
>> diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
>> index 19e6443..48f6028 100644
>> --- a/drivers/bus/mhi/Makefile
>> +++ b/drivers/bus/mhi/Makefile
>> @@ -1,2 +1,3 @@
>>   # core layer
>>   obj-y += core/
>> +obj-y += clients/
>> diff --git a/drivers/bus/mhi/clients/Kconfig b/drivers/bus/mhi/clients/Kconfig
>> new file mode 100644
>> index 0000000..37aaf51
>> --- /dev/null
>> +++ b/drivers/bus/mhi/clients/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +menu "MHI clients support"
>> +
>> +config MHI_UCI
>> +       tristate "MHI UCI"
>> +       depends on MHI_BUS
>> +       help
>> +	 MHI based userspace client interface driver is used for transferring
>> +	 raw data between host and device using standard file operations from
>> +	 userspace. Open, read, write, and close operations are supported
>> +	 by this driver. Please check mhi_uci_match_table for all supported
>> +	 channels that are exposed to userspace.
>> +
>> +endmenu
>> diff --git a/drivers/bus/mhi/clients/Makefile b/drivers/bus/mhi/clients/Makefile
>> new file mode 100644
>> index 0000000..cd34282
>> --- /dev/null
>> +++ b/drivers/bus/mhi/clients/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +obj-$(CONFIG_MHI_UCI) += uci.o
>> diff --git a/drivers/bus/mhi/clients/uci.c b/drivers/bus/mhi/clients/uci.c
>> new file mode 100644
>> index 0000000..3ddf017
>> --- /dev/null
>> +++ b/drivers/bus/mhi/clients/uci.c
>> @@ -0,0 +1,690 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.*/
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/mhi.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/poll.h>
>> +
>> +#define DEVICE_NAME "mhi"
>> +#define MHI_UCI_DRIVER_NAME "mhi_uci"
>> +#define MAX_UCI_DEVICES (64)
>> +
>> +/**
>> + * struct uci_chan - MHI channel for a uci device
>> + * @wq: wait queue for reader/writer
>> + * @lock: spin lock
>> + * @pending: list of rx buffers userspace is waiting to read
>> + * @cur_buf: current buffer userspace is reading
>> + * @rx_size: size of the current rx buffer userspace is reading
>> + */
>> +struct uci_chan {
>> +	wait_queue_head_t wq;
>> +
>> +	/* protects pending and cur_buf members */
>> +	spinlock_t lock;
>> +
>> +	struct list_head pending;
>> +	struct uci_buf *cur_buf;
>> +	size_t rx_size;
>> +};
>> +
>> +/**
>> + * struct uci_buf - uci buffer
>> + * @data: data buffer
>> + * @len: length of data buffer
>> + * @node: list node of the uci buffer
>> + */
>> +struct uci_buf {
>> +	void *data;
>> +	size_t len;
>> +	struct list_head node;
>> +};
>> +
>> +/**
>> + * struct mhi_uci_drv - MHI uci driver
>> + * @head: list head of a uci device nodes
>> + * @lock: mutex lock
>> + * @class: current buffer userspace is reading
>> + * @major: major number for uci driver
>> + * @devt: dev_t object to hold major and minor info
>> + */
>> +struct mhi_uci_drv {
>> +	struct list_head head;
>> +
>> +	/* protects mhi_uci_drv struct members */
>> +	struct mutex lock;
>> +
>> +	struct class *class;
>> +	int major;
>> +	dev_t devt;
>> +};
> 
> So this is just a single static structure for some "global" variables
> for the driver?  Why make it a structure at all?
> 
> And why have a local list of all devices, doesn't the driver core give
> that to you already?  You shouldn't need that if you are doing things
> properly...Done, will get rid of this struct and use static global variable for 
major number, class and idr
> 
>> +
>> +/**
>> + * struct uci_dev - MHI uci device
>> + * @node: uci device node
>> + * @devt: dev_t object to hold major and minor info
>> + * @dev: uci device object
>> + * @mhi_dev: associated mhi device object
>> + * @chan: MHI channel name
>> + * @lock: mutex lock
>> + * @ul_chan: uplink uci channel object
>> + * @dl_chan: downlink uci channel object
>> + * @mtu: max tx buffer length
>> + * @actual_mtu: maximum size of incoming buffer
>> + * @ref_count: uci_dev reference count
>> + * @enabled: uci device node accessibility
>> + */
>> +struct uci_dev {
>> +	struct list_head node;
>> +	dev_t devt;
>> +	struct device *dev;
> 
> This points to what?  Why isn't this structure a 'struct device' and
> then just point to the parent passed to it?
This dev stores the dev pointer returned by device_create() in probe().
> 
>> +	struct mhi_device *mhi_dev;
>> +	const char *chan;
>> +
>> +	/* protects uci_dev struct members */
>> +	struct mutex lock;
>> +
>> +	struct uci_chan ul_chan;
>> +	struct uci_chan dl_chan;
>> +	size_t mtu;
>> +	size_t actual_mtu;
>> +	int ref_count;
> 
> Huh?  What is this used for?  We do have proper refcount structures/apis
> if you really want that, do not roll your own.
Done, going to use kref.
> 
>> +	bool enabled;
>> +};
>> +
>> +static DECLARE_BITMAP(uci_minors, MAX_UCI_DEVICES);
> 
> Why is this needed?  Why not use an idr/ida structure instead?
Done.
> 
>> +static struct mhi_uci_drv uci_drv;
> 
> Here's that single device list :(
Getting rid of this and use idr_alloc/idr_find
> 
> 
>> +
>> +static int mhi_queue_inbound(struct uci_dev *uci_dev)
>> +{
>> +	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
>> +	struct device *dev = &mhi_dev->dev;
>> +	size_t mtu = uci_dev->mtu;
>> +	size_t actual_mtu = uci_dev->actual_mtu;
>> +	int nr_trbs, i, ret = -EIO;
>> +	void *buf;
>> +	struct uci_buf *uci_buf;
>> +
>> +	nr_trbs = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
>> +
>> +	for (i = 0; i < nr_trbs; i++) {
>> +		buf = kmalloc(mtu, GFP_KERNEL);
>> +		if (!buf)
>> +			return -ENOMEM;
>> +
>> +		uci_buf = buf + actual_mtu;
>> +		uci_buf->data = buf;
>> +
>> +		dev_dbg(dev, "Allocated buf %d of %d size %ld\n", i, nr_trbs,
>> +			actual_mtu);
>> +
>> +		ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, actual_mtu,
>> +				    MHI_EOT);
>> +		if (ret) {
>> +			kfree(buf);
>> +			dev_err(dev, "Failed to queue buffer %d\n", i);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int mhi_uci_release(struct inode *inode, struct file *file)
>> +{
>> +	struct uci_dev *uci_dev = file->private_data;
>> +
>> +	mutex_lock(&uci_dev->lock);
>> +	uci_dev->ref_count--;
>> +	if (!uci_dev->ref_count) {
>> +		struct uci_buf *itr, *tmp;
>> +		struct uci_chan *uci_chan;
>> +
>> +		if (uci_dev->enabled)
>> +			mhi_unprepare_from_transfer(uci_dev->mhi_dev);
>> +
>> +		/* clean inbound channel */
>> +		uci_chan = &uci_dev->dl_chan;
>> +
>> +		spin_lock_bh(&uci_chan->lock);
>> +		list_for_each_entry_safe(itr, tmp, &uci_chan->pending, node) {
>> +			list_del(&itr->node);
>> +			kfree(itr->data);
>> +		}
>> +
>> +		if (uci_chan->cur_buf)
>> +			kfree(uci_chan->cur_buf->data);
>> +
>> +		uci_chan->cur_buf = NULL;
>> +		spin_unlock_bh(&uci_chan->lock);
>> +
>> +		if (!uci_dev->enabled) {
>> +			mutex_unlock(&uci_dev->lock);
>> +			mutex_destroy(&uci_dev->lock);
>> +			clear_bit(MINOR(uci_dev->devt), uci_minors);
>> +			kfree(uci_dev);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&uci_dev->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static __poll_t mhi_uci_poll(struct file *file, poll_table *wait)
>> +{
>> +	struct uci_dev *uci_dev = file->private_data;
>> +	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
>> +	struct device *dev = &mhi_dev->dev;
>> +	struct uci_chan *uci_chan;
>> +	__poll_t mask = 0;
>> +
>> +	poll_wait(file, &uci_dev->dl_chan.wq, wait);
>> +	poll_wait(file, &uci_dev->ul_chan.wq, wait);
>> +
>> +	if (!uci_dev->enabled) {
>> +		mask = EPOLLERR;
>> +	} else {
>> +		uci_chan = &uci_dev->dl_chan;
>> +		spin_lock_bh(&uci_chan->lock);
>> +		if (!list_empty(&uci_chan->pending) || uci_chan->cur_buf) {
>> +			dev_dbg(dev, "Client can read from node\n");
>> +			mask |= EPOLLIN | EPOLLRDNORM;
>> +		}
>> +		spin_unlock_bh(&uci_chan->lock);
>> +	}
>> +
>> +	if (!uci_dev->enabled) {
>> +		mask |= EPOLLERR;
>> +	} else if (mhi_get_no_free_descriptors(mhi_dev, DMA_TO_DEVICE) > 0) {
>> +		dev_dbg(dev, "Client can write to node\n");
>> +		mask |= EPOLLOUT | EPOLLWRNORM;
>> +	}
>> +
>> +	dev_dbg(dev, "Client attempted to poll, returning mask 0x%x\n", mask);
>> +
>> +	return mask;
>> +}
>> +
>> +static ssize_t mhi_uci_write(struct file *file,
>> +			     const char __user *buf,
>> +			     size_t count,
>> +			     loff_t *offp)
>> +{
>> +	struct uci_dev *uci_dev = file->private_data;
>> +	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
>> +	struct device *dev = &mhi_dev->dev;
>> +	struct uci_chan *uci_chan = &uci_dev->ul_chan;
>> +	size_t bytes_xfered = 0;
>> +	int ret, nr_avail = 0;
>> +
>> +	if (!buf || !count)
>> +		return -EINVAL;
>> +
>> +	/* confirm channel is active */
>> +	mutex_lock(&uci_dev->lock);
>> +	if (!uci_dev->enabled) {
>> +		ret = -ENODEV;
>> +		goto err_mtx_unlock;
>> +	}
>> +
>> +	dev_dbg(dev, "%s: to xfer: %lu bytes\n", __func__, count);
>> +
>> +	while (count) {
>> +		size_t xfer_size;
>> +		void *kbuf;
>> +		enum mhi_flags flags;
>> +
>> +		mutex_unlock(&uci_dev->lock);
>> +		/* wait for free descriptors */
>> +		ret = wait_event_interruptible(uci_chan->wq,
>> +					       (!uci_dev->enabled) ||
>> +				(nr_avail = mhi_get_no_free_descriptors(mhi_dev,
>> +					       DMA_TO_DEVICE)) > 0);
> 
> Can this ever timeout?
As soon as we have free descriptor available in mhi_ul_xfer_cb, this 
would get unblocked. if write completion never comes for all queued
descriptor then it would be blocked for ever, but interruptible. But not 
getting tx completion is unexpected and if happens there is a bug on MH 
I device side which needs to be fixed. I am not sure what timeout value 
would be a good timeout value.
> 
> 
>> +
>> +		mutex_lock(&uci_dev->lock);
>> +		if (ret == -ERESTARTSYS) {
>> +			dev_dbg(dev, "Exit signal caught for node\n");
>> +			goto err_mtx_unlock;
>> +		}
>> +
>> +		if (!uci_dev->enabled) {
>> +			ret = -ENODEV;
>> +			goto err_mtx_unlock;
>> +		}
>> +
>> +		xfer_size = min_t(size_t, count, uci_dev->mtu);
>> +		kbuf = kmalloc(xfer_size, GFP_KERNEL);
>> +		if (!kbuf) {
>> +			ret = -ENOMEM;
>> +			goto err_mtx_unlock;
>> +		}
>> +
>> +		ret = copy_from_user(kbuf, buf, xfer_size);
>> +		if (unlikely(ret)) {
> 
> Only ever use likely/unlikely if you can test the difference.  Can you
> here?  Otherwise the compiler/cpu will almost always do it better for
> you.
Done. Will get rid of unlikely(), idea was copy_from_user() would most 
likely result into success.
> 
>> +			kfree(kbuf);
>> +			goto err_mtx_unlock;
> 
> Wrong error code sent to userspace :(
Done. will return -EFAULT
> 
>> +		}
>> +
>> +		/* if ring is full after this force EOT */
>> +		if (nr_avail > 1 && (count - xfer_size))
>> +			flags = MHI_CHAIN;
>> +		else
>> +			flags = MHI_EOT;
>> +
>> +		if (uci_dev->enabled)
>> +			ret = mhi_queue_buf(mhi_dev, DMA_TO_DEVICE, kbuf,
>> +					    xfer_size, flags);
>> +		else
>> +			ret = -ENODEV;
>> +
>> +		if (ret) {
>> +			kfree(kbuf);
>> +			goto err_mtx_unlock;
>> +		}
>> +
>> +		bytes_xfered += xfer_size;
>> +		count -= xfer_size;
>> +		buf += xfer_size;
>> +	}
>> +
>> +	mutex_unlock(&uci_dev->lock);
>> +	dev_dbg(dev, "%s: bytes xferred: %lu\n", __func__, bytes_xfered);
>> +
>> +	return bytes_xfered;
>> +
>> +err_mtx_unlock:
>> +	mutex_unlock(&uci_dev->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t mhi_uci_read(struct file *file,
>> +			    char __user *buf,
>> +			    size_t count,
>> +			    loff_t *ppos)
>> +{
>> +	struct uci_dev *uci_dev = file->private_data;
>> +	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
>> +	struct uci_chan *uci_chan = &uci_dev->dl_chan;
>> +	struct device *dev = &mhi_dev->dev;
>> +	struct uci_buf *uci_buf;
>> +	char *ptr;
>> +	size_t to_copy;
>> +	int ret = 0;
>> +
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&uci_dev->lock);
>> +	/* confirm channel is active */
>> +	if (!uci_dev->enabled) {
>> +		ret = -ENODEV;
>> +		goto err_mtx_unlock;
>> +	}
>> +
>> +	spin_lock_bh(&uci_chan->lock);
>> +	/* No data available to read, wait */
>> +	if (!uci_chan->cur_buf && list_empty(&uci_chan->pending)) {
>> +		dev_dbg(dev, "No data available to read waiting\n");
>> +
>> +		spin_unlock_bh(&uci_chan->lock);
>> +		mutex_unlock(&uci_dev->lock);
>> +		ret = wait_event_interruptible(uci_chan->wq,
>> +					       (!uci_dev->enabled ||
>> +					      !list_empty(&uci_chan->pending)));
> 
> any chance to timeout?
For read() we want to wait until a rx buffer gets filled up. Timeout is 
not going to work for read() use case. There is a possibility of 
multiple tx before rx can happen.
> 
>> +
>> +		mutex_lock(&uci_dev->lock);
>> +		if (ret == -ERESTARTSYS) {
>> +			dev_dbg(dev, "Exit signal caught for node\n");
>> +			goto err_mtx_unlock;
>> +		}
>> +
>> +		if (!uci_dev->enabled) {
>> +			ret = -ENODEV;
>> +			goto err_mtx_unlock;
>> +		}
>> +		spin_lock_bh(&uci_chan->lock);
>> +	}
>> +
>> +	/* new read, get the next descriptor from the list */
>> +	if (!uci_chan->cur_buf) {
>> +		uci_buf = list_first_entry_or_null(&uci_chan->pending,
>> +						   struct uci_buf, node);
>> +		if (unlikely(!uci_buf)) {
> 
> Again, prove it otherwise do not use these markings.
Done.
> 
>> +			ret = -EIO;
>> +			goto err_spin_unlock;
>> +		}
>> +
>> +		list_del(&uci_buf->node);
>> +		uci_chan->cur_buf = uci_buf;
>> +		uci_chan->rx_size = uci_buf->len;
>> +		dev_dbg(dev, "Got pkt of size: %zu\n", uci_chan->rx_size);
>> +	}
>> +
>> +	uci_buf = uci_chan->cur_buf;
>> +
>> +	/* Copy the buffer to user space */
>> +	to_copy = min_t(size_t, count, uci_chan->rx_size);
>> +	ptr = uci_buf->data + (uci_buf->len - uci_chan->rx_size);
>> +	spin_unlock_bh(&uci_chan->lock);
>> +
>> +	ret = copy_to_user(buf, ptr, to_copy);
>> +	if (ret)
>> +		goto err_mtx_unlock;
> 
> You forgot to set the proper error value here :(
Done, will return -EFAULT
> 
>> +
>> +	spin_lock_bh(&uci_chan->lock);
>> +
>> +	dev_dbg(dev, "Copied %lu of %lu bytes\n", to_copy, uci_chan->rx_size);
>> +	uci_chan->rx_size -= to_copy;
>> +
>> +	/* we finished with this buffer, queue it back to hardware */
>> +	if (!uci_chan->rx_size) {
>> +		uci_chan->cur_buf = NULL;
>> +
>> +		if (uci_dev->enabled)
>> +			ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE,
>> +					    uci_buf->data,
>> +					    uci_dev->actual_mtu, MHI_EOT);
>> +		else
>> +			ret = -ENODEV;
>> +
>> +		if (ret) {
>> +			dev_err(dev, "Failed to recycle element\n");
>> +			kfree(uci_buf->data);
>> +			goto err_spin_unlock;
>> +		}
>> +	}
>> +	spin_unlock_bh(&uci_chan->lock);
>> +	mutex_unlock(&uci_dev->lock);
>> +
>> +	dev_dbg(dev, "%s: Returning %lu bytes\n", __func__, to_copy);
>> +
>> +	return to_copy;
>> +
>> +err_spin_unlock:
>> +	spin_unlock_bh(&uci_chan->lock);
>> +err_mtx_unlock:
>> +	mutex_unlock(&uci_dev->lock);
>> +	return ret;
>> +}
>> +
>> +static int mhi_uci_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct uci_dev *uci_dev = NULL, *tmp_dev;
>> +	int ret = -EIO;
>> +	struct uci_buf *buf_itr, *tmp;
>> +	struct uci_chan *dl_chan;
>> +	struct mhi_device *mhi_dev;
>> +	struct device *dev;
>> +
>> +	mutex_lock(&uci_drv.lock);
>> +	list_for_each_entry(tmp_dev, &uci_drv.head, node) {
>> +		if (tmp_dev->devt == inode->i_rdev) {
>> +			uci_dev = tmp_dev;
> 
> Really?  There's no other way to look this up?
Planning to use idr_find() here.
> 
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&uci_drv.lock);
>> +
>> +	/* could not find a minor node */
>> +	if (!uci_dev) {
>> +		pr_err("Error finding uci device\n");
>> +		ret = -ENODEV;
>> +		goto error_exit;
>> +	}
>> +
>> +	mhi_dev = uci_dev->mhi_dev;
>> +	dev = &mhi_dev->dev;
>> +
>> +	mutex_lock(&uci_dev->lock);
>> +	if (!uci_dev->enabled) {
>> +		dev_info(dev, "Node exist, but not in active state!\n");
>> +		goto error_open_chan;
>> +	}
>> +
>> +	uci_dev->ref_count++;
>> +
>> +	dev_dbg(dev, "Node open, ref counts %u\n", uci_dev->ref_count);
>> +
>> +	if (uci_dev->ref_count == 1) {
>> +		dev_dbg(dev, "Starting channel\n");
>> +		ret = mhi_prepare_for_transfer(uci_dev->mhi_dev);
>> +		if (ret) {
>> +			dev_err(dev, "Error starting transfer channels\n");
>> +			uci_dev->ref_count--;
>> +			goto error_open_chan;
>> +		}
>> +
>> +		ret = mhi_queue_inbound(uci_dev);
>> +		if (ret)
>> +			goto error_rx_queue;
>> +	}
>> +
>> +	filp->private_data = uci_dev;
>> +	mutex_unlock(&uci_dev->lock);
>> +
>> +	return 0;
>> +
>> +error_rx_queue:
>> +	uci_dev->ref_count--;
>> +	dl_chan = &uci_dev->dl_chan;
>> +	mhi_unprepare_from_transfer(uci_dev->mhi_dev);
>> +	list_for_each_entry_safe(buf_itr, tmp, &dl_chan->pending, node) {
>> +		list_del(&buf_itr->node);
>> +		kfree(buf_itr->data);
>> +	}
>> +error_open_chan:
>> +	mutex_unlock(&uci_dev->lock);
>> +
>> +error_exit:
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations mhidev_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = mhi_uci_open,
>> +	.release = mhi_uci_release,
>> +	.read = mhi_uci_read,
>> +	.write = mhi_uci_write,
>> +	.poll = mhi_uci_poll,
>> +};
>> +
>> +static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
>> +			   struct mhi_result *mhi_result)
>> +{
>> +	struct uci_dev *uci_dev = dev_get_drvdata(&mhi_dev->dev);
>> +	struct uci_chan *uci_chan = &uci_dev->ul_chan;
>> +	struct device *dev = &mhi_dev->dev;
>> +
>> +	dev_dbg(dev, "status: %d xfer_len: %zu\n",
>> +		mhi_result->transaction_status, mhi_result->bytes_xferd);
>> +
>> +	kfree(mhi_result->buf_addr);
>> +
>> +	if (!mhi_result->transaction_status)
>> +		wake_up(&uci_chan->wq);
>> +}
>> +
>> +static void mhi_dl_xfer_cb(struct mhi_device *mhi_dev,
>> +			   struct mhi_result *mhi_result)
>> +{
>> +	struct uci_dev *uci_dev = dev_get_drvdata(&mhi_dev->dev);
>> +	struct uci_chan *uci_chan = &uci_dev->dl_chan;
>> +	struct device *dev = &mhi_dev->dev;
>> +	struct uci_buf *buf;
>> +
>> +	dev_dbg(dev, "status: %d receive_len: %zu\n",
>> +		mhi_result->transaction_status, mhi_result->bytes_xferd);
>> +
>> +	if (mhi_result->transaction_status == -ENOTCONN) {
>> +		kfree(mhi_result->buf_addr);
>> +		return;
>> +	}
>> +
>> +	spin_lock_bh(&uci_chan->lock);
>> +	buf = mhi_result->buf_addr + uci_dev->actual_mtu;
>> +	buf->data = mhi_result->buf_addr;
>> +	buf->len = mhi_result->bytes_xferd;
>> +	list_add_tail(&buf->node, &uci_chan->pending);
>> +	spin_unlock_bh(&uci_chan->lock);
>> +
>> +	wake_up(&uci_chan->wq);
>> +}
>> +
>> +static int mhi_uci_probe(struct mhi_device *mhi_dev,
>> +			 const struct mhi_device_id *id)
>> +{
>> +	struct uci_dev *uci_dev;
>> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>> +	struct device *dev = &mhi_dev->dev;
>> +	int minor;
>> +	int dir;
>> +
>> +	uci_dev = kzalloc(sizeof(*uci_dev), GFP_KERNEL);
>> +	if (!uci_dev)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&uci_dev->lock);
>> +	uci_dev->mhi_dev = mhi_dev;
>> +
>> +	mutex_lock(&uci_dev->lock);
>> +
>> +	mutex_lock(&uci_drv.lock);
>> +	minor = find_first_zero_bit(uci_minors, MAX_UCI_DEVICES);
>> +	if (minor >= MAX_UCI_DEVICES) {
>> +		mutex_unlock(&uci_drv.lock);
>> +		mutex_unlock(&uci_dev->lock);
>> +		kfree(uci_dev);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	/* create device file node /dev/mhi_<cntrl_dev_name>_<mhi_dev_name> */
>> +	uci_dev->devt = MKDEV(uci_drv.major, minor);
>> +	uci_dev->dev = device_create(uci_drv.class, &mhi_dev->dev,
>> +				     uci_dev->devt, uci_dev,
>> +				     DEVICE_NAME "_%s_%s",
>> +				     dev_name(mhi_cntrl->cntrl_dev),
>> +				     mhi_dev->name);
> 
> No error checking if device_create() worked or not?
> 
> :(
Done, this is the API which is storing uci_dev->dev.
> 
> 
>> +	set_bit(minor, uci_minors);
>> +
>> +	for (dir = 0; dir < 2; dir++) {
>> +		struct uci_chan *uci_chan = (dir) ?
>> +			&uci_dev->ul_chan : &uci_dev->dl_chan;
>> +		spin_lock_init(&uci_chan->lock);
>> +		init_waitqueue_head(&uci_chan->wq);
>> +		INIT_LIST_HEAD(&uci_chan->pending);
>> +	}
>> +
>> +	uci_dev->mtu = min_t(size_t, id->driver_data, MHI_MAX_MTU);
>> +	uci_dev->actual_mtu = uci_dev->mtu - sizeof(struct uci_buf);
>> +	dev_set_drvdata(&mhi_dev->dev, uci_dev);
>> +	uci_dev->enabled = true;
>> +
>> +	list_add(&uci_dev->node, &uci_drv.head);
>> +	mutex_unlock(&uci_drv.lock);
>> +
>> +	mutex_unlock(&uci_dev->lock);
>> +
>> +	dev_info(dev, "successfully probed\n");
>> +
>> +	return 0;
>> +};
>> +
>> +static void mhi_uci_remove(struct mhi_device *mhi_dev)
>> +{
>> +	struct uci_dev *uci_dev = dev_get_drvdata(&mhi_dev->dev);
>> +	struct device *dev = &mhi_dev->dev;
>> +
>> +	dev_dbg(dev, "removing\n");
> 
> Debugging stuff like this can now be removed, ftrace is your friend..
Done.
> 
> 
>> +
>> +	mutex_lock(&uci_drv.lock);
>> +	mutex_lock(&uci_dev->lock);
>> +
>> +	/* disable the node */
>> +	uci_dev->enabled = false;
>> +
>> +	wake_up(&uci_dev->dl_chan.wq);
>> +	wake_up(&uci_dev->ul_chan.wq);
>> +
>> +	/* delete the node to prevent new opens */
>> +	device_destroy(uci_drv.class, uci_dev->devt);
>> +	uci_dev->dev = NULL;
>> +	list_del(&uci_dev->node);
>> +
>> +	/* safe to free memory only if all file nodes are closed */
>> +	if (!uci_dev->ref_count) {
>> +		mutex_unlock(&uci_dev->lock);
>> +		mutex_destroy(&uci_dev->lock);
>> +		clear_bit(MINOR(uci_dev->devt), uci_minors);
>> +		dev_set_drvdata(&mhi_dev->dev, NULL);
>> +		kfree(uci_dev);
>> +		mutex_unlock(&uci_drv.lock);
>> +		return;
>> +	}
>> +
>> +	mutex_unlock(&uci_dev->lock);
>> +	mutex_unlock(&uci_drv.lock);
>> +
>> +	dev_dbg(dev, "removed\n");
>> +}
>> +
>> +/* .driver_data stores max mtu */
>> +static const struct mhi_device_id mhi_uci_match_table[] = {
>> +	{ .chan = "LOOPBACK", .driver_data = 0x1000 },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(mhi, mhi_uci_match_table);
>> +
>> +static struct mhi_driver mhi_uci_driver = {
>> +	.id_table = mhi_uci_match_table,
>> +	.remove = mhi_uci_remove,
>> +	.probe = mhi_uci_probe,
>> +	.ul_xfer_cb = mhi_ul_xfer_cb,
>> +	.dl_xfer_cb = mhi_dl_xfer_cb,
>> +	.driver = {
>> +		.name = MHI_UCI_DRIVER_NAME,
>> +	},
>> +};
>> +
>> +static int mhi_uci_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = register_chrdev(0, MHI_UCI_DRIVER_NAME, &mhidev_fops);
>> +	if (ret < 0)
>> +		return ret;
> 
> A whole major for this thing?  How many minor devices are you going to
> have?
As per MHI specification, we can have 255 channels, but i added 128 
minors, considering UL and DL channel per uci device.
> 
> thanks,
> 
> greg k-h
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
