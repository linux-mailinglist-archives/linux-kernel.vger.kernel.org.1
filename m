Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03032FD1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbhATNtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389952AbhATNay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:30:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31FC423380;
        Wed, 20 Jan 2021 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611149414;
        bh=7Dxbf+n+CfQW9d60CkGSPLQL848nYMr0VqI4bSkYekE=;
        h=From:To:Cc:Subject:Date:From;
        b=WoJm4T5pej/KOmtgQNjRwTeXHoGCpQYYRdjvf4UVdwwdA5aSBD3034Esi4JfSo7Jz
         A8lvC5/RfGPf5cxMt039r7uBkU5C70X+7sDMFfu2O4bywJh6aSoX74cvGERxJZ9lFz
         edVbTVwNHmKg0F+LvkYODWNfU/wnl+QTK7VGHB6HsiT/UjPlbWlphcq7kQTX0Trere
         RBvU8OCKiu2Ns/I0gfPnwAy/xsklGc8V28Bs1QYKOApusXcI2hw/g1GqWP0WJKAr4m
         /cEu2Zjox59Mb5ZqCwCIbw/iAGJSLf3QiHEwM8ywmC6ZI95Eu12Zl6iXEf8e0qrWa1
         ffic9kHzYET2A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] irqchip: Remove obsolete drivers
Date:   Wed, 20 Jan 2021 14:30:06 +0100
Message-Id: <20210120133008.2421897-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few Arm platforms are getting removed in v5.12, this removes
the corresponding irqchip drivers.

Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/


Arnd Bergmann (2):
  irqchip: remove sigma tango driver
  irqchip: remove sirfsoc driver

 .../sigma,smp8642-intc.txt                    |  48 ----
 drivers/irqchip/Kconfig                       |   5 -
 drivers/irqchip/Makefile                      |   2 -
 drivers/irqchip/irq-sirfsoc.c                 | 134 -----------
 drivers/irqchip/irq-tango.c                   | 227 ------------------
 5 files changed, 416 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
 delete mode 100644 drivers/irqchip/irq-sirfsoc.c
 delete mode 100644 drivers/irqchip/irq-tango.c

-- 
2.29.2

