Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56A22CEFF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgLDOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:46:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40138 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbgLDOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:46:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id y10so6888050ljc.7;
        Fri, 04 Dec 2020 06:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuN8v+wl7n8X6ofmOSfbc2YBxTt+XcxIQ84FcqRFIhU=;
        b=UcmsduDCGA67QusEkwL9MO21gdS3K/bhuyVnaAMT8paoq2HP9ep2SAmR1iuhhqPeJa
         7OWlt/sUnMUR/982gaHh4LkIy50dK2KKid25NEIMK2vT6F6wRMCzqtjTp2UPuQeQkpTU
         Dbw0tcty41p5SB/Ga6dgrea9ORNQhiAS7P0+083yp/G1KdH1Ev4t8f+QbI5fpxkZKyvW
         WsEg5mxhmej9xPNaHrOUnEM/T6uc4vctYa9mQN1OCxF2JtR+aJhHGT/xnemMJOa+Z2yn
         Jmps8uQ+h9yvodos3wOn9fKAFaFBj//+d+31E7icnEqnStkNe/76Fjz72QIqUr9XhvEV
         M1mw==
X-Gm-Message-State: AOAM530nc2eje2k+C6CNT4ag2MhkyNsZgiWSh7OAMGpzZgwHaiRtLB7/
        ga14AS2LQkjvIkINDKGcbVk=
X-Google-Smtp-Source: ABdhPJzYZArFYZhD7wduBUpvCwP3MOuOH2jpvSitvYO8oRE8ySnOEhqfcE03NOS7ZEGc0zipDFsazA==
X-Received: by 2002:a05:651c:3cf:: with SMTP id f15mr3573033ljp.118.1607093171959;
        Fri, 04 Dec 2020 06:46:11 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f2sm1810567ljc.118.2020.12.04.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:46:11 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1klCM9-0005Mv-HH; Fri, 04 Dec 2020 15:46:45 +0100
Date:   Fri, 4 Dec 2020 15:46:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] usb: misc: idmouse: update to use
 usb_control_msg_send()
Message-ID: <X8pL1bRUTyq2re7Z@localhost>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
 <20201130013031.2580265-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130013031.2580265-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 07:00:31AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_send() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/idmouse.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Especially for control transfers without a data stage there isn't
really any benefit of the new helper.

I'd just leave this one unchanged.

> diff --git a/drivers/usb/misc/idmouse.c b/drivers/usb/misc/idmouse.c
> index e9437a176518..52126441a633 100644
> --- a/drivers/usb/misc/idmouse.c
> +++ b/drivers/usb/misc/idmouse.c
> @@ -56,8 +56,9 @@ static const struct usb_device_id idmouse_table[] = {
>  #define FTIP_SCROLL  0x24
>  
>  #define ftip_command(dev, command, value, index) \
> -	usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0), command, \
> -	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, value, index, NULL, 0, 1000)
> +	usb_control_msg_send(dev->udev, 0, command, \
> +	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, \
> +	value, index, NULL, 0, 1000, GFP_KERNEL)
>  
>  MODULE_DEVICE_TABLE(usb, idmouse_table);

Johan
