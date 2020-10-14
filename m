Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613AD28E2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbgJNPGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:06:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgJNPGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:06:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D622D6E;
        Wed, 14 Oct 2020 08:06:53 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6CDE3F71F;
        Wed, 14 Oct 2020 08:06:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 00/11] SCMI vendor protocols and modularization
Date:   Wed, 14 Oct 2020 16:05:34 +0100
Message-Id: <20201014150545.44807-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The current SCMI implementation does not provide an interface to easily
develop and include a custom vendor protocol implementation as prescribed
by the SCMI standard, also because, there is not currently any custom
protocol in the upstream to justify the development of a custom interface
and its maintenance.

Moreover the current interface exposes protocol operations to the SCMI
driver users attaching per-protocol operations directly to the handle
structure, which, in this way, tends to grow indefinitely for each new
protocol addition.

Beside this, protocols private data are also exposed via handle *_priv
pointers, making such private data accessible also to the SCMI drivers
even if neither really needed nor advisable.

Patches 1,2,3 try to address this simplifying the SCMI protocols interface
and reducing it to these common generic operations:

handle->get_ops() / handle->put_ops() / handle->notify_ops()

All protocols' private data pointers are removed from handle too and made
accessible only to the protocols code through dedicated internal helpers.

Moreover protocol initialization is moved away from device probe and now
happens on demand when the first user shows up (first .get_ops), while
de-initialization is performed once the last user of the protocol (even in
terms of notifications) is gone, with the SCMI core taking care to perform
all the needed underlying resource accounting.

This way any new future standard or custom protocol implementation will
expose a common unified interface which does not need to be extended
endlessly: no need to maintain a custom interface only for vendor protos.
SCMI drivers written on top of standard or custom protocols will use this
same common interface to access any protocol operations.
All existent upstream SCMI drivers are converted to this new interface in
patch 3.

Leveraging this new centralized and common initialization flow, patches 4,5
take care to refactor and simplify protocol-events registration and remove
also *notify_priv from the handle interface making it accessible only to
the notification core.

Finally, patch 6 builds on top of this new interface and introduces a
mechanism to define an SCMI protocol as a full blown module (possibly
loadable) while leaving the core dealing with proper resource accounting.
Moreover protocol initialization is further modified to receive dynamically
a pointer to core scmi_xfer_ops at init time, so avoiding to have to export
all those xfer symbols in order to make the core transfer methods available
to an SCMI protocol dynamically loaded.

Standard protocols are still kept as builtins, though.

Patches 7-11 are marked [DEBUG] and not meant for for upstreaming but just
to be used as an example of how to use all of the above madness to develop
a custom dummy vendor protocol module and a related SCMI custom dummy
driver. (with all related DT entry/devname).

The series is currently based on for-next/scmi [1] on top of:

commit fd7c58ee3026 ("firmware: arm_scmi: Fix locking in notifications")

Any feedback welcome.

Thanks,

Cristian

[1]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi


Cristian Marussi (11):
  firmware: arm_scmi: review protocol registration interface
  firmware: arm_scmi: hide protocols' private data
  firmware: arm_scmi: introduce common protocol interface
  firmware: arm_scmi: refactor events registration
  firmware: arm_scmi: make notify_priv really private
  firmware: arm_scmi: add support for protocol modularization
  [DEBUG] firmware: arm_scmi: add example custom protocol
  [DEBUG] arm64: dts: juno: add example custom protocol support
  [DEBUG] firmware: arm_scmi: add example SCMI driver for custom
    protocol
  [DEBUG] firmware: arm_scmi: add custom_dummy SCMI devname
  [DEBUG][HACK] firmware: arm_scmi: force implemented protocol 0x99

 arch/arm64/boot/dts/arm/juno-base.dtsi        |   4 +
 drivers/clk/clk-scmi.c                        |  30 +-
 drivers/cpufreq/scmi-cpufreq.c                |  28 +-
 drivers/firmware/Kconfig                      |  17 +-
 drivers/firmware/arm_scmi/Makefile            |   5 +
 drivers/firmware/arm_scmi/base.c              |  79 +++--
 drivers/firmware/arm_scmi/bus.c               |  71 +++--
 drivers/firmware/arm_scmi/clock.c             |  72 +++--
 drivers/firmware/arm_scmi/common.h            |  73 ++++-
 drivers/firmware/arm_scmi/driver.c            | 292 +++++++++++++++++-
 drivers/firmware/arm_scmi/notify.c            | 171 ++++++----
 drivers/firmware/arm_scmi/notify.h            |  30 +-
 drivers/firmware/arm_scmi/perf.c              | 135 ++++----
 drivers/firmware/arm_scmi/power.c             |  85 +++--
 drivers/firmware/arm_scmi/reset.c             |  87 ++++--
 drivers/firmware/arm_scmi/scmi_custom.c       | 170 ++++++++++
 drivers/firmware/arm_scmi/scmi_custom_dummy.c | 126 ++++++++
 drivers/firmware/arm_scmi/scmi_pm_domain.c    |  29 +-
 drivers/firmware/arm_scmi/sensors.c           |  92 ++++--
 drivers/firmware/arm_scmi/system.c            |  42 ++-
 drivers/hwmon/scmi-hwmon.c                    |  26 +-
 drivers/reset/reset-scmi.c                    |  26 +-
 include/linux/scmi_protocol.h                 |  78 +++--
 23 files changed, 1354 insertions(+), 414 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_custom.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_custom_dummy.c

-- 
2.17.1

