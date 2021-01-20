Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F402FD286
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbhATOUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389276AbhATNB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:01:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B534423359;
        Wed, 20 Jan 2021 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611147677;
        bh=fv6o22qVsOE0z15uZ3xH1mPJXj9J7IiDzaa60rlTTfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YduoI6OqvxriKJsI6iQsSU1sNIWsz3fWcf4p7CgaeOKUjohpRnHheqTU3PO765iNp
         vGY2VXlOFDKPz6nClnbKlg+pWEIsLmdtS9hqA5Gkv+9JpZnB5K4vto/h7uQ1YUBa72
         BOfmeo4m4MPjpBLWr/ztZ2HMgoz1rmHWPn1jXFdbutdoDIqMniwDofk06oaq5C8k04
         /HY/qNDhuAliRs1+FyC2RtEFieEswHxxyUXs3Ph8QfvgUweibnJoFBjwlqQwr19dRn
         netuWz7cQi/Mi5uH8RUsOWkh68DFHIsxGLT6U7born+S/ewfCh+miaybHXTIc7qhAX
         RES9H8/CZub+Q==
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kvmarm@lists.cs.columbia.edu,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Date:   Wed, 20 Jan 2021 13:01:02 +0000
Message-Id: <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106103453.152275-1-andre.przywara@arm.com>
References: <20210106103453.152275-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 10:34:48 +0000, Andre Przywara wrote:
> a fix to v5, now *really* fixing the wrong priority of SMCCC vs. RNDR
> in arch_get_random_seed_long_early(). Apologies for messing this up
> in v5 and thanks to broonie for being on the watch!
> 
> Will, Catalin: it would be much appreciated if you could consider taking
> patch 1/5. This contains the common definitions, and is a prerequisite
> for every other patch, although they are somewhat independent and likely
> will need to go through different subsystems.
> 
> [...]

Applied the first patch only to arm64 (for-next/rng), thanks!

[1/5] firmware: smccc: Add SMCCC TRNG function call IDs
      https://git.kernel.org/arm64/c/67c6bb56b649

What's the plan for the rest of the series, and I think the related
change over at [1]?

Cheers,
-- 
Will

[1] https://lore.kernel.org/linux-arm-kernel/20201105152944.16953-1-ardb@kernel.org/

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
