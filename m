Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A81CF422
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 14:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgELMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 08:18:35 -0400
Received: from verein.lst.de ([213.95.11.211]:40904 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgELMSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:18:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53E1368BEB; Tue, 12 May 2020 14:18:30 +0200 (CEST)
Date:   Tue, 12 May 2020 14:18:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 02/38] scatterlist: add generic wrappers for
 iterating over sgtable objects
Message-ID: <20200512121830.GB20393@lst.de>
References: <20200512085710.14688-1-m.szyprowski@samsung.com> <20200512090058.14910-1-m.szyprowski@samsung.com> <CGME20200512090108eucas1p10a3571be3f60265daea3b3f1469b5e82@eucas1p1.samsung.com> <20200512090058.14910-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512090058.14910-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
