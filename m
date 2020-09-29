Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8606E27DA58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgI2VpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgI2VpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:45:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:45:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so6069652pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=OREREmqa4D5iO+dq5FbCelMa2m/WLH9mGYCk1JHn+Sg=;
        b=L/IRMODCQIG8HYFpqUHiQE4QQTm9atEqTZnOVziTztSpAcZzrJWRjDHFv8+VQ4b9CR
         SvgJCWvOZu8cWXgopRq9vsMkm9uoGqUVJJIjVOoj6alCCRCp9Bfu6JoIiEIjcICFaDWp
         o8wsASvnMMwRBR56+jHzpST8z8OJaYYDeRvLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=OREREmqa4D5iO+dq5FbCelMa2m/WLH9mGYCk1JHn+Sg=;
        b=b6MkLM8BK4gMSxzbVYOQRn4V2rt0gDeOzZzyanCwHpNL0WripOwqx3nJvvL4uxFQl4
         N01ZbmeZSTiJS/kZX6ESZY0T890KsvaZdVGp9yd5gGbJsFDeVUCDZAdpXxl9Qh76WErS
         RQ0b6/Nc2vSZQNHytQyy3L9k1jBqimdwuourGWuC34RNVozbwVhJmKal/jC3jmdgr4co
         vYDnhA8VtZ6i+jYB3NtgAXkS3ujI3BNCvY7xE4IlyP03c/TqrYfXfMyodbg7kSYZ8pZ1
         lRa+ThMppqXeGe4SB7f7CNbEMLBFE2RZt/TZhFhPP3y55URPOnOnP7XMZwEwJUQzzgRw
         zzCA==
X-Gm-Message-State: AOAM530KIr0A+kSsHfpZarA3qfZDzuiaaPklWieujXw+2bqY+vZuNdOt
        CBpwK1EGyPYGjIWCirWuW4BOGw==
X-Google-Smtp-Source: ABdhPJyY0QGVp57XgKz1IC252++Ml3K0mEd/O0ltMyC4/4c42eE0eAqTD14PNDWvJiiR85KImKKrmw==
X-Received: by 2002:a63:4746:: with SMTP id w6mr4854718pgk.412.1601415921914;
        Tue, 29 Sep 2020 14:45:21 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i17sm6326751pfa.2.2020.09.29.14.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 14:45:21 -0700 (PDT)
Subject: Re: [PATCH v4 06/16] misc: bcm-vk: add ttyVK support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200929001209.16393-1-scott.branden@broadcom.com>
 <20200929001209.16393-7-scott.branden@broadcom.com>
 <20200929103229.GD951772@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3079bae6-1d74-ce67-5a9c-8706e4e076c2@broadcom.com>
Date:   Tue, 29 Sep 2020 14:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929103229.GD951772@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000033831505b07ab369"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000033831505b07ab369
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA



