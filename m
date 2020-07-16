Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B172222216
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgGPMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgGPMAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:00:52 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28D420760;
        Thu, 16 Jul 2020 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594900852;
        bh=wzG1kO8a1wB9j6Gomc3oh/l5KQknXb3VN9MC8crfe+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKRz5oHOJKLP/zkX6KfZVqNaI9BvlpFZ4QIskBlcNAHhZQvGap40sdFnQz2hID1t5
         mDSS7NWG61g+LLB8NBwLfEPHotSktRSD977MrJXCttAf01MADI22etKpe/Q64138Lj
         T9HYIfQrcIFCBf7NHyPZoRzjDzY9FsYwceZhanZM=
From:   Will Deacon <will@kernel.org>
To:     robh+dt@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        Tomasz Nowicki <tn@semihalf.com>, hannah@marvell.com,
        gregory.clement@bootlin.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, nadavh@marvell.com,
        mw@semihalf.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
Date:   Thu, 16 Jul 2020 13:00:43 +0100
Message-Id: <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 09:06:45 +0200, Tomasz Nowicki wrote:
> The series is meant to support SMMU for AP806 and a workaround
> for accessing ARM SMMU 64bit registers is the gist of it.
> 
> For the record, AP-806 can't access SMMU registers with 64bit width.
> This patches split the readq/writeq into two 32bit accesses instead
> and update DT bindings.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu: Call configuration impl hook before consuming features
      https://git.kernel.org/will/c/6a79a5a3842b
[2/3] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
      https://git.kernel.org/will/c/f2d9848aeb9f
[3/3] dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500
      https://git.kernel.org/will/c/e85e84d19b9d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
