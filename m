Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6BA1BF71B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD3Lsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:48:39 -0400
Received: from foss.arm.com ([217.140.110.172]:53142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3Lsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:48:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E49801045;
        Thu, 30 Apr 2020 04:48:36 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A60753F305;
        Thu, 30 Apr 2020 04:48:35 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
Subject: [PATCH 0/5] arm/arm64: smccc: Add ARCH_SOC_ID support
Date:   Thu, 30 Apr 2020 12:48:09 +0100
Message-Id: <20200430114814.14116-1-sudeep.holla@arm.com>
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

Sudeep Holla (5):
  arm/arm64: smccc: Update link to latest SMCCC specification
  arm/arm64: smccc: Add the definition for SMCCCv1.2 version/error codes
  arm/arm64: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
  firmware: psci: Add function to fetch SMCCC version
  arm/arm64: smccc: Add ARCH_SOC_ID support

--
Regards,
Sudeep

[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/4001

 arch/arm64/kernel/paravirt.c   |   2 +-
 drivers/firmware/psci/Makefile |   2 +-
 drivers/firmware/psci/psci.c   |  13 ++-
 drivers/firmware/psci/soc_id.c | 148 +++++++++++++++++++++++++++++++++
 include/linux/arm-smccc.h      |  23 ++++-
 include/linux/psci.h           |   7 +-
 6 files changed, 181 insertions(+), 14 deletions(-)
 create mode 100644 drivers/firmware/psci/soc_id.c

--
2.17.1

