Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4692D2E944C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbhADLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADLuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:50:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CBFF221F9;
        Mon,  4 Jan 2021 11:49:36 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Will Deacon <will@kernel.org>, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: mm: Fix ARCH_LOW_ADDRESS_LIMIT when !CONFIG_ZONE_DMA
Date:   Mon,  4 Jan 2021 11:49:34 +0000
Message-Id: <160976092100.24483.16586418833088712176.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201218163307.10150-1-nsaenzjulienne@suse.de>
References: <20201218163307.10150-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 17:33:07 +0100, Nicolas Saenz Julienne wrote:
> Systems configured with CONFIG_ZONE_DMA32, CONFIG_ZONE_NORMAL and
> !CONFIG_ZONE_DMA will fail to properly setup ARCH_LOW_ADDRESS_LIMIT. The
> limit will default to ~0ULL, effectively spanning the whole memory,
> which is too high for a configuration that expects low memory to be
> capped at 4GB.
> 
> Fix ARCH_LOW_ADDRESS_LIMIT by falling back to arm64_dma32_phys_limit
> when arm64_dma_phys_limit isn't set. arm64_dma32_phys_limit will honour
> CONFIG_ZONE_DMA32, or span the entire memory when not enabled.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: Fix ARCH_LOW_ADDRESS_LIMIT when !CONFIG_ZONE_DMA
      https://git.kernel.org/arm64/c/095507dc1350

-- 
Catalin

