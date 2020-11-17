Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4952B5C82
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgKQKCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgKQKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:02:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECAC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:02:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 34so12529413pgp.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ahe89r+r+D+YbMRJiR/RJ+K3X0e/5dw5oqnPUzAYC04=;
        b=iJSZt8qI4u6EPjsDa7j9r7GgXxvwuCnD8wREfz1Nlell7OlPuY5jmK6vVleKSo4upy
         oClBjnT6Rsx+5y6+QB8AdliYZWBdg99vOPy/iy2jHjUcibYgLhKx+yn/tw7dAHitSqlS
         IFaMBvx8IC5ZVvZeaoarTrf09vXn5Hss4ZXvovyWNvfNX6U8Rr3M6qg+cYlv6VvqymbU
         uyUiRzK6xGySDYCnzNUffkxNsaNzxAV0tq2F9bo1atAZGKiLIF7Y6fH03odisATnBWQW
         DM5zpItuoeGaYQN5APpdIEIEkDIn98udlx7Aa3dFSZ8xg35mkQ+gDgbCsKGerR+fy3H8
         EEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ahe89r+r+D+YbMRJiR/RJ+K3X0e/5dw5oqnPUzAYC04=;
        b=IGZNWXhsOju+wzwruAhDQ3gx1LivCnvm41UDBMRlSIRlYpDJzOay+dRvzCCsvrMneP
         UUQ1Jtrf+PnFb8V+Heb+EKA+79IbFR+Z83s+gqtCQ6Czdv2CqMmaic7iwLEqquDi/rrE
         y1OCBvmoc2Hgu8F2OhENhEaFa6Ztifv8K5OWwuhhf3XAiig6QsNF0kfNvd1RuQ5mWAeR
         cBC+AsvpFjo4UTh6qc2fFEnNsQWnY5CqrXQBYr+A9BdCr8O2FGZnu83hX3nnXOQuaeDj
         4wDG6jFCm8crt9ZS06Lfhj+0/lcozjtmoa1REmH1db0vC9qMncRNFA+3HqULxhckr9sZ
         +0HQ==
X-Gm-Message-State: AOAM532303z+1if0Em3ubQ5ELeCBE1CUaMry82DMIF1OtdRTsg5UH9MN
        PTnZff8toyFHbDF+f0I908kzZQ==
X-Google-Smtp-Source: ABdhPJyIoW6iuGXtw+z6QnwmwA1lntY0QgUXfOhu87pliGd+jQVGAxYWmT3iXnCVazFq1lKI99ImwA==
X-Received: by 2002:a63:e14a:: with SMTP id h10mr2843067pgk.231.1605607335346;
        Tue, 17 Nov 2020 02:02:15 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id cm20sm2552672pjb.18.2020.11.17.02.02.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 02:02:14 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Sudeep.Holla@arm.com,
        morten_bp@live.dk, Tushar Khandelwal <tushar.khandelwal@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V5 1/2] dt-bindings: mailbox : arm,mhuv2: Add bindings
Date:   Tue, 17 Nov 2020 15:32:05 +0530
Message-Id: <bb190c4030a3bfd02fbb1c2bfaffd7480913f3d1.1605607138.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1605607138.git.viresh.kumar@linaro.org>
References: <cover.1605607138.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree binding for ARM Message Handling Unit (MHU)
controller version 2.

Based on earlier work by Morten Borup Petersen.

Reviewed-by: Rob Herring <robh@kernel.org>
Co-developed-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../bindings/mailbox/arm,mhuv2.yaml           | 209 ++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
new file mode 100644
index 000000000000..6608545ea66f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
@@ -0,0 +1,209 @@
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
+  - Data-transfer: Each transfer is made of one or more words, using one or more
+    channel windows.
+
+  - Doorbell: Each transfer is made up of single bit flag, using any one of the
+    bits in a channel window. A channel window can support up to 32 doorbells
+    and the entire window shall be used in doorbell protocol.  Optionally, data
+    may be transmitted through a shared memory region, wherein the MHU is used
+    strictly as an interrupt generation mechanism but that is out of the scope
+    of these bindings.
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
+      for doorbell protocol, and 1 is reserved for data-transfer protocol.
+      Using any other value in the first field of a tuple makes it invalid.
+
+      The second field of a tuple signifies the number of channel windows where
+      the protocol would be used and should be set to a non zero value. For
+      doorbell protocol this field signifies the number of 32-bit channel
+      windows that implement the doorbell protocol. For data-transfer protocol,
+      this field signifies the number of 32-bit channel windows that implement
+      the data-transfer protocol.
+
+      The total number of channel windows specified here shouldn't be more than
+      the ones implemented by the platform, though one can specify lesser number
+      of windows here than what the platform implements.
+
+      mhu: mailbox@2b1f0000 {
+          ...
+
+          arm,mhuv2-protocols = <0 2>, <1 1>, <1 5>, <1 7>;
+      }
+
+      The above example defines the protocols of an ARM MHUv2 mailbox
+      controller, where a total of 15 channel windows are used. The first two
+      windows are used in doorbell protocol (64 doorbells), followed by 1, 5 and
+      7 windows (separately) used in data-transfer protocol.
+
+    minItems: 1
+    maxItems: 124
+    items:
+      items:
+        - enum: [ 0, 1 ]
+        - minimum: 0
+          maximum: 124
+
+
+  '#mbox-cells':
+    description: |
+      It is always set to 2. The first argument in the consumers 'mboxes'
+      property represents the channel window group, which may be used in
+      doorbell, or data-transfer protocol, and the second argument (only
+      relevant in doorbell protocol, should be 0 otherwise) represents the
+      doorbell number within the 32 bit wide channel window.
+
+      From the example given above for arm,mhuv2-protocols, here is how a client
+      node can reference them.
+
+      mboxes = <&mhu 0 5>; // Channel Window Group 0, doorbell 5.
+      mboxes = <&mhu 1 7>; // Channel Window Group 1, doorbell 7.
+      mboxes = <&mhu 2 0>; // Channel Window Group 2, data transfer protocol with 1 window.
+      mboxes = <&mhu 3 0>; // Channel Window Group 3, data transfer protocol with 5 windows.
+      mboxes = <&mhu 4 0>; // Channel Window Group 4, data transfer protocol with 7 windows.
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
+            arm,mhuv2-protocols = <1 5>, <1 2>, <1 5>, <1 7>, <0 2>;
+        };
+
+        mhu_rx: mailbox@2b1f1000 {
+            #mbox-cells = <2>;
+            compatible = "arm,mhuv2-rx", "arm,primecell";
+            reg = <0 0x2b1f1000 0 0x1000>;
+            clocks = <&clock 0>;
+            clock-names = "apb_pclk";
+            interrupts = <0 46 4>;
+            arm,mhuv2-protocols = <1 1>, <1 7>, <0 2>;
+        };
+
+        mhu_client: scb@2e000000 {
+            compatible = "fujitsu,mb86s70-scb-1.0";
+            reg = <0 0x2e000000 0 0x4000>;
+
+            mboxes =
+                     //data-transfer protocol with 5 windows, mhu-tx
+                     <&mhu_tx 2 0>,
+                     //data-transfer protocol with 7 windows, mhu-tx
+                     <&mhu_tx 3 0>,
+                     //doorbell protocol channel 4, doorbell 27, mhu-tx
+                     <&mhu_tx 4 27>,
+                     //data-transfer protocol with 1 window, mhu-rx
+                     <&mhu_rx 0 0>;
+        };
+    };
-- 
2.25.0.rc1.19.g042ed3e048af

