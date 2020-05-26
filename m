Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7D1C3AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgEDNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 09:11:14 -0400
Received: from verein.lst.de ([213.95.11.211]:57839 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDNLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:11:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F34BA68BFE; Mon,  4 May 2020 15:11:10 +0200 (CEST)
Date:   Mon, 4 May 2020 15:11:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 00/21] DRM: fix struct sg_table nents vs. orig_nents
 misuse
Message-ID: <20200504131110.GA18918@lst.de>
References: <CGME20200504125032eucas1p2eeaf22690e6b557d69c834cc9dd75855@eucas1p2.samsung.com> <20200504125017.5494-1-m.szyprowski@samsung.com> <20200504125212.GA17241@lst.de> <b257279c-4138-b28e-584d-92bd15571ae1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b257279c-4138-b28e-584d-92bd15571ae1@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 03:05:30PM +0200, Marek Szyprowski wrote:
> Hi Christoph,
> 
> On 04.05.2020 14:52, Christoph Hellwig wrote:
> > On Mon, May 04, 2020 at 02:50:17PM +0200, Marek Szyprowski wrote:
> >> v2:
> >> - dropped most of the changes to drm/i915
> >> - added fixes for rcar-du, xen, media and ion
> >> - fixed a few issues pointed by kbuild test robot
> >> - added wide cc: list for each patch
> > Didn't you plan to add dma_map_sgbuf and co helper?
> 
> Yes, I have a followup patches for that, but I wanted to fix the 
> existing code in the first step. Then I wanted to send a wrappers and 
> their application. Do you think I should do everything at once, in one 
> patchset?

That would be my preference.  The helpers should be mostly trivial
wrappers, so they can easily backported, and they force passing of the
correct parameters.  So I don't really see a need to fix up all the 20+
places up first just to convert them to the proper API a little later.
