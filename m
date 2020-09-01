Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79BA25924B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 17:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgIAPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 11:07:24 -0400
Received: from verein.lst.de ([213.95.11.211]:53716 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgIAPG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:06:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 103C368B05; Tue,  1 Sep 2020 17:06:55 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:06:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Brown <broonie@kernel.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
Message-ID: <20200901150654.GB30034@lst.de>
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150438.228887-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:04:38PM +0200, Ulf Hansson wrote:
> +#ifdef CONFIG_HAS_DMA
> +static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
> +{
> +	struct spi_device *spi = host->spi;
> +	struct device *dev;
> +
> +	if (!spi->master->dev.parent->dma_mask)
> +		return 0;

I still don't think this makes sense, as the dma_mask should always
be non-NULL here.
