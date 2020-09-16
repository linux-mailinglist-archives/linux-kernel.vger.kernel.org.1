Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8547726CAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIPUSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:18:38 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59195 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728261AbgIPUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:16:46 -0400
Received: (qmail 1062543 invoked by uid 1000); 16 Sep 2020 16:16:43 -0400
Date:   Wed, 16 Sep 2020 16:16:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Quentin Perret <qperret@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com
Subject: Re: [PATCH] ehci-hcd: Move include to keep CRC stable
Message-ID: <20200916201643.GA1062163@rowland.harvard.edu>
References: <20200916171825.3228122-1-qperret@google.com>
 <20200916173127.GB3068942@kroah.com>
 <20200916173206.GA3070014@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173206.GA3070014@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 07:32:06PM +0200, Greg KH wrote:
> On Wed, Sep 16, 2020 at 07:31:27PM +0200, Greg KH wrote:
> > On Wed, Sep 16, 2020 at 06:18:25PM +0100, Quentin Perret wrote:
> > > The CRC calculation done by genksyms is triggered when the parser hits
> > > EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
> > > types of the function parameters, and uses that as the input for the CRC
> > > calculation. In the case of forward-declared structs, the type expands
> > > to 'UNKNOWN'. Following this, it appears that the result of the
> > > expansion of each type is cached somewhere, and seems to be re-used
> > > when/if the same type is seen again for another exported symbol in the
> > > same C file.
> > > 
> > > Unfortunately, this can cause CRC 'stability' issues when a struct
> > > definition becomes visible in the middle of a C file. For example, let's
> > > assume code with the following pattern:
> > > 
> > >     struct foo;
> > > 
> > >     int bar(struct foo *arg)
> > >     {
> > > 	/* Do work ... */
> > >     }
> > >     EXPORT_SYMBOL_GPL(bar);
> > > 
> > >     /* This contains struct foo's definition */
> > >     #include "foo.h"
> > > 
> > >     int baz(struct foo *arg)
> > >     {
> > > 	/* Do more work ... */
> > >     }
> > >     EXPORT_SYMBOL_GPL(baz);
> > > 
> > > Here, baz's CRC will be computed using the expansion of struct foo that
> > > was cached after bar's CRC calculation ('UNKOWN' here). But if
> > > EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
> > > trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
> > > late, during baz's CRC calculation, which now has visibility over the
> > > full struct definition, hence resulting in a different CRC for baz.
> > > 
> > > The proper fix for this certainly is in genksyms, but that will take me
> > > some time to get right. In the meantime, we have seen one occurrence of
> > > this in the ehci-hcd code which hits this problem because of the way it
> > > includes C files halfway through the code together with an unlucky mix
> > > of symbol trimming.
> > > 
> > > In order to workaround this, move the include done in ehci-hub.c early
> > > in ehci-hcd.c, hence making sure the struct definitions are visible to
> > > the entire file. This improves CRC stability of the ehci-hcd exports
> > > even when symbol trimming is enabled.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  drivers/usb/host/ehci-hcd.c | 1 +
> > >  drivers/usb/host/ehci-hub.c | 1 -
> > >  2 files changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > > index 6257be4110ca..3575b7201881 100644
> > > --- a/drivers/usb/host/ehci-hcd.c
> > > +++ b/drivers/usb/host/ehci-hcd.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/usb.h>
> > >  #include <linux/usb/hcd.h>
> > > +#include <linux/usb/otg.h>
> > >  #include <linux/moduleparam.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/debugfs.h>
> > > diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
> > > index ce0eaf7d7c12..087402aec5cb 100644
> > > --- a/drivers/usb/host/ehci-hub.c
> > > +++ b/drivers/usb/host/ehci-hub.c
> > > @@ -14,7 +14,6 @@
> > >   */
> > >  
> > >  /*-------------------------------------------------------------------------*/
> > > -#include <linux/usb/otg.h>
> > >  
> > >  #define	PORT_WAKE_BITS	(PORT_WKOC_E|PORT_WKDISC_E|PORT_WKCONN_E)
> > 
> > Thanks for root-causing this issue.  genksyms is a fragile beast, good
> > luck trying to resolve that!
> > 
> > I'll go queue this up and mark it for stable kernels, thanks.
> 
> I'll queue it up after I get Alan's review first :)

It's fine with me.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
