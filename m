Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD95522AD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgGWK4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 06:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGWKz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:55:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3459F2080D;
        Thu, 23 Jul 2020 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595501758;
        bh=rOif2suP7KxnL8T+L3PWl9WY4FaYmE1dtO5JYOiUmc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K91lnDrZZp3AiLjDTMTTBnfi0BSRzgndD9D6oQ1kbiyUiR4M7OgM0pAdFSIzA7p4r
         oL47+MeDKrNo4dX/tSdgCNJKntkI+CwM5X9x0FdoG8YKuf6akV/QVTFkKV1LxCeZRI
         /eOsKnnNRJrzMNcudnpi0wTqJQXKlxKgcPNGboHk=
Date:   Thu, 23 Jul 2020 12:56:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: hpilo: switch from 'pci_' to 'dma_' API
Message-ID: <20200723105602.GD1949236@kroah.com>
References: <20200718070224.337964-1-christophe.jaillet@wanadoo.fr>
 <20200723073433.GA1273491@kroah.com>
 <15e5f2e4-a623-3fc2-36b6-4132ee316220@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15e5f2e4-a623-3fc2-36b6-4132ee316220@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:59:49AM +0200, Christophe JAILLET wrote:
> Le 23/07/2020 � 09:34, Greg KH a �crit�:
> > On Sat, Jul 18, 2020 at 09:02:24AM +0200, Christophe JAILLET wrote:
> > > The wrappers in include/linux/pci-dma-compat.h should go away.
> > > 
> > > The patch has been generated with the coccinelle script below and has been
> > > hand modified to replace GFP_ with a correct flag.
> > > It has been compile tested.
> > > 
> > > When memory is allocated in 'ilo_ccb_setup()' GFP_ATOMIC must be used
> > > because a spin_lock is hold in 'ilo_open()' before calling
> > > 'ilo_ccb_setup()'
> 
>        ^
>        |

{sigh} see how well I read changelog text...

> 
> > > [...]
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > If needed, see post from Christoph Hellwig on the kernel-janitors ML:
> > >     https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> > > ---
> > >   drivers/misc/hpilo.c | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> > > index 10c975662f8b..c9539c89a925 100644
> > > --- a/drivers/misc/hpilo.c
> > > +++ b/drivers/misc/hpilo.c
> > > @@ -256,7 +256,8 @@ static void ilo_ccb_close(struct pci_dev *pdev, struct ccb_data *data)
> > >   	memset_io(device_ccb, 0, sizeof(struct ccb));
> > >   	/* free resources used to back send/recv queues */
> > > -	pci_free_consistent(pdev, data->dma_size, data->dma_va, data->dma_pa);
> > > +	dma_free_coherent(&pdev->dev, data->dma_size, data->dma_va,
> > > +			  data->dma_pa);
> > >   }
> > >   static int ilo_ccb_setup(struct ilo_hwinfo *hw, struct ccb_data *data, int slot)
> > > @@ -272,8 +273,8 @@ static int ilo_ccb_setup(struct ilo_hwinfo *hw, struct ccb_data *data, int slot)
> > >   			 2 * desc_mem_sz(NR_QENTRY) +
> > >   			 ILO_START_ALIGN + ILO_CACHE_SZ;
> > > -	data->dma_va = pci_alloc_consistent(hw->ilo_dev, data->dma_size,
> > > -					    &data->dma_pa);
> > > +	data->dma_va = dma_alloc_coherent(&hw->ilo_dev->dev, data->dma_size,
> > > +					  &data->dma_pa, GFP_ATOMIC);
> > 
> > This is being called from open() so it can be GFP_KERNEL.  Can you fix
> > that up and resend a new version?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> The call chain is:
>    .open	                       (file_operations)
>       --> ilo_open
> 	  spin_lock(&hw->open_lock);   (around line 782)
>          --> ilo_ccb_setup	       (hw->open_lock is still hold)
> 
> So I think that GFP_ATOMIC is needed here, or the code should be reworked to
> avoid holding the spin_lock when ilo_ccb_setup is called.

Ok, fair enough, this patch is ok as-is, I'll go queue it up.  Further
fixes for this to move the spinlock out from this is probably a good
idea, if anyone cares about this driver anymore.

thanks,

greg k-h
