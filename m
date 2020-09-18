Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6E26F82C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIRI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRI3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:29:46 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BA3C06174A;
        Fri, 18 Sep 2020 01:29:45 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 068E5396; Fri, 18 Sep 2020 10:29:42 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:29:41 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, yong.wu@mediatek.com,
        miles.chen@mediatek.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: iommu: Add binding for MediaTek
 MT8167 IOMMU
Message-ID: <20200918082941.GE31590@8bytes.org>
References: <20200907101649.1573134-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907101649.1573134-1-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:16:47PM +0200, Fabien Parent wrote:
> This commit adds IOMMU binding documentation and larb port definitions
> for the MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> V4:
> 	* Added path to mt8167 larb header file
> 	* Added Honghui Zhang in copyright header
> V3: Added mt8167-larb-port.h file for iommu port definitions
> V2: no change

Applied all, thanks.

