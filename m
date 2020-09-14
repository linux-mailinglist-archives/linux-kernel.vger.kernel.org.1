Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A759268587
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgINHL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgINHL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:11:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:11:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so17435810wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCeerB1JSj7Ad5/NePzzCyRJn16Be5wrFWWH1CWiDP0=;
        b=X55de4su8ACUlJzml7jbOdk740UeBZL1QwYX0385QEl8yyFdpcIvMBswozXI9Iwi5d
         KjGu3pvIc/WJcfXlGJT3CCBr1yU4aa2EKuwMrNk2rw0TaoYVpguYEZkjcxyC+HxICaqj
         fPaATeZl5KF7sn+32WoC+XjDF0l4B0XagqZDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCeerB1JSj7Ad5/NePzzCyRJn16Be5wrFWWH1CWiDP0=;
        b=l0nkNJJJkTsJSFebY4uo2/E/dTvzqASvAoEnjBwJkAY4gfUwCa1X/HXtzgcUtZOc8M
         Xhc0DfXtKdJwosygFhcHqzwIPlAsamSvEBeosMxLYlZ75i35IR9vNma2VU26gJqpf83B
         ub098x/R28k1SF8qkOiE4OhQwodfQ9rPiVBJWXfliWPcxmMTi6A1z0nNbsz4c5cXhqzZ
         QQZglrg+dZm+uCcY6QYdM7loD1RHO7BEyQNy5WjXqULCjo0rx5j6OQi1cvOuQ7Hy8WbA
         44rI+pIVZ5JgDHifVkpd8VIydNKyEtBtzTh4UbxoZqU3ueA52cNzoVT1L0kJC8KNtqO7
         QJTQ==
X-Gm-Message-State: AOAM533Tc0q3dEXW+3aQsiWdxiEShh+uBMbsKh+rL7UmqjnO997ysEf+
        kTs47MFU5DGELkZ1KvQaDKQh1WDH+06kHyjtqEMRnQ==
X-Google-Smtp-Source: ABdhPJx1POr9ptHGzWWSxkqesqTMHmNyfnUZTuDp4ZxAnJYirIn+uphhC/pcSaZjMrvjb+RpqSRrO0hwrCGElxPN/YY=
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr14188706wrt.366.1600067481657;
 Mon, 14 Sep 2020 00:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200911102534.25218-1-srinath.mannam@broadcom.com> <20200911151659.GA868760@bjorn-Precision-5520>
In-Reply-To: <20200911151659.GA868760@bjorn-Precision-5520>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 14 Sep 2020 12:41:10 +0530
Message-ID: <CABe79T7sdW7GBhNR=VQ9kXY1JOOimY3wsQZ0xxTbN9rz2j5z5w@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/dma: Fix IOVA reserve dma ranges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 8:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
Hi Bjorn,
Thanks for review.
> On Fri, Sep 11, 2020 at 03:55:34PM +0530, Srinath Mannam wrote:
> > Fix IOVA reserve failure in the case when address of first memory region
> > listed in dma-ranges is equal to 0x0.
> >
> > Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> > Changes from v1:
> >    Removed unnecessary changes based on Robin's review comments.
> >
> >  drivers/iommu/dma-iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 5141d49a046b..682068a9aae7 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -217,7 +217,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
> >                       lo = iova_pfn(iovad, start);
> >                       hi = iova_pfn(iovad, end);
> >                       reserve_iova(iovad, lo, hi);
> > -             } else {
> > +             } else if (end < start) {
> >                       /* dma_ranges list should be sorted */
> >                       dev_err(&dev->dev, "Failed to reserve IOVA\n");
>
It is very unlikely to come to this error, dma_ranges list is sorted
in "devm_of_pci_get_host_bridge_resources" function.
> You didn't actually change the error message, but the message would be
> way more useful if it included the IOVA address range, e.g., the
> format used in pci_register_host_bridge():
>
>   bus address [%#010llx-%#010llx]
I will add this change and send the next patchset.

Thanks & Regards,
Srinath.
>
> Incidentally, the pr_err() in copy_reserved_iova() looks bogus; it
> prints iova->pfn_low twice, when it should probably print the base and
> size or (my preference) something like the above:
>
>         pr_err("Reserve iova range %lx@%lx failed\n",
>                iova->pfn_lo, iova->pfn_lo);
>
> >                       return -EINVAL;
> > --
> > 2.17.1
> >