On 2020-09-29 3:32 a.m., Greg Kroah-Hartman wrote:
> On Mon, Sep 28, 2020 at 05:11:59PM -0700, Scott Branden wrote:
>> Add ttyVK support to driver to allow console access to VK card from host.
>>
>> Device node will be in the follow form /dev/bcm-vk.x_ttyVKy where:
>> x is the instance of the VK card
>> y is the tty device number on the VK card
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  drivers/misc/bcm-vk/Makefile     |   4 +-
>>  drivers/misc/bcm-vk/bcm_vk.h     |  27 +++
>>  drivers/misc/bcm-vk/bcm_vk_dev.c |  14 +-
>>  drivers/misc/bcm-vk/bcm_vk_tty.c | 336 +++++++++++++++++++++++++++++++
>>  4 files changed, 379 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
>>
>> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
>> index f8a7ac4c242f..e50aa3ca31e9 100644
>> --- a/drivers/misc/bcm-vk/Makefile
>> +++ b/drivers/misc/bcm-vk/Makefile
>> @@ -5,4 +5,6 @@
>>  
>>  obj-$(CONFIG_BCM_VK) += bcm_vk.o
>>  bcm_vk-objs := \
>> -	bcm_vk_dev.o
>> +	bcm_vk_dev.o \
>> +	bcm_vk_tty.o
>> +
>> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
>> index f428ad9a0c3d..b1408daa7261 100644
>> --- a/drivers/misc/bcm-vk/bcm_vk.h
>> +++ b/drivers/misc/bcm-vk/bcm_vk.h
>> @@ -10,6 +10,8 @@
>>  #include <linux/miscdevice.h>
>>  #include <linux/pci.h>
>>  #include <linux/sched/signal.h>
>> +#include <linux/tty.h>
>> +#include <uapi/linux/misc/bcm_vk.h>
>>  
>>  #define DRV_MODULE_NAME		"bcm-vk"
>>  
>> @@ -76,6 +78,9 @@
>>  #define CODEPUSH_BOOT2_ENTRY		0x60000000
>>  
>>  #define BAR_CARD_STATUS			0x410
>> +/* CARD_STATUS definitions */
>> +#define CARD_STATUS_TTYVK0_READY	BIT(0)
>> +#define CARD_STATUS_TTYVK1_READY	BIT(1)
>>  
>>  #define BAR_BOOT1_STDALONE_PROGRESS	0x420
>>  #define BOOT1_STDALONE_SUCCESS		(BIT(13) | BIT(14))
>> @@ -199,6 +204,19 @@ enum pci_barno {
>>  
>>  #define BCM_VK_NUM_TTY 2
>>  
>> +struct bcm_vk_tty {
>> +	struct tty_port port;
>> +	u32 to_offset;	/* bar offset to use */
>> +	u32 to_size;	/* to VK buffer size */
>> +	u32 wr;		/* write offset shadow */
>> +	u32 from_offset;	/* bar offset to use */
>> +	u32 from_size;	/* from VK buffer size */
>> +	u32 rd;		/* read offset shadow */
>> +	pid_t pid;
>> +	bool irq_enabled;
>> +	bool is_opened;		/* tracks tty open/close */
> Why do you need to track open/close?  Your driver should not care,
> right?
We do care as we wanted the buffered data to remain in PCIe memory
until the device is opened. If not, when we service the shared MSI interrupt
we would end up reading the data out and incrementing the read pointer.
>
>
>
>> +};
>> +
>>  /* DAUTH related info */
>>  struct bcm_vk_dauth_key {
>>  	char store[VK_BAR1_DAUTH_STORE_SIZE];
>> @@ -218,6 +236,12 @@ struct bcm_vk {
>>  	struct miscdevice miscdev;
>>  	int devid; /* dev id allocated */
>>  
>> +	struct tty_driver *tty_drv;
>> +	struct timer_list serial_timer;
>> +	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
>> +	struct workqueue_struct *tty_wq_thread;
>> +	struct work_struct tty_wq_work;
>> +
>>  	struct workqueue_struct *wq_thread;
>>  	struct work_struct wq_work; /* work queue for deferred job */
>>  	unsigned long wq_offload[1]; /* various flags on wq requested */
>> @@ -279,5 +303,8 @@ static inline bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk)
>>  }
>>  
>>  int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
>> +int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
>> +void bcm_vk_tty_exit(struct bcm_vk *vk);
>> +void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk);
>>  
>>  #endif
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
>> index 0782e2cff36d..dfef9546c5a7 100644
>> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
>> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
>> @@ -761,6 +761,11 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  		goto err_destroy_workqueue;
>>  	}
>>  
>> +	snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
>> +	err = bcm_vk_tty_init(vk, name);
>> +	if (err)
>> +		goto err_unregister_panic_notifier;
>> +
>>  	/*
>>  	 * lets trigger an auto download.  We don't want to do it serially here
>>  	 * because at probing time, it is not supposed to block for a long time.
>> @@ -769,7 +774,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	if (auto_load) {
>>  		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
>>  			if (bcm_vk_trigger_autoload(vk))
>> -				goto err_unregister_panic_notifier;
>> +				goto err_bcm_vk_tty_exit;
>>  		} else {
>>  			dev_err(dev,
>>  				"Auto-load skipped - BROM not in proper state (0x%x)\n",
>> @@ -781,6 +786,9 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  
>>  	return 0;
>>  
>> +err_bcm_vk_tty_exit:
>> +	bcm_vk_tty_exit(vk);
>> +
>>  err_unregister_panic_notifier:
>>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>>  					 &vk->panic_nb);
>> @@ -836,6 +844,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
>>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>>  					 &vk->panic_nb);
>>  
>> +	bcm_vk_tty_exit(vk);
>> +
>>  	if (vk->tdma_vaddr)
>>  		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
>>  				  vk->tdma_vaddr, vk->tdma_addr);
>> @@ -849,6 +859,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
>>  
>>  	cancel_work_sync(&vk->wq_work);
>>  	destroy_workqueue(vk->wq_thread);
>> +	cancel_work_sync(&vk->tty_wq_work);
>> +	destroy_workqueue(vk->tty_wq_thread);
>>  
>>  	for (i = 0; i < MAX_BAR; i++) {
>>  		if (vk->bar[i])
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
>> new file mode 100644
>> index 000000000000..7f71d1f9085b
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
>> @@ -0,0 +1,336 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#include <linux/tty.h>
>> +#include <linux/tty_driver.h>
>> +#include <linux/tty_flip.h>
>> +
>> +#include "bcm_vk.h"
>> +
>> +/* TTYVK base offset is 0x30000 into BAR1 */
>> +#define BAR1_TTYVK_BASE_OFFSET	0x300000
>> +/* Each TTYVK channel (TO or FROM) is 0x10000 */
>> +#define BAR1_TTYVK_CHAN_OFFSET	0x100000
>> +/* Each TTYVK channel has TO and FROM, hence the * 2 */
>> +#define BAR1_TTYVK_BASE(index)	(BAR1_TTYVK_BASE_OFFSET + \
>> +				 ((index) * BAR1_TTYVK_CHAN_OFFSET * 2))
>> +/* TO TTYVK channel base comes before FROM for each index */
>> +#define TO_TTYK_BASE(index)	BAR1_TTYVK_BASE(index)
>> +#define FROM_TTYK_BASE(index)	(BAR1_TTYVK_BASE(index) + \
>> +				 BAR1_TTYVK_CHAN_OFFSET)
>> +
>> +struct bcm_vk_tty_chan {
>> +	u32 reserved;
>> +	u32 size;
>> +	u32 wr;
>> +	u32 rd;
>> +	u32 *data;
>> +};
>> +
>> +#define VK_BAR_CHAN(v, DIR, e)	((v)->DIR##_offset \
>> +				 + offsetof(struct bcm_vk_tty_chan, e))
>> +#define VK_BAR_CHAN_SIZE(v, DIR)	VK_BAR_CHAN(v, DIR, size)
>> +#define VK_BAR_CHAN_WR(v, DIR)		VK_BAR_CHAN(v, DIR, wr)
>> +#define VK_BAR_CHAN_RD(v, DIR)		VK_BAR_CHAN(v, DIR, rd)
>> +#define VK_BAR_CHAN_DATA(v, DIR, off)	(VK_BAR_CHAN(v, DIR, data) + (off))
>> +
>> +#define VK_BAR0_REGSEG_TTY_DB_OFFSET	0x86c
>> +
>> +/* Poll every 1/10 of second - temp hack till we use MSI interrupt */
>> +#define SERIAL_TIMER_VALUE (HZ / 10)
>> +
>> +static void bcm_vk_tty_poll(struct timer_list *t)
>> +{
>> +	struct bcm_vk *vk = from_timer(vk, t, serial_timer);
>> +
>> +	queue_work(vk->tty_wq_thread, &vk->tty_wq_work);
>> +	mod_timer(&vk->serial_timer, jiffies + SERIAL_TIMER_VALUE);
>> +}
>> +
>> +irqreturn_t bcm_vk_tty_irqhandler(int irq, void *dev_id)
>> +{
>> +	struct bcm_vk *vk = dev_id;
>> +
>> +	queue_work(vk->tty_wq_thread, &vk->tty_wq_work);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void bcm_vk_tty_wq_handler(struct work_struct *work)
>> +{
>> +	struct bcm_vk *vk = container_of(work, struct bcm_vk, tty_wq_work);
>> +	struct bcm_vk_tty *vktty;
>> +	int card_status;
>> +	int count;
>> +	unsigned char c;
>> +	int i;
>> +	int wr;
>> +
>> +	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
>> +	if (card_status == -1)
>> +		return;
>> +
>> +	for (i = 0; i < BCM_VK_NUM_TTY; i++) {
>> +		count = 0;
>> +		/* Check the card status that the tty channel is ready */
>> +		if ((card_status & BIT(i)) == 0)
>> +			continue;
>> +
>> +		vktty = &vk->tty[i];
>> +
>> +		/* Don't increment read index if tty app is closed */
>> +		if (!vktty->is_opened)
>> +			continue;
>> +
>> +		/* Fetch the wr offset in buffer from VK */
>> +		wr = vkread32(vk, BAR_1, VK_BAR_CHAN_WR(vktty, from));
>> +
>> +		/* safe to ignore until bar read gives proper size */
>> +		if (vktty->from_size == 0)
>> +			continue;
>> +
>> +		if (wr >= vktty->from_size) {
>> +			dev_err(&vk->pdev->dev,
>> +				"ERROR: wq handler ttyVK%d wr:0x%x > 0x%x\n",
>> +				i, wr, vktty->from_size);
>> +			/* Need to signal and close device in this case */
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * Simple read of circular buffer and
>> +		 * insert into tty flip buffer
>> +		 */
>> +		while (vk->tty[i].rd != wr) {
>> +			c = vkread8(vk, BAR_1,
>> +				    VK_BAR_CHAN_DATA(vktty, from, vktty->rd));
>> +			vktty->rd++;
>> +			if (vktty->rd >= vktty->from_size)
>> +				vktty->rd = 0;
>> +			tty_insert_flip_char(&vktty->port, c, TTY_NORMAL);
>> +			count++;
>> +		}
>> +
>> +		if (count) {
>> +			tty_flip_buffer_push(&vktty->port);
>> +
>> +			/* Update read offset from shadow register to card */
>> +			vkwrite32(vk, vktty->rd, BAR_1,
>> +				  VK_BAR_CHAN_RD(vktty, from));
>> +		}
>> +	}
>> +}
>> +
>> +static int bcm_vk_tty_open(struct tty_struct *tty, struct file *file)
>> +{
>> +	int card_status;
>> +	struct bcm_vk *vk;
>> +	struct bcm_vk_tty *vktty;
>> +	int index;
>> +
>> +	/* initialize the pointer in case something fails */
>> +	tty->driver_data = NULL;
>> +
>> +	vk = (struct bcm_vk *)dev_get_drvdata(tty->dev);
>> +	index = tty->index;
>> +
>> +	if (index >= BCM_VK_NUM_TTY)
>> +		return -EINVAL;
>> +
>> +	vktty = &vk->tty[index];
>> +
>> +	vktty->pid = task_pid_nr(current);
>> +	vktty->to_offset = TO_TTYK_BASE(index);
>> +	vktty->from_offset = FROM_TTYK_BASE(index);
>> +
>> +	/* Do not allow tty device to be opened if tty on card not ready */
>> +	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
>> +	if (card_status == -1)
>> +		return -1;
> Do not make up random error values, always use ral ones.
Missed fixing return vals in this patch, will look for appropriate ERRNO. thanks.
>
>> +
>> +	if ((card_status & BIT(index)) == 0)
>> +		return -1;
>> +
>> +	/*
>> +	 * Get shadow registers of the buffer sizes and the "to" write offset
>> +	 * and "from" read offset
>> +	 */
>> +	vktty->to_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, to));
>> +	vktty->wr = vkread32(vk, BAR_1,  VK_BAR_CHAN_WR(vktty, to));
>> +	vktty->from_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, from));
>> +	vktty->rd = vkread32(vk, BAR_1,  VK_BAR_CHAN_RD(vktty, from));
>> +	vktty->is_opened = true;
> Again, why does this matter?  How can it ever be "false" if the
> structure is around?
Hmm, I thought I answered this before but maybe the email didn't go out.
We need to track whether a particular tty device is open or not to keep
data in the buffer and not advance the read pointer.  Otherwise the
data would be read from the device and discarded if the tty device
is not open.
>
> But the larger comment, why is a tty device even needed here at all?
The VK card has multiple physical UARTs connected to CPUs on the card.
These could be connected to the host server to access the CPUs' consoles.
But such physical connections are not practical in real use cases.
And especially not true when multiple (think 16) VK cards are plugged
into the same server.  Fortunately the UART data is also stored in
large circular buffers with read and write pointers in memory addressable
via BAR space.  A shared MSI interrupt is generated to host when read/write
offsets are updated.  Host writes a mailbox register to generate interrupt to card.

