Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735432CF1AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgLDQNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:13:31 -0500
Received: from netrider.rowland.org ([192.131.102.5]:36795 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728708AbgLDQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:13:31 -0500
Received: (qmail 1143058 invoked by uid 1000); 4 Dec 2020 11:12:49 -0500
Date:   Fri, 4 Dec 2020 11:12:49 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: dummy-hcd: Fix uninitialized array use in init()
Message-ID: <20201204161249.GA1141609@rowland.harvard.edu>
References: <1607063090-3426-1-git-send-email-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607063090-3426-1-git-send-email-minhquangbui99@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:24:49AM +0000, Bui Quang Minh wrote:
> This error path
> 
> 	err_add_pdata:
> 		for (i = 0; i < mod_data.num; i++)
> 			kfree(dum[i]);
> 
> can be triggered when not all dum's elements are initialized.
> 
> Fix this by initializing all dum's elements to NULL.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/usb/gadget/udc/dummy_hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index 0eeaead..a2cf009 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -2734,7 +2734,7 @@ static int __init init(void)
>  {
>  	int	retval = -ENOMEM;
>  	int	i;
> -	struct	dummy *dum[MAX_NUM_UDC];
> +	struct	dummy *dum[MAX_NUM_UDC] = {};
>  
>  	if (usb_disabled())
>  		return -ENODEV;

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Does this initialization end up using less memory than an explicit 
memset() call?

Alan Stern
