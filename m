Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE0300489
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbhAVNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbhAVNuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:50:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B522F23A53;
        Fri, 22 Jan 2021 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611323380;
        bh=LGurerklXvR4NnJ2R8hS26LPpzDeKKOYA+gAwfQoSdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7F5A79gPeylu8LP+hiFK16LlhWxqX7PQuZQXrumdef0GPdCK/AQMnUwxq1tdbEsu
         5Nm3cpEVRksO6fmVPZM4UgZpBYwmce1fFrAvpZKsZBLuvaMYolqDxnqmQFZQ9A3jOQ
         IMavJ6SASKap66Tag9gRQatH9bMF3d9QO8UiLFnSJdQjiwUqGsAWGLDW/ugzk7QUq6
         h+41OC/bj9BWNZAUoe9gqCYnteRgoPTqHN7YjfM6bXkQghmAGu/gasnzdMHhNJJxyV
         ybEWzGbOnLthYyMyALLby4bxjigillVvvZAicIN9S2eAVsNN2ughyucXtPjj0Rej9D
         U5R2YA5nl0pCQ==
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X compatible
Date:   Fri, 22 Jan 2021 13:49:31 +0000
Message-Id: <161132114998.228840.14370401178606658365.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
References: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 17:40:04 -0800, Bjorn Andersson wrote:
> Add compatible for the ARM SMMU found in the Qualcomm SC8180x platform.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X compatible
      https://git.kernel.org/will/c/9cde12ba07ce
[2/2] iommu/arm-smmu-qcom: Add Qualcomm SC8180X impl
      https://git.kernel.org/will/c/1a7180ff81aa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
