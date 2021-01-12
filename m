Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114502F397C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392907AbhALTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbhALTEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:04:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B93E230F9;
        Tue, 12 Jan 2021 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478208;
        bh=arJYye6Gv+8BuVsZc+5AV+LIkT34tlazeQkU3YPaluM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJx7vokyB5+qhEnSmUd0eR+wmyyCD0UMA411LAhNUBO5eknScs5nLleFxQ9uCG9OZ
         gsZ8SkoRr1t7DrFPG4dy756LV/FwGIKOjPCKFwSmmUbjWWjnl8xLcONV/tvActX/nY
         6M9bJGW7vLRwM+tjCs4wYFWhd4/roFfBc1he8QPr+r3qrRYilSJqWBcqqFBY4Dhsqn
         L5h84UpX57SC6H+tNiFO0x8Lwwxi0CLS5n7++OaIbDQcfXYhB3ESsz3PTxewbFWMRa
         pcXjsB3pdqMQIq+LZezGBVWU0xfaavcgDVAPUakFmjiXUZlJIjfsKoY4/2NpYiz1vx
         bEesUrjXb23MQ==
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        John Stultz <john.stultz@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH v2] iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles for qcom quirks
Date:   Tue, 12 Jan 2021 19:03:20 +0000
Message-Id: <161046656595.1107648.16027501350781316856.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210109165622.149777-1-konrad.dybcio@somainline.org>
References: <20210109165622.149777-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jan 2021 17:56:21 +0100, Konrad Dybcio wrote:
> SDM630 and MSM8998 are among the SoCs that use Qualcomm's implementation
> of SMMUv2 which has already proven to be problematic over the years. Add
> their compatibles to the lookup list to prevent the platforms from being
> shut down by the hypervisor at MMU probe.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles for qcom quirks
      https://git.kernel.org/arm64/c/b812834b5329

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
