Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834FA214742
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGDQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 12:09:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:49789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgGDQJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 12:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593878907;
        bh=4kcyXcVtSIIHYcMtwyp8hReO1kEfmKVhpt4EhWkO53A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NCEOkwn83EWm7mZzM5hKOmT9XG6nW7i3Cm6EbDpZSlw5qcfeq4Evst3CDyguqfETB
         kcMG2DRiPZkVP6fG/eOStDqHagSqyyujUVUEnf+32hAVqYpZhmfW6No2OWLUwWm3lT
         A4Y9a1TeOIWey5KztRPmQfEXJ4OaeopHUMMmcJbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY68d-1kQAf00yR3-00YNkI; Sat, 04
 Jul 2020 18:08:27 +0200
Date:   Sat, 4 Jul 2020 18:08:14 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     kernel-hardening@lists.openwall.com,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Subject: Re: [PATCH v3] firewire: Remove function callback casts
Message-ID: <20200704160814.GA3527@ubuntu>
References: <20200530090839.7895-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530090839.7895-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:5wBEMKpp+/jkYeAz/ZH4Jill3Gn+BMXWceRcNIBp5gN/l06FetY
 ol/bnNQBaZ5svLry/JOYQ4XU+PCtnpXDjRKigr86lvv1+uZzur0GUu2h98PPYBTZhHACq2/
 2f3GmMDcONZPCdl9migey4qVJvWHDXYeJraWx6PYKtZJU3LQ2EsNlXDi2+GPpkEhLxoMxQh
 M8eeCiOR5xlFS6WiD6R3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rP0V3ip4rew=:ARXfQtOo+BkW0Hka1U/E/b
 Z7b1IYlw5Bar6hyK3EEpfzHyJvrIfAK7PWQVnEQve7rdc2BXR4fLwYljpxrMAUQryT4/BU49Z
 vMGjFxf3702yRqrpysG9+R13ngSDXCvdEKPouNwxSAOWrDfPd3v+gNDffWF+rJJg11WPIJHdZ
 rh+ZdF307Tq2EHLA0wbTT7SfkIy9g+z26DxS/O2oW4TdE7A+e6C6w8ZdTYxsY7Pi6gK3jbZix
 iTBtRVYmPpqEhiGNcwH7e6YkW2DXt96BqIJOJAo5rzBv6SDDjbHzoZyKrLTIrM0kdAcXIGLwb
 1HH11UtTVDsTWIOXB7XtYVcbvdJSq9fAZWxnDpcCldF7f31I7VTCiyyDSPm1uzbykfSdUol3Y
 hzgDO3uHaPpeCphB4iKet5uG+SIZHIiV5Ec1TQYl+kS9S785DAqA/UBycWskZ9LmCppsYVR1n
 AfBP9B8Mi2uzI5vU4+WHqeO5Nttdx4AUXPgV1H2ThLOkq2qiauoA0IHP8nQvvrQWGHNvMpwl6
 9WLTXBboXoc0EYgem8t+ajQoOASfH5LxemBskxrniN0mk6wMppZOqf9juDwP8an/co6agsClU
 FTJFSVSMrpZM4Y+Di9/x0eAs35ORBl5XNQFmn3BRMo2WljXqhXKy7m52d8wsJHttrVl/Ldhl6
 Rn2imNBIsTsGFXSuLBW56YVPFTPiuli2GXzloc64uHuh0BtqKxBbfIoJDWWvoxyU0XXdFD8n/
 y/9ONBzB5WMkrti9YdXIjOn56kNEWq5nRQ4YiqiDuBGE3DpwNiLtN4oKz8MnnB4QzRTnBXQbs
 0JXZP/zYrFyU6JvbkE1g1VknPfu265+UvN5TR8D4pcP8FMpRYypjkZwd3tKZo0bd7xjFkFZ5L
 uk1Br0Dp7HVGDClu8CX59XMl//7t4M3P+6x6HjMFs9mWZ0DUHBohXXlEfjd/q8VuwrF+HlgM6
 hEeGe5LnmwyKwqxr5f3qFNju0YD16S8fG91qpk5uhrPxRCKNnZ7yKHXclPUehXw6E91zYf2S4
 9SgWGzAOtJRw2bC/Ec0sMUdJzcAQ0WyVA41oXvQ6AK+ClFThnk1Rn7I1ar6wGvHn8zsOrq4F0
 OrMKo/ebDGZveFWqHDqT2wPyqnsF57wqWs4pkVVzqnrrla5FpNzEkMyurfCe1CbeRHWzi0Zjs
 yAGQbMt9wcwR99iYKx137cfCiOfNqj6redSPVSQaAHipbIIpJ97B1YHGqS9qfM5uM/186/x7l
 XYa3SBco3+1PB24n7
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anyone has had time to review this patch? Any comments on this?

