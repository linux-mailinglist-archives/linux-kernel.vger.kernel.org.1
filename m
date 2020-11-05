Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0A2A88F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbgKEV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:28:14 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:48569 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgKEV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:28:13 -0500
Received: from spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115])
        by plasma.jpberlin.de (Postfix) with ESMTP id DE4ECAB7DC;
        Thu,  5 Nov 2020 22:21:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id r4z_FNNlEUTs; Thu,  5 Nov 2020 22:21:42 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 03EE6AB751;
        Thu,  5 Nov 2020 22:21:41 +0100 (CET)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>, <anton.yakovlev@opensynergy.com>
Subject: [RFC PATCH v2 00/10] firmware: arm_scmi: Add virtio transport
Date:   Thu, 5 Nov 2020 22:21:06 +0100
Message-ID: <20201105212116.411422-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.70 / 15.00 / 15.00
X-Rspamd-Queue-Id: DE4ECAB7DC
X-Rspamd-UID: ee1eec
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements an SCMI virtio driver according to the virtio
SCMI device spec patch v5 [1], after simple preparatory changes to the
existing arm-scmi driver.

The virtio transport differs in some respects from the existing
shared-memory based SCMI transports.

Message timeouts can be a problem if the virtio device (SCMI platform)
does not have real-time properties. I set a high message rx timeout
value which should work for non real-time virtio devices as well. There
are other timeouts for delayed response and polling which were not
addressed yet. Delayed responses are not really needed since, with the
virtio transport, message responses may be transmitted out of order.
Polling doesn't make sense at least for virtio devices without real-time
behavior, in my understanding.

There are some known issues which will be resolved before removing the
RFC tag:

- Further work is needed on the scmi_xfer management. Unlike shmem based
  transports, the virtio transport is actually exchanging messages with
  the SCMI agent through the scmi_xfer tx and rx buffers. In case of a
  message rx timeout, the arm-scmi driver could try to re-use the
  scmi_xfer, while that might still be used by the virtio device. I
  think part of the scmi_xfers_info bookkeeping could be optionally
  outsourced to the transport to remediate this.

- After arm-scmi driver probe failure, or after remove, the scmi-virtio
  driver may still try to process and forward message responses from the
  virtio device.

- We must be sure that the virtio transport option (such as virtio over
  MMIO) is available when the virtio SCMI device is probed.

The series is based on for-next/scmi [2], on top of

commit b9ceca6be432 ("firmware: arm_scmi: Fix duplicate workqueue name")

The series was actually tested with a v5.4 based kernel, with the Base
protocol and Sensor management protocol. The virtio SCMI device used was
a proprietary implementation by OpenSynergy. Delayed responses were not
tested.

Changes in RFC v2:

- Remove the DT virtio_transport phandle, since the SCMI virtio device may
  not be known in advance. Instead, use the first suitable probed device.
  Change due to Rob Herring's comment.

Any comments are very welcome.

[1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git


Igor Skalkin (7):
  firmware: arm_scmi, smccc, mailbox: Make shmem based transports
    optional
  firmware: arm_scmi: Document that max_msg is a per channel type limit
  firmware: arm_scmi: Add op to override max message #
  firmware: arm_scmi: Add per message transport data
  firmware: arm_scmi: Add xfer_init_buffers transport op
  dt-bindings: arm: Add virtio transport for SCMI
  firmware: arm_scmi: Add virtio transport

Peter Hilber (3):
  firmware: arm_scmi: Add optional link_supplier() transport op
  firmware: arm_scmi: Add per-device transport private info
  firmware: arm_scmi: Add is_scmi_protocol_device()

 .../devicetree/bindings/arm/arm,scmi.txt      |  35 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  19 +-
 drivers/firmware/arm_scmi/Makefile            |   3 +-
 drivers/firmware/arm_scmi/bus.c               |   5 +
 drivers/firmware/arm_scmi/common.h            |  37 +-
 drivers/firmware/arm_scmi/driver.c            | 124 ++++-
 drivers/firmware/arm_scmi/virtio.c            | 493 ++++++++++++++++++
 drivers/firmware/smccc/Kconfig                |   1 +
 drivers/mailbox/Kconfig                       |   1 +
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  41 ++
 12 files changed, 736 insertions(+), 25 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h


base-commit: b9ceca6be43233845be70792be9b5ab315d2e010
-- 
2.25.1

