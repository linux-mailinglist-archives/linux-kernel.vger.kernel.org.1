Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E22D4C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgLIVNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLIVNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:13:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F65C0613CF;
        Wed,  9 Dec 2020 13:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gS0VLE/3Ng4U2SxkbHkG9CNtkXAr3yvJos8iwhaz6f8=; b=khzpdumaWG5wnv6HYv+lMM/TUG
        F/Sy61OYE7cV/UH83JYY4h/phIO5J7+BpJnUJBV/y5DUEyCAMEOoN8aNA4UsFnJROv85KEqNpgW2P
        f8ky3rBC+uUjAdk6J0igI4j/EkIVjP/H7dRpujvbzaR8HwMWS82QOpRg8kzNK7jIKO+3xZMhco6NV
        2Oe0FB/R492jpNxWZG0xuWC/4/9cYxjnGdwPMAH+c4Iim/yvTcOObczjUiiRUA9RtVSVbEweMEI29
        Cvbx/IUreAkEQxNrDhjGPJ6L6n5LOsrqop+Yd5xosPZ98N5TBkvigXIugA6kUa5HPvjr2wlpvYqRr
        aasBbY5Q==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn6l5-0001xS-Ha; Wed, 09 Dec 2020 21:12:24 +0000
Subject: Re: [PATCH] usb: cdns3: Fixed kernel test robot warning
To:     Souptick Joarder <jrdr.linux@gmail.com>, pawell@cadence.com,
        peter.chen@nxp.com, rogerq@ti.com, a-govindraju@ti.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1607544952-4891-1-git-send-email-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae8cd88c-ea5d-a045-c6cd-2579a55f88d2@infradead.org>
Date:   Wed, 9 Dec 2020 13:12:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1607544952-4891-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 12:15 PM, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> 
> In file included from drivers/usb/cdns3/core.c:23:
>>> drivers/usb/cdns3/host-export.h:27:51: warning: 'struct usb_hcd'
>>> declared inside parameter list will not be visible outside of this
>>> definition or declaration
>       27 | static inline int xhci_cdns3_suspend_quirk(struct usb_hcd
> *hcd)
>          |                                                   ^~~~~~~
> 
> This patch will silence it.

Really?  Didn't silence it for me when I tested this patch.

Also, please see

https://lore.kernel.org/linux-usb/DBBPR04MB7979502194410BB1AE96DF038BCC0@DBBPR04MB7979.eurprd04.prod.outlook.com/T/#m7f73fdd57c0f1577fb610dcaf28646b53fa7dc26

(what a strange URL)

I now get these 2 warnings:

In file included from ../drivers/usb/cdns3/core.c:23:0:
../drivers/usb/cdns3/host-export.h:27:44: warning: ‘struct usb_hcd’ declared inside parameter list will not be visible outside of this definition or declaration
 static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
                                            ^~~~~~~
  CC [M]  drivers/usb/gadget/function/uvc_queue.o
../drivers/usb/cdns3/host-export.h:27:12: warning: ‘xhci_cdns3_suspend_quirk’ defined but not used [-Wunused-function]
 static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
            ^~~~~~~~~~~~~~~~~~~~~~~~


> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/usb/cdns3/host-export.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-export.h
> index fb8541b..c1259af 100644
> --- a/drivers/usb/cdns3/host-export.h
> +++ b/drivers/usb/cdns3/host-export.h
> @@ -24,7 +24,7 @@ static inline int cdns_host_init(struct cdns *cdns)
>  }
>  
>  static inline void cdns_host_exit(struct cdns *cdns) { }
> -static inline int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
> +static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
>  {
>  	return 0;
>  }
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
