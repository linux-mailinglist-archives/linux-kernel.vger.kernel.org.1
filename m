Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6971C35AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEDJ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 05:29:13 -0400
Received: from foss.arm.com ([217.140.110.172]:40526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgEDJ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:29:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F86D101E;
        Mon,  4 May 2020 02:29:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A2253F305;
        Mon,  4 May 2020 02:29:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
Subject: [PATCH v2 0/5] arm/arm64: smccc: Add ARCH_SOC_ID support
Date:   Mon,  4 May 2020 10:29:00 +0100
Message-Id: <20200504092905.10580-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
This doesn't add other changes added in SMCCC v1.2 yet. They will
follow these soon along with its first user SPCI/PSA-FF.

This is tested using upstream TF-A + the patch[1] fixing the original
implementation there.


v1[0]->v2:
	- Incorporated comments from Steven Price in patch 5/5
	- Fixed build for CONFIG_PSCI_FW=n on some arm32 platforms
	- Added Steven Price's review tags

Regards,
Sudeep

[0] https://lore.kernel.org/r/20200430114814.14116-1-sudeep.holla@arm.com/
[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/4001

Sudeep Holla (5):
  arm/arm64: smccc: Update link to latest SMCCC specification
  arm/arm64: smccc: Add the definition for SMCCCv1.2 version/error codes
  arm/arm64: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
  firmware: psci: Add function to fetch SMCCC version
  arm/arm64: smccc: Add ARCH_SOC_ID support

 arch/arm64/kernel/paravirt.c   |   2 +-
 drivers/firmware/psci/Kconfig  |   9 ++
 drivers/firmware/psci/Makefile |   1 +
 drivers/firmware/psci/psci.c   |  13 ++-
 drivers/firmware/psci/soc_id.c | 165 +++++++++++++++++++++++++++++++++
 include/linux/arm-smccc.h      |  23 ++++-
 include/linux/psci.h           |   7 +-
 7 files changed, 207 insertions(+), 13 deletions(-)
 create mode 100644 drivers/firmware/psci/soc_id.c

--
2.17.1

