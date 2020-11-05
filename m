Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8A72A88FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbgKEV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:28:35 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:37469 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbgKEV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:28:14 -0500
Received: from spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115])
        by plasma.jpberlin.de (Postfix) with ESMTP id 685EDABBC9;
        Thu,  5 Nov 2020 22:21:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id fzjoFdtuPM-S; Thu,  5 Nov 2020 22:21:52 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id D2C75AB986;
        Thu,  5 Nov 2020 22:21:51 +0100 (CET)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH v2 09/10] dt-bindings: arm: Add virtio transport for SCMI
Date:   Thu, 5 Nov 2020 22:21:15 +0100
Message-ID: <20201105212116.411422-10-peter.hilber@opensynergy.com>
In-Reply-To: <20201105212116.411422-1-peter.hilber@opensynergy.com>
References: <20201105212116.411422-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.07 / 15.00 / 15.00
X-Rspamd-Queue-Id: 685EDABBC9
X-Rspamd-UID: d798ee
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
 .../devicetree/bindings/arm/arm,scmi.txt      | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 55deb68230eb..6ded49d82773 100644
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
@@ -21,6 +24,15 @@ The scmi node with the following properties shall be under the /firmware/ node.
 	  supported.
 - shmem : List of phandle pointing to the shared memory(SHM) area as per
 	  generic mailbox client binding.
+
+Virtio transport:
+
+- compatible : shall be "arm,scmi-virtio".
+
+The virtio transport only supports a single device.
+
+Additional required properties:
+
 - #address-cells : should be '1' if the device has sub-nodes, maps to
 	  protocol identifier for a given sub-node.
 - #size-cells : should be '0' as 'reg' property doesn't have any size
@@ -42,7 +54,8 @@ Each protocol supported shall have a sub-node with corresponding compatible
 as described in the following sections. If the platform supports dedicated
 communication channel for a particular protocol, the 3 properties namely:
 mboxes, mbox-names and shmem shall be present in the sub-node corresponding
-to that protocol.
+to that protocol. The virtio transport does not support dedicated communication
+channels.
 
 Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
 ------------------------------------------------------------
@@ -106,7 +119,8 @@ Required sub-node properties:
 [4] Documentation/devicetree/bindings/sram/sram.yaml
 [5] Documentation/devicetree/bindings/reset/reset.txt
 
-Example:
+Example (mailbox transport):
+----------------------------
 
 sram@50000000 {
 	compatible = "mmio-sram";
@@ -195,3 +209,20 @@ thermal-zones {
 		...
 	};
 };
+
+Example (virtio transport):
+---------------------------
+
+virtio_mmio@4b001000 {
+	compatible = "virtio,mmio";
+	...
+};
+
+firmware {
+	...
+	scmi {
+		compatible = "arm,scmi-virtio";
+		...
+
+The rest is similar to the mailbox transport example, when omitting the
+mailbox/shmem-specific properties.
-- 
2.25.1

