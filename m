Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0B24CF4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgHUHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHUHb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:31:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F2C2078D;
        Fri, 21 Aug 2020 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597995088;
        bh=zj/aZnBQm8kFqhOGpWxH3Mew6BLTWbXLfyCo9iwAJ+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8zK7oPiLwnJ2LDjAH6lJs+EBUX7wQNEGSv7oaRqbbVM0LsaiaY8xTKt6yNFOd3BB
         P86zbtb+QJOEd5V+q3ruju/o2LR9pAYTR2oltQtUufXIAsYUk92ER4OPJj+84cTrwC
         F3IJFtSUzdhUVw77iVJvJAv+LttybNfXFs0W5KbE=
Date:   Fri, 21 Aug 2020 09:31:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Always restore EP_SOFT_CLEAR_TOGGLE even if ep
 reset failed
Message-ID: <20200821073147.GA1681156@kroah.com>
References: <20200821070652.27782-1-dinghui@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821070652.27782-1-dinghui@sangfor.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 03:06:52PM +0800, Ding Hui wrote:
> Some devices driver call libusb_clear_halt when target ep queue
> is not empty. (eg. spice client connected to qemu for usb redir)
> 
> Before commit f5249461b504 ("xhci: Clear the host side toggle
> manually when endpoint is soft reset"), that works well.
> But now, we got the error log:
> 
>     EP not empty, refuse reset
> 
> xhch_endpoint_reset failed and left ep_state's EP_SOFT_CLEAR_TOGGLE
> bit is still on
> 
> So all the subsequent urb sumbit to the ep will fail with the
> warn log:
> 
>     Can't enqueue URB while manually clearing toggle
> 
> We need restore ep_state EP_SOFT_CLEAR_TOGGLE bit after
> xhci_endpoint_reset, even if it is failed.
> 
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>  drivers/usb/host/xhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Shouldn't this have a Fixes: tag on it and be backported to the affected
stable trees?

thanks,

greg k-h
