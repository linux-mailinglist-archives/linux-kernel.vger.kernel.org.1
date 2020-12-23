Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7F2E1A28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgLWIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgLWIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:52:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3mzr93rw3bP5ndgOkj2J3rKWLzLdUR7cBci5P56NY/A=; b=e7DvOMVGT/z24nyz8RevO5TNuL
        WdyEBLPTXKZhnYQ2+JVThOyNcxf1W5KmTwA5W+HXZ8RE0mSTFAIkiLI0qGI4zRULn4wEHAusY5Vbe
        D24ApPSkSgchloP395V8Td00Gs/g6HoEYWoOCASf4iAdUL3iFj2TNNS33xKjYQM6AaQA/TOVozKYh
        1sDh3FDP4ocjoCLt1zgYr+7Khy+s/SqFXCFz4AQ2Ur0gzSqXXjkBfokXBTz1QUm1C1hgs0V+bSlqw
        PBsf/QGD/O0JyNCf9CiaF68I94p3AU25XOkvlee4xZxdJq3JNylV8r+FV5TvU99JNFVaeGRyMp2C4
        W6+6dNow==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krzs9-0008Rh-6Z; Wed, 23 Dec 2020 08:51:53 +0000
Date:   Wed, 23 Dec 2020 08:51:53 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/7] iommu: Move iotlb_sync_map out from __iommu_map
Message-ID: <20201223085153.GA30643@infradead.org>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216103607.23050-2-yong.wu@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 06:36:01PM +0800, Yong Wu wrote:
> In the end of __iommu_map, It alway call iotlb_sync_map.
> This patch moves iotlb_sync_map out from __iommu_map since it is
> unnecessary to call this for each sg segment especially iotlb_sync_map
> is flush tlb all currently.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

What about adding a little helper that does the NULL check and method
call instead of duplicating it all over?
