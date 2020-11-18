Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AA2B81EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKRQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:29:22 -0500
Received: from foss.arm.com ([217.140.110.172]:58840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgKRQ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:29:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A431396;
        Wed, 18 Nov 2020 08:29:21 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8AF3F719;
        Wed, 18 Nov 2020 08:29:19 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, egranata@google.com,
        jbhayana@google.com, peter.hilber@opensynergy.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        cristian.marussi@arm.com
Subject: [PATCH v3 0/6] SCMIv3.0 Sensor Extensions
Date:   Wed, 18 Nov 2020 16:28:59 +0000
Message-Id: <20201118162905.10439-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is meant to add support for the new SCMI Sensor Protocol
features defined by the upcoming SCMIv3.0 specification, whose BETA
release is available at [1].

The series is currently based on for-next/scmi [2] on top of:

commit b141fca08207 ("firmware: arm_scmi: Fix missing destroy_workqueue()")

Any feedback welcome,

Thanks,

Cristian

---
v2 --> v3
- removed stale unused msg payload definition
- moved variable declaration inside switch block
- setting rx_size to 0 in sensor_reading_get to allow fw to send
  both v2 and v3 replies...even if sensor_reading_get() only handles
  v2 spec and returns one single value
- using get_unaligned_le64 in lieu of le64_to_cpu
- removed refs to v2.1
- Fix SCMI_MAX_NUM_SENSOR_AXIS to 63
- added missing Dox comment in resolution
- added common INTVL SEGMENT macros

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

 drivers/firmware/arm_scmi/sensors.c | 743 ++++++++++++++++++++++++++--
 drivers/hwmon/scmi-hwmon.c          |   2 +-
 include/linux/scmi_protocol.h       | 291 ++++++++++-
 3 files changed, 977 insertions(+), 59 deletions(-)

-- 
2.17.1

