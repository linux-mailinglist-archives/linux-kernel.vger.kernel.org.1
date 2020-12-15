Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B502DAE21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgLONjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgLONiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:38:51 -0500
Date:   Tue, 15 Dec 2020 14:39:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608039491;
        bh=4F6182ElpK4fSQTfF1pePVhieZFGbZGfkxBZYVvD/lU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrOiQLM0ABxXkfc242ywPIDzbP9SJhkZfQFyAa106qk8pPHw61yb04PSHOgBbSWPE
         MIu/UVZ3R/tjUAOyJrBubyWOR/sXmwWVzcfVVEXmnbZxHDEEeQWlrYwx+4lc7B834X
         mk0af2/2u36yZUkyOJk80EMgjDja7fCk0HER/wgo=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Muchowski, MaciejX" <maciejx.muchowski@intel.com>,
        "Paczynski, Lukasz" <lukasz.paczynski@intel.com>
Subject: Re: [PATCH] xhci: Introduce max wait timeout in xhci_handshake()
Message-ID: <X9i8grY9BRbbCqNZ@kroah.com>
References: <20201215132240.4094-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215132240.4094-1-yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:22:40PM +0800, Chen Yu wrote:
> The time to finish a xhci_handshake() is platform specific
> and sometimes during suspend resume test the followng
> errors were encountered:
> [53455.418330] ACPI: Waking up from system sleep state S4
> [66838.490856] xhci_hcd 0000:00:14.0: xHCI dying, ignoring interrupt.
>                Shouldn't IRQs be disabled?
> After changing the poll time granularity from 1 usec to 20 usec in
> xhci_handshake() this issue was not reproduced. While tuning on the
> poll time granularity might be painful on different platforms, it is
> applicable to introduce a module parameter to allow the xhci driver to wait
> for at max 16 ms.
> 
> Reported-by: "Muchowski, MaciejX" <maciejx.muchowski@intel.com>

I doubt the "X" is part of this person's name, please just spell it out
without the "," please.

> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/usb/host/xhci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index d4a8d0efbbc4..b8be9f3cc987 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -38,6 +38,10 @@ static unsigned long long quirks;
>  module_param(quirks, ullong, S_IRUGO);
>  MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
>  
> +static int wait_handshake;
> +module_param(wait_handshake, int, 0644);
> +MODULE_PARM_DESC(wait_handshake, "Force wait for completion of handshake");

This is not the 1990's, we are not adding new module parameters that no
one will know how to change.

Make this dynamic, and per-device, and work properly instead.  This can
not handle multiple controllers in the system at all :(

thanks,

greg k-h
