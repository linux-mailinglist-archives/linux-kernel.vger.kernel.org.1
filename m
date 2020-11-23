Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B892C167B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgKWUYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:24:12 -0500
Received: from foss.arm.com ([217.140.110.172]:41488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgKWUYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:24:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B12A1396;
        Mon, 23 Nov 2020 12:24:09 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91E293F71F;
        Mon, 23 Nov 2020 12:24:07 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v7 0/3] Add support for SCMI-Regulator
Date:   Mon, 23 Nov 2020 20:23:33 +0000
Message-Id: <20201123202336.46701-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series introduces the support for a new generic SCMI Regulator driver
developed on top of the recently introduced SCMI Voltage Domain Protocol
support as specified in the upcoming SCMIv3.0 specification. [1]

The underlying SCMI VD Protocol support, which was originally part of this
series, is now applied on for-next/scmi-voltage [2], and this series,
reduced to its SCMI Regulator support and dt-bindings fixes is similarly
based on top of [2]:

commit ec8838193695 ("firmware: arm_scmi: Add support to enumerated SCMI
		      voltage domain device")

Thanks,

Cristian

---
v6 --> v7
- rebased on top of for-next/scmi-voltage
- added dt-bindings fix to remove optional properties
- add proper blank lines between semantic blocks
- fix return value on error path of scmi_reg_is_enabled()
- use generic Failure message on err path of info_get()
- fix comment containing apostrophe

v5 --> v6
- reordered dt bindings patch
- removed single field struct
- reviewed args to scmi_init_voltage_levels()
- allocating scmi_voltage_info_array contiguously

v4 --> v5
- rebased
- VD Protocol
 - removed inline
 - moved segmented intervals defines
 - fixed some macros complaints by checkpatch

v3 --> v4
- DT bindings
 - using generic node names
 - listing explicitly subset of supported regulators bindings
- SCMI Regulator
 - using of_match_full_name core regulator flag
 - avoid coccinelle false flag complaints
- VD Protocol
 - avoid coccinelle false flag complaints
 - avoiding fixed size typing

v2 --> v3
- DT bindings
  - avoid awkard examples based on _cpu/_gpu regulators
- SCMI Regulator
  - remove multiple linear mappings support
  - removed duplicated voltage name printout
  - added a few comments
  - simplified return path in scmi_reg_set_voltage_sel()
- VD Protocol
  - restrict segmented voltage domain descriptors to one triplet
  - removed unneeded inline
  - free allocated resources for invalid voltage domain
  - added __must_check to info_get voltage operations
  - added a few comments
  - removed fixed size typing from struct voltage_info
    
v1 --> v2
- rebased on for-next/scmi v5.10
- DT bindings
  - removed any reference to negative voltages
- SCMI Regulator
  - removed duplicate regulator naming
  - removed redundant .get/set_voltage ops: only _sel variants implemented
  - removed condexpr on fail path to increase readability
- VD Protocol
  - fix voltage levels query loop to reload full cmd description
    between iterations as reported by Etienne Carriere
  - ensure transport rx buffer is properly sized calli scmi_reset_rx_to_maxsz
    between transfers

[1]:https://developer.arm.com/documentation/den0056/c/
[2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi-voltage

Cristian Marussi (3):
  dt-bindings: arm: remove optional properties for SCMI Regulators
  regulator: core: add of_match_full_name boolean flag
  regulator: add SCMI driver

 .../devicetree/bindings/arm/arm,scmi.txt      |  11 +-
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/of_regulator.c              |   8 +-
 drivers/regulator/scmi-regulator.c            | 417 ++++++++++++++++++
 include/linux/regulator/driver.h              |   3 +
 6 files changed, 437 insertions(+), 12 deletions(-)
 create mode 100644 drivers/regulator/scmi-regulator.c

-- 
2.17.1

