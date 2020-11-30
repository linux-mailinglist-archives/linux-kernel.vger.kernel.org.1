Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96D72C7E09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgK3GKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:10:39 -0500
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:15552
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgK3GKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:10:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvMocZ8J8MHKujghdX+RuLOnoE/LUrsQQkPySeTG3/Cbx1HVVTlbWp42D1Z6QDlZMviw6bp0GCFTh9i+Pz5gj5OHfD49veCrsyirkcQlkcvkVKxoB+MWGhIT8Nl60Lk/n+QnlAHMNzQJJVksbkb5VmVG6O3+ay8qX2ntGt46p3KqE9+AHQewkkbcYWioF3MF1A3n1PuWTry2Wb4BjELcuX/msDCBfDC/Z0nmfVVJby1UXjpSNNUAZoFqmvG+IN8jmNK7NKJWgG33r9tnhB4CvA9g9fxixxQtghUuvYJ4vznU5ccDhPM2RHumIoP/WsACqceF8db6IcGhxlOxzfMyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMqUOd4IvU6j4HHCoBbHAgP225jK8IxjHVgGZEnk7eM=;
 b=UW5iwO1Az2O9BrnjoOV+yznqzCGpyAptN9/WAYqn/8EJaN+xvzwCPB4oD8hzuHYIsSEgGHPN1c3KBeDSWVJFbnYLZTXN2kduJEvGJ2Vt+H1uZe7jOirFUQGl+UNRVB4Ebfrnyda+P16pNyrXvfvI6ngTh4rimS1LiU4AG/6SFQDwH4b9ow7h4LAJWp1rgsWMy/AdthJfsRJgAUJkJQd/xdHrNiHJ0Le6bWhdslhF/OHnrqJpbpFYlousVKspT8Xdm8Sz4Io63CXJnyKmOCj3o+1assJTYC0qERfCbLyH9qNejCNJkpe7syLHyajiTYNBuadsxcWzzvGL3JCgq9wpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMqUOd4IvU6j4HHCoBbHAgP225jK8IxjHVgGZEnk7eM=;
 b=Xec6KTb3PnVd9EbTxZHriBlus0IweyCoTiGJKvizNPmVKvBnQxXgmrlsx4EtqO1kafCC9N6dG0++tr/J5melsTdXEVhT5jAOKhY/ZXBnSzFZaQ/YZXSQejB5y73x7nzGJQ5/sf/4NBV5OSjoUVtwF+uLRzakcLJ+dhXAa4K5Qqg=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB4233.eurprd04.prod.outlook.com (2603:10a6:5:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Mon, 30 Nov
 2020 06:09:44 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 06:09:44 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "willmcvicker@google.com" <willmcvicker@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] USB: gadget: f_fs: remove likely/unlikely
Thread-Topic: [PATCH v2 5/5] USB: gadget: f_fs: remove likely/unlikely
Thread-Index: AQHWxMaATMegqth+zUaViRxmSYobWangNRoA
Date:   Mon, 30 Nov 2020 06:09:44 +0000
Message-ID: <20201130060914.GA32154@b29397-desktop>
References: <20201127140559.381351-1-gregkh@linuxfoundation.org>
 <20201127140559.381351-6-gregkh@linuxfoundation.org>
