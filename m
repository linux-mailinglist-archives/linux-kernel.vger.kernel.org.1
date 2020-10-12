Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283D128BD09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgJLP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgJLP6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:58:37 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C3E2067C;
        Mon, 12 Oct 2020 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602518315;
        bh=liPwYfK8PstYEsxOdTqBv3Uz10zosMn4dq0jRK+FncA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NMLxUavgck+LKSq02E3y/nrc5dWz52ZKrnIFwgmi2yl6XVP7/aUZ16IMDdFU9URnj
         KuXYtVwLgScFqxrpfE+ixYBi27st24uRiJ38yKL1MKqs5Fm5rbLAi6+4g/952vTIbD
         kqf4ZsgFc9QnKkiwPUoe8Lb927yyGijmItV8R76s=
From:   Felipe Balbi <balbi@kernel.org>
To:     rickyniu <rickyniu@google.com>, gregkh@linuxfoundation.org,
        astrachan@google.com, rickyniu@google.com, amit.pundir@linaro.org,
        lockwood@android.com, benoit@android.com, jackp@codeaurora.org,
        vvreddy@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kyletso@google.com
Subject: Re: [PATCH 1/3] ANDROID: usb: gadget: f_accessory: Add Android
 Accessory function
In-Reply-To: <20201012111024.2259162-2-rickyniu@google.com>
References: <20201012111024.2259162-1-rickyniu@google.com>
 <20201012111024.2259162-2-rickyniu@google.com>
Date:   Mon, 12 Oct 2020 18:58:27 +0300
Message-ID: <87blh7l9lo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

rickyniu <rickyniu@google.com> writes:
> From: Benoit Goby <benoit@android.com>

missing Signed-off-by for author

> USB accessory mode allows users to connect USB host hardware
> specifically designed for Android-powered devices. The accessories
> must adhere to the Android accessory protocol outlined in the
> http://accessories.android.com documentation. This allows
> Android devices that cannot act as a USB host to still interact with
> USB hardware. When an Android device is in USB accessory mode, the
> attached Android USB accessory acts as the host, provides power
> to the USB bus, and enumerates connected devices.

The protocol is still a HID protocol, is it? Why couldn't you use f_hid.c?

