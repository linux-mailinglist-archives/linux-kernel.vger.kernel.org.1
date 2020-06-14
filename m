Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7141F88FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgFNNmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 09:42:08 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54527 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727027AbgFNNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 09:42:08 -0400
Received: (qmail 17826 invoked by uid 1000); 14 Jun 2020 09:42:07 -0400
Date:   Sun, 14 Jun 2020 09:42:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Lee, Chiasheng" <chiasheng.lee@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: fix reference count leak in usb_port_resume
Message-ID: <20200614134207.GA17297@rowland.harvard.edu>
References: <20200614033355.129442-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614033355.129442-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 10:33:53PM -0500, Aditya Pakki wrote:
> usb_port_resume() calls pm_runtime_get_sync() that increments
> the reference counter. In case of failure, decrement the reference
> count and return the error.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/usb/core/hub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b1e14beaac5f..a9231f27144e 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3542,6 +3542,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  		if (status < 0) {
>  			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
>  					status);
> +			pm_runtime_put_sync(&port_dev->dev);

This is wrong; you need to do test_and_clear_bit(port1, 
hub->child_usage_bits) before calling pm_runtime_put_sync().  Otherwise 
the child_usage_bits value will get out of sync with the port's runtime 
status.

Alan Stern

