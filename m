Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7F295C89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896436AbgJVKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896349AbgJVKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:15:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A2BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:15:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so1439287ejy.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/fHz2F23wxZp51hcPtR3S79J5mUlwbRRNL/AuZaMZs=;
        b=vs2V1d1FMBhjFrvO1kbPDRiniMWwuwcUW7iW/cRXLmhPKvWH7/+LVW+y8Mi/Q4OBuj
         dM4rLnECYV1hvJyg5sXyrP25mXdlE+HQRzDPeRiukPrwVX5dJWXp8r21dbuOKWuMiEKB
         3X7XJDIAgdc3B1sH4n5Z8zVCoizVPGNVMLPCWCgiRd4FtLlr46x0i2ZRLv32DyIbVAPc
         eZ/u1gVzHpPA1qGkdp0mIO5j9lgzPHjby9DJI2Pkor0GjI1eZ6HeHrz2X02aE02LUjme
         bIvBhYPNaSKaYTCU/DSjWmxnER3LyvsPViN2viycvj7Nthg4GPHe50V3I33A4OuhcvRI
         HMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/fHz2F23wxZp51hcPtR3S79J5mUlwbRRNL/AuZaMZs=;
        b=NyX9UjN3hrArwq7TF052Wk0bBBC5ZdG7UqUWCJvdJagFMsJ6B0qaT003cqPDnxhmPf
         fRt65juoNPhVCvB5/FgM1leWw4McXSfmao8heztNVlzW2rZlFgBbAZcqVEaEJO6reeRn
         9DL1H40blzu1SL3qE/o0RSZ2MxKB+3MMbBkIQN7Nx77kjcabu5LQYYj7jWtypcjZlqSw
         Jy4BsMO8ip8hcWj0aC6Tx0n2bf8o3FBSdK5k93A9ARS7AVgfeun+3rL5KbuklOYdnKPa
         TVXwyrU0ZTWXAoDkj14GHYz6sTcYaAdWy3u4YDZrji9nenkU3cP0zg5X5wqmHzJQu1by
         ljKQ==
X-Gm-Message-State: AOAM533tdJUiV7KwqC5ITRSz3QQgqWDJ/5t8rIRvr0cfLkzhxecMN5xK
        u4+w+zIWQ14uXrs2tK0eUE58HTOjpbAYR3NFrASMRw==
X-Google-Smtp-Source: ABdhPJxD73iOrvTk2fERDeEp7R/KPCy5qrj3ViwOx+3Apcmlu+wlr6oeallon6gzZlG2zDCllINp9hfyGG6/usmazAw=
X-Received: by 2002:a17:906:f205:: with SMTP id gt5mr1515414ejb.48.1603361713102;
 Thu, 22 Oct 2020 03:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <1603354958-24025-1-git-send-email-hemantk@codeaurora.org> <1603354958-24025-5-git-send-email-hemantk@codeaurora.org>
In-Reply-To: <1603354958-24025-5-git-send-email-hemantk@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 22 Oct 2020 12:20:36 +0200
Message-ID: <CAMZdPi_e4V+Bs5FSqZ4G=CTxJfJi5AZY1kXJESWMxEtT=TwNZg@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] bus: mhi: Add userspace client interface driver
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hemant,

A few comments inline.

