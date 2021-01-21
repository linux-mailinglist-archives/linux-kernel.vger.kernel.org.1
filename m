Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445A42FE08B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbhAUEX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:23:57 -0500
Received: from foss.arm.com ([217.140.110.172]:45082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732063AbhAUESS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:18:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D15414FF;
        Wed, 20 Jan 2021 20:17:31 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B4063F719;
        Wed, 20 Jan 2021 20:17:31 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        bhelgaas@google.com, robh@kernel.org, vidyas@nvidia.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 0/1] arm64: PCI SMC config conduit
Date:   Wed, 20 Jan 2021 22:17:28 -0600
Message-Id: <20210121041729.1858499-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set provides a platform standardized way to access PCI
config space. It does that via an Arm specific interface
exported by the firmware. The Arm specification this is
based on can be found here:

The Arm PCI Configuration Space Access Firmware Interface
https://developer.arm.com/documentation/den0115/latest


v2->v3:
    Convert from SMC only calls to arm_smccc_1_1_invoke() for better
      conformance with the specification.
v1->v2:
    Add SMC_PCI_FEATURES calls to verify _READ, _WRITE and _SEG_INFO 
      functions exist.
    Add a _SEG_INFO bus start, end validation against the ACPI table.
    Adjust some function naming, and log messages.

Jeremy Linton (1):
  arm64: PCI: Enable SMC conduit

 arch/arm64/kernel/pci.c   | 111 ++++++++++++++++++++++++++++++++++++++
 include/linux/arm-smccc.h |  29 ++++++++++
 2 files changed, 140 insertions(+)

-- 
2.26.2

