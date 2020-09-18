Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB95270183
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRQBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:01:35 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C812388B;
        Fri, 18 Sep 2020 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600444894;
        bh=+y08LIMjQWBttNhnxoOfklDMRBTpk6CDyAXUosBciKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFfkBv9SEhD1t424jZjepHDiEoxrb7S+Q65VatFgmqPC2PJ7yZF+5zJ50G1QaK5TT
         8DoRW/+/9FpdO9bwB4RBLjt1hINS8BgKyKD+Dn1OYdTqvmiFurq8rpV+D3qrsKd0xQ
         r7HhSjDfXXDetlxFrpdTv6alu2Nm0ctAjnX6XF4U=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kJIpI-00D3Kp-J6; Fri, 18 Sep 2020 17:01:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     catalin.marinas@arm.com, YueHaibing <yuehaibing@huawei.com>,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64: Fix -Wunused-function warning
Date:   Fri, 18 Sep 2020 17:01:29 +0100
Message-Id: <160044487333.1302416.595224309717788435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918123318.23764-1-yuehaibing@huawei.com>
References: <20200918123318.23764-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, yuehaibing@huawei.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 20:33:18 +0800, YueHaibing wrote:
> If CONFIG_HOTPLUG_CPU is n, gcc warns:
> 
> arch/arm64/kernel/smp.c:967:13: warning: ‘ipi_teardown’ defined but not used [-Wunused-function]
>  static void ipi_teardown(int cpu)
>              ^~~~~~~~~~~~
> 
> Use #ifdef guard this.

Applied to irq/irqchip-next, thanks!

[1/1] arm64: Fix -Wunused-function warning when !CONFIG_HOTPLUG_CPU
      commit: 9d9edb962e910552c9c008800ec907293a47852e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


