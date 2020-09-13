Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE6268052
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgIMQuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgIMQuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:50:00 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D16622204;
        Sun, 13 Sep 2020 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600015799;
        bh=L8XEq3jBSI/fRgNLHQoreiMSaRqoRqn+i3vv+wcOYEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nRtB29+nSDA5SBvFnszAZ08C8r5Gpc02M+j2TvLOK8uLi42rW1qNoWyY+hxgX0s5+
         QJq+PgrBh+8szwagcE7CwEnstuzAWDTn/z0IaXT1oUqZE25N/ZfStBs3z4PUJeNTso
         uZFT3gQ/GqmldNwdZT6GRDs+RrGKmf9zQcOGSOq4=
Date:   Sun, 13 Sep 2020 11:49:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     ricky_wu@realtek.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        bhelgaas@google.com, vaibhavgupta40@gmail.com,
        rui_feng@realsil.com.cn, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in
 rtsx_pci_init_ocp()
Message-ID: <20200913164957.GA1190742@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06d7691-01ab-303c-e687-dd8c51a8a9c5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 09:40:56AM +0100, Chris Clayton wrote:
> Hi Greg and Arnd,
> 
> On 24/08/2020 04:00, ricky_wu@realtek.com wrote:
> > From: Ricky Wu <ricky_wu@realtek.com>
> > 
> > this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
> > missing card reader
> 
> In his changelog above, Ricky didn't mention that this patch fixes a
> regression that was introduced (in 5.1) by commit bede03a579b3.
> 
> The patch that I posted to LKML contained the appropriate Fixes, etc
> tags. After discussion, the patch was changed to remove the code
> that effectively disables the RTS5229 cardreader on (at least some)
> Intel NUC boxes. I prepared the patch that Ricky submitted but he
> didn't include my Signed-off-by or the Fixes tag. I think the
> following needs to be added to the changelog.
> 
> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
> Link: https://marc.info/?l=linux-kernel&m=159105912832257

Better lore link:

  Link: https://lore.kernel.org/r/CACYmiSer8FA+qjh8NHZJ2maxSd-=RwDdZ2F7_-E4uM1NXuZ8gQ@mail.gmail.com/

But I'm not sure the above is the most relevant.  Seems like the one
below is more to the point since it has the exact patch below and is
part of a thread developing it:

  Link: https://lore.kernel.org/r/20da8b4b-8426-9568-c0f1-4d1c2006c53f@googlemail.com/

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> 
> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express
> card reader on the Intel NUC6CAYH box.
> 
> My main point, however, is that the patch is also needed in the 5.4
> (longterm) and 5.8 (stable) series kernels.

This would be accomplished by:

Cc: stable@vger.kernel.org	# v5.1+

> > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > ---
> >  drivers/misc/cardreader/rtsx_pcr.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> > index 37ccc67f4914..3a4a7b0cc098 100644
> > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > @@ -1155,10 +1155,6 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *pcr)
> >  			rtsx_pci_write_register(pcr, REG_OCPGLITCH,
> >  				SD_OCP_GLITCH_MASK, pcr->hw_param.ocp_glitch);
> >  			rtsx_pci_enable_ocp(pcr);
> > -		} else {
> > -			/* OC power down */
> > -			rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
> > -				OC_POWER_DOWN);
> >  		}
> >  	}
> >  }
> > 
