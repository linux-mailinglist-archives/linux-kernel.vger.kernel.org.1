Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8471CF540
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgELNJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 09:09:40 -0400
Received: from verein.lst.de ([213.95.11.211]:41138 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgELNJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:09:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FB5F68BEB; Tue, 12 May 2020 15:09:36 +0200 (CEST)
Date:   Tue, 12 May 2020 15:09:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 01/38] dma-mapping: add generic helpers for mapping
 sgtable objects
Message-ID: <20200512130936.GA24428@lst.de>
References: <20200512085710.14688-1-m.szyprowski@samsung.com> <CGME20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0@eucas1p1.samsung.com> <20200512090058.14910-1-m.szyprowski@samsung.com> <20200512121808.GA20393@lst.de> <1a80255d-81de-2c5d-6d06-ea126fd7f994@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a80255d-81de-2c5d-6d06-ea126fd7f994@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:00:31PM +0200, Marek Szyprowski wrote:
> > 	if (n <= 0)
> > 		return -EINVAL;
> > 	sgt->nents = n;
> > 	return 0;
> >
> Indeed this version looks much better. I will resend it in a few minutes.

I could also just fix it up when applying the patch.
