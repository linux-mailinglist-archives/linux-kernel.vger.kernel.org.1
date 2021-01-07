Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512F32ED209
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbhAGOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbhAGOXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:23:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB78723340;
        Thu,  7 Jan 2021 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610029372;
        bh=QwOHtluI5QjPAV+iXFS1yvi49MqVAvgoQ2rboBEBOpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNabRhPE10cp2uCbeRIIlWuNVwROfR7d1Jc8lv57+sBchnd9xm2/6paMrq6akzVjK
         iNAjoK2H75lpmOuav5qpv9FP/ICRMeeHZEuQfgtBLGyFg654hX80PXYa0ra5WtO5tY
         FZA1L5NVwnGtxKQKwk/LCO9FV/7S1tlEN36rY03NiiFBdCF4CGFVvMxAFDuRmzxLrI
         BP2uiFPG6YrInkO+Rjp+BNJsXcfXLGoV2zuSzn9AzbPWVzZ4jEXiH+EixoG5aKsbib
         DpPPHBfkh162vI9wlenvAj1Df58lqm0CndcltXf+GVwWmSWHLFD1qvFtji/bFSbc5q
         TIDX+aRQtmkgw==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu/vt-d: Fix misuse of ALIGN in qi_flush_piotlb()
Date:   Thu,  7 Jan 2021 14:22:46 +0000
Message-Id: <161002603532.2363893.7669085161472435807.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Dec 2020 08:53:19 +0800, Lu Baolu wrote:
> Use IS_ALIGNED() instead. Otherwise, an unaligned address will be ignored.

Applied patches 1, 4 and 5 to arm64 (for-next/iommu/fixes), thanks!

[1/5] iommu/vt-d: Fix misuse of ALIGN in qi_flush_piotlb()
      https://git.kernel.org/arm64/c/1efd17e7acb6
[4/5] Revert "iommu: Add quirk for Intel graphic devices in map_sg"
      https://git.kernel.org/arm64/c/4df7b2268ad8
[5/5] iommu/vt-d: Fix lockdep splat in sva bind()/unbind()
      https://git.kernel.org/arm64/c/420d42f6f9db

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
