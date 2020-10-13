Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDB28C802
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgJMEcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgJMEcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:32:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21812C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:32:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w21so7218127plq.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhphS5GOaPGnFP8QvPZSIKQT0BYlr1dVmtm05huYnNQ=;
        b=y/5WwxKblutys2+zJh79w3AyY8m52TYJAXKJ7D/blOByFAnjm104KDv3r2THoamtJ4
         w3hEJyVMU1nENDzur9zUCPyDYeCDAIRO16hQzx6m7foRlzQ1f5tl1Olf4TWj4nSdYcIH
         sdmw7p7y34NHwZEDK9/C/uheQJRsVT0aZXc+yDj3c8ydSgsSwXdfBdV/Ho/v8ww1S7E2
         kqSlySp++vj+dFu2LzMvBiEfRgFkvHG8tnpkC4ARxE/Z1vF+nopSwxlMw/1Y4tWOLrTA
         yM90j8KO0x+czNF4sxVo3Sv3Ayo5HL7DgSUpXaHwv98uxLZ/rN0py0Ws5Hn6Qd7YtY/g
         pJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhphS5GOaPGnFP8QvPZSIKQT0BYlr1dVmtm05huYnNQ=;
        b=gLw0XYBicp2eBMOtClXOWzGLzVcZ2sKQER+WvGwv3UbPfi6vmDH5nyJXCuv2/35Czc
         yMWpPJvNp2P9WeolHtSK+7vaM2ITISMQ+JouKxxQPy/FcW433iuco/EMt288uvB6gV1E
         B9PURB8D3yoiz8nv9aG8GEin3GDbcsUKaAVq9M2gHnpajznc/I+XDaamObdE8lcb+mIn
         fK6eCycLpu777soURhZAax5Oy/Tx5qaTKWsaWoQnRKZEsmhW2cFg8Fcu/eH6CZydGFgY
         OwJQQh+IIItg8O5njgzje7AOOlqFVIbdHAKR0QoiP7s+7sE84wfHa8bnn3y8kPVSQtcb
         Vl1g==
X-Gm-Message-State: AOAM533ZLitc7BSSYnlBlrCX7UITZTZfwxhdFqB51nSFvgsGN99ZUNyF
        w2Pgro1tNryHef7Lk+pmgq0VHA==
X-Google-Smtp-Source: ABdhPJwDu27biUnqueCXzS+Hq8pf9P2p1ebT2+cViqHDXrPkHuaGOydQNJlBOU1QJXXFRHiPR/6RFg==
X-Received: by 2002:a17:902:8b89:b029:d2:4345:5dd with SMTP id ay9-20020a1709028b89b02900d2434505ddmr27549392plb.57.1602563540428;
        Mon, 12 Oct 2020 21:32:20 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z10sm22183601pff.218.2020.10.12.21.32.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 21:32:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, morten_bp@live.dk,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Sudeep.Holla@arm.com,
        Frank Rowand <frowand.list@gmail.com>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4] dt-bindings: mailbox : arm,mhuv2: Add bindings
Date:   Tue, 13 Oct 2020 10:02:06 +0530
Message-Id: <61ca14fc441f92c1e7994e5bebae5c49811a3050.1602563406.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <20201012191648.GA1908871@bogus>
References: <20201012191648.GA1908871@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree binding for ARM Message Handling Unit (MHU)
controller version 2.

Based on earlier work by Morten Borup Petersen.

Co-developed-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V3->V4:
- Made interrupts property compulsory for receiver
- Added interrupts for both nodes in example
- Fixed min/max items for protocols property
- Don't add -tx/rx to node's name.

V2->V3:
- compatible is changed to arm-mhuv2-tx/rx. Later version of MHUv2
  have an interrupt in the sender mode as well and we can't find if a
  mailbox is sender or receiver just based on an interrupt anymore. We
  needed a better way.

- arm-mhuv2-mode is renamed to arm,mhuv2-protocols to fit the purpose
  better.

- Minor formatting otherwise.

Morten: Please let me know if you want me to add your signoff here from
some other email id as you no longer work with ARM.
---
 .../bindings/mailbox/arm,mhuv2.yaml           | 215 ++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
