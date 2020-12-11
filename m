Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EEE2D788C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437110AbgLKPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436769AbgLKPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF3C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:49 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYqYduDkUukwxgxgmWqTZcKXb7Iz6dWIZ/h9dTTZ9vI=;
        b=UCFl/kQoFu1+Jg8lLspwfG6DWh9wwzd8v2MDgHG06HxbX0Ho4BG4IpXPZFlVIzLmnXaxuj
        hgh25WYvN25cY/Na7U0ufK1iYnItILGaD1EG8FvomfBOOH0J4IAlg4SfRY+f974xer3wn/
        pestgdeVF6lIC/IT5wWaPMPQApT/6d9Dh+Dj45USIAACLspPHqOwfkO0ptF+2pteV8x2b6
        pmrhYftGz9eiwILqf/+Gn8PFVbc8Orb7HweUmctvg/1acln70I4nIyJRRN7OG64GIaLjb+
        ptHh+D5SPhjH402VbCd49ogeqGZPdv49j1i9esNRJwsHA3UDfYigOZBUpdR3/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYqYduDkUukwxgxgmWqTZcKXb7Iz6dWIZ/h9dTTZ9vI=;
        b=SrDG7D2c5KR5k4SWm4PH0RIOkMd4UAdR9ahvGFDqIcbCQzfiXTtUhNQUO0aMGUXmVz1wcO
        wo9v9Mfnfz8JYnCA==
From:   "irqchip-bot for Shenming Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v4.1: Reduce the delay when
 polling GICR_VPENDBASER.Dirty
Cc:     Shenming Lu <lushenming@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20201128141857.983-2-lushenming@huawei.com>
References: <20201128141857.983-2-lushenming@huawei.com>
MIME-Version: 1.0
Message-ID: <160769872547.3364.17606433720729162482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0b39498230ae53e6af981141be99f4c7d5144de6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0b39498230ae53e6af981141be99f4c7d5144de6
Author:        Shenming Lu <lushenming@huawei.com>
AuthorDate:    Sat, 28 Nov 2020 22:18:56 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:10 

irqchip/gic-v4.1: Reduce the delay when polling GICR_VPENDBASER.Dirty

The 10us delay of the poll on the GICR_VPENDBASER.Dirty bit is too
high, which might greatly affect the total scheduling latency of a
vCPU in our measurement. So we reduce it to 1 to lessen the impact.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201128141857.983-2-lushenming@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4069c21..d74ef41 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3808,7 +3808,7 @@ static void its_wait_vpt_parse_complete(void)
 	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
 						       val,
 						       !(val & GICR_VPENDBASER_Dirty),
-						       10, 500));
+						       1, 500));
 }
 
 static void its_vpe_schedule(struct its_vpe *vpe)
