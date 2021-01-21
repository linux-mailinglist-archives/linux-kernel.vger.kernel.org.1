Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77B2FF602
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhAUUgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbhAUUfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:35:46 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F83A230F9;
        Thu, 21 Jan 2021 20:35:05 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2gfX-009HND-HV; Thu, 21 Jan 2021 20:35:03 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] irqchip: Remove obsolete drivers
Date:   Thu, 21 Jan 2021 20:34:59 +0000
Message-Id: <161126112131.135928.3923425882090490812.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120133008.2421897-1-arnd@kernel.org>
References: <20210120133008.2421897-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: arnd@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 14:30:06 +0100, Arnd Bergmann wrote:
> A few Arm platforms are getting removed in v5.12, this removes
> the corresponding irqchip drivers.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/
> 
> 
> Arnd Bergmann (2):
>   irqchip: remove sigma tango driver
>   irqchip: remove sirfsoc driver
> 
> [...]

Applied to irq/irqchip-5.12, thanks!

[1/2] irqchip: remove sigma tango driver
      commit: 00e772c4929257b11b51d47e4645f67826ded0fc
[2/2] irqchip: remove sirfsoc driver
      commit: 5c1ea0d842b1e73ae04870527ec29d5479c35041

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


