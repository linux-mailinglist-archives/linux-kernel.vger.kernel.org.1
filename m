Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86809265A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 09:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgIKHKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 03:10:16 -0400
Received: from verein.lst.de ([213.95.11.211]:35778 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKHKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:10:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD69168BFE; Fri, 11 Sep 2020 09:10:09 +0200 (CEST)
Date:   Fri, 11 Sep 2020 09:10:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        iommu@lists.linux-foundation.org, Tomasz Figa <tfiga@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 04/12] dma-mapping: fix DMA_OPS dependencies
Message-ID: <20200911071009.GC22394@lst.de>
References: <20200908164758.3177341-1-hch@lst.de> <20200908164758.3177341-5-hch@lst.de> <8404208b-7276-914e-e4da-e65a907a5e9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8404208b-7276-914e-e4da-e65a907a5e9b@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 09:04:17PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 9/8/20 7:47 PM, Christoph Hellwig wrote:
> 
> > Driver that select DMA_OPS need to depend on HAS_DMA support to
> > work.  The vop driver was missing that dependency, so add it, and also
> > add a nother depends in DMA_OPS itself.  That won't fix the issue due
> 
>    Another? :-)

Yes, fixed.