On Sat, May 30, 2020 at 11:08:39AM +0200, Oscar Carter wrote:
> In 1394 OHCI specification, Isochronous Receive DMA context has several
> modes. One of mode is 'BufferFill' and Linux FireWire stack uses it to
> receive isochronous packets for multiple isochronous channel as
> FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL.
>
> The mode is not used by in-kernel driver, while it's available for
> userspace. The character device driver in firewire-core includes
> cast of function callback for the mode since the type of callback
> function is different from the other modes. The case is inconvenient
> to effort of Control Flow Integrity builds due to
> -Wcast-function-type warning.
>
> This commit removes the cast. A static helper function is newly added
> to initialize isochronous context for the mode. The helper function
> arranges isochronous context to assign specific callback function
> after call of existent kernel API. It's noticeable that the number of
> isochronous channel, speed, and the size of header are not required for
> the mode. The helper function is used for the mode by character device
> driver instead of direct call of existent kernel API.
>
> The same goal can be achieved (in the ioctl_create_iso_context function)
> without this helper function as follows:
> - Call the fw_iso_context_create function passing NULL to the callback
>   parameter.
> - Then setting the context->callback.sc or context->callback.mc
>   variables based on the a->type value.
>
> However using the helper function created in this patch makes code more
> clear and declarative. This way avoid the call to a function with one
> purpose to achieved another one.
>
> Co-developed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Co-developed-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
> Hi,
>
> this is another proposal to achieved the goal of remove function callbac=
k
> cast start by me with the first [1] and second [2] versions, and followe=
d
> by the work of Takashi Sakamoto with his first [3] and second [4] versio=
ns,
> and the code of Stefan Richter [5].
>
> The purpose of this third version is to put together all the work done
> until now following the comments of all reviewed patches.
>
> I've added the "Co-developed-by" and "Signed-off-by" tags to give credit=
 to
