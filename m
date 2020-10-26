Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07C22997AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgJZUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:10:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgJZUK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:10:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CC111FB;
        Mon, 26 Oct 2020 13:10:24 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4CE53F68F;
        Mon, 26 Oct 2020 13:10:22 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v2 0/6] SCMIv3.0 Sensor Extensions
Date:   Mon, 26 Oct 2020 20:10:01 +0000
Message-Id: <20201026201007.23591-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is meant to add support for the new SCMI Sensor Protocol
features defined by the upcoming SCMIv3.0 specification, whose BETA
release is available at [1].

The series is currently based on for-next/scmi [2] on top of:

commit b9ceca6be432 ("firmware: arm_scmi: Fix duplicate workqueue name")

Any feedback welcome,

Thanks,

Cristian

---

v1 --> v2
- rebased on for-next/scmi v5.10
- restrict segmented intervals descriptors to single triplet
- add proper usage of scmi_reset_rx_to_maxsz

[1]:https://developer.arm.com/documentation/den0056/c/
[2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi



Cristian Marussi (6):
  firmware: arm_scmi: rework scmi_sensors_protocol_init
  firmware: arm_scmi: add SCMIv3.0 Sensors descriptors extensions
  hwmon: scmi: update hwmon internal scale data type
  firmware: arm_scmi: add SCMIv3.0 Sensors timestamped reads
  firmware: arm_scmi: add SCMIv3.0 Sensor configuration support
  firmware: arm_scmi: add SCMIv3.0 Sensor notifications

 drivers/firmware/arm_scmi/sensors.c | 740 ++++++++++++++++++++++++++--
 drivers/hwmon/scmi-hwmon.c          |   2 +-
 include/linux/scmi_protocol.h       | 287 ++++++++++-
 3 files changed, 974 insertions(+), 55 deletions(-)

-- 
2.17.1