In-Reply-To: <20201127140559.381351-6-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33aa8fbb-8aef-4744-6f5c-08d894f68844
x-ms-traffictypediagnostic: DB7PR04MB4233:
x-microsoft-antispam-prvs: <DB7PR04MB423327B8778F4FB3AED2E09A8BF50@DB7PR04MB4233.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqHCXbRlX8AyeBZK93iJvabM7M4ZmMOTGfImydIwnBmjwgAtYMM0vM50ckBUl5krEY/Bn5WicyQhZ1cmRHM+DDpSE564bYck1ZlV/ddwut6/yxAk8ut8A5LiJlHY1oeEGAd9RY+XU2ktlbexMC4YFFmCRRT2xsZbtOcH4d/64QtMp3DjqotepBsKVq039XEFid7zjIyVkvzs0RLXU89ZmOKE2KU01pSMlUuJ7jFjUOwiuN8+XbMwwcGSJgYFMtcUXWX8wUjPuczE8nCq4yy/E6WdQpATTjen9OmI95LnNk2DBZnOvIhXM397jA4ZGO1tBmV/qy/Rk/BH8bHSWDMroA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(33716001)(76116006)(91956017)(4326008)(71200400001)(6512007)(9686003)(478600001)(66946007)(66556008)(8676002)(66446008)(66476007)(64756008)(2906002)(33656002)(30864003)(86362001)(1076003)(26005)(6486002)(8936002)(186003)(6506007)(54906003)(44832011)(5660300002)(316002)(6916009)(83380400001)(53546011)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZOo3OHnNfa7do6n6O5rd33XrT+PrzxlerMnmojbSXyGNjMyC3zjpMaQTSdmD?=
 =?us-ascii?Q?Ymo8vsFa01mSBUGGGBi6hrYiDzn+obj1KNPOp1yP+SAUFHuOJDBDoiIZZFul?=
 =?us-ascii?Q?zC+y9aQosohVROQVHr0oo7sSAvQx6VG4TXIakPHSoHBI7HNsix1j3zrVJqe1?=
 =?us-ascii?Q?4pbaY3SBvQdLoPDAn4ufpyFgBO+mJlsrsMq/p5h1+po1zSfrej2nTttPaA0z?=
 =?us-ascii?Q?EuF3KCMbcvoCK1MrsHVFBaccrfhkDgYtzOqSP75fkgzn5AR6d+NZqoD9a5pc?=
 =?us-ascii?Q?7IcvXJoax8ydGcMjcpnKcgjLrTCMUciFBGgl9idLZrb9HM1wX1f1DHW5SO1Z?=
 =?us-ascii?Q?hzuLP2Wyhpz3b3BgM/jh5CUPhH5Jwn5ulOIfk2DpjnN0zcGgM8DdRF9dNB+Y?=
 =?us-ascii?Q?gLjDQ2ihfdEGAaBJxbpV1Im3U8fMW3Y2l27fgyB7mG2VSrc0vYCsgA8k2ORI?=
 =?us-ascii?Q?jwS9AvX2OKXUGwxnV4UX8Hmdsudr75w/+J3GsveRjdMlHqOJeVZ9MG9/2Sh8?=
 =?us-ascii?Q?WjLEb4wjuDhjSE20TvIVUn7M/VJrxjQKF+tGqRpDRN1ptEXoq73+tN+4vbxv?=
 =?us-ascii?Q?8st+ndGlg/6cGSxXdD7ZwbRXTSim5y6IoppB4s1kKBjgb47QoBRKJFjXVkrt?=
 =?us-ascii?Q?89potN03Omenovg5gpVTjiw3llR/Xv/Jx3iFyRM33EdWu7/7z7JYqPWPWDoT?=
 =?us-ascii?Q?Ug21/u+yaPtneTdU4ATSSISaKbZ3JsPfm0lgECgNIHo+D/DLgOxeAGqZfZsC?=
 =?us-ascii?Q?fjvkcXG4y1hiPCGd7KHZ7oStOODNcFGcM6Ve5gppzeAfdg9lqnzMhV7zXF4D?=
 =?us-ascii?Q?8g0ObEMmDaZYYwbp4bcuqzim14iKhYDuwgdFzvZVkTm3q6HtBuFtV61soI8B?=
 =?us-ascii?Q?DNG5R7bHuxGgWaOpeMHVsWG+MIxSNT++1EXWiU0bJLKBAz86hBJdJhq5FM7d?=
 =?us-ascii?Q?UZSFKGfbl+R7YjdN04lQGKGoKi7+EElmh7o5KwRRNYjAD3K2bIGX4l34oPYf?=
 =?us-ascii?Q?2uH2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <079B338A9A5DE642B6F5DA3BF4164C60@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa8fbb-8aef-4744-6f5c-08d894f68844
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 06:09:44.0682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffDbXXls2yr7LsB3xVQxU0qIN2sQVFgQyRF457q9UNlhLI0o7dxT0dWw3D9iLak8uZMdYaOCQ5D2skl9ivnKgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-27 15:05:59, Greg Kroah-Hartman wrote:
> They are used way too often in this file, in some ways that are actually
> wrong.  Almost all of these are already known by the compiler and CPU so
> just remove them all as none of these should be on any "hot paths" where
> it actually matters.
>=20
> Cc: Felipe Balbi <balbi@kernel.org>
> Reported-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 179 ++++++++++++++---------------
>  1 file changed, 89 insertions(+), 90 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/func=
tion/f_fs.c
> index a34a7c96a1ab..9047b20b6715 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -296,11 +296,11 @@ static int __ffs_ep0_queue_wait(struct ffs_data *ff=
s, char *data, size_t len)
>  	reinit_completion(&ffs->ep0req_completion);
> =20
>  	ret =3D usb_ep_queue(ffs->gadget->ep0, req, GFP_ATOMIC);
> -	if (unlikely(ret < 0))
> +	if (ret < 0)
>  		return ret;
> =20
>  	ret =3D wait_for_completion_interruptible(&ffs->ep0req_completion);
> -	if (unlikely(ret)) {
> +	if (ret) {
>  		usb_ep_dequeue(ffs->gadget->ep0, req);
>  		return -EINTR;
>  	}
> @@ -337,7 +337,7 @@ static ssize_t ffs_ep0_write(struct file *file, const=
 char __user *buf,
> =20
>  	/* Acquire mutex */
>  	ret =3D ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
> -	if (unlikely(ret < 0))
> +	if (ret < 0)
>  		return ret;
> =20
>  	/* Check state */
> @@ -345,7 +345,7 @@ static ssize_t ffs_ep0_write(struct file *file, const=
 char __user *buf,
>  	case FFS_READ_DESCRIPTORS:
>  	case FFS_READ_STRINGS:
>  		/* Copy data */
> -		if (unlikely(len < 16)) {
> +		if (len < 16) {
>  			ret =3D -EINVAL;
>  			break;
>  		}
> @@ -360,7 +360,7 @@ static ssize_t ffs_ep0_write(struct file *file, const=
 char __user *buf,
>  		if (ffs->state =3D=3D FFS_READ_DESCRIPTORS) {
>  			pr_info("read descriptors\n");
>  			ret =3D __ffs_data_got_descs(ffs, data, len);
> -			if (unlikely(ret < 0))
> +			if (ret < 0)
>  				break;
> =20
>  			ffs->state =3D FFS_READ_STRINGS;
> @@ -368,11 +368,11 @@ static ssize_t ffs_ep0_write(struct file *file, con=
st char __user *buf,
>  		} else {
>  			pr_info("read strings\n");
>  			ret =3D __ffs_data_got_strings(ffs, data, len);
> -			if (unlikely(ret < 0))
> +			if (ret < 0)
>  				break;
> =20
>  			ret =3D ffs_epfiles_create(ffs);
> -			if (unlikely(ret)) {
> +			if (ret) {
>  				ffs->state =3D FFS_CLOSING;
>  				break;
>  			}
> @@ -381,7 +381,7 @@ static ssize_t ffs_ep0_write(struct file *file, const=
 char __user *buf,
>  			mutex_unlock(&ffs->mutex);
> =20
>  			ret =3D ffs_ready(ffs);
> -			if (unlikely(ret < 0)) {
> +			if (ret < 0) {
>  				ffs->state =3D FFS_CLOSING;
>  				return ret;
>  			}
> @@ -495,7 +495,7 @@ static ssize_t __ffs_ep0_read_events(struct ffs_data =
*ffs, char __user *buf,
>  	spin_unlock_irq(&ffs->ev.waitq.lock);
>  	mutex_unlock(&ffs->mutex);
> =20
> -	return unlikely(copy_to_user(buf, events, size)) ? -EFAULT : size;
> +	return copy_to_user(buf, events, size) ? -EFAULT : size;
>  }
> =20
>  static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
> @@ -514,7 +514,7 @@ static ssize_t ffs_ep0_read(struct file *file, char _=
_user *buf,
> =20
>  	/* Acquire mutex */
>  	ret =3D ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
> -	if (unlikely(ret < 0))
> +	if (ret < 0)
>  		return ret;
> =20
>  	/* Check state */
> @@ -536,7 +536,7 @@ static ssize_t ffs_ep0_read(struct file *file, char _=
_user *buf,
> =20
>  	case FFS_NO_SETUP:
>  		n =3D len / sizeof(struct usb_functionfs_event);
> -		if (unlikely(!n)) {
> +		if (!n) {
>  			ret =3D -EINVAL;
>  			break;
>  		}
> @@ -567,9 +567,9 @@ static ssize_t ffs_ep0_read(struct file *file, char _=
_user *buf,
> =20
>  		spin_unlock_irq(&ffs->ev.waitq.lock);
> =20
> -		if (likely(len)) {
> +		if (len) {
>  			data =3D kmalloc(len, GFP_KERNEL);
> -			if (unlikely(!data)) {
> +			if (!data) {
>  				ret =3D -ENOMEM;
>  				goto done_mutex;
>  			}
> @@ -586,7 +586,7 @@ static ssize_t ffs_ep0_read(struct file *file, char _=
_user *buf,
> =20
>  		/* unlocks spinlock */
>  		ret =3D __ffs_ep0_queue_wait(ffs, data, len);
> -		if (likely(ret > 0) && unlikely(copy_to_user(buf, data, len)))
> +		if ((ret > 0) && (copy_to_user(buf, data, len)))
>  			ret =3D -EFAULT;
>  		goto done_mutex;
> =20
> @@ -608,7 +608,7 @@ static int ffs_ep0_open(struct inode *inode, struct f=
ile *file)
> =20
>  	ENTER();
> =20
> -	if (unlikely(ffs->state =3D=3D FFS_CLOSING))
> +	if (ffs->state =3D=3D FFS_CLOSING)
>  		return -EBUSY;
> =20
>  	file->private_data =3D ffs;
> @@ -657,7 +657,7 @@ static __poll_t ffs_ep0_poll(struct file *file, poll_=
table *wait)
>  	poll_wait(file, &ffs->ev.waitq, wait);
> =20
>  	ret =3D ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
> -	if (unlikely(ret < 0))
> +	if (ret < 0)
>  		return mask;
> =20
>  	switch (ffs->state) {
> @@ -706,7 +706,7 @@ static const struct file_operations ffs_ep0_operation=
s =3D {
>  static void ffs_epfile_io_complete(struct usb_ep *_ep, struct usb_reques=
t *req)
>  {
>  	ENTER();
> -	if (likely(req->context)) {
> +	if (req->context) {
>  		struct ffs_ep *ep =3D _ep->driver_data;
>  		ep->status =3D req->status ? req->status : req->actual;
>  		complete(req->context);
> @@ -716,10 +716,10 @@ static void ffs_epfile_io_complete(struct usb_ep *_=
ep, struct usb_request *req)
>  static ssize_t ffs_copy_to_iter(void *data, int data_len, struct iov_ite=
r *iter)
>  {
>  	ssize_t ret =3D copy_to_iter(data, data_len, iter);
> -	if (likely(ret =3D=3D data_len))
> +	if (ret =3D=3D data_len)
>  		return ret;
> =20
> -	if (unlikely(iov_iter_count(iter)))
> +	if (iov_iter_count(iter))
>  		return -EFAULT;
> =20
>  	/*
> @@ -885,7 +885,7 @@ static ssize_t __ffs_epfile_read_buffered(struct ffs_=
epfile *epfile,
>  		return ret;
>  	}
> =20
> -	if (unlikely(iov_iter_count(iter))) {
> +	if (iov_iter_count(iter)) {
>  		ret =3D -EFAULT;
>  	} else {
>  		buf->length -=3D ret;
> @@ -906,10 +906,10 @@ static ssize_t __ffs_epfile_read_data(struct ffs_ep=
file *epfile,
>  	struct ffs_buffer *buf;
> =20
>  	ssize_t ret =3D copy_to_iter(data, data_len, iter);
> -	if (likely(data_len =3D=3D ret))
> +	if (data_len =3D=3D ret)
>  		return ret;
> =20
> -	if (unlikely(iov_iter_count(iter)))
> +	if (iov_iter_count(iter))
>  		return -EFAULT;
> =20
>  	/* See ffs_copy_to_iter for more context. */
> @@ -930,7 +930,7 @@ static ssize_t __ffs_epfile_read_data(struct ffs_epfi=
le *epfile,
>  	 * in struct ffs_epfile for full read_buffer pointer synchronisation
>  	 * story.
>  	 */
> -	if (unlikely(cmpxchg(&epfile->read_buffer, NULL, buf)))
> +	if (cmpxchg(&epfile->read_buffer, NULL, buf))
>  		kfree(buf);
> =20
>  	return ret;
> @@ -968,7 +968,7 @@ static ssize_t ffs_epfile_io(struct file *file, struc=
t ffs_io_data *io_data)
> =20
>  	/* We will be using request and read_buffer */
>  	ret =3D ffs_mutex_lock(&epfile->mutex, file->f_flags & O_NONBLOCK);
> -	if (unlikely(ret))
> +	if (ret)
>  		goto error;
> =20
>  	/* Allocate & copy */
> @@ -1013,7 +1013,7 @@ static ssize_t ffs_epfile_io(struct file *file, str=
uct ffs_io_data *io_data)
>  		spin_unlock_irq(&epfile->ffs->eps_lock);
> =20
>  		data =3D ffs_alloc_buffer(io_data, data_len);
> -		if (unlikely(!data)) {
> +		if (!data) {
>  			ret =3D -ENOMEM;
>  			goto error_mutex;
>  		}
> @@ -1033,7 +1033,7 @@ static ssize_t ffs_epfile_io(struct file *file, str=
uct ffs_io_data *io_data)
>  		ret =3D usb_ep_set_halt(ep->ep);
>  		if (!ret)
>  			ret =3D -EBADMSG;
> -	} else if (unlikely(data_len =3D=3D -EINVAL)) {
> +	} else if (data_len =3D=3D -EINVAL) {
>  		/*
>  		 * Sanity Check: even though data_len can't be used
>  		 * uninitialized at the time I write this comment, some
> @@ -1068,12 +1068,12 @@ static ssize_t ffs_epfile_io(struct file *file, s=
truct ffs_io_data *io_data)
>  		req->complete =3D ffs_epfile_io_complete;
> =20
>  		ret =3D usb_ep_queue(ep->ep, req, GFP_ATOMIC);
> -		if (unlikely(ret < 0))
> +		if (ret < 0)
>  			goto error_lock;
> =20
>  		spin_unlock_irq(&epfile->ffs->eps_lock);
> =20
> -		if (unlikely(wait_for_completion_interruptible(&done))) {
> +		if (wait_for_completion_interruptible(&done)) {
>  			/*
>  			 * To avoid race condition with ffs_epfile_io_complete,
>  			 * dequeue the request first then check
> @@ -1115,7 +1115,7 @@ static ssize_t ffs_epfile_io(struct file *file, str=
uct ffs_io_data *io_data)
>  		req->complete =3D ffs_epfile_async_io_complete;
> =20
>  		ret =3D usb_ep_queue(ep->ep, req, GFP_ATOMIC);
> -		if (unlikely(ret)) {
> +		if (ret) {
>  			io_data->req =3D NULL;
>  			usb_ep_free_request(ep->ep, req);
>  			goto error_lock;
> @@ -1166,7 +1166,7 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
> =20
>  	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
> =20
> -	if (likely(io_data && io_data->ep && io_data->req))
> +	if (io_data && io_data->ep && io_data->req)
>  		value =3D usb_ep_dequeue(io_data->ep, io_data->req);
>  	else
>  		value =3D -EINVAL;
> @@ -1185,7 +1185,7 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *=
kiocb, struct iov_iter *from)
> =20
>  	if (!is_sync_kiocb(kiocb)) {
>  		p =3D kzalloc(sizeof(io_data), GFP_KERNEL);
> -		if (unlikely(!p))
> +		if (!p)
>  			return -ENOMEM;
>  		p->aio =3D true;
>  	} else {
> @@ -1222,7 +1222,7 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *k=
iocb, struct iov_iter *to)
> =20
>  	if (!is_sync_kiocb(kiocb)) {
>  		p =3D kzalloc(sizeof(io_data), GFP_KERNEL);
> -		if (unlikely(!p))
> +		if (!p)
>  			return -ENOMEM;
>  		p->aio =3D true;
>  	} else {
> @@ -1384,7 +1384,7 @@ ffs_sb_make_inode(struct super_block *sb, void *dat=
a,
> =20
>  	inode =3D new_inode(sb);
> =20
> -	if (likely(inode)) {
> +	if (inode) {
>  		struct timespec64 ts =3D current_time(inode);
> =20
>  		inode->i_ino	 =3D get_next_ino();
> @@ -1416,11 +1416,11 @@ static struct dentry *ffs_sb_create_file(struct s=
uper_block *sb,
>  	ENTER();
> =20
>  	dentry =3D d_alloc_name(sb->s_root, name);
> -	if (unlikely(!dentry))
> +	if (!dentry)
>  		return NULL;
> =20
>  	inode =3D ffs_sb_make_inode(sb, data, fops, NULL, &ffs->file_perms);
> -	if (unlikely(!inode)) {
> +	if (!inode) {
>  		dput(dentry);
>  		return NULL;
>  	}
> @@ -1467,12 +1467,11 @@ static int ffs_sb_fill(struct super_block *sb, st=
ruct fs_context *fc)
>  				  &simple_dir_inode_operations,
>  				  &data->perms);
>  	sb->s_root =3D d_make_root(inode);
> -	if (unlikely(!sb->s_root))
> +	if (!sb->s_root)
>  		return -ENOMEM;
> =20
>  	/* EP0 file */
> -	if (unlikely(!ffs_sb_create_file(sb, "ep0", ffs,
> -					 &ffs_ep0_operations)))
> +	if (!ffs_sb_create_file(sb, "ep0", ffs, &ffs_ep0_operations))
>  		return -ENOMEM;
> =20
>  	return 0;
> @@ -1560,13 +1559,13 @@ static int ffs_fs_get_tree(struct fs_context *fc)
>  		return invalf(fc, "No source specified");
> =20
>  	ffs =3D ffs_data_new(fc->source);
> -	if (unlikely(!ffs))
> +	if (!ffs)
>  		return -ENOMEM;
>  	ffs->file_perms =3D ctx->perms;
>  	ffs->no_disconnect =3D ctx->no_disconnect;
> =20
>  	ffs->dev_name =3D kstrdup(fc->source, GFP_KERNEL);
> -	if (unlikely(!ffs->dev_name)) {
> +	if (!ffs->dev_name) {
>  		ffs_data_put(ffs);
>  		return -ENOMEM;
>  	}
> @@ -1652,7 +1651,7 @@ static int functionfs_init(void)
>  	ENTER();
> =20
>  	ret =3D register_filesystem(&ffs_fs_type);
> -	if (likely(!ret))
> +	if (!ret)
>  		pr_info("file system registered\n");
>  	else
>  		pr_err("failed registering file system (%d)\n", ret);
> @@ -1697,7 +1696,7 @@ static void ffs_data_put(struct ffs_data *ffs)
>  {
>  	ENTER();
> =20
> -	if (unlikely(refcount_dec_and_test(&ffs->ref))) {
> +	if (refcount_dec_and_test(&ffs->ref)) {
>  		pr_info("%s(): freeing\n", __func__);
>  		ffs_data_clear(ffs);
>  		BUG_ON(waitqueue_active(&ffs->ev.waitq) ||
> @@ -1739,7 +1738,7 @@ static void ffs_data_closed(struct ffs_data *ffs)
>  static struct ffs_data *ffs_data_new(const char *dev_name)
>  {
>  	struct ffs_data *ffs =3D kzalloc(sizeof *ffs, GFP_KERNEL);
> -	if (unlikely(!ffs))
> +	if (!ffs)
>  		return NULL;
> =20
>  	ENTER();
> @@ -1829,11 +1828,11 @@ static int functionfs_bind(struct ffs_data *ffs, =
struct usb_composite_dev *cdev)
>  		return -EBADFD;
> =20
>  	first_id =3D usb_string_ids_n(cdev, ffs->strings_count);
> -	if (unlikely(first_id < 0))
> +	if (first_id < 0)
>  		return first_id;
> =20
>  	ffs->ep0req =3D usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
> -	if (unlikely(!ffs->ep0req))
> +	if (!ffs->ep0req)
>  		return -ENOMEM;
>  	ffs->ep0req->complete =3D ffs_ep0_complete;
>  	ffs->ep0req->context =3D ffs;
> @@ -1889,7 +1888,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
>  		epfile->dentry =3D ffs_sb_create_file(ffs->sb, epfile->name,
>  						 epfile,
>  						 &ffs_epfile_operations);
> -		if (unlikely(!epfile->dentry)) {
> +		if (!epfile->dentry) {
>  			ffs_epfiles_destroy(epfiles, i - 1);
>  			return -ENOMEM;
>  		}
> @@ -1927,7 +1926,7 @@ static void ffs_func_eps_disable(struct ffs_functio=
n *func)
>  	spin_lock_irqsave(&func->ffs->eps_lock, flags);
>  	while (count--) {
>  		/* pending requests get nuked */
> -		if (likely(ep->ep))
> +		if (ep->ep)
>  			usb_ep_disable(ep->ep);
>  		++ep;
> =20
> @@ -1961,7 +1960,7 @@ static int ffs_func_eps_enable(struct ffs_function =
*func)
>  		}
> =20
>  		ret =3D usb_ep_enable(ep->ep);
> -		if (likely(!ret)) {
> +		if (!ret) {
>  			epfile->ep =3D ep;
>  			epfile->in =3D usb_endpoint_dir_in(ep->ep->desc);
>  			epfile->isoc =3D usb_endpoint_xfer_isoc(ep->ep->desc);
> @@ -2034,12 +2033,12 @@ static int __must_check ffs_do_single_desc(char *=
data, unsigned len,
>  #define __entity_check_ENDPOINT(val)   ((val) & USB_ENDPOINT_NUMBER_MASK=
)
>  #define __entity(type, val) do {					\
>  		pr_vdebug("entity " #type "(%02x)\n", (val));		\
> -		if (unlikely(!__entity_check_ ##type(val))) {		\
> +		if (!__entity_check_ ##type(val)) {			\
>  			pr_vdebug("invalid entity's value\n");		\
>  			return -EINVAL;					\
>  		}							\
>  		ret =3D entity(FFS_ ##type, &val, _ds, priv);		\
> -		if (unlikely(ret < 0)) {				\
> +		if (ret < 0) {						\
>  			pr_debug("entity " #type "(%02x); ret =3D %d\n",	\
>  				 (val), ret);				\
>  			return ret;					\
> @@ -2164,7 +2163,7 @@ static int __must_check ffs_do_descs(unsigned count=
, char *data, unsigned len,
> =20
>  		/* Record "descriptor" entity */
>  		ret =3D entity(FFS_DESCRIPTOR, (u8 *)num, (void *)data, priv);
> -		if (unlikely(ret < 0)) {
> +		if (ret < 0) {
>  			pr_debug("entity DESCRIPTOR(%02lx); ret =3D %d\n",
>  				 num, ret);
>  			return ret;
> @@ -2175,7 +2174,7 @@ static int __must_check ffs_do_descs(unsigned count=
, char *data, unsigned len,
> =20
>  		ret =3D ffs_do_single_desc(data, len, entity, priv,
>  			&current_class);
> -		if (unlikely(ret < 0)) {
> +		if (ret < 0) {
>  			pr_debug("%s returns %d\n", __func__, ret);
>  			return ret;
>  		}
> @@ -2281,7 +2280,7 @@ static int __must_check ffs_do_single_os_desc(char =
*data, unsigned len,
>  	/* loop over all ext compat/ext prop descriptors */
>  	while (feature_count--) {
>  		ret =3D entity(type, h, data, len, priv);
> -		if (unlikely(ret < 0)) {
> +		if (ret < 0) {
>  			pr_debug("bad OS descriptor, type: %d\n", type);
>  			return ret;
>  		}
> @@ -2321,7 +2320,7 @@ static int __must_check ffs_do_os_descs(unsigned co=
unt,
>  			return -EINVAL;
> =20
>  		ret =3D __ffs_do_os_desc_header(&type, desc);
> -		if (unlikely(ret < 0)) {
> +		if (ret < 0) {
>  			pr_debug("entity OS_DESCRIPTOR(%02lx); ret =3D %d\n",
>  				 num, ret);
>  			return ret;
> @@ -2342,7 +2341,7 @@ static int __must_check ffs_do_os_descs(unsigned co=
unt,
>  		 */
>  		ret =3D ffs_do_single_os_desc(data, len, type,
>  					    feature_count, entity, priv, desc);
> -		if (unlikely(ret < 0)) {
> +		if (ret < 0) {
>  			pr_debug("%s returns %d\n", __func__, ret);
>  			return ret;
>  		}
> @@ -2574,20 +2573,20 @@ static int __ffs_data_got_strings(struct ffs_data=
 *ffs,
> =20
>  	ENTER();
> =20
> -	if (unlikely(len < 16 ||
> -		     get_unaligned_le32(data) !=3D FUNCTIONFS_STRINGS_MAGIC ||
> -		     get_unaligned_le32(data + 4) !=3D len))
> +	if (len < 16 ||
> +	    get_unaligned_le32(data) !=3D FUNCTIONFS_STRINGS_MAGIC ||
> +	    get_unaligned_le32(data + 4) !=3D len)
>  		goto error;
>  	str_count  =3D get_unaligned_le32(data + 8);
>  	lang_count =3D get_unaligned_le32(data + 12);
> =20
>  	/* if one is zero the other must be zero */
> -	if (unlikely(!str_count !=3D !lang_count))
> +	if (!str_count !=3D !lang_count)
>  		goto error;
> =20
>  	/* Do we have at least as many strings as descriptors need? */
>  	needed_count =3D ffs->strings_count;
> -	if (unlikely(str_count < needed_count))
> +	if (str_count < needed_count)
>  		goto error;
> =20
>  	/*
> @@ -2611,7 +2610,7 @@ static int __ffs_data_got_strings(struct ffs_data *=
ffs,
> =20
>  		char *vlabuf =3D kmalloc(vla_group_size(d), GFP_KERNEL);
> =20
> -		if (unlikely(!vlabuf)) {
> +		if (!vlabuf) {
>  			kfree(_data);
>  			return -ENOMEM;
>  		}
> @@ -2638,7 +2637,7 @@ static int __ffs_data_got_strings(struct ffs_data *=
ffs,
>  	do { /* lang_count > 0 so we can use do-while */
>  		unsigned needed =3D needed_count;
> =20
> -		if (unlikely(len < 3))
> +		if (len < 3)
>  			goto error_free;
>  		t->language =3D get_unaligned_le16(data);
>  		t->strings  =3D s;
> @@ -2651,7 +2650,7 @@ static int __ffs_data_got_strings(struct ffs_data *=
ffs,
>  		do { /* str_count > 0 so we can use do-while */
>  			size_t length =3D strnlen(data, len);
> =20
> -			if (unlikely(length =3D=3D len))
> +			if (length =3D=3D len)
>  				goto error_free;
> =20
>  			/*
> @@ -2659,7 +2658,7 @@ static int __ffs_data_got_strings(struct ffs_data *=
ffs,
>  			 * if that's the case we simply ignore the
>  			 * rest
>  			 */
> -			if (likely(needed)) {
> +			if (needed) {
>  				/*
>  				 * s->id will be set while adding
>  				 * function to configuration so for
> @@ -2681,7 +2680,7 @@ static int __ffs_data_got_strings(struct ffs_data *=
ffs,
>  	} while (--lang_count);
> =20
>  	/* Some garbage left? */
> -	if (unlikely(len))
> +	if (len)
>  		goto error_free;
> =20
>  	/* Done! */
> @@ -2828,7 +2827,7 @@ static int __ffs_func_bind_do_descs(enum ffs_entity=
_type type, u8 *valuep,
> =20
>  	ffs_ep =3D func->eps + idx;
> =20
> -	if (unlikely(ffs_ep->descs[ep_desc_id])) {
> +	if (ffs_ep->descs[ep_desc_id]) {
>  		pr_err("two %sspeed descriptors for EP %d\n",
>  			  speed_names[ep_desc_id],
>  			  ds->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
> @@ -2859,12 +2858,12 @@ static int __ffs_func_bind_do_descs(enum ffs_enti=
ty_type type, u8 *valuep,
>  		wMaxPacketSize =3D ds->wMaxPacketSize;
>  		pr_vdebug("autoconfig\n");
>  		ep =3D usb_ep_autoconfig(func->gadget, ds);
> -		if (unlikely(!ep))
> +		if (!ep)
>  			return -ENOTSUPP;
>  		ep->driver_data =3D func->eps + idx;
> =20
>  		req =3D usb_ep_alloc_request(ep, GFP_KERNEL);
> -		if (unlikely(!req))
> +		if (!req)
>  			return -ENOMEM;
> =20
>  		ffs_ep->ep  =3D ep;
> @@ -2906,7 +2905,7 @@ static int __ffs_func_bind_do_nums(enum ffs_entity_=
type type, u8 *valuep,
>  		idx =3D *valuep;
>  		if (func->interfaces_nums[idx] < 0) {
>  			int id =3D usb_interface_id(func->conf, &func->function);
> -			if (unlikely(id < 0))
> +			if (id < 0)
>  				return id;
>  			func->interfaces_nums[idx] =3D id;
>  		}
> @@ -2927,7 +2926,7 @@ static int __ffs_func_bind_do_nums(enum ffs_entity_=
type type, u8 *valuep,
>  			return 0;
> =20
>  		idx =3D (*valuep & USB_ENDPOINT_NUMBER_MASK) - 1;
> -		if (unlikely(!func->eps[idx].ep))
> +		if (!func->eps[idx].ep)
>  			return -EINVAL;
> =20
>  		{
> @@ -3110,12 +3109,12 @@ static int _ffs_func_bind(struct usb_configuratio=
n *c,
>  	ENTER();
> =20
>  	/* Has descriptors only for speeds gadget does not support */
> -	if (unlikely(!(full | high | super)))
> +	if (!(full | high | super))
>  		return -ENOTSUPP;
> =20
>  	/* Allocate a single chunk, less management later on */
>  	vlabuf =3D kzalloc(vla_group_size(d), GFP_KERNEL);
> -	if (unlikely(!vlabuf))
> +	if (!vlabuf)
>  		return -ENOMEM;
> =20
>  	ffs->ms_os_descs_ext_prop_avail =3D vla_ptr(vlabuf, d, ext_prop);
> @@ -3144,13 +3143,13 @@ static int _ffs_func_bind(struct usb_configuratio=
n *c,
>  	 * endpoints first, so that later we can rewrite the endpoint
>  	 * numbers without worrying that it may be described later on.
>  	 */
> -	if (likely(full)) {
> +	if (full) {
>  		func->function.fs_descriptors =3D vla_ptr(vlabuf, d, fs_descs);
>  		fs_len =3D ffs_do_descs(ffs->fs_descs_count,
>  				      vla_ptr(vlabuf, d, raw_descs),
>  				      d_raw_descs__sz,
>  				      __ffs_func_bind_do_descs, func);
> -		if (unlikely(fs_len < 0)) {
> +		if (fs_len < 0) {
>  			ret =3D fs_len;
>  			goto error;
>  		}
> @@ -3158,13 +3157,13 @@ static int _ffs_func_bind(struct usb_configuratio=
n *c,
>  		fs_len =3D 0;
>  	}
> =20
> -	if (likely(high)) {
> +	if (high) {
>  		func->function.hs_descriptors =3D vla_ptr(vlabuf, d, hs_descs);
>  		hs_len =3D ffs_do_descs(ffs->hs_descs_count,
>  				      vla_ptr(vlabuf, d, raw_descs) + fs_len,
>  				      d_raw_descs__sz - fs_len,
>  				      __ffs_func_bind_do_descs, func);
> -		if (unlikely(hs_len < 0)) {
> +		if (hs_len < 0) {
>  			ret =3D hs_len;
>  			goto error;
>  		}
> @@ -3172,13 +3171,13 @@ static int _ffs_func_bind(struct usb_configuratio=
n *c,
>  		hs_len =3D 0;
>  	}
> =20
> -	if (likely(super)) {
> +	if (super) {
>  		func->function.ss_descriptors =3D vla_ptr(vlabuf, d, ss_descs);
>  		ss_len =3D ffs_do_descs(ffs->ss_descs_count,
>  				vla_ptr(vlabuf, d, raw_descs) + fs_len + hs_len,
>  				d_raw_descs__sz - fs_len - hs_len,
>  				__ffs_func_bind_do_descs, func);
> -		if (unlikely(ss_len < 0)) {
> +		if (ss_len < 0) {
>  			ret =3D ss_len;
>  			goto error;
>  		}
> @@ -3196,7 +3195,7 @@ static int _ffs_func_bind(struct usb_configuration =
*c,
>  			   (super ? ffs->ss_descs_count : 0),
>  			   vla_ptr(vlabuf, d, raw_descs), d_raw_descs__sz,
>  			   __ffs_func_bind_do_nums, func);
> -	if (unlikely(ret < 0))
> +	if (ret < 0)
>  		goto error;
> =20
>  	func->function.os_desc_table =3D vla_ptr(vlabuf, d, os_desc_table);
> @@ -3217,13 +3216,13 @@ static int _ffs_func_bind(struct usb_configuratio=
n *c,
>  				      d_raw_descs__sz - fs_len - hs_len -
>  				      ss_len,
>  				      __ffs_func_bind_do_os_desc, func);
> -		if (unlikely(ret < 0))
> +		if (ret < 0)
>  			goto error;
>  	}
>  	func->function.os_desc_n =3D
>  		c->cdev->use_os_string ? ffs->interfaces_count : 0;
> =20
> -	if (likely(super)) {
> +	if (super) {
>  		func->function.ssp_descriptors =3D
>  			usb_copy_descriptors(func->function.ss_descriptors);
>  	}
> @@ -3272,7 +3271,7 @@ static int ffs_func_set_alt(struct usb_function *f,
> =20
>  	if (alt !=3D (unsigned)-1) {
>  		intf =3D ffs_func_revmap_intf(func, interface);
> -		if (unlikely(intf < 0))
> +		if (intf < 0)
>  			return intf;
>  	}
> =20
> @@ -3297,7 +3296,7 @@ static int ffs_func_set_alt(struct usb_function *f,
> =20
>  	ffs->func =3D func;
>  	ret =3D ffs_func_eps_enable(func);
> -	if (likely(ret >=3D 0))
> +	if (ret >=3D 0)
>  		ffs_event_add(ffs, FUNCTIONFS_ENABLE);
>  	return ret;
>  }
> @@ -3339,13 +3338,13 @@ static int ffs_func_setup(struct usb_function *f,
>  	switch (creq->bRequestType & USB_RECIP_MASK) {
>  	case USB_RECIP_INTERFACE:
>  		ret =3D ffs_func_revmap_intf(func, le16_to_cpu(creq->wIndex));
> -		if (unlikely(ret < 0))
> +		if (ret < 0)
>  			return ret;
>  		break;
> =20
>  	case USB_RECIP_ENDPOINT:
>  		ret =3D ffs_func_revmap_ep(func, le16_to_cpu(creq->wIndex));
> -		if (unlikely(ret < 0))
> +		if (ret < 0)
>  			return ret;
>  		if (func->ffs->user_flags & FUNCTIONFS_VIRTUAL_ADDR)
>  			ret =3D func->ffs->eps_addrmap[ret];
> @@ -3599,7 +3598,7 @@ static struct usb_function *ffs_alloc(struct usb_fu=
nction_instance *fi)
>  	ENTER();
> =20
>  	func =3D kzalloc(sizeof(*func), GFP_KERNEL);
> -	if (unlikely(!func))
> +	if (!func)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	func->function.name    =3D "Function FS Gadget";
> @@ -3814,7 +3813,7 @@ static void ffs_closed(struct ffs_data *ffs)
>  static int ffs_mutex_lock(struct mutex *mutex, unsigned nonblock)
>  {
>  	return nonblock
> -		? likely(mutex_trylock(mutex)) ? 0 : -EAGAIN
> +		? mutex_trylock(mutex) ? 0 : -EAGAIN
>  		: mutex_lock_interruptible(mutex);
>  }
> =20
> @@ -3822,14 +3821,14 @@ static char *ffs_prepare_buffer(const char __user=
 *buf, size_t len)
>  {
>  	char *data;
> =20
> -	if (unlikely(!len))
> +	if (!len)
>  		return NULL;
> =20
>  	data =3D kmalloc(len, GFP_KERNEL);
> -	if (unlikely(!data))
> +	if (!data)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	if (unlikely(copy_from_user(data, buf, len))) {
> +	if (copy_from_user(data, buf, len)) {
>  		kfree(data);
>  		return ERR_PTR(-EFAULT);
>  	}
> --=20
> 2.29.2
>=20

--=20

Thanks,
Peter Chen=