> Signed-off-by: Mike Lockwood <lockwood@android.com>
> [AmitP: Folded following android-4.9 commit changes into this patch
>         ceb2f0aac624 ("ANDROID: usb: gadget: accessory: Fix section misma=
tch")
>         Parts of e27543931009 ("ANDROID: usb: gadget: Fixes and hacks to =
make android usb gadget compile on 3.8")
>         1b07ec751563 ("ANDROID: drivers: usb: gadget: 64-bit related type=
 fixes")]
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> [astrachan: Folded the following changes into this patch:
>             9d5891d516e2 ("ANDROID: usb: gadget: f_accessory: Add ACCESSO=
RY_SET_AUDIO_MODE control request and ioctl")
>             dc66cfce9622 ("ANDROID: usb: gadget: f_accessory: Add support=
 for HID input devices")
>             5f1ac9c2871b ("ANDROID: usb: gadget: f_accessory: move usersp=
ace interface to uapi")
>             9a6241722cd8 ("ANDROID: usb: gadget: f_accessory: Enabled Zer=
o Length Packet (ZLP) for acc_write")
>             31a0ecd5a825 ("ANDROID: usb: gadget: f_accessory: check for a=
ccessory device before disconnecting HIDs")
>             580721fa6cbc ("ANDROID: usb: gadget: f_accessory: Migrate to =
USB_FUNCTION API")
>             7f407172fb28 ("ANDROID: usb: gadget: f_accessory: Fix for Usb=
Accessory clean unbind.")
>             ebc98ac5a22f ("ANDROID: usb: gadget: f_accessory: fix false d=
isconnect due to a signal sent to the reading process")
>             71c6dc5ffdab ("ANDROID: usb: gadget: f_accessory: assign no-o=
p request complete callbacks")
>             675047ee68e9 ("ANDROID: usb: gadget: f_accessory: Move gadget=
 functions code")
>             b2bedaa5c7df ("CHROMIUM: usb: gadget: f_accessory: add .raw_r=
equest callback")]
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> Signed-off-by: rickyniu <rickyniu@google.com>

We need an actual name here, IIRC.

> diff --git a/drivers/usb/gadget/function/f_accessory.c b/drivers/usb/gadg=
et/function/f_accessory.c
> new file mode 100644
> index 000000000000..514eadee1793
> --- /dev/null
> +++ b/drivers/usb/gadget/function/f_accessory.c
> @@ -0,0 +1,1352 @@

missing SPDX license identifier comment

> +/*
> + * Gadget Function Driver for Android USB accessories
> + *
> + * Copyright (C) 2011 Google, Inc.
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
> + *
> + */
> +
> +/* #define DEBUG */
> +/* #define VERBOSE_DEBUG */

these shouldn't be necessary

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/poll.h>
> +#include <linux/delay.h>
> +#include <linux/wait.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
> +
> +#include <linux/types.h>
> +#include <linux/file.h>
> +#include <linux/device.h>
> +#include <linux/miscdevice.h>
> +
> +#include <linux/hid.h>
> +#include <linux/hiddev.h>
>
> +#include <linux/usb.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/f_accessory.h>
> +
> +#include <linux/configfs.h>
> +#include <linux/usb/composite.h>
> +
> +#define MAX_INST_NAME_LEN        40
> +#define BULK_BUFFER_SIZE    16384
> +#define ACC_STRING_SIZE     256
> +
> +#define PROTOCOL_VERSION    2
> +
> +/* String IDs */
> +#define INTERFACE_STRING_INDEX	0
> +
> +/* number of tx and rx requests to allocate */
> +#define TX_REQ_MAX 4
> +#define RX_REQ_MAX 2
> +
> +struct acc_hid_dev {
> +	struct list_head	list;
> +	struct hid_device *hid;
> +	struct acc_dev *dev;
> +	/* accessory defined ID */
> +	int id;
> +	/* HID report descriptor */
> +	u8 *report_desc;
> +	/* length of HID report descriptor */
> +	int report_desc_len;
> +	/* number of bytes of report_desc we have received so far */
> +	int report_desc_offset;
> +};
> +
> +struct acc_dev {
> +	struct usb_function function;
> +	struct usb_composite_dev *cdev;
> +	spinlock_t lock;
> +
> +	struct usb_ep *ep_in;
> +	struct usb_ep *ep_out;
> +
> +	/* online indicates state of function_set_alt & function_unbind
> +	 * set to 1 when we connect
> +	 */

wrong multi-line comment style

> +	int online:1;
> +
> +	/* disconnected indicates state of open & release
> +	 * Set to 1 when we disconnect.
> +	 * Not cleared until our file is closed.
> +	 */
> +	int disconnected:1;
> +
> +	/* strings sent by the host */
> +	char manufacturer[ACC_STRING_SIZE];
> +	char model[ACC_STRING_SIZE];
> +	char description[ACC_STRING_SIZE];
> +	char version[ACC_STRING_SIZE];
> +	char uri[ACC_STRING_SIZE];
> +	char serial[ACC_STRING_SIZE];
> +
> +	/* for acc_complete_set_string */
> +	int string_index;
> +
> +	/* set to 1 if we have a pending start request */
> +	int start_requested;
> +
> +	int audio_mode;
> +
> +	/* synchronize access to our device file */
> +	atomic_t open_excl;
> +
> +	struct list_head tx_idle;
> +
> +	wait_queue_head_t read_wq;
> +	wait_queue_head_t write_wq;
> +	struct usb_request *rx_req[RX_REQ_MAX];
> +	int rx_done;
> +
> +	/* delayed work for handling ACCESSORY_START */
> +	struct delayed_work start_work;
> +
> +	/* worker for registering and unregistering hid devices */
> +	struct work_struct hid_work;

why are these workers needed?

> +static struct usb_interface_descriptor acc_interface_desc =3D {
> +	.bLength                =3D USB_DT_INTERFACE_SIZE,
> +	.bDescriptorType        =3D USB_DT_INTERFACE,
> +	.bInterfaceNumber       =3D 0,
> +	.bNumEndpoints          =3D 2,
> +	.bInterfaceClass        =3D USB_CLASS_VENDOR_SPEC,
> +	.bInterfaceSubClass     =3D USB_SUBCLASS_VENDOR_SPEC,
> +	.bInterfaceProtocol     =3D 0,
> +};

const?

> +static struct usb_endpoint_descriptor acc_highspeed_in_desc =3D {
> +	.bLength                =3D USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType        =3D USB_DT_ENDPOINT,
> +	.bEndpointAddress       =3D USB_DIR_IN,
> +	.bmAttributes           =3D USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize         =3D __constant_cpu_to_le16(512),
> +};

const?

> +static struct usb_endpoint_descriptor acc_highspeed_out_desc =3D {
> +	.bLength                =3D USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType        =3D USB_DT_ENDPOINT,
> +	.bEndpointAddress       =3D USB_DIR_OUT,
> +	.bmAttributes           =3D USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize         =3D __constant_cpu_to_le16(512),
> +};

const?

> +static struct usb_endpoint_descriptor acc_fullspeed_in_desc =3D {
> +	.bLength                =3D USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType        =3D USB_DT_ENDPOINT,
> +	.bEndpointAddress       =3D USB_DIR_IN,
> +	.bmAttributes           =3D USB_ENDPOINT_XFER_BULK,
> +};

const?

> +static struct usb_endpoint_descriptor acc_fullspeed_out_desc =3D {
> +	.bLength                =3D USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType        =3D USB_DT_ENDPOINT,
> +	.bEndpointAddress       =3D USB_DIR_OUT,
> +	.bmAttributes           =3D USB_ENDPOINT_XFER_BULK,
> +};

const?

> +static struct usb_descriptor_header *fs_acc_descs[] =3D {
> +	(struct usb_descriptor_header *) &acc_interface_desc,
> +	(struct usb_descriptor_header *) &acc_fullspeed_in_desc,
> +	(struct usb_descriptor_header *) &acc_fullspeed_out_desc,
> +	NULL,
> +};

const?

> +static struct usb_descriptor_header *hs_acc_descs[] =3D {
> +	(struct usb_descriptor_header *) &acc_interface_desc,
> +	(struct usb_descriptor_header *) &acc_highspeed_in_desc,
> +	(struct usb_descriptor_header *) &acc_highspeed_out_desc,
> +	NULL,
> +};

const?

> +/* temporary variable used between acc_open() and acc_gadget_bind() */
> +static struct acc_dev *_acc_dev;

why?

> +struct acc_instance {
> +	struct usb_function_instance func_inst;
> +	const char *name;
> +};
> +
> +static inline struct acc_dev *func_to_dev(struct usb_function *f)
> +{
> +	return container_of(f, struct acc_dev, function);
> +}

this can be a define, but fine :-)

> +static void acc_request_free(struct usb_request *req, struct usb_ep *ep)
> +{
> +	if (req) {

why would req ever be NULL here?

> +static void req_put(struct acc_dev *dev, struct list_head *head,

how about we use a more descriptive name? Usually this would be called $pre=
fix_enqueue().

> +		struct usb_request *req)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->lock, flags);
> +	list_add_tail(&req->list, head);
> +	spin_unlock_irqrestore(&dev->lock, flags);
> +}
> +
> +/* remove a request from the head of a list */
> +static struct usb_request *req_get(struct acc_dev *dev, struct list_head=
 *head)
> +{
> +	unsigned long flags;
> +	struct usb_request *req;
> +
> +	spin_lock_irqsave(&dev->lock, flags);
> +	if (list_empty(head)) {
> +		req =3D 0;
> +	} else {
> +		req =3D list_first_entry(head, struct usb_request, list);
> +		list_del(&req->list);
> +	}

list_first_entry_or_null()?

> +static void acc_complete_in(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct acc_dev *dev =3D _acc_dev;
> +
> +	if (req->status =3D=3D -ESHUTDOWN) {
> +		pr_debug("acc_complete_in set disconnected");

yeah, we need something with a dev* for these prints.

> +static int acc_hid_start(struct hid_device *hid)
> +{
> +	return 0;
> +}
> +
> +static void acc_hid_stop(struct hid_device *hid)
> +{
> +}
> +
> +static int acc_hid_open(struct hid_device *hid)
> +{
> +	return 0;
> +}
> +
> +static void acc_hid_close(struct hid_device *hid)
> +{
> +}
> +
> +static int acc_hid_raw_request(struct hid_device *hid, unsigned char rep=
ortnum,
> +	__u8 *buf, size_t len, unsigned char rtype, int reqtype)
> +{
> +	return 0;
> +}

what's with all the unimplemented methods?

> +static long acc_ioctl(struct file *fp, unsigned code, unsigned long valu=
e)
> +{
> +	struct acc_dev *dev =3D fp->private_data;
> +	char *src =3D NULL;
> +	int ret;
> +
> +	switch (code) {
> +	case ACCESSORY_GET_STRING_MANUFACTURER:
> +		src =3D dev->manufacturer;
> +		break;
> +	case ACCESSORY_GET_STRING_MODEL:
> +		src =3D dev->model;
> +		break;
> +	case ACCESSORY_GET_STRING_DESCRIPTION:
> +		src =3D dev->description;
> +		break;
> +	case ACCESSORY_GET_STRING_VERSION:
> +		src =3D dev->version;
> +		break;
> +	case ACCESSORY_GET_STRING_URI:
> +		src =3D dev->uri;
> +		break;
> +	case ACCESSORY_GET_STRING_SERIAL:
> +		src =3D dev->serial;
> +		break;
> +	case ACCESSORY_IS_START_REQUESTED:
> +		return dev->start_requested;
> +	case ACCESSORY_GET_AUDIO_MODE:
> +		return dev->audio_mode;
> +	}
> +	if (!src)
> +		return -EINVAL;

add this part as a default on the switch above?

> +
> +	ret =3D strlen(src) + 1;
> +	if (copy_to_user((void __user *)value, src, ret))
> +		ret =3D -EFAULT;
> +	return ret;
> +}
> +
> +static int acc_open(struct inode *ip, struct file *fp)
> +{
> +	printk(KERN_INFO "acc_open\n");

no printk() calls!

why couldn't you get your acc_dev from fp->private_data?

> +	if (atomic_xchg(&_acc_dev->open_excl, 1))

do you really need this to be an atomic_t?

> +int acc_ctrlrequest(struct usb_composite_dev *cdev,
> +				const struct usb_ctrlrequest *ctrl)
> +{
> +	struct acc_dev	*dev =3D _acc_dev;
> +	int	value =3D -EOPNOTSUPP;
> +	struct acc_hid_dev *hid;
> +	int offset;
> +	u8 b_requestType =3D ctrl->bRequestType;
> +	u8 b_request =3D ctrl->bRequest;
> +	u16	w_index =3D le16_to_cpu(ctrl->wIndex);
> +	u16	w_value =3D le16_to_cpu(ctrl->wValue);
> +	u16	w_length =3D le16_to_cpu(ctrl->wLength);
> +	unsigned long flags;
> +
> +/*
> +	printk(KERN_INFO "acc_ctrlrequest "
> +			"%02x.%02x v%04x i%04x l%u\n",
> +			b_requestType, b_request,
> +			w_value, w_index, w_length);
> +*/

commented out code? Please remove.

> +	if (b_requestType =3D=3D (USB_DIR_OUT | USB_TYPE_VENDOR)) {
> +		if (b_request =3D=3D ACCESSORY_START) {

looks like a switch statement is fitting here?

> +EXPORT_SYMBOL_GPL(acc_ctrlrequest);

why do you export this for any caller? Who is going to call this?

> +void acc_disconnect(void)
> +{
> +	/* unregister all HID devices if USB is disconnected */
> +	kill_all_hid_devices(_acc_dev);
> +}
> +EXPORT_SYMBOL_GPL(acc_disconnect);

why exported?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+EfSMRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZhtw//Xfko0STxsJ3+/9f+LCsuifkWT0c2ju6R
KOszmTDUn8TQykvKVPyAoH3JIppgbTpV4l1s335O7Qs3LeRhp3/FWGCZCsLWjeBm
4du0Z/ZdGlsOF6DWdolGfWunPxOv30jVe7+wLs2gpEID4NL7+9Fqjg7o08CcgQ+E
+Jt2gwi39NMYMuoEtNPmOBaJw5ASmL2vvJXbUMTJN3zidixIfKeHbUky4Fdq5LEe
T8m7BE/BEcRDQ7gX7RMBHn8kmJnzpaSXSRY8ieknmyjGCcL/JSATiZmoMCQVz28L
J6MCBgenEAnCgMJ9NxIQj4BSLPuichHCzlq7o9JJ2bo1LbkTQ0IWPHW5gs/6gUQr
hCIIbQTQFOKlQQqGibS+YQplp/eu4AMcZSbWIhfbt0vzL4pRBC6VrwqNSclpjZp/
OBUC9KxlVyMO8if6ouMLX7nWZ/I+s4Oeq+NnRNS5joNN/biDtUiwNNa6FxqZec1Y
hLN6ITMXaRcINo7V0qRgfyW429yx2kFPxq8JMoS6BCNcZpa14U8zIcYOyCuFWsFv
NOnZvvP6N2WN+DBPBkzNLbvKp0FDGaxKgGATl97a9TyRnrWfhww5NloZ8DlAX3kG
sVgQJvqB1KkHlyQJzJVCrQlxFq2WJiCa7OwNuRW7YkCPUwA+Zg+NFn9N0MHxoJla
AguHkx2woPY=
=nf/7
-----END PGP SIGNATURE-----
--=-=-=--
