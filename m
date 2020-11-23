Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5AB2C0375
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgKWKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:37:49 -0500
Received: from foss.arm.com ([217.140.110.172]:41140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgKWKht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:37:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CA70101E;
        Mon, 23 Nov 2020 02:37:48 -0800 (PST)
Received: from usa.arm.com (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CACF43F70D;
        Mon, 23 Nov 2020 02:37:46 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     ALKML <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [GIT PULL] firmware: arm_scmi: SCMI voltage domain support for v5.11
Date:   Mon, 23 Nov 2020 10:37:41 +0000
Message-Id: <20201123103741.19148-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

As discussed here is the pull request for SCMI firmware part for regulator
support. Please pull !

Regards,
Sudeep

-->8

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-voltage-5.11

for you to fetch changes up to ec88381936954a146f260a21bf8466ca07e5c71e:

  firmware: arm_scmi: Add support to enumerated SCMI voltage domain device (2020-11-20 14:55:48 +0000)

----------------------------------------------------------------
SCMI voltage domain management protocol support for v5.11

SCMI v3.0 voltage domain protocol support to discover the voltage levels
supported by the domains and to set/get the configuration and voltage
level of any given domain.

----------------------------------------------------------------
Cristian Marussi (3):
      dt-bindings: arm: Add support for SCMI Regulators
      firmware: arm_scmi: Add voltage domain management protocol support
      firmware: arm_scmi: Add support to enumerated SCMI voltage domain device

 Documentation/devicetree/bindings/arm/arm,scmi.txt |  43 +++
 drivers/firmware/arm_scmi/Makefile                 |   2 +-
 drivers/firmware/arm_scmi/common.h                 |   1 +
 drivers/firmware/arm_scmi/driver.c                 |   3 +
 drivers/firmware/arm_scmi/voltage.c                | 380 +++++++++++++++++++++
 include/linux/scmi_protocol.h                      |  64 ++++
 6 files changed, 492 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/voltage.c
