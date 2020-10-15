Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4728ECC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJOFiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 01:38:12 -0400
Received: from verein.lst.de ([213.95.11.211]:59135 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgJOFiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:38:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 48D5B68AFE; Thu, 15 Oct 2020 07:38:08 +0200 (CEST)
Date:   Thu, 15 Oct 2020 07:38:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dma-direct: Turn zone_dma_bits default value
 into a define
Message-ID: <20201015053808.GA12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de> <20201014191211.27029-6-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014191211.27029-6-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:12:07PM +0200, Nicolas Saenz Julienne wrote:
> Set zone_dma_bits default value through a define so as for architectures
> to be able to override it with their default value.

Architectures can do that already by assigning a value to zone_dma_bits
at runtime.  I really do not want to add the extra clutter.
