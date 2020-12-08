Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE842D2EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgLHPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgLHPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:55:27 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     iommu@lists.linux-foundation.org,
        Keqian Zhu <zhukeqian1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        jiangkunkun@huawei.com, wanghaibin.wang@huawei.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2] iommu: Defer the early return in arm_(v7s/lpae)_map
Date:   Tue,  8 Dec 2020 15:54:32 +0000
Message-Id: <160743579041.2814165.8711661573048681201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201207115758.9400-1-zhukeqian1@huawei.com>
References: <20201207115758.9400-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 19:57:58 +0800, Keqian Zhu wrote:
> Although handling a mapping request with no permissions is a
> trivial no-op, defer the early return until after the size/range
> checks so that we are consistent with other mapping requests.

Applied to arm64 (for-next/iommu/misc), thanks!

[1/1] iommu: Defer the early return in arm_(v7s/lpae)_map
      https://git.kernel.org/arm64/c/f12e0d22903e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
