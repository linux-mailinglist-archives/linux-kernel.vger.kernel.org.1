Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F652AF656
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKKQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:28:50 -0500
Received: from foss.arm.com ([217.140.110.172]:57708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgKKQ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:28:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4F051FB;
        Wed, 11 Nov 2020 08:28:47 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD18F3F6CF;
        Wed, 11 Nov 2020 08:28:46 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] GIC v4.1: Disable VSGI support for GIC CPUIF < v4.1
Date:   Wed, 11 Nov 2020 16:28:39 +0000
Message-Id: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIC v4.1 introduced changes to the GIC CPU interface; systems that
integrate CPUs that do not support GIC v4.1 features (as reported in the
ID_AA64PFR0_EL1.GIC bitfield) and a GIC v4.1 controller must disable in
software virtual SGIs support since the CPUIF and GIC controller version
mismatch results in CONSTRAINED UNPREDICTABLE behaviour at architectural
level.

For systems with CPUs reporting ID_AA64PFR0_EL1.GIC == b0001 integrated
in a system with a GIC v4.1 it _should_ still be safe to enable vLPIs
(other than vSGI) since the protocol between the GIC redistributor and
the GIC CPUIF was not changed from GIC v4.0 to GIC v4.1.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>

Lorenzo Pieralisi (2):
  arm64: cpufeature: Add GIC CPUIF v4.1 detection
  irqchip/gic-v3-its: Disable vSGI upon (CPUIF < v4.1) detection

 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
 drivers/irqchip/irq-gic-v3-its.c | 20 +++++++++++++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.29.1