new file mode 100644
index 000000000000..013b7aeda713
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
@@ -0,0 +1,215 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/arm,mhuv2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM MHUv2 Mailbox Controller
+
+maintainers:
+  - Tushar Khandelwal <tushar.khandelwal@arm.com>
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+description: |
+  The Arm Message Handling Unit (MHU) Version 2 is a mailbox controller that has
+  between 1 and 124 channel windows (each 32-bit wide) to provide unidirectional
+  communication with remote processor(s), where the number of channel windows
+  are implementation dependent.
+
+  Given the unidirectional nature of the controller, an MHUv2 mailbox may only
+  be written to or read from. If a pair of MHU controllers is implemented
+  between two processing elements to provide bidirectional communication, these
+  must be specified as two separate mailboxes.
+
+  If the interrupts property is present in device tree node, then its treated as
+  a "receiver" mailbox, otherwise a "sender".
+
+  An MHU controller must be specified along with the supported transport
+  protocols. The transport protocols determine the method of data transmission
+  as well as the number of provided mailbox channels.
+
+  Following are the possible transport protocols.
+
+  - Doorbell: Each transfer is made up of single bit flag, using any one of the
+    bits in a channel window. A channel window can support up to 32 doorbells
+    and the entire window shall be used in doorbell protocol.  Optionally, data
+    may be transmitted through a shared memory region, wherein the MHU is used
+    strictly as an interrupt generation mechanism but that is out of the scope
+    of these bindings.
+
+  - Single-word: Each transfer is single word, using a single Channel window.
+
+  - Multi-word: Each transfer is made of two or more words, using two or more
+    channel windows.
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - arm,mhuv2-tx
+          - arm,mhuv2-rx
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - description: Sender mode
+        items:
+          - const: arm,mhuv2-tx
+          - const: arm,primecell
+
+      - description: Receiver-mode
+        items:
+          - const: arm,mhuv2-rx
+          - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The MHUv2 controller always implements an interrupt in the "receiver"
+      mode, while the interrupt in the "sender" mode was not available in the
+      version MHUv2.0, but the later versions do have it.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  arm,mhuv2-protocols:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      The MHUv2 controller may contain up to 124 channel windows (each 32-bit
+      wide). The hardware and the DT bindings allows any combination of those to
+      be used for various transport protocols.
+
+      This property allows a platform to describe how these channel windows are
+      used in various transport protocols. The entries in this property shall be
+      present as an array of tuples, where each tuple describes details about
+      one of the transport protocol being implemented over some channel
+      window(s).
+
+      The first field of a tuple signifies the transfer protocol, 0 is reserved
+      for doorbell protocol, 1 is reserved for single-word protocol and 2 is
+      reserved for multi-word protocol. Using any other value in the first field
+      of a tuple makes it invalid.
+
+      The second field of a tuple signifies the number of channel windows where
+      the protocol would be used. For doorbell protocol this field signifies the
+      number of 32-bit channel windows that implement the doorbell protocol. For
+      single-word protocol this field signifies the number of 32-bit channel
+      windows that implement separate single-word protocol mailbox channels. For
+      multi-word protocol this field signifies the number of channel windows
+      used for a multi-word protocol, it should be 2 or more.
+
+      The total number of channel windows specified here shouldn't be more than
+      the ones implemented by the platform, though one can specify lesser number
+      of windows here than what the platform implements.
+
+      mhu: mailbox@2b1f0000 {
+          ...
+
+          arm,mhuv2-protocols = <0 2>, <1 3>, <2 5>, <2 7>;
+      }
+
+      The above example defines the protocols of an ARM MHUv2 mailbox
+      controller, where a total of 17 channel windows are used. The first two
+      windows are used in doorbell protocol (64 doorbells), the next 3 windows
+      are (separately) used in single-word protocol, and the last two mailbox
+      channels are used in multi-word protocol of length 5 and 7 channel
+      windows.
+
+    minItems: 1
+    maxItems: 124
+    items:
+      items:
+        - enum: [ 0, 1, 2 ]
+        - minimum: 0
+          maximum: 124
+
+
+  '#mbox-cells':
+    description: |
+      It contains two fields, the first field represents the channel number,
+      which may be used in doorbell, single-word, or multi-word protocol, and
+      the second field (only relevant in doorbell protocol, should be 0
+      otherwise) represents the doorbell number within the 32 bit wide channel
+      window.
+
+      From the example given above for the arm,mhuv2-protocols, here is how a
+      client node can reference them.
+
+      mboxes = <&mhu 0 5>; // Mailbox channel 0, doorbell 5.
+      mboxes = <&mhu 1 7>; // Mailbox channel 1, doorbell 7.
+      mboxes = <&mhu 2 0>; // Mailbox channel 2, single-word protocol.
+      mboxes = <&mhu 4 0>; // Mailbox channel 4, single-word protocol.
+      mboxes = <&mhu 6 0>; // Mailbox channel 6, multi-word protocol with 7 windows.
+
+    const: 2
+
+if:
+  # Interrupt is compulsory for receiver
+  properties:
+    compatible:
+      contains:
+        const: arm,mhuv2-rx
+then:
+  required:
+    - interrupts
+
+required:
+  - compatible
+  - reg
+  - '#mbox-cells'
+  - arm,mhuv2-protocols
+
+additionalProperties: false
+
+examples:
+  # Multiple transport protocols implemented by the mailbox controllers
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhu_tx: mailbox@2b1f0000 {
+            #mbox-cells = <2>;
+            compatible = "arm,mhuv2-tx", "arm,primecell";
+            reg = <0 0x2b1f0000 0 0x1000>;
+            clocks = <&clock 0>;
+            clock-names = "apb_pclk";
+            interrupts = <0 45 4>;
+            arm,mhuv2-protocols = <1 5>, <2 2>, <2 5>, <2 7>, <0 2>;
+        };
+
+        mhu_rx: mailbox@2b1f1000 {
+            #mbox-cells = <2>;
+            compatible = "arm,mhuv2-rx", "arm,primecell";
+            reg = <0 0x2b1f1000 0 0x1000>;
+            clocks = <&clock 0>;
+            clock-names = "apb_pclk";
+            interrupts = <0 46 4>;
+            arm,mhuv2-protocols = <1 5>, <2 7>, <0 2>;
+        };
+
+        mhu_client: scb@2e000000 {
+            compatible = "fujitsu,mb86s70-scb-1.0";
+            reg = <0 0x2e000000 0 0x4000>;
+
+            mboxes =
+                     //single-word protocol channel 0, mhu-rx
+                     <&mhu_rx 0 0>,
+                     //single-word protocol channel 4, mhu-tx
+                     <&mhu_tx 4 0>,
+                     //multi-word protocol channel 6 with 5 windows, mhu-tx
+                     <&mhu_tx 6 0>,
+                     //doorbell protocol channel 9, doorbell 27, mhu-tx
+                     <&mhu_tx 9 27>;
+        };
+    };
-- 
2.25.0.rc1.19.g042ed3e048af

