Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E02FF28B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbhAURzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388837AbhAURyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:54:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F32A7207C5;
        Thu, 21 Jan 2021 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251605;
        bh=vDwNDLdPpFTwrWqZmAFtSoWHQOtXgmCA2y8ljJ/9Lvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6CGLXDIqpndRDF7BL5eQvvqn36AXV/Ziil1sr3uDqHKENxAK1bgi/5nOG4hgsdlh
         P49tMC2kwamaG1KYCiDaXSnuIqZkwapB5hl0S15Oh+njMP2zl85jtJryEpARqQwN3v
         eXdznxDwCtF35IPBHReT0E6bQ3LRx8uN1ndYA2RJATKDllXTOf+R0tUm7GOyGEORgy
         XaaNnP8aBewjV/KCUxEINc+J50T0tXSFl/yn1bD+3vWemUGBOv+rDlpS/YpeiBbMWc
         qnn9yQJCuiYSZYowZA3kQvXDp71AjoG1P2AaBEnUQqOiPKlctWduLAoWTXjddFZ69H
         CPyic9Eptlqrw==
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>, tytso@mit.edu
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        andre.przywara@arm.com
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting IRQ randomness
Date:   Thu, 21 Jan 2021 17:53:18 +0000
Message-Id: <161124379345.536991.7126735996539393054.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105152944.16953-1-ardb@kernel.org>
References: <20201105152944.16953-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 16:29:44 +0100, Ard Biesheuvel wrote:
> When reseeding the CRNG periodically, arch_get_random_seed_long() is
> called to obtain entropy from an architecture specific source if one
> is implemented. In most cases, these are special instructions, but in
> some cases, such as on ARM, we may want to back this using firmware
> calls, which are considerably more expensive.
> 
> Another call to arch_get_random_seed_long() exists in the CRNG driver,
> in add_interrupt_randomness(), which collects entropy by capturing
> inter-interrupt timing and relying on interrupt jitter to provide
> random bits. This is done by keeping a per-CPU state, and mixing in
> the IRQ number, the cycle counter and the return address every time an
> interrupt is taken, and mixing this per-CPU state into the entropy pool
> every 64 invocations, or at least once per second. The entropy that is
> gathered this way is credited as 1 bit of entropy. Every time this
> happens, arch_get_random_seed_long() is invoked, and the result is
> mixed in as well, and also credited with 1 bit of entropy.
> 
> [...]

Applied to arm64 (for-next/random), thanks!

[1/1] random: avoid arch_get_random_seed_long() when collecting IRQ randomness
      https://git.kernel.org/arm64/c/390596c9959c

Ted -- please shout if you would prefer me not to carry this in the arm64
tree. I've haven't seen a response from you on this thread, but this patch
is currently blocking support for the TRNG firmware call on arm64 [1], so
I've pulled it in as a dependency. The branch above is stable, so you can
pull it in as well if necessary.

[1] https://lore.kernel.org/r/20210106103453.152275-1-andre.przywara@arm.com

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
