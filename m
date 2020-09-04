Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200F825D768
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgIDLdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbgIDLb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:31:58 -0400
X-Greylist: delayed 6918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Sep 2020 04:21:25 PDT
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532CC061262;
        Fri,  4 Sep 2020 04:21:24 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6B8533D5; Fri,  4 Sep 2020 13:21:19 +0200 (CEST)
Date:   Fri, 4 Sep 2020 13:21:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCHv5] iommu/mediatek: check 4GB mode by reading
 infracfg
Message-ID: <20200904112117.GC16609@8bytes.org>
References: <20200904104038.4979-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904104038.4979-1-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 06:40:38PM +0800, Miles Chen wrote:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> [1] https://lore.kernel.org/lkml/20200603161132.2441-1-miles.chen@mediatek.com/
> [2] https://lore.kernel.org/lkml/20200604080120.2628-1-miles.chen@mediatek.com/
> [3] https://lore.kernel.org/lkml/20200715205120.GA778876@bogus/

Applied, thanks.
