Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71742270247
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIRQdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:33:13 -0400
Received: from plasma31.jpberlin.de ([80.241.56.82]:27825 "EHLO
        plasma31.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgIRQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:33:13 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 12:33:11 EDT
Received: from spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117])
        by plasma.jpberlin.de (Postfix) with ESMTP id 810E01025E4;
        Fri, 18 Sep 2020 18:26:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.76])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id BIAa6MxQyu22; Fri, 18 Sep 2020 18:26:24 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id B07F7100971;
        Fri, 18 Sep 2020 18:26:23 +0200 (CEST)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <alex.bennee@linaro.org>, <jean-philippe@linaro.org>,
        <igor.skalkin@opensynergy.com>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Jason Wang <jasowang@redhat.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 0/7] firmware: arm_scmi: Add virtio transport
Date:   Fri, 18 Sep 2020 18:23:09 +0200
Message-ID: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.87 / 15.00 / 15.00
X-Rspamd-Queue-Id: 810E01025E4
X-Rspamd-UID: d4e547
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

commit 66d90f6ecee7 ("firmware: arm_scmi: Enable building as a single module")

The series was actually tested with a v5.4 based kernel, with the Base
protocol and Sensor management protocol. The virtio SCMI device used was
a proprietary implementation by OpenSynergy. Delayed responses were not
tested.

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

 .../devicetree/bindings/arm/arm,scmi.txt      |  38 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  19 +-
 drivers/firmware/arm_scmi/Makefile            |   3 +-
 drivers/firmware/arm_scmi/common.h            |  31 +-
 drivers/firmware/arm_scmi/driver.c            |  83 +++-
 drivers/firmware/arm_scmi/virtio.c            | 470 ++++++++++++++++++
 drivers/firmware/smccc/Kconfig                |   1 +
 drivers/mailbox/Kconfig                       |   1 +
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  41 ++
 11 files changed, 664 insertions(+), 25 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h


base-commit: 66d90f6ecee755e9c19a119c9255e80091165498
-- 
2.25.1

