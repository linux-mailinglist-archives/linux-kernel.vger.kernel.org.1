Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10B027E144
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgI3Gh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgI3Gh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:37:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD042075F;
        Wed, 30 Sep 2020 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601447879;
        bh=aUeSXzjVFtMG4x8dh311yA0nBhGA2MwjJn6twEOju38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaSpRDICsclE/SvX67Lp9K0qt/WHzUETeVkskQuL6z4RV7YnPcDUh7Yupo+wHIkgR
         I3iTQVHwYmxGzGNIRASR5fY5OWFbRfDeYujj1FDDlMBObHup5HpbNypJz4Nt1caUe2
         zUq1uf3KM/MJHMUS+85IF+08IkgbBgGudvQv95mY=
Date:   Wed, 30 Sep 2020 08:38:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] habanalabs/gaudi: use correct define for qman init
Message-ID: <20200930063803.GB1490382@kroah.com>
References: <20200925171415.25663-1-oded.gabbay@gmail.com>
 <CAFCwf12jX9sg8xjh4AGQvzyJaCu=bZaf+HjBqeauxV4Ry0A5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12jX9sg8xjh4AGQvzyJaCu=bZaf+HjBqeauxV4Ry0A5qQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:58:22PM +0300, Oded Gabbay wrote:
> On Fri, Sep 25, 2020 at 8:14 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > There was a copy-paste error, and the wrong define was used for
> > initializing the QMAN.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > index a227806be328..5f65a1691551 100644
> > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > @@ -2039,7 +2039,7 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
> >                 WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
> >                                                         QMAN_LDMA_SRC_OFFSET);
> >                 WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
> > -                                                       QMAN_LDMA_SIZE_OFFSET);
> > +                                                       QMAN_LDMA_DST_OFFSET);
> >
> >                 /* Configure RAZWI IRQ */
> >                 dma_qm_err_cfg = HBM_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
> > --
> > 2.17.1
> >
> 
> Hi Greg,
> Do you think you can apply this patch directly to your char-misc-next
> branch before the merge window opens ?
> I don't have anything pending and I don't want to send a pull request
> for a single patch.

Sure, I'll be glad to queue it up now.

thanks,

greg k-h
