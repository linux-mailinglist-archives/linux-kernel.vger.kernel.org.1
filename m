Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2859327C264
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgI2K3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2K3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:29:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=snXqE5Fuxzxj+Dq80Fpy82dFJ2huHsUwNyoAuNAyXRY=; b=rQmUQrw33LG8nHvT1R/EABov+K
        eqbghjG+ymbal+7K/qbZZhvd+c3bcolL1qNWFJA+GUC4D63UT3akhGM2p67WKEj1cbBdNuMeWIImC
        JJM5OpEzA4nvsFz1rG3kHXu2gHZG68HHRQLnRI92Lowu1CLA87NltVtPSqdat4puT/xVoE4imrW41
        DgMohGK/KDPzPCWqxn9YoexvEbZWOIGdUlBHnwJKxwTkWVISAZIbgt3UVhRp4oi6slK9Esqh6BM/I
        /z29uDmPjOQXPUod0TGBBxeC8DZ5mIHa5GDFOKKUoIWXG/5ZNNSk2PPaQss4tn2FVfj3YzgJ8TGq6
        WBKPLhig==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNCsZ-0002gP-Id; Tue, 29 Sep 2020 10:29:03 +0000
Date:   Tue, 29 Sep 2020 11:29:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for vop driver
Message-ID: <20200929102903.GE7784@infradead.org>
References: <20200929084944.24146-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084944.24146-1-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:49:44PM +0800, Sherry Sun wrote:
> Set VIRTIO_F_ACCESS_PLATFORM feature for vop driver, as the DMA mapping
> details shouldn't decide on the virtio implementation, but the host PCIe
> implementatio
>
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
