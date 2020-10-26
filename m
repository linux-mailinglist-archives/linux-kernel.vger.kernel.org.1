Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C1A2997F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgJZUcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:32:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgJZUcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:32:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DB4F1FB;
        Mon, 26 Oct 2020 13:32:17 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170413F68F;
        Mon, 26 Oct 2020 13:32:14 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v3 0/4] Add support for SCMIv3.0 Voltage Domain Protocol and SCMI-Regulator
Date:   Mon, 26 Oct 2020 20:31:44 +0000
Message-Id: <20201026203148.47416-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series introduces the support for the new SCMI Voltage Domain Protocol
defined by the upcoming SCMIv3.0 specification, whose BETA release is
available at [1].

Afterwards, a new generic SCMI Regulator driver is developed on top of the
new SCMI VD Protocol.

The series is currently based on for-next/scmi [2] on top of:

commit b9ceca6be432 ("firmware: arm_scmi: Fix duplicate workqueue name")

Any feedback welcome,

Thanks,

Cristian

---

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
[2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi


Cristian Marussi (4):
  firmware: arm_scmi: Add Voltage Domain Support
  firmware: arm_scmi: add SCMI Voltage Domain devname
  regulator: add SCMI driver
  dt-bindings: arm: add support for SCMI Regulators

 .../devicetree/bindings/arm/arm,scmi.txt      |  42 ++
 drivers/firmware/arm_scmi/Makefile            |   2 +-
 drivers/firmware/arm_scmi/common.h            |   1 +
 drivers/firmware/arm_scmi/driver.c            |   3 +
 drivers/firmware/arm_scmi/voltage.c           | 398 +++++++++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/scmi-regulator.c            | 403 ++++++++++++++++++
 include/linux/scmi_protocol.h                 |  64 +++
 9 files changed, 922 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/voltage.c
 create mode 100644 drivers/regulator/scmi-regulator.c

-- 
2.17.1