So the tty VK devices are used instead of the physical UART tty devices.
The host doesn't know any difference vs. opening /dev/ttyS0 for example.
>
> What is it being used for that the char device is not, or can not, be
> used for?
We are replacing tty devices /dev/ttyS0, ttyS1, etc with /dev/vk.x_ttyVKy
to access card x tty device y.
>
> You are tying two different user interfaces to the same PCI "resource"
> here, and having to go through a lot of gyrations to handle the
> reference count and logic for both of them.
>
> Why not split this up, as many other PCI drivers are having to do, if
> you REALLY need this, into two different "drivers" that both bind to
> different sub-children of this device?
We were not familiar with writing PCI device drivers before this VK driver.

The VK tty devices lifetime currently depends on the misc device to know the state of the card.
Also, the image loading and resets of the card are handled by the misc device and during these periods the tty devices would not be sane.
User processes of tty devices need to be terminated when the card does internal resets via ioctl or other notifier methods.
Also, tty dev nodes match MISC device nodes so we can access appropriate card x.
ie.  MISC devnode = /dev/vk.x has TTY devnodes y = /dev/tty.x_ttyVKy

So I think a VK tty driver would be a child of the misc driver?

Also, can 2 drivers both map the same BAR space to write mailbox registers and read status information? (sorry unfamiliar with PCIe to know)
There would also need to be a way for different MSI interrupts to be serviced between the drivers.

