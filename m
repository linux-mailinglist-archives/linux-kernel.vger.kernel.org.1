Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE20E28B3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbgJLL1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbgJLL1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:27:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE3DE20679;
        Mon, 12 Oct 2020 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602502060;
        bh=iXmgaliDICpCj7IouMdZqbYOwFT7qxyGOsw58ImWLes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfN8S8VU+ZdgJ8Im6re0nv4chi+l3bbPUg/X7VXC67F+U9biibWFIYL750Op3Psa1
         tC9IIALGODunq4m+8atgein9Qoa1OI1lSlzsl2EvOFEmjxjWJ5nZdVQW7XCR0mWjNe
         lc0s468vzY6CGKIlu+QPaxrx/zOzQHCGmFlyv/4I=
Date:   Mon, 12 Oct 2020 13:28:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rickyniu <rickyniu@google.com>
Cc:     balbi@kernel.org, astrachan@google.com, amit.pundir@linaro.org,
        lockwood@android.com, benoit@android.com, jackp@codeaurora.org,
        vvreddy@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kyletso@google.com
Subject: Re: [PATCH 1/3] ANDROID: usb: gadget: f_accessory: Add Android
 Accessory function
Message-ID: <20201012112819.GC356911@kroah.com>
References: <20201012111024.2259162-1-rickyniu@google.com>
 <20201012111024.2259162-2-rickyniu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012111024.2259162-2-rickyniu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 07:10:22PM +0800, rickyniu wrote:
> @@ -369,6 +372,13 @@ config USB_CONFIGFS_F_FS
>  	  implemented in kernel space (for instance Ethernet, serial or
>  	  mass storage) and other are implemented in user space.
>  
> +config USB_CONFIGFS_F_ACC
> +	bool "Accessory gadget"
> +	depends on USB_CONFIGFS
> +	select USB_F_ACC
> +	help
> +	  USB gadget Accessory support
> +

We need a real help text here please.

>  config USB_CONFIGFS_F_UAC1
>  	bool "Audio Class 1.0"
>  	depends on USB_CONFIGFS
> diff --git a/drivers/usb/gadget/function/Makefile b/drivers/usb/gadget/function/Makefile
> index 5d3a6cf02218..2305360e5f22 100644
> --- a/drivers/usb/gadget/function/Makefile
> +++ b/drivers/usb/gadget/function/Makefile
> @@ -50,3 +50,5 @@ usb_f_printer-y			:= f_printer.o
>  obj-$(CONFIG_USB_F_PRINTER)	+= usb_f_printer.o
>  usb_f_tcm-y			:= f_tcm.o
>  obj-$(CONFIG_USB_F_TCM)		+= usb_f_tcm.o
> +usb_f_accessory-y		:= f_accessory.o
> +obj-$(CONFIG_USB_F_ACC)		+= usb_f_accessory.o
> diff --git a/drivers/usb/gadget/function/f_accessory.c b/drivers/usb/gadget/function/f_accessory.c
> new file mode 100644
> index 000000000000..514eadee1793
> --- /dev/null
> +++ b/drivers/usb/gadget/function/f_accessory.c
> @@ -0,0 +1,1352 @@
> +/*
> + * Gadget Function Driver for Android USB accessories

You didn't run this through checkpatch, did you :(

You need a spdx line here.

> + *
> + * Copyright (C) 2011 Google, Inc.

No one has touched this since 2011?

> + * Author: Mike Lockwood <lockwood@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

license boiler-plate text can be removed once you add the correct spdx
line.

> + *
> + */
> +
> +/* #define DEBUG */
> +/* #define VERBOSE_DEBUG */

Why are these here?

