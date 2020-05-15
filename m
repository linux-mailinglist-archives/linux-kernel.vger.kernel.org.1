Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E861D449D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 06:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEOEbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 00:31:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:44610 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgEOEbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 00:31:38 -0400
IronPort-SDR: 6mRQnVuywkyC+Gg/XY/lCQXWIRDgBJJIC5XvvBaA2RSlzG3Xe2nJbdPpRoSYYnnDTbofpKCx0h
 TToOl3k0m9qg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 21:31:38 -0700
IronPort-SDR: UAxhLDAi8+9xPZmMy6x7eaPJCfhYTtz/Oy388lxXc4jNN8iz51wac8qdPw/qR7V4hkjmRjLi9a
 1rBMphgdKzhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="438170435"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2020 21:31:35 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v8 0/3] Add Intel ComboPhy driver
Date:   Fri, 15 May 2020 12:30:23 +0800
Message-Id: <cover.1589516297.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Intel ComboPhy driver, respective yaml schemas

Changes on v8:
  As per PHY Maintainer's request add description in comments for doing
  register access through register map framework.

Changes on v7:
  As per System control driver maintainer's inputs remove
    fwnode_to_regmap() definition and use device_node_get_regmap()
    
Changes on v6:
  Rebase patches on the latest maintainer's branch
  https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/?h=phy-for-5.7
Dilip Kota (3):
  dt-bindings: phy: Add PHY_TYPE_XPCS definition
  dt-bindings: phy: Add YAML schemas for Intel ComboPhy
  phy: intel: Add driver support for ComboPhy

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
 drivers/phy/intel/Kconfig                          |  14 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-combo.c                | 627 +++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |   1 +
 5 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 create mode 100644 drivers/phy/intel/phy-intel-combo.c

-- 
2.11.0

