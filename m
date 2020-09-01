Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54652596D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgIAQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:06:52 -0400
Received: from verein.lst.de ([213.95.11.211]:53903 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731513AbgIAPkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:40:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12DF268B05; Tue,  1 Sep 2020 17:40:50 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:40:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rich Felker <dalias@libc.org>, Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
Message-ID: <20200901154049.GA376@lst.de>
References: <20200901150438.228887-1-ulf.hansson@linaro.org> <20200901150654.GB30034@lst.de> <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > I still don't think this makes sense, as the dma_mask should always
> > be non-NULL here.
> 
> If that is the case, I wonder how the driver could even have worked without DMA.
> 
> Because in the existing code, host->dma_dev gets assigned to
> spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> usage in the driver.
> 
> What am I missing?

Do you know of other non-DMA users?  For SH nommu it probably worked
because SH nommu used to provide a DMA implementation that worked
fine for streaming maps, but was completely broken for coherent
allocation.  And this driver appears to only use the former.