> +static int create_bulk_endpoints(struct acc_dev *dev,
> +				struct usb_endpoint_descriptor *in_desc,
> +				struct usb_endpoint_descriptor *out_desc)
> +{
> +	struct usb_composite_dev *cdev = dev->cdev;
> +	struct usb_request *req;
> +	struct usb_ep *ep;
> +	int i;
> +
> +	DBG(cdev, "create_bulk_endpoints dev: %p\n", dev);

ftrace is your friend, this is not needed.

> +
> +	ep = usb_ep_autoconfig(cdev->gadget, in_desc);
> +	if (!ep) {
> +		DBG(cdev, "usb_ep_autoconfig for ep_in failed\n");

dev_err()?

> +		return -ENODEV;
> +	}
> +	DBG(cdev, "usb_ep_autoconfig for ep_in got %s\n", ep->name);

dev_dbg()?

> +	ep->driver_data = dev;		/* claim the endpoint */
> +	dev->ep_in = ep;
> +
> +	ep = usb_ep_autoconfig(cdev->gadget, out_desc);
> +	if (!ep) {
> +		DBG(cdev, "usb_ep_autoconfig for ep_out failed\n");
> +		return -ENODEV;
> +	}
> +	DBG(cdev, "usb_ep_autoconfig for ep_out got %s\n", ep->name);
> +	ep->driver_data = dev;		/* claim the endpoint */
> +	dev->ep_out = ep;
> +
> +	/* now allocate requests for our endpoints */
> +	for (i = 0; i < TX_REQ_MAX; i++) {
> +		req = acc_request_new(dev->ep_in, BULK_BUFFER_SIZE);
> +		if (!req)
> +			goto fail;
> +		req->complete = acc_complete_in;
> +		req_put(dev, &dev->tx_idle, req);
> +	}
> +	for (i = 0; i < RX_REQ_MAX; i++) {
> +		req = acc_request_new(dev->ep_out, BULK_BUFFER_SIZE);
> +		if (!req)
> +			goto fail;
> +		req->complete = acc_complete_out;
> +		dev->rx_req[i] = req;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	pr_err("acc_bind() could not allocate requests\n");

dev_err()?

Same goes for all other pr_* calls in this driver.

> +	while ((req = req_get(dev, &dev->tx_idle)))
> +		acc_request_free(req, dev->ep_in);
> +	for (i = 0; i < RX_REQ_MAX; i++)
> +		acc_request_free(dev->rx_req[i], dev->ep_out);
> +	return -1;
> +}
> +
> +static ssize_t acc_read(struct file *fp, char __user *buf,
> +	size_t count, loff_t *pos)
> +{
> +	struct acc_dev *dev = fp->private_data;
> +	struct usb_request *req;
> +	ssize_t r = count;
> +	unsigned xfer;
> +	int ret = 0;
> +
> +	pr_debug("acc_read(%zu)\n", count);

Again, ftrace is there, please use it and remove all of this type of
debugging lines.

> +
> +	if (dev->disconnected) {
> +		pr_debug("acc_read disconnected");
> +		return -ENODEV;
> +	}
> +
> +	if (count > BULK_BUFFER_SIZE)
> +		count = BULK_BUFFER_SIZE;
> +
> +	/* we will block until we're online */
> +	pr_debug("acc_read: waiting for online\n");
> +	ret = wait_event_interruptible(dev->read_wq, dev->online);
> +	if (ret < 0) {
> +		r = ret;
> +		goto done;
> +	}
> +
> +	if (dev->rx_done) {
> +		// last req cancelled. try to get it.
> +		req = dev->rx_req[0];
> +		goto copy_data;
> +	}
> +
> +requeue_req:
> +	/* queue a request */
> +	req = dev->rx_req[0];
> +	req->length = count;
> +	dev->rx_done = 0;
> +	ret = usb_ep_queue(dev->ep_out, req, GFP_KERNEL);
> +	if (ret < 0) {
> +		r = -EIO;
> +		goto done;
> +	} else {
> +		pr_debug("rx %p queue\n", req);
> +	}
> +
> +	/* wait for a request to complete */
> +	ret = wait_event_interruptible(dev->read_wq, dev->rx_done);
> +	if (ret < 0) {
> +		r = ret;
> +		ret = usb_ep_dequeue(dev->ep_out, req);
> +		if (ret != 0) {
> +			// cancel failed. There can be a data already received.
> +			// it will be retrieved in the next read.
> +			pr_debug("acc_read: cancelling failed %d", ret);
> +		}
> +		goto done;
> +	}
> +
> +copy_data:
> +	dev->rx_done = 0;
> +	if (dev->online) {
> +		/* If we got a 0-len packet, throw it back and try again. */
> +		if (req->actual == 0)
> +			goto requeue_req;
> +
> +		pr_debug("rx %p %u\n", req, req->actual);
> +		xfer = (req->actual < count) ? req->actual : count;
> +		r = xfer;
> +		if (copy_to_user(buf, req->buf, xfer))
> +			r = -EFAULT;
> +	} else
> +		r = -EIO;
> +
> +done:
> +	pr_debug("acc_read returning %zd\n", r);
> +	return r;
> +}
> +
> +static ssize_t acc_write(struct file *fp, const char __user *buf,
> +	size_t count, loff_t *pos)
> +{
> +	struct acc_dev *dev = fp->private_data;
> +	struct usb_request *req = 0;
> +	ssize_t r = count;
> +	unsigned xfer;
> +	int ret;
> +
> +	pr_debug("acc_write(%zu)\n", count);
> +
> +	if (!dev->online || dev->disconnected) {
> +		pr_debug("acc_write disconnected or not online");
> +		return -ENODEV;
> +	}
> +
> +	while (count > 0) {
> +		if (!dev->online) {
> +			pr_debug("acc_write dev->error\n");
> +			r = -EIO;
> +			break;
> +		}
> +
> +		/* get an idle tx request to use */
> +		req = 0;
> +		ret = wait_event_interruptible(dev->write_wq,
> +			((req = req_get(dev, &dev->tx_idle)) || !dev->online));
> +		if (!req) {
> +			r = ret;
> +			break;
> +		}
> +
> +		if (count > BULK_BUFFER_SIZE) {
> +			xfer = BULK_BUFFER_SIZE;
> +			/* ZLP, They will be more TX requests so not yet. */
> +			req->zero = 0;
> +		} else {
> +			xfer = count;
> +			/* If the data length is a multple of the
> +			 * maxpacket size then send a zero length packet(ZLP).
> +			*/
> +			req->zero = ((xfer % dev->ep_in->maxpacket) == 0);
> +		}
> +		if (copy_from_user(req->buf, buf, xfer)) {
> +			r = -EFAULT;
> +			break;
> +		}
> +
> +		req->length = xfer;
> +		ret = usb_ep_queue(dev->ep_in, req, GFP_KERNEL);
> +		if (ret < 0) {
> +			pr_debug("acc_write: xfer error %d\n", ret);
> +			r = -EIO;
> +			break;
> +		}
> +
> +		buf += xfer;
> +		count -= xfer;
> +
> +		/* zero this so we don't try to free it on error exit */
> +		req = 0;
> +	}
> +
> +	if (req)
> +		req_put(dev, &dev->tx_idle, req);
> +
> +	pr_debug("acc_write returning %zd\n", r);
> +	return r;
> +}
> +
> +static long acc_ioctl(struct file *fp, unsigned code, unsigned long value)
> +{
> +	struct acc_dev *dev = fp->private_data;
> +	char *src = NULL;
> +	int ret;
> +
> +	switch (code) {
> +	case ACCESSORY_GET_STRING_MANUFACTURER:
> +		src = dev->manufacturer;
> +		break;
> +	case ACCESSORY_GET_STRING_MODEL:
> +		src = dev->model;
> +		break;
> +	case ACCESSORY_GET_STRING_DESCRIPTION:
> +		src = dev->description;
> +		break;
> +	case ACCESSORY_GET_STRING_VERSION:
> +		src = dev->version;
> +		break;
> +	case ACCESSORY_GET_STRING_URI:
> +		src = dev->uri;
> +		break;
> +	case ACCESSORY_GET_STRING_SERIAL:
> +		src = dev->serial;
> +		break;
> +	case ACCESSORY_IS_START_REQUESTED:
> +		return dev->start_requested;
> +	case ACCESSORY_GET_AUDIO_MODE:
> +		return dev->audio_mode;
> +	}
> +	if (!src)
> +		return -EINVAL;
> +
> +	ret = strlen(src) + 1;
> +	if (copy_to_user((void __user *)value, src, ret))
> +		ret = -EFAULT;
> +	return ret;
> +}
> +
> +static int acc_open(struct inode *ip, struct file *fp)
> +{
> +	printk(KERN_INFO "acc_open\n");

That's just noisy, did you test this???

> +	if (atomic_xchg(&_acc_dev->open_excl, 1))
> +		return -EBUSY;
> +
> +	_acc_dev->disconnected = 0;
> +	fp->private_data = _acc_dev;
> +	return 0;
> +}
> +
> +static int acc_release(struct inode *ip, struct file *fp)
> +{
> +	printk(KERN_INFO "acc_release\n");

Again, this is wrong.

> +
> +	WARN_ON(!atomic_xchg(&_acc_dev->open_excl, 0));
> +	/* indicate that we are disconnected
> +	 * still could be online so don't touch online flag
> +	 */
> +	_acc_dev->disconnected = 1;
> +	return 0;
> +}
> +
> +/* file operations for /dev/usb_accessory */
> +static const struct file_operations acc_fops = {
> +	.owner = THIS_MODULE,
> +	.read = acc_read,
> +	.write = acc_write,
> +	.unlocked_ioctl = acc_ioctl,
> +	.open = acc_open,
> +	.release = acc_release,
> +};
> +
> +static int acc_hid_probe(struct hid_device *hdev,
> +		const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	ret = hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +}
> +
> +static struct miscdevice acc_device = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "usb_accessory",
> +	.fops = &acc_fops,
> +};
> +
> +static const struct hid_device_id acc_hid_table[] = {
> +	{ HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
> +	{ }
> +};
> +
> +static struct hid_driver acc_hid_driver = {
> +	.name = "USB accessory",
> +	.id_table = acc_hid_table,
> +	.probe = acc_hid_probe,
> +};
> +
> +static void acc_complete_setup_noop(struct usb_ep *ep, struct usb_request *req)
> +{
> +	/*
> +	 * Default no-op function when nothing needs to be done for the
> +	 * setup request
> +	 */
> +}
> +
> +int acc_ctrlrequest(struct usb_composite_dev *cdev,
> +				const struct usb_ctrlrequest *ctrl)
> +{
> +	struct acc_dev	*dev = _acc_dev;
> +	int	value = -EOPNOTSUPP;
> +	struct acc_hid_dev *hid;
> +	int offset;
> +	u8 b_requestType = ctrl->bRequestType;
> +	u8 b_request = ctrl->bRequest;
> +	u16	w_index = le16_to_cpu(ctrl->wIndex);
> +	u16	w_value = le16_to_cpu(ctrl->wValue);
> +	u16	w_length = le16_to_cpu(ctrl->wLength);
> +	unsigned long flags;

Odd alignment issues :(

> +
> +/*
> +	printk(KERN_INFO "acc_ctrlrequest "
> +			"%02x.%02x v%04x i%04x l%u\n",
> +			b_requestType, b_request,
> +			w_value, w_index, w_length);
> +*/

Please remove all debugging code from the driver when you resend this.

thanks,

greg k-h
