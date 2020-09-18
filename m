Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCEB2701F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIRQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgIRQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:17:32 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4232396D;
        Fri, 18 Sep 2020 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445851;
        bh=+ZDDi5fKSOk2QwweJZEnSXEbFsLv0NPSYsNZKOgudqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjWKhi16rnfviTFnXVHuIWxyxghCY9wvbQTOmh0y2Dv/YOQgNyna1op0Y00sNz4UC
         PIT08bg5XR/GH707u8t6UqGWyt32ZhZV2bVudPcGIqpmailEmQ3rhOgvOB5p3HSBwZ
         9KsIFHt2dMbb+hW6DeyafK2LlN4G1HVlPwzctiNY=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Clint Sbisa <csbisa@amazon.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] arm64: Enable PCI write-combine resources under sysfs
Date:   Fri, 18 Sep 2020 17:17:15 +0100
Message-Id: <160043431383.3781570.11856151668553199705.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918033312.ddfpibgfylfjpex2@amazon.com>
References: <20200918033312.ddfpibgfylfjpex2@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 03:33:12 +0000, Clint Sbisa wrote:
> This change exposes write-combine mappings under sysfs for
> prefetchable PCI resources on arm64.
> 
> Originally, the usage of "write combine" here was driven by the x86
> definition of write combine. This definition is specific to x86 and
> does not generalize to other architectures. However, the usage of WC
> has mutated to "write combine" semantics, which is implemented
> differently on each arch.
> 
> [...]

Applied to arm64 (for-next/pci), thanks!

[1/1] arm64: Enable PCI write-combine resources under sysfs
      https://git.kernel.org/arm64/c/5fd39dc22027

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
