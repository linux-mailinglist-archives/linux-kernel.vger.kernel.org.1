Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7427B303B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392041AbhAZLJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:09:06 -0500
Received: from verein.lst.de ([213.95.11.211]:46935 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388072AbhAZGis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:38:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5217A68BEB; Tue, 26 Jan 2021 07:38:05 +0100 (CET)
Date:   Tue, 26 Jan 2021 07:38:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/5] kernel/dma: remove unnecessary unmap_kernel_range
Message-ID: <20210126063805.GB26674@lst.de>
References: <20210126045404.2492588-1-npiggin@gmail.com> <20210126045404.2492588-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126045404.2492588-3-npiggin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:54:01PM +1000, Nicholas Piggin wrote:
> vunmap will remove ptes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
