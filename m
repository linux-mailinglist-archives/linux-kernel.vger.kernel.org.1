Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB22DBA19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 05:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgLPEen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 23:34:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:54885 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgLPEem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:34:42 -0500
IronPort-SDR: gmtwRNuKblF27Emdn4XF5LPYWaC4c/4FucmA8LlNiO8tZoFva/LjF+1vSXvZIjkyUUJz3XItJz
 nuRfL5BUfX7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="193384735"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="193384735"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 20:34:02 -0800
IronPort-SDR: WJjQtyuMpJ2SeXJO6hFto7Vp8uSNt7LvgTu+RsugfHraPPw4MILtcB3qQe6mOVnIIn2zph4KIB
 6PYGzaK1HjyQ==
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="559520854"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 20:34:00 -0800
Date:   Wed, 16 Dec 2020 12:36:41 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Muchowski, MaciejX" <maciejx.muchowski@intel.com>,
        "Paczynski, Lukasz" <lukasz.paczynski@intel.com>
Subject: Re: [PATCH] xhci: Introduce max wait timeout in xhci_handshake()
Message-ID: <20201216043641.GA15845@chenyu-office.sh.intel.com>
References: <20201215132240.4094-1-yu.c.chen@intel.com>
 <X9i8grY9BRbbCqNZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9i8grY9BRbbCqNZ@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
thanks for taking a look at this.
On Tue, Dec 15, 2020 at 02:39:14PM +0100, Greg KH wrote:
> On Tue, Dec 15, 2020 at 09:22:40PM +0800, Chen Yu wrote:
> > The time to finish a xhci_handshake() is platform specific
> > and sometimes during suspend resume test the followng
> > errors were encountered:
> > [53455.418330] ACPI: Waking up from system sleep state S4
> > [66838.490856] xhci_hcd 0000:00:14.0: xHCI dying, ignoring interrupt.
> >                Shouldn't IRQs be disabled?
> > After changing the poll time granularity from 1 usec to 20 usec in
> > xhci_handshake() this issue was not reproduced. While tuning on the
> > poll time granularity might be painful on different platforms, it is
> > applicable to introduce a module parameter to allow the xhci driver to wait
> > for at max 16 ms.
> > 
> > Reported-by: "Muchowski, MaciejX" <maciejx.muchowski@intel.com>
> 
> I doubt the "X" is part of this person's name, please just spell it out
> without the "," please.
> 
Okay, will do.
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/usb/host/xhci.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index d4a8d0efbbc4..b8be9f3cc987 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -38,6 +38,10 @@ static unsigned long long quirks;
> >  module_param(quirks, ullong, S_IRUGO);
> >  MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
> >  
> > +static int wait_handshake;
> > +module_param(wait_handshake, int, 0644);
> > +MODULE_PARM_DESC(wait_handshake, "Force wait for completion of handshake");
> 
> This is not the 1990's, we are not adding new module parameters that no
> one will know how to change.
>
Okay.
> Make this dynamic, and per-device, and work properly instead.  This can
> not handle multiple controllers in the system at all :(
>
Okay. After checking the error log, enlarging the timeout might not be enough
and I'll dig into it a little deeper and send feedback.

thanks,
Chenyu
> thanks,
> 
> greg k-h
