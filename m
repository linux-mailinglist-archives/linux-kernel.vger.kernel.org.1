Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D819F0EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 09:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDFHkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 03:40:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:40996 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFHke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:40:34 -0400
IronPort-SDR: FItPyEdnoSSmEuW8UT1mCq+gfVsyAlvH+tMFzZIeKPMrqthunCt64EugaPNsLO5Vvz58hirKrJ
 vL4RsTz6dR+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 00:40:34 -0700
IronPort-SDR: /DzNWLxCCbTbUDXDeH3lPb8n10n1ahXE5Aanbc+RlLyA46g9doKIOyEjdJsNb8/K6IGaK9Z6Bl
 re8C65sKqhdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="285814083"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga002.fm.intel.com with ESMTP; 06 Apr 2020 00:40:31 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [RESEND PATCH v6 0/4] Add Intel ComboPhy driver
Date:   Mon,  6 Apr 2020 15:39:52 +0800
Message-Id: <cover.1585889042.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Intel ComboPhy driver, respective yaml schemas
and a kernel API fwnode_to_regmap().
ComboPhy driver calls it to get regmap handle through firmware node.

Resending the patches v6 by adding the system configuration Maintainers,
which i missed to add them.

Changes on v6:
  Rebase patches on the latest maintainer's branch
  https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/?h=phy-for-5.7

Dilip Kota (4):
  mfd: syscon: Add fwnode_to_regmap
  dt-bindings: phy: Add PHY_TYPE_XPCS definition
  dt-bindings: phy: Add YAML schemas for Intel ComboPhy
  phy: intel: Add driver support for ComboPhy

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
 drivers/mfd/syscon.c                               |   8 +
 drivers/phy/intel/Kconfig                          |  14 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-combo.c                | 626 +++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |   1 +
 include/linux/mfd/syscon.h                         |   6 +
 7 files changed, 757 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 create mode 100644 drivers/phy/intel/phy-intel-combo.c

-- 
2.11.0

