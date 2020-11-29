Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229A72C7975
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgK2NxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 08:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2NxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 08:53:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DDFD207FF;
        Sun, 29 Nov 2020 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606657945;
        bh=Kn1rRPWrjEwR8dXnIKxEErgiDmpy2An000c8jxqiEqA=;
        h=From:To:Cc:Subject:Date:From;
        b=eFqPpoVbvOHrsjoKyCsvzo/j1j+gBzD+01IahaZk6C4K6H4niPIoMn+UjawiAp5/h
         7p1c5FEMes9TDXxU6citczk6+o6KkEmQSIV13UjSrAAkOpnAUydTF869JXK3ZNUYEe
         xmk3Rb/GbwS4Vu9ZtHgbGyxZPDf72Gi99UX3JlMo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjN7n-00ETZs-8I; Sun, 29 Nov 2020 13:52:23 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, john.garry@huawei.com
Subject: [PATCH 0/3] MSI: Track device proxying when allocating MSIs
Date:   Sun, 29 Nov 2020 13:52:05 +0000
Message-Id: <20201129135208.680293-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to plug a gap found with John's "managed interrupts
for platform devices" series.

We have a couple of cases where we allocate MSIs for a device, but the
endpoint generating the actual interrupts (let's call it the "logical
device") isn't the one being seen generating the MSIs (the "effective
device"):

- PCI devices behind a non transparent bridge
- Devices attached to a wire-to-MSI bridge

For interrupt infrastructures such as the ITS (where the effective
device ID is part of the translation), it is important decouple the
lifetime of the effective device mapping from the interrupt allocation
on behalf of the logical device. Yes, I have a headache too.

To achieve this split, let's tag the such allocations with a new flag
that convey the fact that the effective device isn't the logical
one. This mostly affects the platform-MSI subsystem.

Subsequent patches add handling of this new flag in the GICv3 ITS
(though there may be scope for something more generic in the case of
the last patch).

Marc Zyngier (3):
  platform-msi: Track shared domain allocation
  irqchip/gic-v3-its: Tag ITS device as shared if allocating for a proxy
    device
  irqchip/gic-v3-its: Flag device allocation as proxied if behind a PCI
    bridge

 drivers/base/platform-msi.c              |  7 +++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 11 ++++++++---
 drivers/irqchip/irq-gic-v3-its.c         |  3 +++
 include/asm-generic/msi.h                |  4 ++++
 4 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.28.0

