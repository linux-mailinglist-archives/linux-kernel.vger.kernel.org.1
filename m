Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125302552E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 04:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgH1CLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 22:11:54 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:47544 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgH1CLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:11:54 -0400
Date:   Thu, 27 Aug 2020 22:11:53 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-ID: <20200828021152.GU3265@brightrain.aerifal.cx>
References: <20200714121856.955680-1-hch@lst.de>
 <20200714121856.955680-10-hch@lst.de>
 <20200828020045.GT3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828020045.GT3265@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:00:48PM -0400, Rich Felker wrote:
> On Tue, Jul 14, 2020 at 02:18:55PM +0200, Christoph Hellwig wrote:
> > The code handling non-coherent DMA depends on being able to remap code
> > as non-cached.  But that can't be done without an MMU, so using this
> > option on NOMMU builds is broken.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/sh/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index f8027eee08edae..337eb496c45a0a 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -61,6 +61,7 @@ config SUPERH
> >  	select MAY_HAVE_SPARSE_IRQ
> >  	select MODULES_USE_ELF_RELA
> >  	select NEED_SG_DMA_LENGTH
> > +	select NO_DMA if !MMU && !DMA_COHERENT
> >  	select NO_GENERIC_PCI_IOPORT_MAP if PCI
> >  	select OLD_SIGACTION
> >  	select OLD_SIGSUSPEND
> > @@ -135,7 +136,7 @@ config DMA_COHERENT
> >  	bool
> 
> This change broke SD card support on J2 because MMC_SPI spuriously
> depends on HAS_DMA. It looks like it can be fixed just by removing
> that dependency from drivers/mmc/host/Kconfig.

It can't. mmp_spi_probe fails with ENOMEM, probably due to trying to
do some DMA setup thing that's not going to be needed if the
underlying SPI device doesn't support/use DMA.

Rich
