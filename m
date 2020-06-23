Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A020521D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbgFWMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 08:13:08 -0400
Received: from verein.lst.de ([213.95.11.211]:39101 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732518AbgFWMNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:13:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B182C68AEF; Tue, 23 Jun 2020 14:13:04 +0200 (CEST)
Date:   Tue, 23 Jun 2020 14:13:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, jean-philippe@linaro.org,
        bbhushan2@marvell.com
Subject: Re: [PATCH v2] dma-remap: Align the size in dma_common_*_remap()
Message-ID: <20200623121304.GA20261@lst.de>
References: <20200623120755.27710-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623120755.27710-1-eric.auger@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:07:55PM +0200, Eric Auger wrote:
> Running a guest with a virtio-iommu protecting virtio devices
> is broken since commit 515e5b6d90d4 ("dma-mapping: use vmap insted
> of reimplementing it"). Before the conversion, the size was
> page aligned in __get_vm_area_node(). Doing so fixes the
> regression.
> 
> Fixes: 515e5b6d90d4 ("dma-mapping: use vmap insted of reimplementing it")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Thanks,

I've applied this locally, waiting for git.infradead.org to be back
up.
