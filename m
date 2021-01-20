Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6434B2FDA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbhATOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388346AbhATN1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:27:17 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A68233A1;
        Wed, 20 Jan 2021 13:26:28 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2DVC-008x9e-IT; Wed, 20 Jan 2021 13:26:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 13:26:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kvmarm@lists.cs.columbia.edu,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/5] ARM: arm64: Add SMCCC TRNG entropy service
In-Reply-To: <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
References: <20210106103453.152275-1-andre.przywara@arm.com>
 <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <d2423ab6e44855846a8f61f327932784@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, andre.przywara@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com, ardb@kernel.org, kernel-team@android.com, tytso@mit.edu, broonie@kernel.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, kvmarm@lists.cs.columbia.edu, lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 13:01, Will Deacon wrote:
> On Wed, 6 Jan 2021 10:34:48 +0000, Andre Przywara wrote:
>> a fix to v5, now *really* fixing the wrong priority of SMCCC vs. RNDR
>> in arch_get_random_seed_long_early(). Apologies for messing this up
>> in v5 and thanks to broonie for being on the watch!
>> 
>> Will, Catalin: it would be much appreciated if you could consider 
>> taking
>> patch 1/5. This contains the common definitions, and is a prerequisite
>> for every other patch, although they are somewhat independent and 
>> likely
>> will need to go through different subsystems.
>> 
>> [...]
> 
> Applied the first patch only to arm64 (for-next/rng), thanks!
> 
> [1/5] firmware: smccc: Add SMCCC TRNG function call IDs
>       https://git.kernel.org/arm64/c/67c6bb56b649

I can't see how the rest of the patches can go via any other tree
if all the definitions are in the first one.

Andre, can you explain what your plan is?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
