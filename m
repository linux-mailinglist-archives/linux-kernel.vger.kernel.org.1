Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2811C20D2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgF2Svk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:51:40 -0400
Received: from verein.lst.de ([213.95.11.211]:58883 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbgF2Svf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:51:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 335C268B05; Mon, 29 Jun 2020 10:12:56 +0200 (CEST)
Date:   Mon, 29 Jun 2020 10:12:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200629081255.GA32155@lst.de>
References: <20200608132217.29945-1-geert@linux-m68k.org> <20200620200936.GA106151@roeck-us.net> <20200624073815.GE18609@lst.de> <6473db8e-4116-c994-aa08-6b50a6c609fb@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6473db8e-4116-c994-aa08-6b50a6c609fb@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 06:13:43PM +0200, Marion & Christophe JAILLET wrote:
> I'm sorry, but I will not send pci_ --> dma_ conversion for this driver.
> I'm a bit puzzled by some choice of GFP_KERNEL and GFP_ATOMIC that not all 
> that obvious to me.
>
> I'll try to send some patches for other easier drivers in the coming weeks.

No problem, I sent a patch for the conversion of the allocations that
caused problems.
