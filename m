Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D561E574E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 08:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgE1GOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 02:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgE1GOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:14:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D2C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zni0B8k5iMx2062s+cLkcal1ezBX/6+aSXESnytrVBA=; b=n6L4oCgg5qx1q88mtA0neKBlJH
        VH5WkwsKABSpxb2nXXripcejQz22sXvL/OXW6RXPrCwIl3MJy9Z0HTPAP2asJIv+VT3HxqDGr6Qtj
        Db/jZtyXSdRaq03bWrdWmluP1qui019NEK5NZkiRVdb6cNJNj85irS1+kavTyvaJ3gwBTlAAShxgF
        6jcnT1yUoRPamgODIO4mqAstUWV9KEQzTDTcyuAukl73XzsP2imQk1CtHPU8waqlwRAPN6V8CP717
        A1wABNoblFdvkivbGnODWd7/NBuXGGgYsjNhvA4Qmt3/7dasgoJfiboIkWqXJ2iSsbO87fAqkCStm
        SIyURPEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeBnd-0007EK-9j; Thu, 28 May 2020 06:13:53 +0000
Date:   Wed, 27 May 2020 23:13:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iommu/amd: Unexport get_dev_data()
Message-ID: <20200528061353.GA17035@infradead.org>
References: <20200527115313.7426-1-joro@8bytes.org>
 <20200527115313.7426-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527115313.7426-3-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:53:05PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This function is internal to the AMD IOMMU driver and only exported
> because the amd_iommu_v2 modules calls it. But the reason it is called
> from there could better be handled by amd_iommu_is_attach_deferred().
> So unexport get_dev_data() and use amd_iommu_is_attach_deferred()
> instead.

Btw, what is the reason amd_iommu_v2 is a separate module?  It is
very little code, and other drivers seem to just integrate such
functionality.

