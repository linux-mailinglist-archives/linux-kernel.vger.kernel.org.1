Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3401F216697
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgGGGlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 02:41:25 -0400
Received: from verein.lst.de ([213.95.11.211]:57326 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgGGGlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:41:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D51F68AFE; Tue,  7 Jul 2020 08:41:22 +0200 (CEST)
Date:   Tue, 7 Jul 2020 08:41:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Message-ID: <20200707064122.GA23444@lst.de>
References: <20200703162548.19953-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703162548.19953-1-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 05:25:48PM +0100, Will Deacon wrote:
> The IOMMU_SYS_CACHE_ONLY flag was never exposed via the DMA API and
> has no in-tree users. Remove it.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
