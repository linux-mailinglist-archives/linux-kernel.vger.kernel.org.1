Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D7283870
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgJEOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:46:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgJEOqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:46:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB30A106F;
        Mon,  5 Oct 2020 07:46:45 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25BBA3F70D;
        Mon,  5 Oct 2020 07:46:44 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 0/7] SCMIv3.0 Sensor Extensions
Date:   Mon,  5 Oct 2020 15:45:12 +0100
Message-Id: <20201005144518.31832-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is meant to add support for the new SCMI Sensor Protocol
features defined by the upcoming SCMIv3.0 specification, whose BETA
release is available at [1].

The series is currently based on for-next/scmi [2] on top of:

commit 66d90f6ecee7 ("firmware: arm_scmi: Enable building as a single
		     module")

Any feedback welcome,

Thanks,

Cristian

[1]:https://developer.arm.com/documentation/den0056/c/
[2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi

Cristian Marussi (6):
  firmware: arm_scmi: rework scmi_sensors_protocol_init
  firmware: arm_scmi: add SCMIv3.0 Sensors descriptors extensions
  hwmon: scmi: update hwmon internal scale data type
  firmware: arm_scmi: add SCMIv3.0 Sensors timestamped reads
  firmware: arm_scmi: add SCMIv3.0 Sensor configuration support
  firmware: arm_scmi: add SCMIv3.0 Sensor notifications

 drivers/firmware/arm_scmi/sensors.c | 722 ++++++++++++++++++++++++++--
 drivers/hwmon/scmi-hwmon.c          |   2 +-
 include/linux/scmi_protocol.h       | 287 ++++++++++-
 3 files changed, 956 insertions(+), 55 deletions(-)

-- 
2.17.1

