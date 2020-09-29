Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E11D27C271
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgI2KcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2KcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:32:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D57207C4;
        Tue, 29 Sep 2020 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601375543;
        bh=9887a6tS5HgsY+OVZGWBnfGCXzYne6KvCF04RxYPqDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Il8tI7ekShUcGeeoAcgOOtLS0uMkWtjP+uYEaqxt/5eqY5hTniVxk4N9WV47B5lRe
         gJrBA7kIADm/TDOA32jBKneyWWlu2gNVZdlzq5UyFgFU06bGxxQERnskpw0H6vTR95
         84Wokbsb+ENRFXc5jp3UnB58/3fDezJ4iEHP8kW0=
Date:   Tue, 29 Sep 2020 12:32:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4 06/16] misc: bcm-vk: add ttyVK support
Message-ID: <20200929103229.GD951772@kroah.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
 <20200929001209.16393-7-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929001209.16393-7-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:11:59PM -0700, Scott Branden wrote:
> Add ttyVK support to driver to allow console access to VK card from host.
> 
> Device node will be in the follow form /dev/bcm-vk.x_ttyVKy where:
> x is the instance of the VK card
> y is the tty device number on the VK card
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/misc/bcm-vk/Makefile     |   4 +-
>  drivers/misc/bcm-vk/bcm_vk.h     |  27 +++
>  drivers/misc/bcm-vk/bcm_vk_dev.c |  14 +-
>  drivers/misc/bcm-vk/bcm_vk_tty.c | 336 +++++++++++++++++++++++++++++++
>  4 files changed, 379 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
> 
> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
> index f8a7ac4c242f..e50aa3ca31e9 100644
> --- a/drivers/misc/bcm-vk/Makefile
> +++ b/drivers/misc/bcm-vk/Makefile
> @@ -5,4 +5,6 @@
>  
>  obj-$(CONFIG_BCM_VK) += bcm_vk.o
>  bcm_vk-objs := \
> -	bcm_vk_dev.o
> +	bcm_vk_dev.o \
> +	bcm_vk_tty.o
> +
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> index f428ad9a0c3d..b1408daa7261 100644
> --- a/drivers/misc/bcm-vk/bcm_vk.h
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -10,6 +10,8 @@
>  #include <linux/miscdevice.h>
>  #include <linux/pci.h>
>  #include <linux/sched/signal.h>
> +#include <linux/tty.h>
> +#include <uapi/linux/misc/bcm_vk.h>
>  
>  #define DRV_MODULE_NAME		"bcm-vk"
>  
> @@ -76,6 +78,9 @@
>  #define CODEPUSH_BOOT2_ENTRY		0x60000000
>  
>  #define BAR_CARD_STATUS			0x410
> +/* CARD_STATUS definitions */
> +#define CARD_STATUS_TTYVK0_READY	BIT(0)
> +#define CARD_STATUS_TTYVK1_READY	BIT(1)
>  
>  #define BAR_BOOT1_STDALONE_PROGRESS	0x420
>  #define BOOT1_STDALONE_SUCCESS		(BIT(13) | BIT(14))
> @@ -199,6 +204,19 @@ enum pci_barno {
>  
>  #define BCM_VK_NUM_TTY 2
>  
> +struct bcm_vk_tty {
> +	struct tty_port port;
> +	u32 to_offset;	/* bar offset to use */
> +	u32 to_size;	/* to VK buffer size */
> +	u32 wr;		/* write offset shadow */
> +	u32 from_offset;	/* bar offset to use */
> +	u32 from_size;	/* from VK buffer size */
> +	u32 rd;		/* read offset shadow */
> +	pid_t pid;
> +	bool irq_enabled;
> +	bool is_opened;		/* tracks tty open/close */

Why do you need to track open/close?  Your driver should not care,
right?



> +};
> +
>  /* DAUTH related info */
>  struct bcm_vk_dauth_key {
>  	char store[VK_BAR1_DAUTH_STORE_SIZE];
> @@ -218,6 +236,12 @@ struct bcm_vk {
>  	struct miscdevice miscdev;
>  	int devid; /* dev id allocated */
>  
> +	struct tty_driver *tty_drv;
> +	struct timer_list serial_timer;
> +	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
> +	struct workqueue_struct *tty_wq_thread;
> +	struct work_struct tty_wq_work;
> +
>  	struct workqueue_struct *wq_thread;
>  	struct work_struct wq_work; /* work queue for deferred job */
>  	unsigned long wq_offload[1]; /* various flags on wq requested */
> @@ -279,5 +303,8 @@ static inline bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk)
>  }
>  
>  int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
> +int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
> +void bcm_vk_tty_exit(struct bcm_vk *vk);
> +void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk);
>  
>  #endif
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index 0782e2cff36d..dfef9546c5a7 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -761,6 +761,11 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_destroy_workqueue;
>  	}
>  
> +	snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
> +	err = bcm_vk_tty_init(vk, name);
> +	if (err)
> +		goto err_unregister_panic_notifier;
> +
>  	/*
>  	 * lets trigger an auto download.  We don't want to do it serially here
>  	 * because at probing time, it is not supposed to block for a long time.
> @@ -769,7 +774,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (auto_load) {
>  		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
>  			if (bcm_vk_trigger_autoload(vk))
> -				goto err_unregister_panic_notifier;
> +				goto err_bcm_vk_tty_exit;
>  		} else {
>  			dev_err(dev,
>  				"Auto-load skipped - BROM not in proper state (0x%x)\n",
> @@ -781,6 +786,9 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	return 0;
>  
> +err_bcm_vk_tty_exit:
> +	bcm_vk_tty_exit(vk);
> +
>  err_unregister_panic_notifier:
>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>  					 &vk->panic_nb);
> @@ -836,6 +844,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>  					 &vk->panic_nb);
>  
> +	bcm_vk_tty_exit(vk);
> +
>  	if (vk->tdma_vaddr)
>  		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
>  				  vk->tdma_vaddr, vk->tdma_addr);
> @@ -849,6 +859,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
>  
>  	cancel_work_sync(&vk->wq_work);
>  	destroy_workqueue(vk->wq_thread);
> +	cancel_work_sync(&vk->tty_wq_work);
> +	destroy_workqueue(vk->tty_wq_thread);
>  
>  	for (i = 0; i < MAX_BAR; i++) {
>  		if (vk->bar[i])
> diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
> new file mode 100644
> index 000000000000..7f71d1f9085b
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/tty_flip.h>
> +
> +#include "bcm_vk.h"
> +
> +/* TTYVK base offset is 0x30000 into BAR1 */
> +#define BAR1_TTYVK_BASE_OFFSET	0x300000
> +/* Each TTYVK channel (TO or FROM) is 0x10000 */
> +#define BAR1_TTYVK_CHAN_OFFSET	0x100000
> +/* Each TTYVK channel has TO and FROM, hence the * 2 */
> +#define BAR1_TTYVK_BASE(index)	(BAR1_TTYVK_BASE_OFFSET + \
> +				 ((index) * BAR1_TTYVK_CHAN_OFFSET * 2))
> +/* TO TTYVK channel base comes before FROM for each index */
> +#define TO_TTYK_BASE(index)	BAR1_TTYVK_BASE(index)
> +#define FROM_TTYK_BASE(index)	(BAR1_TTYVK_BASE(index) + \
> +				 BAR1_TTYVK_CHAN_OFFSET)
> +
> +struct bcm_vk_tty_chan {
> +	u32 reserved;
> +	u32 size;
> +	u32 wr;
> +	u32 rd;
> +	u32 *data;
> +};
> +
> +#define VK_BAR_CHAN(v, DIR, e)	((v)->DIR##_offset \
> +				 + offsetof(struct bcm_vk_tty_chan, e))
> +#define VK_BAR_CHAN_SIZE(v, DIR)	VK_BAR_CHAN(v, DIR, size)
> +#define VK_BAR_CHAN_WR(v, DIR)		VK_BAR_CHAN(v, DIR, wr)
> +#define VK_BAR_CHAN_RD(v, DIR)		VK_BAR_CHAN(v, DIR, rd)
> +#define VK_BAR_CHAN_DATA(v, DIR, off)	(VK_BAR_CHAN(v, DIR, data) + (off))
> +
> +#define VK_BAR0_REGSEG_TTY_DB_OFFSET	0x86c
> +
> +/* Poll every 1/10 of second - temp hack till we use MSI interrupt */
> +#define SERIAL_TIMER_VALUE (HZ / 10)
> +
> +static void bcm_vk_tty_poll(struct timer_list *t)
> +{
> +	struct bcm_vk *vk = from_timer(vk, t, serial_timer);
> +
> +	queue_work(vk->tty_wq_thread, &vk->tty_wq_work);
> +	mod_timer(&vk->serial_timer, jiffies + SERIAL_TIMER_VALUE);
> +}
> +
> +irqreturn_t bcm_vk_tty_irqhandler(int irq, void *dev_id)
> +{
> +	struct bcm_vk *vk = dev_id;
> +
> +	queue_work(vk->tty_wq_thread, &vk->tty_wq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void bcm_vk_tty_wq_handler(struct work_struct *work)
> +{
> +	struct bcm_vk *vk = container_of(work, struct bcm_vk, tty_wq_work);
> +	struct bcm_vk_tty *vktty;
> +	int card_status;
> +	int count;
> +	unsigned char c;
> +	int i;
> +	int wr;
> +
> +	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
> +	if (card_status == -1)
> +		return;
> +
> +	for (i = 0; i < BCM_VK_NUM_TTY; i++) {
> +		count = 0;
> +		/* Check the card status that the tty channel is ready */
> +		if ((card_status & BIT(i)) == 0)
> +			continue;
> +
> +		vktty = &vk->tty[i];
> +
> +		/* Don't increment read index if tty app is closed */
> +		if (!vktty->is_opened)
> +			continue;
> +
> +		/* Fetch the wr offset in buffer from VK */
> +		wr = vkread32(vk, BAR_1, VK_BAR_CHAN_WR(vktty, from));
> +
> +		/* safe to ignore until bar read gives proper size */
> +		if (vktty->from_size == 0)
> +			continue;
> +
> +		if (wr >= vktty->from_size) {
> +			dev_err(&vk->pdev->dev,
> +				"ERROR: wq handler ttyVK%d wr:0x%x > 0x%x\n",
> +				i, wr, vktty->from_size);
> +			/* Need to signal and close device in this case */
> +			continue;
> +		}
> +
> +		/*
> +		 * Simple read of circular buffer and
> +		 * insert into tty flip buffer
> +		 */
> +		while (vk->tty[i].rd != wr) {
> +			c = vkread8(vk, BAR_1,
> +				    VK_BAR_CHAN_DATA(vktty, from, vktty->rd));
> +			vktty->rd++;
> +			if (vktty->rd >= vktty->from_size)
> +				vktty->rd = 0;
> +			tty_insert_flip_char(&vktty->port, c, TTY_NORMAL);
> +			count++;
> +		}
> +
> +		if (count) {
> +			tty_flip_buffer_push(&vktty->port);
> +
> +			/* Update read offset from shadow register to card */
> +			vkwrite32(vk, vktty->rd, BAR_1,
> +				  VK_BAR_CHAN_RD(vktty, from));
> +		}
> +	}
> +}
> +
> +static int bcm_vk_tty_open(struct tty_struct *tty, struct file *file)
> +{
> +	int card_status;
> +	struct bcm_vk *vk;
> +	struct bcm_vk_tty *vktty;
> +	int index;
> +
> +	/* initialize the pointer in case something fails */
> +	tty->driver_data = NULL;
> +
> +	vk = (struct bcm_vk *)dev_get_drvdata(tty->dev);
> +	index = tty->index;
> +
> +	if (index >= BCM_VK_NUM_TTY)
> +		return -EINVAL;
> +
> +	vktty = &vk->tty[index];
> +
> +	vktty->pid = task_pid_nr(current);
> +	vktty->to_offset = TO_TTYK_BASE(index);
> +	vktty->from_offset = FROM_TTYK_BASE(index);
> +
> +	/* Do not allow tty device to be opened if tty on card not ready */
> +	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
> +	if (card_status == -1)
> +		return -1;

Do not make up random error values, always use ral ones.

> +
> +	if ((card_status & BIT(index)) == 0)
> +		return -1;
> +
> +	/*
> +	 * Get shadow registers of the buffer sizes and the "to" write offset
> +	 * and "from" read offset
> +	 */
> +	vktty->to_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, to));
> +	vktty->wr = vkread32(vk, BAR_1,  VK_BAR_CHAN_WR(vktty, to));
> +	vktty->from_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, from));
> +	vktty->rd = vkread32(vk, BAR_1,  VK_BAR_CHAN_RD(vktty, from));
> +	vktty->is_opened = true;

Again, why does this matter?  How can it ever be "false" if the
structure is around?

But the larger comment, why is a tty device even needed here at all?

What is it being used for that the char device is not, or can not, be
used for?

You are tying two different user interfaces to the same PCI "resource"
here, and having to go through a lot of gyrations to handle the
reference count and logic for both of them.

Why not split this up, as many other PCI drivers are having to do, if
you REALLY need this, into two different "drivers" that both bind to
different sub-children of this device?  The virtual bus code that keeps
getting posted to the networking mailing list is there to help solve
this issue, as others are having the same problem.

But, can you step back and explain why a TTY device is even needed?
Your changelog does not explain it at all, only that "this is what the
patch does", not "this is why we are doing this".

thanks,

greg k-h
