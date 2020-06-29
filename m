Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89B20D165
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgF2Sln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:41:43 -0400
Received: from verein.lst.de ([213.95.11.211]:58787 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgF2Slf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C35C168AFE; Mon, 29 Jun 2020 10:05:56 +0200 (CEST)
Date:   Mon, 29 Jun 2020 10:05:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] dma-pool: warn when coherent pool is depleted
Message-ID: <20200629080556.GA32027@lst.de>
References: <20200621211200.GA158319@roeck-us.net> <alpine.DEB.2.22.394.2006272124470.591864@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006272124470.591864@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:25:21PM -0700, David Rientjes wrote:
> Thanks Guenter.  Christoph, does it make sense to apply this patch since 
> there may not be an artifact left behind in the kernel log on allocation 
> failure by the caller?

Sorry, this fell through the cracks.  I've added it to the dma-mapping
tree now.
