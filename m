Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710FB2702B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIRQ4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:56:40 -0400
Received: from plasma31.jpberlin.de ([80.241.56.82]:14869 "EHLO
        plasma31.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:56:40 -0400
Received: from spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115])
        by plasma.jpberlin.de (Postfix) with ESMTP id 3BC0010268D;
        Fri, 18 Sep 2020 18:56:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.76])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 1lhJ3zNlksY9; Fri, 18 Sep 2020 18:56:33 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 49CB1100D05;
        Fri, 18 Sep 2020 18:56:33 +0200 (CEST)
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
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: [RFC PATCH 6/7] dt-bindings: arm: Add virtio transport for SCMI
Date:   Fri, 18 Sep 2020 18:55:58 +0200
Message-ID: <20200918165558.257086-1-peter.hilber@opensynergy.com>
In-Reply-To: <20200918162311.254564-1-peter.hilber@opensynergy.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.01 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3BC0010268D
X-Rspamd-UID: 776556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Document the properties for arm,scmi-virtio compatible nodes. The
backing virtio SCMI device is described in patch [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 .../devicetree/bindings/arm/arm,scmi.txt      | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 55deb68230eb..844ff3c40a49 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -13,6 +13,9 @@ the device tree.
 Required properties:
 
 The scmi node with the following properties shall be under the /firmware/ node.
+Some properties are specific to a transport type.
+
+shmem-based transports (mailbox, smc/hvc):
 
 - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
 - mboxes: List of phandle and mailbox channel specifiers. It should contain
@@ -21,6 +24,17 @@ The scmi node with the following properties shall be under the /firmware/ node.
 	  supported.
 - shmem : List of phandle pointing to the shared memory(SHM) area as per
 	  generic mailbox client binding.
+
+Virtio transport:
+
+- compatible : shall be "arm,scmi-virtio".
+- virtio_transport : phandle of the virtio device. This device must support one
+                     virtqueue for transmitting commands ("tx", cmdq), and,
+		     optionally, one more virtqueue for receiving notifications
+		     and delayed responses ("rx", eventq).
+
+Additional required properties:
+
 - #address-cells : should be '1' if the device has sub-nodes, maps to
 	  protocol identifier for a given sub-node.
 - #size-cells : should be '0' as 'reg' property doesn't have any size
@@ -42,7 +56,8 @@ Each protocol supported shall have a sub-node with corresponding compatible
 as described in the following sections. If the platform supports dedicated
 communication channel for a particular protocol, the 3 properties namely:
 mboxes, mbox-names and shmem shall be present in the sub-node corresponding
-to that protocol.
+to that protocol. The virtio transport does not support dedicated communication
+channels.
 
 Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
 ------------------------------------------------------------
@@ -106,7 +121,8 @@ Required sub-node properties:
 [4] Documentation/devicetree/bindings/sram/sram.yaml
 [5] Documentation/devicetree/bindings/reset/reset.txt
 
-Example:
+Example (mailbox transport):
+----------------------------
 
 sram@50000000 {
 	compatible = "mmio-sram";
@@ -195,3 +211,21 @@ thermal-zones {
 		...
 	};
 };
+
+Example (virtio transport):
+---------------------------
+
+virtio_mmio_scmi: virtio_mmio@4b001000 {
+	compatible = "virtio,mmio";
+	...
+};
+
+firmware {
+	...
+	scmi {
+		compatible = "arm,scmi-virtio";
+		virtio_transport = <&virtio_mmio_scmi>;
+		...
+
+The rest is similar to the mailbox transport example, when omitting the
+mailbox/shmem-specific properties.
-- 
2.25.1

