Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72751E4289
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgE0Mj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbgE0Mj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:39:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC0C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:39:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 82F30247; Wed, 27 May 2020 14:39:25 +0200 (CEST)
Date:   Wed, 27 May 2020 14:39:24 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] drivers/iommu: Constify structs
Message-ID: <20200527123923.GJ5221@8bytes.org>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:49:56PM +0200, Rikard Falkeborn wrote:
> Constify some structs with function pointers to allow the compiler to
> put them in read-only memory. There is not dependency between the
> patches.
> 
> Rikard Falkeborn (2):
>   iommu/hyper-v: Constify hyperv_ir_domain_ops
>   iommu/sun50i: Constify sun50i_iommu_ops
> 
>  drivers/iommu/hyperv-iommu.c | 2 +-
>  drivers/iommu/sun50i-iommu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied both, thanks.