>   The virtual bus code that keeps
> getting posted to the networking mailing list is there to help solve
> this issue, as others are having the same problem.
I am not familiar with such support in the upstream kernel.  Could you point me at the post you are referring to?
It doesn't sound like such support exists in the kernel today?
>
> But, can you step back and explain why a TTY device is even needed?
> Your changelog does not explain it at all, only that "this is what the
> patch does", not "this is why we are doing this".
We need to access the UART devices over PCIe instead of physical cables connected to each UART as described above.
> thanks,
>
> greg k-h
If you think this tty driver can be split out and misc driver remain I could drop tty from this patch series to make the rest easier to accept and then work on whatever rewrite of the tty device is needed.  If I understood you comment above about "virtual bus code" perhaps that would be the way to go?

Regards,
Scott

--00000000000033831505b07ab369
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
I/3RRboOeC9M13VNr5feU91O0iDoMreAgPQJ0Lo7YrodKYug0Tt/fFDjkW3v3VIbEr2liUN69U0C
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUWOK7
qiyDSt/IDm/SRcNi/sTEiyswDQYJKoZIhvcNAQELBQADggEBAEe2edd4F9tpp0GPmrFrQ+xp9kY7
uxBzPdCw588bgVrPemjLwiwV37XTT4iWJtNhPfEpaguM6jeLm58LCvHq5/IBjcyHyf4URQVwAg7B
pqkH8/M+IBstu4/D+znPHB59X+c+au3Q8D+xoNFd7I30kaE+oJuBuFsGXRBc0Ci+FM86x9k7SF8U
aui1E7Y9wDfsRSCL2TSwU773f09WkrvVdlKxNqQZj2z7bQUUn+yfXdFfBz0LqlYNfn7xJOpQE3HI
H4jq6U9+b0Qf+J0n0wyysjXPSeQ7EKXVkT8dM2KSpIN86v5dd9LkAz3C1dmjuPRGEC8ZhI1IjMBt
0itrn6C23NsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgeI4ELTYt
3nkDEVUixMz6X51gnbFPyqA1sFTwaMg6UGowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAwOTI5MjE0NTIyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIeeHptnxuZMkx46u4Bi/PT8TEBn
hFiYMvs+JbmPpdu8gkUmQS6va1TrPOAW78Yl8li/Q7du8UbriHn/2nd/x2LGTrnC8SUnK4rlJ2F8
2vzkXRZ1TcebK8FbksPfCGx+mphOtoKV8w0pWwyOAIyW1S4IKZ8/BtMTz+mw8olWt6br8VcHiGeY
J9AOXYyI4GWmhmrtITwqAPyb1jlFOYcWmRM9aZ/THwMNjEzQwllGMEfGI8beOiMBoUVZVfNbqkPK
aeF8U+9CHJVQMqlAIS04cdlliOfyzcOpXY0WVhLIBIln1AYPnMDlBMytV5lQCg7419N6YEvD8qDE
WVgylyOUcSk=
--00000000000033831505b07ab369--
