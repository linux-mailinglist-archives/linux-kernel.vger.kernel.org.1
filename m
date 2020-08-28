Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF43B25538F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 06:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgH1EYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 00:24:25 -0400
Received: from verein.lst.de ([213.95.11.211]:40822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgH1EYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 00:24:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D4C3468BEB; Fri, 28 Aug 2020 06:24:22 +0200 (CEST)
Date:   Fri, 28 Aug 2020 06:24:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-ID: <20200828042422.GA29734@lst.de>
References: <20200714121856.955680-1-hch@lst.de> <20200714121856.955680-10-hch@lst.de> <20200828020045.GT3265@brightrain.aerifal.cx> <20200828021152.GU3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828021152.GU3265@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:11:53PM -0400, Rich Felker wrote:
> > This change broke SD card support on J2 because MMC_SPI spuriously
> > depends on HAS_DMA. It looks like it can be fixed just by removing
> > that dependency from drivers/mmc/host/Kconfig.
> 
> It can't. mmp_spi_probe fails with ENOMEM, probably due to trying to
> do some DMA setup thing that's not going to be needed if the
> underlying SPI device doesn't support/use DMA.

Adding the linux-mmc and linux-spi lists, as that seems pretty odd.
