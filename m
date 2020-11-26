Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607D42C5A38
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbgKZRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:07:01 -0500
Received: from verein.lst.de ([213.95.11.211]:35086 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391628AbgKZRHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:07:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D7E768B05; Thu, 26 Nov 2020 18:06:57 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:06:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: Fix sizeof() mismatch on tsk allocation
Message-ID: <20201126170657.GA21791@lst.de>
References: <20201125140523.1880669-1-colin.king@canonical.com> <a6c5e5ed9a66485da301c1e91b56ccc7@hisilicon.com> <20201125182941.GB10377@lst.de> <cf79f1ba-aeba-6237-81c8-ca7efc1425e2@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf79f1ba-aeba-6237-81c8-ca7efc1425e2@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 06:49:19PM +0000, Colin Ian King wrote:
> On 25/11/2020 18:29, Christoph Hellwig wrote:
> > I'll fold this one in as well.
> > 
> OK, so two SoB's disappear?

Yes, and are replaced by an annotation about folded fixes, just like
for all kinds of other commits.
