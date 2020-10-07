Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698CA28606A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgJGNsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGNsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:48:36 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BEE206F0;
        Wed,  7 Oct 2020 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602078515;
        bh=wgaV+OreOb2/VRx5awMmSsVGlLPYVfFyk/tGS6NloNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2BHK5oz4eaaxLnhSWqVT6QV7gYLhAdoupWvYqdACPoWA8QKD+nA/4Mr387/YQGdr6
         hPIIS9M+b1EaynZSdKvTIweEZq8ajKRUjsz3lOtG9FvBXWNpdN1ozXh0e5zbPsp+9C
         gjqPiNz3USL9ViUhGJ2soWfXAPLQKaGb9ca6DCMU=
From:   Will Deacon <will@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: random: Remove no longer needed prototypes
Date:   Wed,  7 Oct 2020 14:48:29 +0100
Message-Id: <160207664101.1151622.16725986201349020679.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201006194453.36519-1-andre.przywara@arm.com>
References: <20201006194453.36519-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 20:44:53 +0100, Andre Przywara wrote:
> Commit 9bceb80b3cc4 ("arm64: kaslr: Use standard early random
> function") removed the direct calls of the __arm64_rndr() and
> __early_cpu_has_rndr() functions, but left the dummy prototypes in the
>  #else branch of the #ifdef CONFIG_ARCH_RANDOM guard.
> 
> Remove the redundant prototypes, as they have no users outside of
> this header file.

Applied to arm64 (for-next/late-arrivals), thanks!

[1/1] arm64: random: Remove no longer needed prototypes
      https://git.kernel.org/arm64/c/d433ab42fdc2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
