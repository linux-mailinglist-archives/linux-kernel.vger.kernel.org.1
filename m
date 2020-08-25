Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B092512A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgHYHJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 03:09:45 -0400
Received: from verein.lst.de ([213.95.11.211]:57698 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgHYHJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:09:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B38B568BEB; Tue, 25 Aug 2020 09:09:40 +0200 (CEST)
Date:   Tue, 25 Aug 2020 09:09:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        james.smart@broadcom.com, hch@lst.de, chaitanya.kulkarni@wdc.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock
 in 'nvmet_fc_fod_op_done()'
Message-ID: <20200825070940.GD29268@lst.de>
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr> <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me> <20200824211630.GA1490518@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824211630.GA1490518@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:16:30PM -0700, Keith Busch wrote:
> On Mon, Aug 24, 2020 at 01:00:11PM -0700, Sagi Grimberg wrote:
> > > The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> > > in this function.
> > > 
> > > Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> > > interruptions are disabled at that point, according to surrounding code.
> > > 
> > > Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Not tested, only based on what looks logical to me according to
> > > surrounding code
> > > ---
> > >   drivers/nvme/target/fc.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> > > index 55bafd56166a..e6861cc10e7d 100644
> > > --- a/drivers/nvme/target/fc.c
> > > +++ b/drivers/nvme/target/fc.c
> > > @@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
> > >   			return;
> > >   		if (fcpreq->fcp_error ||
> > >   		    fcpreq->transferred_length != fcpreq->transfer_length) {
> > > -			spin_lock(&fod->flock);
> > > +			spin_lock_irqsave(&fod->flock, flags);
> > >   			fod->abort = true;
> > > -			spin_unlock(&fod->flock);
> > > +			spin_unlock_irqrestore(&fod->flock, flags);
> > >   			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
> > >   			return;
> > > 
> > 
> > James, can I get a reviewed-by from you on this?
> 
> afaics, the lock just serializes single writes, in which
> WRITE/READ_ONCE() can handle that without a lock, right?

It synchronizes a few fields, sometimes taken over multiple updates.
