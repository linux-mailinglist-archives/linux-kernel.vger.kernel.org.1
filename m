Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5F2F0674
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 11:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAJKaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 05:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbhAJKaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 05:30:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32595C06179F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 02:29:28 -0800 (PST)
Date:   Sun, 10 Jan 2021 10:29:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610274564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7eJ5CPFbT/2PKsQbGJFtV1+jDwpPZQ2LApk5uV3MMbs=;
        b=Ed/aDN54Id7ZWW72QV3haLwqWWHKXMMlS/DvuzzaPxubUuATuazPaBvRVVzKFc6YalWVuz
        IfChP7845OOxTGTu2tBpEjpb177VM8EhBEOVS0xFLeoFnj14oZMIqHGsUeIeVeXR/z23Cp
        EJt1dJHsdOjjG0ahy9+MjoVnTvuZgEFNVzM2K2FH0GLLNsku8kKgYHaq32S3XH78logCRh
        Ln6/PU5LAkoQ78SGUH2cXbJbey3vIyUnwR+oP7WUvdRPpAv8IIGIQZezRFLCFYWKEiybTY
        Cu1T/6mo0bEadEM9ylijdFE5J8LVIXIUB9PaDhqr6lmZA3OYTS8COJNSAC+50Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610274564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7eJ5CPFbT/2PKsQbGJFtV1+jDwpPZQ2LApk5uV3MMbs=;
        b=5AiC4UdzXV01quSntddsETut8jUGkydcGeTjxWMmmi2bva+CZbR2wP/refB9MyYYNBd/09
        3izBawKiB3f8UeDQ==
From:   "irqchip-bot for Suman Anna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/pruss: Simplify the TI_PRUSS_INTC Kconfig
Cc:     Suman Anna <s-anna@ti.com>, David Lechner <david@lechnology.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210108162901.6003-1-s-anna@ti.com>
References: <20210108162901.6003-1-s-anna@ti.com>
MIME-Version: 1.0
Message-ID: <161027456295.414.14849180372531206590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b8e594fa20d2e33d40c7a8c7c106549a35c38972
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b8e594fa20d2e33d40c7a8c7c106549a35c38972
Author:        Suman Anna <s-anna@ti.com>
AuthorDate:    Fri, 08 Jan 2021 10:29:01 -06:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Jan 2021 10:19:14 

irqchip/pruss: Simplify the TI_PRUSS_INTC Kconfig

The TI PRUSS INTC irqchip driver handles the local interrupt controller
which is a child device of it's parent PRUSS/ICSSG device. The driver
was upstreamed in parallel with the PRUSS platform driver, and was
configurable independently previously. The PRUSS interrupt controller
is an integral part of the overall PRUSS software architecture, and is
not useful at all by itself.

Simplify the TI_PRUSS_INTC Kconfig dependencies by making it silent and
selected automatically when the TI_PRUSS platform driver is enabled.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210108162901.6003-1-s-anna@ti.com
---
 drivers/irqchip/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 94920a5..b147f22 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -493,8 +493,9 @@ config TI_SCI_INTA_IRQCHIP
 	  TI System Controller, say Y here. Otherwise, say N.
 
 config TI_PRUSS_INTC
-	tristate "TI PRU-ICSS Interrupt Controller"
-	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
+	tristate
+	depends on TI_PRUSS
+	default TI_PRUSS
 	select IRQ_DOMAIN
 	help
 	  This enables support for the PRU-ICSS Local Interrupt Controller
