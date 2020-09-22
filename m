Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE32743D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVOH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:07:58 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:55236 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIVOH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:07:58 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 10:07:57 EDT
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 012F1200ED6;
        Tue, 22 Sep 2020 14:00:10 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 1C81D20D67; Tue, 22 Sep 2020 15:59:49 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:59:49 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dma-mapping: remove DMA_MASK_NONE
Message-ID: <20200922135949.GA43152@light.dominikbrodowski.net>
References: <20200922134002.1227279-1-hch@lst.de>
 <20200922134002.1227279-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922134002.1227279-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:40:00PM +0200, Christoph Hellwig wrote:
> This value is only used by a PCMCIA driver and not very useful.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Dominik Brodowski <linux@dominikbrodwski.net>

