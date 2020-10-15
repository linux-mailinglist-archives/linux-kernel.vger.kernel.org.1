Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABA328F5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbgJOPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:40:10 -0400
Received: from foss.arm.com ([217.140.110.172]:47006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgJOPkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:40:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5098613D5;
        Thu, 15 Oct 2020 08:40:09 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74C803F719;
        Thu, 15 Oct 2020 08:40:07 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v2 0/4] Add support for SCMIv3.0 Voltage Domain Protocol and SCMI-Regulator
Date:   Thu, 15 Oct 2020 16:39:57 +0100
Message-Id: <20201015154001.8931-1-cristian.marussi@arm.com>
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

commit fd7c58ee3026 ("firmware: arm_scmi: Fix locking in notifications")

Any feedback welcome,

Thanks,

Cristian

---
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
 drivers/firmware/arm_scmi/voltage.c           | 382 +++++++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/scmi-regulator.c            | 453 ++++++++++++++++++
 include/linux/scmi_protocol.h                 |  64 +++
 9 files changed, 956 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/voltage.c
 create mode 100644 drivers/regulator/scmi-regulator.c

-- 
2.17.1

