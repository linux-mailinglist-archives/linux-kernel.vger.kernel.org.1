Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417CE23DF58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgHFRqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:46:00 -0400
Received: from verein.lst.de ([213.95.11.211]:50250 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgHFQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:38:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA0EC68D0D; Thu,  6 Aug 2020 15:55:25 +0200 (CEST)
Date:   Thu, 6 Aug 2020 15:55:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, amit.pundir@linaro.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200806135525.GA4380@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de> <20200803160956.19235-3-nsaenzjulienne@suse.de> <20200804060633.GA7368@lst.de> <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de> <20200806051814.GA10143@lst.de> <3a530804ad5aa96d2502da8ee3e8650b0b477c0f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a530804ad5aa96d2502da8ee3e8650b0b477c0f.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:50:29PM +0200, Nicolas Saenz Julienne wrote:
> > The latter is pretty much what I expect, as we only support the default and
> > per-device DMA CMAs.
> 
> Fair enough, should I send a v3 with everything cleaned-up/rebased, or you'd
> rather pick it up from your version?

Please just resend the whole thing. 
