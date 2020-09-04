Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B48F25D3D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgIDIls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIDIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:41:45 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE8C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 01:41:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 49EED3D5; Fri,  4 Sep 2020 10:41:37 +0200 (CEST)
Date:   Fri, 4 Sep 2020 10:41:35 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: mtk: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200904084135.GA6714@8bytes.org>
References: <20200727181842.8441-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727181842.8441-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 08:18:42PM +0200, Krzysztof Kozlowski wrote:
> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:
> 
>     drivers/iommu/mtk_iommu.c:833:34: warning: 'mtk_iommu_of_ids' defined but not used [-Wunused-const-variable=]
>       833 | static const struct of_device_id mtk_iommu_of_ids[] = {
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
