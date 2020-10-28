Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C944629D3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgJ1Vr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:47:26 -0400
Received: from foss.arm.com ([217.140.110.172]:38346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbgJ1VrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 741DB1A9A;
        Wed, 28 Oct 2020 13:29:43 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8C663F66E;
        Wed, 28 Oct 2020 13:29:41 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 0/8] SCMI vendor protocols and modularization
Date:   Wed, 28 Oct 2020 20:29:06 +0000
Message-Id: <20201028202914.43662-1-cristian.marussi@arm.com>
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

This series tris to address this simplifying the SCMI protocols interface
and reducing it, roughly, to these common generic operations:

handle->get_ops() / handle->put_ops() / handle->notify_ops()

and a few related devres managed flavours.

All protocols' private data pointers are removed from handle too and made
accessible only to the protocols code through dedicated internal helpers.

The concept of protocol handle is introduced in the SCMI protocol code
to represent a protocol instance initialized against a specific SCMI
instance(handle): so that all the new protocol code uses such protocol
handles wherever previously SCMI handle was used: this enable tighter
control of what is exposed to the protocol code vs the SCMI drivers.

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
All existent upstream SCMI drivers are converted to this new interface.

Leveraging this new centralized and common initialization flow, patches 5,7
take care also to refactor and simplify protocol-events registration and
remove *notify_priv from the handle interface making it accessible only to
the notification core.

Finally, patch 8 builds on top of this new interface and introduces a
mechanism to define an SCMI protocol as a full blown module (possibly
loadable) while leaving the core dealing with proper resource accounting.

Standard protocols are still kept as builtins, though.

The whole SCMI stack can be built alternatively as a module (incudling all
the standard protocols).

On top of this series an example SCMI Custom protocol 0x99 and related
SCMI Custom Dummy driver has been built and it is available at [2] as a
series of DEBUG patches on top this same series.

The current revision of this series still does not address the possibility
of creating dynamically the SCMI devices: any new protocols must be added
to the SCMI embedded module device table as of now, while it could be
desirable to have such devices created dynamically whenever a new protocol
is added and loaded into the system.

The series is currently based on for-next/scmi [1] on top of:

commit b9ceca6be432 ("firmware: arm_scmi: Fix duplicate workqueue name")

Any feedback welcome.

Thanks,

Cristian

---

v1 --> v2
- rebased on for-next/scmi v5.10-rc1
- introduced protocol handles
- added devres managed devm_ variant for protocols operations
- made all scmi_protocol refs const
- introduced IDR to handle protocols instead of static array
- refactored code around fast path

[1]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
[2]:https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_modules_ext_V2/

Cristian Marussi (8):
  firmware: arm_scmi: review protocol registration interface
  firmware: arm_scmi: introduce protocol handles
  firmware: arm_scmi: introduce new protocol operations support
  firmware: arm_scmi: make notifications aware of protocol usage
  firmware: arm_scmi: refactor events registration
  firmware: arm_scmi: port all protocols and drivers to the new API
  firmware: arm_scmi: make notify_priv really private
  firmware: arm_scmi: add protocol modularization support

 drivers/clk/clk-scmi.c                     |  27 +-
 drivers/cpufreq/scmi-cpufreq.c             |  38 +-
 drivers/firmware/arm_scmi/base.c           | 140 +++---
 drivers/firmware/arm_scmi/bus.c            |  70 +--
 drivers/firmware/arm_scmi/clock.c          | 127 +++---
 drivers/firmware/arm_scmi/common.h         | 114 ++++-
 drivers/firmware/arm_scmi/driver.c         | 474 +++++++++++++++++++--
 drivers/firmware/arm_scmi/notify.c         | 303 ++++++++++---
 drivers/firmware/arm_scmi/notify.h         |  38 +-
 drivers/firmware/arm_scmi/perf.c           | 257 +++++------
 drivers/firmware/arm_scmi/power.c          | 132 +++---
 drivers/firmware/arm_scmi/reset.c          | 144 ++++---
 drivers/firmware/arm_scmi/scmi_pm_domain.c |  26 +-
 drivers/firmware/arm_scmi/sensors.c        | 135 +++---
 drivers/firmware/arm_scmi/system.c         |  60 +--
 drivers/hwmon/scmi-hwmon.c                 |  24 +-
 drivers/reset/reset-scmi.c                 |  33 +-
 include/linux/scmi_protocol.h              | 142 +++---
 18 files changed, 1569 insertions(+), 715 deletions(-)

-- 
2.17.1