> Takashi Sakamoto and Stefan Richter if there are no objections.
>
> Changelog v1->v2
> -Set explicity to NULL the "ctx->callback.sc" variable and return an err=
or
>  code in "fw_iso_context_create" function if both callback parameters ar=
e
>  NULL as Lev R. Oshvang suggested.
> -Modify the commit changelog accordingly.
>
> Changelog v2->v3
> -Put togeher all the work done in different patches by different authors=
.
> -Modify the previous work following the comments in the reviewed patches=
.
>
> [1] https://lore.kernel.org/lkml/20200516173934.31527-1-oscar.carter@gmx=
.com/
> [2] https://lore.kernel.org/lkml/20200519173425.4724-1-oscar.carter@gmx.=
com/
> [3] https://lore.kernel.org/lkml/20200520064726.31838-1-o-takashi@sakamo=
cchi.jp/
> [4] https://lore.kernel.org/lkml/20200524132048.243223-1-o-takashi@sakam=
occhi.jp/
> [5] https://lore.kernel.org/lkml/20200525015532.0055f9df@kant/
>
>  drivers/firewire/core-cdev.c | 32 ++++++++++++++++++++++++++------
>  include/linux/firewire.h     | 11 +++++++----
>  2 files changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index 6e291d8f3a27..f7212331f245 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/firewire.h>
>  #include <linux/firewire-cdev.h>
> @@ -953,11 +954,25 @@ static enum dma_data_direction iso_dma_direction(s=
truct fw_iso_context *context)
>  			return DMA_FROM_DEVICE;
>  }
>
> +static struct fw_iso_context *fw_iso_mc_context_create(struct fw_card *=
card,
> +						fw_iso_mc_callback_t callback,
> +						void *callback_data)
> +{
> +	struct fw_iso_context *ctx;
> +
> +	ctx =3D fw_iso_context_create(card, FW_ISO_CONTEXT_RECEIVE_MULTICHANNE=
L,
> +				    0, 0, 0, NULL, callback_data);
> +	if (!IS_ERR(ctx))
> +		ctx->callback.mc =3D callback;
> +
> +	return ctx;
> +}
> +
>  static int ioctl_create_iso_context(struct client *client, union ioctl_=
arg *arg)
>  {
>  	struct fw_cdev_create_iso_context *a =3D &arg->create_iso_context;
>  	struct fw_iso_context *context;
> -	fw_iso_callback_t cb;
> +	union fw_iso_callback cb;
>  	int ret;
>
>  	BUILD_BUG_ON(FW_CDEV_ISO_CONTEXT_TRANSMIT !=3D FW_ISO_CONTEXT_TRANSMIT=
 ||
> @@ -970,7 +985,7 @@ static int ioctl_create_iso_context(struct client *c=
lient, union ioctl_arg *arg)
>  		if (a->speed > SCODE_3200 || a->channel > 63)
>  			return -EINVAL;
>
> -		cb =3D iso_callback;
> +		cb.sc =3D iso_callback;
>  		break;
>
>  	case FW_ISO_CONTEXT_RECEIVE:
> @@ -978,19 +993,24 @@ static int ioctl_create_iso_context(struct client =
*client, union ioctl_arg *arg)
>  		    a->channel > 63)
>  			return -EINVAL;
>
> -		cb =3D iso_callback;
> +		cb.sc =3D iso_callback;
>  		break;
>
>  	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
> -		cb =3D (fw_iso_callback_t)iso_mc_callback;
> +		cb.mc =3D iso_mc_callback;
>  		break;
>
>  	default:
>  		return -EINVAL;
>  	}
>
> -	context =3D fw_iso_context_create(client->device->card, a->type,
> -			a->channel, a->speed, a->header_size, cb, client);
> +	if (a->type =3D=3D FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
> +		context =3D fw_iso_mc_context_create(client->device->card, cb.mc,
> +						   client);
> +	else
> +		context =3D fw_iso_context_create(client->device->card, a->type,
> +						a->channel, a->speed,
> +						a->header_size, cb.sc, client);
>  	if (IS_ERR(context))
>  		return PTR_ERR(context);
>  	if (client->version < FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW)
> diff --git a/include/linux/firewire.h b/include/linux/firewire.h
> index aec8f30ab200..07967a450eaa 100644
> --- a/include/linux/firewire.h
> +++ b/include/linux/firewire.h
> @@ -436,6 +436,12 @@ typedef void (*fw_iso_callback_t)(struct fw_iso_con=
text *context,
>  				  void *header, void *data);
>  typedef void (*fw_iso_mc_callback_t)(struct fw_iso_context *context,
>  				     dma_addr_t completed, void *data);
> +
> +union fw_iso_callback {
> +	fw_iso_callback_t sc;
> +	fw_iso_mc_callback_t mc;
> +};
> +
>  struct fw_iso_context {
>  	struct fw_card *card;
>  	int type;
> @@ -443,10 +449,7 @@ struct fw_iso_context {
>  	int speed;
>  	bool drop_overflow_headers;
>  	size_t header_size;
> -	union {
> -		fw_iso_callback_t sc;
> -		fw_iso_mc_callback_t mc;
> -	} callback;
> +	union fw_iso_callback callback;
>  	void *callback_data;
>  };
>
> --
> 2.20.1
>

Regards,
Oscar Carter
