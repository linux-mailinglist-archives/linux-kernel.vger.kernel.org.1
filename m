Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B9A302F04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbhAYW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbhAYW07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:26:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872A620756;
        Mon, 25 Jan 2021 22:26:08 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l4AJC-009ypw-8i; Mon, 25 Jan 2021 22:26:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: (subset) [PATCH v6 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Date:   Mon, 25 Jan 2021 22:25:49 +0000
Message-Id: <161161350642.425740.16814835137021867526.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106103453.152275-1-andre.przywara@arm.com>
References: <20210106103453.152275-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux@armlinux.org.uk, andre.przywara@arm.com, ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linus.walleij@linaro.org, sudeep.holla@arm.com, broonie@kernel.org, lorenzo.pieralisi@arm.com, tytso@mit.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
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

Applied to kvm-arm64/rng-5.12, thanks!

[5/5] KVM: arm64: implement the TRNG hypervisor call
      commit: a8e190cdae1bf8e9e490776b8179babc1962bb25

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


