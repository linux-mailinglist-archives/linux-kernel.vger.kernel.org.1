Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D148626C193
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIPKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:23:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgIPKT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:19:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332031FB;
        Wed, 16 Sep 2020 03:18:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 023183F718;
        Wed, 16 Sep 2020 03:18:50 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        etienne.carriere@linaro.org, cristian.marussi@arm.com
Subject: [PATCH 0/1] SCMI SystemPower Control driver
Date:   Wed, 16 Sep 2020 11:18:26 +0100
Message-Id: <20200916101827.48047-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch, building on top of the recently introduced SCMI System Power
Protocol support, adds a new SCMI driver which, registering for SCMI System
Power notifications, acts accordingly to satisfy such SCMI plaform
system-wide transition requests (which can be of forceful or graceful kind)

In order to comply with graceful requests, and co-operate with userspace
entities to drive a clean shutdown/reboot, the logic of the driver relies
on the same orderly_* API methods used by ACPI when handling ACPI Shutdown
bus events.
As an alternative method to tunnel graceful requests to userspace, though,
it is possible to configure, via module parameters, a specific signal to be
sent to CAD pid.

It is currently based on for-next/scmi [1] on top of:

commit 66d90f6ecee7 ("firmware: arm_scmi: Enable building as a single
		     module")

Thanks,

Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi


Cristian Marussi (1):
  firmware: arm_scmi: Add SCMI System Power Control driver

 drivers/firmware/Kconfig                      |  12 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 .../firmware/arm_scmi/scmi_power_control.c    | 387 ++++++++++++++++++
 3 files changed, 400 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_power_control.c

-- 
2.17.1