On Thu, 22 Oct 2020 at 10:22, Hemant Kumar <hemantk@codeaurora.org> wrote:
>
> This MHI client driver allows userspace clients to transfer
> raw data between MHI device and host using standard file operations.
> Driver instantiates UCI device object which is associated to device
> file node. UCI device object instantiates UCI channel object when device
> file node is opened. UCI channel object is used to manage MHI channels
> by calling MHI core APIs for read and write operations. MHI channels
> are started as part of device open(). MHI channels remain in start
> state until last release() is called on UCI device file node. Device
> file node is created with format
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
> index e841c10..476cc55 100644
> --- a/drivers/bus/mhi/Kconfig
> +++ b/drivers/bus/mhi/Kconfig
> @@ -20,3 +20,16 @@ config MHI_BUS_DEBUG
>           Enable debugfs support for use with the MHI transport. Allows
>           reading and/or modifying some values within the MHI controller
>           for debug and test purposes.
> +
> +config MHI_UCI
> +       tristate "MHI UCI"
> +       depends on MHI_BUS
> +       help
> +         MHI based Userspace Client Interface (UCI) driver is used for
> +         transferring raw data between host and device using standard file
> +         operations from userspace. Open, read, write, and close operations
> +         are supported by this driver. Please check mhi_uci_match_table for
> +         all supported channels that are exposed to userspace.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called mhi_uci.
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
> index 0000000..472bd63
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
> +#define MAX_UCI_MINORS 128
> +
> +static DEFINE_IDR(uci_idr);
> +static DEFINE_MUTEX(uci_drv_mutex);
> +static struct class *uci_dev_class;
> +static int uci_dev_major;
> +
> +/**
> + * struct uci_chan - MHI channel for a UCI device
> + * @udev: associated UCI device object
> + * @ul_wq: wait queue for writer
> + * @write_lock: mutex write lock for ul channel
> + * @dl_wq: wait queue for reader
> + * @read_lock: mutex read lock for dl channel
> + * @dl_lock: spin lock
> + * @pending: list of dl buffers userspace is waiting to read
> + * @cur_buf: current buffer userspace is reading
> + * @dl_size: size of the current dl buffer userspace is reading
> + * @ref_count: uci_chan reference count
> + */
> +struct uci_chan {
> +       struct uci_dev *udev;
> +       wait_queue_head_t ul_wq;
> +
> +       /* ul channel lock to synchronize multiple writes */
> +       struct mutex write_lock;
> +
> +       wait_queue_head_t dl_wq;
> +
> +       /* dl channel lock to synchronize multiple reads */
> +       struct mutex read_lock;
> +
> +       /*
> +        * protects pending and cur_buf members in bh context, channel release,
> +        * read and poll
> +        */
> +       spinlock_t dl_lock;

Maybe I'm wrong, but I think it would be clearer and simpler for
dl_lock to be only a lock for the pending RX list (e.g. pending_lock),
for protecting against concurrent access in chardev read ops
(consumer) and MHI download callback (producer). cur_buf is the
currently read buffer, and so could be simply protected by the
read_lock mutex (never accessed from bh/irq callback context).

> +
> +       struct list_head pending;
> +       struct uci_buf *cur_buf;
> +       size_t dl_size;
> +       struct kref ref_count;
> +};
> +
> +/**
> + * struct uci_buf - UCI buffer
> + * @data: data buffer
> + * @len: length of data buffer
> + * @node: list node of the UCI buffer
> + */
> +struct uci_buf {
> +       void *data;
> +       size_t len;
> +       struct list_head node;
> +};
> +
> +/**
> + * struct uci_dev - MHI UCI device
> + * @minor: UCI device node minor number
> + * @mhi_dev: associated mhi device object
> + * @uchan: UCI uplink and downlink channel object
> + * @mtu: max TRE buffer length
> + * @enabled: Flag to track the state of the UCI device
> + * @lock: mutex lock to manage uchan object
> + * @ref_count: uci_dev reference count
> + */
> +struct uci_dev {
> +       unsigned int minor;
> +       struct mhi_device *mhi_dev;
> +       struct uci_chan *uchan;
> +       size_t mtu;
> +       bool enabled;
> +
> +       /* synchronize open, release and driver remove */
> +       struct mutex lock;
> +       struct kref ref_count;
> +};
> +
> +static void mhi_uci_dev_chan_release(struct kref *ref)
> +{
> +       struct uci_buf *buf_itr, *tmp;
> +       struct uci_chan *uchan =
> +               container_of(ref, struct uci_chan, ref_count);
> +
> +       if (uchan->udev->enabled)
> +               mhi_unprepare_from_transfer(uchan->udev->mhi_dev);
> +
> +       spin_lock_bh(&uchan->dl_lock);
> +       list_for_each_entry_safe(buf_itr, tmp, &uchan->pending, node) {
> +               list_del(&buf_itr->node);
> +               kfree(buf_itr->data);
> +       }
> +
> +       if (uchan->cur_buf)
> +               kfree(uchan->cur_buf->data);
> +       spin_unlock_bh(&uchan->dl_lock);
> +
> +       uchan->cur_buf = NULL;
> +
> +       wake_up(&uchan->ul_wq);
> +       wake_up(&uchan->dl_wq);
> +
> +       mutex_destroy(&uchan->write_lock);
> +       mutex_destroy(&uchan->read_lock);
> +
> +       uchan->udev->uchan = NULL;
> +       kfree(uchan);
> +}
> +
> +static int mhi_queue_inbound(struct uci_dev *udev)
> +{
> +       struct mhi_device *mhi_dev = udev->mhi_dev;
> +       struct device *dev = &mhi_dev->dev;
> +       int nr_trbs, i, ret = -EIO;
> +       size_t dl_buf_size;
> +       void *buf;
> +       struct uci_buf *ubuf;
> +
> +       /* dont queue if dl channel is not supported */
> +       if (!udev->mhi_dev->dl_chan)
> +               return 0;
> +
> +       nr_trbs = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
> +
> +       for (i = 0; i < nr_trbs; i++) {
> +               buf = kmalloc(udev->mtu, GFP_KERNEL);
> +               if (!buf)
> +                       return -ENOMEM;
> +
> +               dl_buf_size = udev->mtu - sizeof(*ubuf);
> +
> +               /* save uci_buf info at the end of buf */
> +               ubuf = buf + dl_buf_size;
> +               ubuf->data = buf;
> +
> +               dev_dbg(dev, "Allocated buf %d of %d size %zu\n", i, nr_trbs,
> +                       dl_buf_size);
> +
> +               ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, dl_buf_size,
> +                                   MHI_EOT);
> +               if (ret) {
> +                       kfree(buf);
> +                       dev_err(dev, "Failed to queue buffer %d\n", i);
> +                       return ret;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int mhi_uci_dev_start_chan(struct uci_dev *udev)
> +{
> +       int ret = 0;
> +       struct uci_chan *uchan;
> +
> +       mutex_lock(&udev->lock);
> +       if (!udev->uchan || !kref_get_unless_zero(&udev->uchan->ref_count)) {
> +               uchan = kzalloc(sizeof(*uchan), GFP_KERNEL);
> +               if (!uchan) {
> +                       ret = -ENOMEM;
> +                       goto error_chan_start;
> +               }
> +
> +               udev->uchan = uchan;
> +               uchan->udev = udev;
> +               init_waitqueue_head(&uchan->ul_wq);
> +               init_waitqueue_head(&uchan->dl_wq);
> +               mutex_init(&uchan->write_lock);
> +               mutex_init(&uchan->read_lock);
> +               spin_lock_init(&uchan->dl_lock);
> +               INIT_LIST_HEAD(&uchan->pending);
> +
> +               ret = mhi_prepare_for_transfer(udev->mhi_dev);
> +               if (ret) {
> +                       dev_err(&udev->mhi_dev->dev, "Error starting transfer channels\n");
> +                       goto error_chan_cleanup;
> +               }
> +
> +               ret = mhi_queue_inbound(udev);
> +               if (ret)
> +                       goto error_chan_cleanup;
> +
> +               kref_init(&uchan->ref_count);
> +       }
> +
> +       mutex_unlock(&udev->lock);
> +
> +       return 0;
> +
> +error_chan_cleanup:
> +       mhi_uci_dev_chan_release(&uchan->ref_count);
> +error_chan_start:
> +       mutex_unlock(&udev->lock);
> +       return ret;
> +}
> +
> +static void mhi_uci_dev_release(struct kref *ref)
> +{
> +       struct uci_dev *udev =
> +               container_of(ref, struct uci_dev, ref_count);
> +
> +       mutex_destroy(&udev->lock);
> +
> +       kfree(udev);
> +}
> +
> +static int mhi_uci_open(struct inode *inode, struct file *filp)
> +{
> +       unsigned int minor = iminor(inode);
> +       struct uci_dev *udev = NULL;
> +       int ret;
> +
> +       mutex_lock(&uci_drv_mutex);
> +       udev = idr_find(&uci_idr, minor);
> +       if (!udev) {
> +               pr_debug("uci dev: minor %d not found\n", minor);
> +               mutex_unlock(&uci_drv_mutex);
> +               return -ENODEV;
> +       }
> +
> +       kref_get(&udev->ref_count);
> +       mutex_unlock(&uci_drv_mutex);
> +
> +       ret = mhi_uci_dev_start_chan(udev);
> +       if (ret) {
> +               kref_put(&udev->ref_count, mhi_uci_dev_release);
> +               return ret;
> +       }
> +
> +       filp->private_data = udev;
> +
> +       return 0;
> +}
> +
> +static int mhi_uci_release(struct inode *inode, struct file *file)
> +{
> +       struct uci_dev *udev = file->private_data;
> +
> +       mutex_lock(&udev->lock);
> +       kref_put(&udev->uchan->ref_count, mhi_uci_dev_chan_release);
> +       mutex_unlock(&udev->lock);
> +
> +       kref_put(&udev->ref_count, mhi_uci_dev_release);
> +
> +       return 0;
> +}
> +
> +static __poll_t mhi_uci_poll(struct file *file, poll_table *wait)
> +{
> +       struct uci_dev *udev = file->private_data;
> +       struct mhi_device *mhi_dev = udev->mhi_dev;
> +       struct device *dev = &mhi_dev->dev;
> +       struct uci_chan *uchan = udev->uchan;
> +       __poll_t mask = 0;
> +
> +       poll_wait(file, &udev->uchan->ul_wq, wait);
> +       poll_wait(file, &udev->uchan->dl_wq, wait);
> +
> +       if (!udev->enabled) {
> +               mask = EPOLLERR;
> +               goto done;
> +       }
> +
> +       spin_lock_bh(&uchan->dl_lock);
> +       if (!list_empty(&uchan->pending) || uchan->cur_buf) {
> +               dev_dbg(dev, "Client can read from node\n");
> +               mask |= EPOLLIN | EPOLLRDNORM;
> +       }
> +       spin_unlock_bh(&uchan->dl_lock);
> +
> +       if (mhi_get_free_desc_count(mhi_dev, DMA_TO_DEVICE) > 0) {
> +               dev_dbg(dev, "Client can write to node\n");
> +               mask |= EPOLLOUT | EPOLLWRNORM;
> +       }
> +
> +       dev_dbg(dev, "Client attempted to poll, returning mask 0x%x\n", mask);
> +
> +done:
> +       return mask;
> +}
> +
> +static ssize_t mhi_uci_write(struct file *file,
> +                            const char __user *buf,
> +                            size_t count,
> +                            loff_t *offp)
> +{
> +       struct uci_dev *udev = file->private_data;
> +       struct mhi_device *mhi_dev = udev->mhi_dev;
> +       struct device *dev = &mhi_dev->dev;
> +       struct uci_chan *uchan = udev->uchan;
> +       size_t bytes_xfered = 0;
> +       int ret, nr_avail = 0;
> +
> +       /* if ul channel is not supported return error */
> +       if (!buf || !count || !mhi_dev->ul_chan)
> +               return -EINVAL;
> +
> +       dev_dbg(dev, "%s: to xfer: %zu bytes\n", __func__, count);
> +
> +       mutex_lock(&uchan->write_lock);
> +       while (count) {
> +               size_t xfer_size;
> +               void *kbuf;
> +               enum mhi_flags flags;
> +
> +               /* wait for free descriptors */
> +               ret = wait_event_interruptible(uchan->ul_wq,
> +                                              (!udev->enabled) ||
> +                               (nr_avail = mhi_get_free_desc_count(mhi_dev,
> +                                              DMA_TO_DEVICE)) > 0);
> +
> +               if (ret == -ERESTARTSYS) {
> +                       dev_dbg(dev, "Interrupted by a signal in %s, exiting\n",
> +                               __func__);
> +                       goto err_mtx_unlock;
> +               }
> +
> +               if (!udev->enabled) {
> +                       ret = -ENODEV;
> +                       goto err_mtx_unlock;
> +               }
> +
> +               xfer_size = min_t(size_t, count, udev->mtu);
> +               kbuf = kmalloc(xfer_size, GFP_KERNEL);
> +               if (!kbuf) {
> +                       ret = -ENOMEM;
> +                       goto err_mtx_unlock;
> +               }
> +
> +               ret = copy_from_user(kbuf, buf, xfer_size);
> +               if (ret) {
> +                       kfree(kbuf);
> +                       ret = -EFAULT;
> +                       goto err_mtx_unlock;
> +               }
> +
> +               /* if ring is full after this force EOT */
> +               if (nr_avail > 1 && (count - xfer_size))
> +                       flags = MHI_CHAIN;
> +               else
> +                       flags = MHI_EOT;
> +
> +               ret = mhi_queue_buf(mhi_dev, DMA_TO_DEVICE, kbuf, xfer_size,
> +                                   flags);
> +               if (ret) {
> +                       kfree(kbuf);
> +                       goto err_mtx_unlock;
> +               }
> +
> +               bytes_xfered += xfer_size;
> +               count -= xfer_size;
> +               buf += xfer_size;
> +       }
> +
> +       mutex_unlock(&uchan->write_lock);
> +       dev_dbg(dev, "%s: bytes xferred: %zu\n", __func__, bytes_xfered);
> +
> +       return bytes_xfered;
> +
> +err_mtx_unlock:
> +       mutex_unlock(&uchan->write_lock);
> +
> +       return ret;
> +}
> +
> +static ssize_t mhi_uci_read(struct file *file,
> +                           char __user *buf,
> +                           size_t count,
> +                           loff_t *ppos)
> +{
> +       struct uci_dev *udev = file->private_data;
> +       struct mhi_device *mhi_dev = udev->mhi_dev;
> +       struct uci_chan *uchan = udev->uchan;
> +       struct device *dev = &mhi_dev->dev;
> +       struct uci_buf *ubuf;
> +       size_t rx_buf_size;
> +       char *ptr;
> +       size_t to_copy;
> +       int ret = 0;
> +
> +       /* if dl channel is not supported return error */
> +       if (!buf || !mhi_dev->dl_chan)
> +               return -EINVAL;
> +
> +       mutex_lock(&uchan->read_lock);
> +       spin_lock_bh(&uchan->dl_lock);
> +       /* No data available to read, wait */
> +       if (!uchan->cur_buf && list_empty(&uchan->pending)) {
> +               dev_dbg(dev, "No data available to read, waiting\n");
> +
> +               spin_unlock_bh(&uchan->dl_lock);
> +               ret = wait_event_interruptible(uchan->dl_wq,
> +                                              (!udev->enabled ||
> +                                             !list_empty(&uchan->pending)));
> +
> +               if (ret == -ERESTARTSYS) {
> +                       dev_dbg(dev, "Interrupted by a signal in %s, exiting\n",
> +                               __func__);
> +                       goto err_mtx_unlock;
> +               }
> +
> +               if (!udev->enabled) {
> +                       ret = -ENODEV;
> +                       goto err_mtx_unlock;
> +               }
> +               spin_lock_bh(&uchan->dl_lock);
> +       }
> +
> +       /* new read, get the next descriptor from the list */
> +       if (!uchan->cur_buf) {
> +               ubuf = list_first_entry_or_null(&uchan->pending,
> +                                               struct uci_buf, node);
> +               if (!ubuf) {
> +                       ret = -EIO;
> +                       goto err_spin_unlock;
> +               }
> +
> +               list_del(&ubuf->node);
> +               uchan->cur_buf = ubuf;
> +               uchan->dl_size = ubuf->len;
> +               dev_dbg(dev, "Got pkt of size: %zu\n", uchan->dl_size);
> +       }
> +
> +       ubuf = uchan->cur_buf;
> +       spin_unlock_bh(&uchan->dl_lock);
> +
> +       /* Copy the buffer to user space */
> +       to_copy = min_t(size_t, count, uchan->dl_size);
> +       ptr = ubuf->data + (ubuf->len - uchan->dl_size);
> +
> +       ret = copy_to_user(buf, ptr, to_copy);
> +       if (ret) {
> +               ret = -EFAULT;
> +               goto err_mtx_unlock;
> +       }
> +
> +       dev_dbg(dev, "Copied %zu of %zu bytes\n", to_copy, uchan->dl_size);
> +       uchan->dl_size -= to_copy;
> +
> +       /* we finished with this buffer, queue it back to hardware */
> +       if (!uchan->dl_size) {
> +               spin_lock_bh(&uchan->dl_lock);
> +               uchan->cur_buf = NULL;
> +               spin_unlock_bh(&uchan->dl_lock);
> +
> +               rx_buf_size = udev->mtu - sizeof(*ubuf);
> +               ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, ubuf->data,
> +                                   rx_buf_size, MHI_EOT);
> +               if (ret) {
> +                       dev_err(dev, "Failed to recycle element: %d\n", ret);
> +                       kfree(ubuf->data);
> +                       goto err_mtx_unlock;
> +               }
> +       }
> +       mutex_unlock(&uchan->read_lock);
> +
> +       dev_dbg(dev, "%s: Returning %zu bytes\n", __func__, to_copy);
> +
> +       return to_copy;
> +
> +err_spin_unlock:
> +       spin_unlock_bh(&uchan->dl_lock);
> +err_mtx_unlock:
> +       mutex_unlock(&uchan->read_lock);
> +       return ret;
> +}
> +
> +static const struct file_operations mhidev_fops = {
> +       .owner = THIS_MODULE,
> +       .open = mhi_uci_open,
> +       .release = mhi_uci_release,
> +       .read = mhi_uci_read,
> +       .write = mhi_uci_write,
> +       .poll = mhi_uci_poll,
> +};
> +
> +static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
> +                          struct mhi_result *mhi_result)
> +{
> +       struct uci_dev *udev = dev_get_drvdata(&mhi_dev->dev);
> +       struct uci_chan *uchan = udev->uchan;
> +       struct device *dev = &mhi_dev->dev;
> +
> +       dev_dbg(dev, "status: %d xfer_len: %zu\n",
> +               mhi_result->transaction_status, mhi_result->bytes_xferd);
> +
> +       kfree(mhi_result->buf_addr);
> +
> +       if (!mhi_result->transaction_status)
> +               wake_up(&uchan->ul_wq);
> +}
> +
> +static void mhi_dl_xfer_cb(struct mhi_device *mhi_dev,
> +                          struct mhi_result *mhi_result)
> +{
> +       struct uci_dev *udev = dev_get_drvdata(&mhi_dev->dev);
> +       struct uci_chan *uchan = udev->uchan;
> +       struct device *dev = &mhi_dev->dev;
> +       struct uci_buf *ubuf;
> +       size_t dl_buf_size = udev->mtu - sizeof(*ubuf);
> +
> +       dev_dbg(dev, "status: %d receive_len: %zu\n",
> +               mhi_result->transaction_status, mhi_result->bytes_xferd);
> +
> +       if (mhi_result->transaction_status == -ENOTCONN) {
> +               kfree(mhi_result->buf_addr);
> +               return;
> +       }

It would be more robust to test only transaction_status values that
allow you to consider the buffer as valid, AFAIU 0 and -EOVERFLOW.
That would prevent breaking that code if new transaction_status errors
are returned in the futur (e.g. -EIO...).


> +
> +       ubuf = mhi_result->buf_addr + dl_buf_size;
> +       ubuf->data = mhi_result->buf_addr;
> +       ubuf->len = mhi_result->bytes_xferd;
> +       spin_lock_bh(&uchan->dl_lock);
> +       list_add_tail(&ubuf->node, &uchan->pending);
> +       spin_unlock_bh(&uchan->dl_lock);
> +
> +       wake_up(&uchan->dl_wq);
> +}
> +
> +static int mhi_uci_probe(struct mhi_device *mhi_dev,
> +                        const struct mhi_device_id *id)
> +{
> +       struct uci_dev *udev;
> +       struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +       struct device *dev;
> +       int index;
> +
> +       udev = kzalloc(sizeof(*udev), GFP_KERNEL);
> +       if (!udev)
> +               return -ENOMEM;
> +
> +       kref_init(&udev->ref_count);
> +       mutex_init(&udev->lock);
> +       udev->mhi_dev = mhi_dev;
> +
> +       mutex_lock(&uci_drv_mutex);
> +       index = idr_alloc(&uci_idr, udev, 0, MAX_UCI_MINORS, GFP_KERNEL);
> +       mutex_unlock(&uci_drv_mutex);
> +       if (index < 0) {
> +               kfree(udev);
> +               return index;
> +       }
> +
> +       udev->minor = index;
> +
> +       udev->mtu = min_t(size_t, id->driver_data, MHI_MAX_MTU);
> +       dev_set_drvdata(&mhi_dev->dev, udev);
> +       udev->enabled = true;
> +
> +       /* create device file node /dev/mhi_<cntrl_dev_name>_<mhi_dev_name> */
> +       dev = device_create(uci_dev_class, &mhi_dev->dev,
> +                           MKDEV(uci_dev_major, index), udev,
> +                           DEVICE_NAME "_%s_%s",
> +                           dev_name(mhi_cntrl->cntrl_dev), mhi_dev->name);
> +       if (IS_ERR(dev)) {
> +               mutex_lock(&uci_drv_mutex);
> +               idr_remove(&uci_idr, udev->minor);
> +               mutex_unlock(&uci_drv_mutex);
> +               dev_set_drvdata(&mhi_dev->dev, NULL);
> +               kfree(udev);
> +               return PTR_ERR(dev);
> +       }
> +
> +       dev_dbg(&mhi_dev->dev, "probed uci dev: minor %d\n", index);
> +
> +       return 0;
> +};
> +
> +static void mhi_uci_remove(struct mhi_device *mhi_dev)
> +{
> +       struct uci_dev *udev = dev_get_drvdata(&mhi_dev->dev);
> +
> +       /* disable the node */
> +       mutex_lock(&udev->lock);
> +       udev->enabled = false;
> +
> +       /* delete the node to prevent new opens */
> +       device_destroy(uci_dev_class, MKDEV(uci_dev_major, udev->minor));
> +
> +       /* return error for any blocked read or write */
> +       if (udev->uchan) {
> +               wake_up(&udev->uchan->ul_wq);
> +               wake_up(&udev->uchan->dl_wq);
> +       }
> +       mutex_unlock(&udev->lock);
> +
> +       mutex_lock(&uci_drv_mutex);
> +       idr_remove(&uci_idr, udev->minor);
> +       kref_put(&udev->ref_count, mhi_uci_dev_release);
> +       mutex_unlock(&uci_drv_mutex);
> +}
> +
> +/* .driver_data stores max mtu */
> +static const struct mhi_device_id mhi_uci_match_table[] = {
> +       { .chan = "LOOPBACK", .driver_data = 0x1000},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(mhi, mhi_uci_match_table);
> +
> +static struct mhi_driver mhi_uci_driver = {
> +       .id_table = mhi_uci_match_table,
> +       .remove = mhi_uci_remove,
> +       .probe = mhi_uci_probe,
> +       .ul_xfer_cb = mhi_ul_xfer_cb,
> +       .dl_xfer_cb = mhi_dl_xfer_cb,
> +       .driver = {
> +               .name = MHI_UCI_DRIVER_NAME,
> +       },
> +};
> +
> +static int mhi_uci_init(void)
> +{
> +       int ret;
> +
> +       ret = register_chrdev(0, MHI_UCI_DRIVER_NAME, &mhidev_fops);
> +       if (ret < 0)
> +               return ret;
> +
> +       uci_dev_major = ret;
> +       uci_dev_class = class_create(THIS_MODULE, MHI_UCI_DRIVER_NAME);
> +       if (IS_ERR(uci_dev_class)) {
> +               unregister_chrdev(uci_dev_major, MHI_UCI_DRIVER_NAME);
> +               return PTR_ERR(uci_dev_class);
> +       }
> +
> +       ret = mhi_driver_register(&mhi_uci_driver);
> +       if (ret) {
> +               class_destroy(uci_dev_class);
> +               unregister_chrdev(uci_dev_major, MHI_UCI_DRIVER_NAME);
> +       }
> +
> +       return ret;
> +}
> +
> +static void __exit mhi_uci_exit(void)
> +{
> +       mhi_driver_unregister(&mhi_uci_driver);
> +       class_destroy(uci_dev_class);
> +       unregister_chrdev(uci_dev_major, MHI_UCI_DRIVER_NAME);
> +       idr_destroy(&uci_idr);
> +}
> +
> +module_init(mhi_uci_init);
> +module_exit(mhi_uci_exit);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MHI UCI Driver");
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
