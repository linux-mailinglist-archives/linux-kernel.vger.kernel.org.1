Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37625FE1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgIGQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 12:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbgIGQGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:06:01 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ABD21789;
        Mon,  7 Sep 2020 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494761;
        bh=u+k7kNV35vshUGOv/l53aOVXGrjP+5BmSgodlKTxJ1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EB1zGfdI/2Irq6huzU1qnpnAJgCC56yqMX8YrqhjMhF+71NiOtRxfBYvFWR0CL9rv
         ELZQCy6nONVEkOamdDCy0xQI+Ax0137BrSgVFoc1OJiYCCb/7uEWL6Uw8GHMGm3E+l
         r39M9YH667xes+vMr0eqvXmUfhUS/3GN+R6WJSYo=
From:   Will Deacon <will@kernel.org>
To:     robin.murphy@arm.com, Zenghui Yu <yuzenghui@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, wanghaibin.wang@huawei.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix l1 stream table size in the error message
Date:   Mon,  7 Sep 2020 17:05:38 +0100
Message-Id: <159948439400.581956.11158746781131068189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200826141758.341-1-yuzenghui@huawei.com>
References: <20200826141758.341-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 22:17:58 +0800, Zenghui Yu wrote:
> The actual size of level-1 stream table is l1size. This looks like an
> oversight on commit d2e88e7c081ef ("iommu/arm-smmu: Fix LOG2SIZE setting
> for 2-level stream tables") which forgot to update the @size in error
> message as well.
> 
> As memory allocation failure is already bad enough, nothing worse would
> happen. But let's be careful.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Fix l1 stream table size in the error message
      https://git.kernel.org/will/c/dc898eb84b25

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
