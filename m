Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E021AFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgGJGu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 02:50:59 -0400
Received: from verein.lst.de ([213.95.11.211]:42097 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJGu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:50:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1999E68BEB; Fri, 10 Jul 2020 08:50:55 +0200 (CEST)
Date:   Fri, 10 Jul 2020 08:50:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, hch@lst.de,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dma-pool: Get rid of dma_in_atomic_pool()
Message-ID: <20200710065054.GA19416@lst.de>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de> <20200709161903.26229-3-nsaenzjulienne@suse.de> <alpine.DEB.2.23.453.2007091449540.972523@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2007091449540.972523@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 02:51:13PM -0700, David Rientjes wrote:
> On Thu, 9 Jul 2020, Nicolas Saenz Julienne wrote:
> 
> > The function is only used once and can be simplified to a one-liner.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> I'll leave this one to Christoph to decide on.  One thing I really liked 
> about hacking around in kernel/dma is the coding style, it really follows 
> "one function does one thing and does it well" even if there is only one 
> caller.  dma_in_atomic_pool() was an attempt to follow in those footsteps.

While I like the helper aswell, I don't see how it could work nicely
with the changes in patch 4.
