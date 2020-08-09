Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AF23FE1D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHIMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 08:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHIMCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 08:02:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB6B206B6;
        Sun,  9 Aug 2020 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596974545;
        bh=R0J5yufUsoZ7RR4AK9Jav8aRu4/PcqRQbVISdz2gnzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oepBPitX7d3m+I18DKXA/IgvFMfE8H4sAk8+m7tDLlkSxibss8Gg9QaDJ/7N7TG6O
         tpgpeGkkFaZdH+QIAf5UcfhFWDGuq5BHmNYGbIM88CENh1RdJji/Ntk6/uU6Iv3XwF
         IdNrTEwAlOmSv/Tl9vYYuZhrLYLrRu3hods0NP74=
Date:   Sun, 9 Aug 2020 14:02:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] habanalabs: fix incorrect check on failed
 workqueue create
Message-ID: <20200809120238.GC385599@kroah.com>
References: <20200730082022.5557-1-colin.king@canonical.com>
 <CAFCwf101gsf3GK6f_ggNgPeKTFXEDdCYz-LugNq5mY342zc2Hw@mail.gmail.com>
 <20200731062057.GC1508201@kroah.com>
 <CAFCwf11oAg=mhsqwnSh7vHuUeJEpEtBFKggFaRcbOFY8PhPsPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11oAg=mhsqwnSh7vHuUeJEpEtBFKggFaRcbOFY8PhPsPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 02:02:18PM +0300, Oded Gabbay wrote:
> On Fri, Jul 31, 2020 at 9:21 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 30, 2020 at 01:51:48PM +0300, Oded Gabbay wrote:
> > > On Thu, Jul 30, 2020 at 11:20 AM Colin King <colin.king@canonical.com> wrote:
> > > >
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > >
> > > > The null check on a failed workqueue create is currently null checking
> > > > hdev->cq_wq rather than the pointer hdev->cq_wq[i] and so the test
> > > > will never be true on a failed workqueue create. Fix this by checking
> > > > hdev->cq_wq[i].
> > > >
> > > > Addresses-Coverity: ("Dereference before null check")
> > > > Fixes: 5574cb2194b1 ("habanalabs: Assign each CQ with its own work queue")
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > ---
> > > >  drivers/misc/habanalabs/common/device.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> > > > index be16b75bdfdb..35214a186913 100644
> > > > --- a/drivers/misc/habanalabs/common/device.c
> > > > +++ b/drivers/misc/habanalabs/common/device.c
> > > > @@ -288,7 +288,7 @@ static int device_early_init(struct hl_device *hdev)
> > > >         for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
> > > >                 snprintf(workq_name, 32, "hl-free-jobs-%u", i);
> > > >                 hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
> > > > -               if (hdev->cq_wq == NULL) {
> > > > +               if (hdev->cq_wq[i] == NULL) {
> > > >                         dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
> > > >                         rc = -ENOMEM;
> > > >                         goto free_cq_wq;
> > > > --
> > > > 2.27.0
> > > >
> > >
> > > This patch is:
> > > Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> > >
> > > Greg, can you please apply it directly to the char-misc-next branch ?
> > > I don't want to send a pull request for 1 patch.
> >
> > Already merged :)
> 
> Hi Greg,
> I can't find this patch in char-misc-next.
> Can you please check if you applied it ?

Oops, you are right, I did not take it, my fault, sorry.

> If not, I'll apply it to my fixes tree and send it to you for -rc2

That would be great, thanks for following up on this.

greg k-h
