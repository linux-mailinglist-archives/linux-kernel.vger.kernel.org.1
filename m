Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2642E268070
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgIMRFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 13:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgIMRFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 13:05:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9EAD206C3;
        Sun, 13 Sep 2020 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600016731;
        bh=tWUeEoiDLzjse01SftgPJVDp93ipLBBoG2B3S+yl1U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FAaro49hjsaP7m2vX3EgVkgcKTLb9y0uIkvTb+MGolPLpqqKdjx5MLDEZyy42+mm
         CyicsspgrkDkn3drLqyeRVdUWCGILOSri3JgPVIFGHOANLExFjjGdOQRenUAfQxaqk
         a94tgzmpTTX983YcdKia3VvLQElJI9yY+/k3Zj1w=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kHVRQ-00BTQE-TL; Sun, 13 Sep 2020 18:05:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        catalin.marinas@arm.com
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0
Date:   Sun, 13 Sep 2020 18:05:15 +0100
Message-Id: <160001658182.6915.9030793517863303185.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912153707.667731-1-alexandru.elisei@arm.com>
References: <20200912153707.667731-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org, jason@lakedaemon.net, tglx@linutronix.de, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Sep 2020 16:37:05 +0100, Alexandru Elisei wrote:
> Trusted Firmware-A's default interrupt routing model is to clear
> SCR_EL3.FIQ, which is the only case that GICv3 doesn't support. This series
> tries to fix that by detecting it at runtime and using a different priority
> value for ICC_PMR_EL1 when masking regular interrupts. As a result, we will
> be able to support pseudo-NMIs on all combinations of GIC security states
> and firmware configurations.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/2] irqchip/gic-v3: Spell out when pseudo-NMIs are enabled
      commit: 4e594ad1068ea1db359d6161f580f03edecf6cb0
[2/2] irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0
      commit: 336780590990efa69596884114cad3f517b6333b

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


