Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615E228ECD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgJOFmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 01:42:49 -0400
Received: from verein.lst.de ([213.95.11.211]:59172 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgJOFmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:42:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4D9068BEB; Thu, 15 Oct 2020 07:42:44 +0200 (CEST)
Date:   Thu, 15 Oct 2020 07:42:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/8] of/address: Introduce
 of_dma_get_max_cpu_address()
Message-ID: <20201015054244.GD12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de> <20201014191211.27029-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014191211.27029-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> +{
> +	phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> +	struct of_range_parser parser;
> +	phys_addr_t subtree_max_addr;
> +	struct device_node *child;
> +	phys_addr_t cpu_end = 0;
> +	struct of_range range;
> +	const __be32 *ranges;
> +	int len;
> +
> +	if (!np)
> +		np = of_root;

Requiring of_root to be passed explicitly would seem more natural
to me than the magic NULL argument.  There doesn't seem to be any
precedent for that kind of calling convention either.
