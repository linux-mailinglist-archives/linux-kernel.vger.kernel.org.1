Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227CD217FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 08:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgGHGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 02:45:53 -0400
Received: from verein.lst.de ([213.95.11.211]:33822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgGHGpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:45:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01BA868AFE; Wed,  8 Jul 2020 08:45:50 +0200 (CEST)
Date:   Wed, 8 Jul 2020 08:45:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] scatterlist: protect parameters of the sg_table
 related macros
Message-ID: <20200708064550.GA5577@lst.de>
References: <CGME20200630081613eucas1p2af288e1a5b91c8e62cb8af2901cc45a4@eucas1p2.samsung.com> <20200630081602.30594-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630081602.30594-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 10:16:02AM +0200, Marek Szyprowski wrote:
> Add brackets to protect parameters of the recently added sg_table related
> macros from side-effects.

Applied to the dma-mapping tree, thanks.
