Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B36271456
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 14:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgITMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 08:47:13 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:21468 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgITMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 08:47:12 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468614397"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 14:47:11 +0200
Date:   Sun, 20 Sep 2020 14:47:11 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     kernel-janitors@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] pch_uart: drop double zeroing
In-Reply-To: <20200920121404.GA2830482@kroah.com>
Message-ID: <alpine.DEB.2.22.394.2009201443590.2966@hadrien>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr> <1600601186-7420-2-git-send-email-Julia.Lawall@inria.fr> <20200920121404.GA2830482@kroah.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Sep 2020, Greg Kroah-Hartman wrote:

> On Sun, Sep 20, 2020 at 01:26:13PM +0200, Julia Lawall wrote:
> > sg_init_table zeroes its first argument, so the allocation of that argument
> > doesn't have to.
> >
> > the semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @@
> > expression x,n,flags;
> > @@
> >
> > x =
> > - kcalloc
> > + kmalloc_array
> >   (n,sizeof(struct scatterlist),flags)
> > ...
> > sg_init_table(x,n)
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> It inits the first entry in the array, but what about all of the other
> ones?  Is that "safe" to have uninitialized data in them like your
> change causes to happen?

Sorry, I don't follow.  The complete code is:

        priv->sg_tx_p = kcalloc(num, sizeof(struct scatterlist), GFP_ATOMIC);
        if (!priv->sg_tx_p) {
		dev_err(priv->port.dev, "%s:kzalloc Failed\n", __func__);
                return 0;
	}

	sg_init_table(priv->sg_tx_p, num); /* Initialize SG table */

and the definition of sg_init_table is:

void sg_init_table(struct scatterlist *sgl, unsigned int nents)
{
	memset(sgl, 0, sizeof(*sgl) * nents);
	sg_init_marker(sgl, nents);
}

It looks to me like it zeroes all of the elements?  The same file does
contain a call:

sg_init_table(&priv->sg_rx, 1);

But that's not the one associated with the patch.

julia
