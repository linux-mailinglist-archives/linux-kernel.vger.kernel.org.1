Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D604244C42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHNPmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 11:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgHNPmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:42:36 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A750C2074D;
        Fri, 14 Aug 2020 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597419756;
        bh=+up87sODqYUrxoIZ1gLOYF3UjeAagJtD1rwQwhmj+sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auPdDnywEkEQZk0vPg/NbewQ0pEX3D+Q+m5H0419IlYT8+910NKmGJScWULSYGe6E
         wkvKNjrPurKntZdHZGeBBNXtlflPAr5YX3Ow1nUlNnKLM6oIrb0FPcjYqXGen+HthJ
         riJoe9Wvp/0VBAfr66Vu9TCM3RdrDK0e7GC9jGpc=
Date:   Fri, 14 Aug 2020 08:42:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 11:37:20AM -0400, Tong Zhang wrote:
> On Fri, Aug 14, 2020 at 11:04 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > >               dev_warn_ratelimited(dev->ctrl.device,
> > >                        "I/O %d QID %d timeout, disable controller\n",
> > >                        req->tag, nvmeq->qid);
> > > -             nvme_dev_disable(dev, true);
> > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > +             nvme_dev_disable(dev, true);
> > >               return BLK_EH_DONE;
> >
> > Shouldn't this flag have been set in nvme_cancel_request()?
> 
> nvme_cancel_request() is not setting this flag to cancelled and this is causing

Right, I see that it doesn't, but I'm saying that it should. We used to
do something like that, and I'm struggling to recall why we're not
anymore. The driver is not reporting   non-response back for all
cancelled requests, and that is probably not what we should be doing.
