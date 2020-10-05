Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E02283630
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgJENEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:04:50 -0400
Received: from verein.lst.de ([213.95.11.211]:58991 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgJENEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17CA868B05; Mon,  5 Oct 2020 15:04:46 +0200 (CEST)
Date:   Mon, 5 Oct 2020 15:04:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, od@zcrc.me,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cma: decrease CMA_ALIGNMENT lower limit to 2
Message-ID: <20201005130445.GA2163@lst.de>
References: <20200930102821.26421-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930102821.26421-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to dma-mapping for-next.
