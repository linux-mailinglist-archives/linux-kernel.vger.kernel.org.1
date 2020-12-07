Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6034B2D0EA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLGLGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgLGLGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:06:13 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Yong Wu <yong.wu@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, srv_heupstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chao.hao@mediatek.com, anan.sun@mediatek.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] iommu: Improve the performance for direct_mapping
Date:   Mon,  7 Dec 2020 11:05:24 +0000
Message-Id: <160733817514.2997477.1549939879163904100.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201207093553.8635-1-yong.wu@mediatek.com>
References: <20201207093553.8635-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 17:35:53 +0800, Yong Wu wrote:
> Currently direct_mapping always use the smallest pgsize which is SZ_4K
> normally to mapping. This is unnecessary. we could gather the size, and
> call iommu_map then, iommu_map could decide how to map better with the
> just right pgsize.
> 
> >From the original comment, we should take care overlap, otherwise,
> iommu_map may return -EEXIST. In this overlap case, we should map the
> previous region before overlap firstly. then map the left part.
> 
> [...]

Applied to arm64 (for-next/iommu/misc), thanks!

[1/1] iommu: Improve the performance for direct_mapping
      https://git.kernel.org/arm64/c/093b32a849b3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
