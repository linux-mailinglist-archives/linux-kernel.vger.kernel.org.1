Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E62286220
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgJGP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgJGP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:28:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A3C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:28:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so1503090pfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=riAKcPVYtg+GC1pCuIb7AnRFVCer0d2eMcLFBIHh+3I=;
        b=ZzHhbfWpkIXkuRlZzNJQFnbzeCqmp4T0ayR6XwXDfdsjtdRtYriAAkNvFEwNApL3jy
         qCZW6QzXZ5g8FQGGXo0NTBv6tItZ+tHXNNt0uUCnAVQn+Neh1uOaEJqziFwAAB1hKZqT
         JTBGyfP5+PCkEDW9gw5BF/QzmQ7SNu80IQrwVXcUGJ5TPfDNrrhnW2GJ4OJOIUGWhiFl
         PvMLz616WnmTBkdJ4oY2lC5h1gxSx9DhNOQqrewym4A2GMwFt/6yqPUT5d4EkEJb58mV
         Z53q/mpfKfcVSNZJ2mULJFjJkZq8CZwfnd/LV5Xca4NcaCF0mz4AgnFZDJtSnBMuZ2ZN
         rdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=riAKcPVYtg+GC1pCuIb7AnRFVCer0d2eMcLFBIHh+3I=;
        b=S/k1YcHMHV2dhFN4zN32zWhdjFJ7R4Oz7SNbUstd+fhUHIFeR9fF134RdOcZjTVI8R
         1nnXRPi1YV9KydTHnRiM77YZuRZ6wysaZkNOQWGg3rifeg6iUR+0tdTiTDESsZ8qrfLl
         rNoskDGh0mroP22G01BMpJpm330HQC3gChE1NW8Jq/tZStYJZ3/rkgMon95KeQ+H1JLU
         5MF5Pl8iFY8HA4RDm/9EaKp9YqZh6Rp38jpVc1dy9P4mxjYCg5RCRzNbYMCZ8PLFfWXK
         KKVxJdQm+4e+IYDwBfjRtPVHKsBhVQyIUpgbVWDIlh627Ix7hxOyEdem20YV7qKeROfd
         WKFg==
X-Gm-Message-State: AOAM531zQEZLOWw0bRmfbOTzGJXOAb+NRncCI4ek5R/YI/aGyG4X6ajC
        qoH8wFdEUfjM0uezyfqYc32b0g==
X-Google-Smtp-Source: ABdhPJwm9/+C5j7lYWV/wf8OnBPEDMdbN2tJBzwqTh4AYDbMvERw2OR0LU+trZIacjQmA27Tft6RUw==
X-Received: by 2002:a65:6086:: with SMTP id t6mr3509049pgu.146.1602084529013;
        Wed, 07 Oct 2020 08:28:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id r8sm4322494pgn.30.2020.10.07.08.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 08:28:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Borup Petersen <morten.petersen@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Sudeep.Holla@arm.com,
        Frank Rowand <frowand.list@gmail.com>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC V2] dt-bindings: mailbox : arm,mhuv2: Add bindings
Date:   Wed,  7 Oct 2020 20:58:44 +0530
Message-Id: <ca2f491fc97bdf6d7fc8d6fee5f702be27db6702.1602084104.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree binding for ARM Message Handling Unit (MHU)
controller version 2.

Based on earlier work by Morten Borup Petersen.

Co-developed-by: Morten Borup Petersen <morten.petersen@arm.com>
Signed-off-by: Morten Borup Petersen <morten.petersen@arm.com>
Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Morten/Tushar,

I have prepared this based on the best of my understanding about the
hardware, but since I haven't worked on the actual hardware yet there
are chances that I may have misunderstood some of it. Please lemme know
if any of my understanding is incorrect.

Here is the link to the previous attempt by Tushar to get it upstreamed
long back:

https://lore.kernel.org/lkml/20190717192616.1731-1-tushar.khandelwal@arm.com/

This is very much a new approach and so I am not pointing out the
differences from the previous one.

I haven't started with redesigning the driver as of now and would like
to get some feedback on the bindings first. Thanks in advance.
---
 .../bindings/mailbox/arm,mhuv2.yaml           | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
new file mode 100644
index 000000000000..3cbdc97f1f4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/arm,mhuv2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM MHUv2 Mailbox Controller
+
+maintainers:
+  - Morten Borup Petersen <morten.petersen@arm.com>
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
+  a receiver mailbox, otherwise a sender.
+
+  An MHU controller must be specified along with the supported transport
+  protocols. The transport protocols determine the method of data transmission
+  as well as the number of provided mailbox channels.
+
+  Following are the possible transport protocols.
+
+  - Doorbell: Each transfer is made up of single bit flag, using any one of the
+    bits in a channel window. A channel window can support up to 32 doorbells
+    and the entire window shall be used in doorbell mode.  Optionally, data may
+    be transmitted through a shared memory region, wherein the MHU is used
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
+        const: arm,mhuv2
+  required:
+    - compatible
+
+properties:
+  compatible:
+        items:
+          - const: arm,mhuv2
+          - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  arm-mhuv2-mode:
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
+      the ones implemented by the platform.
+
+      mhu: mailbox@2b1f0000 {
+          ...
+
+          arm-mhuv2-mode = <0 2>, <1 3>, <2 5>, <2 7>;
+      }
+
+      The above example defines the mode of an ARM MHUv2 mailbox controller,
+      where a total of 17 channel windows are used. The first two windows are
+      used in doorbell mode (64 doorbells), the next 3 windows are (separately)
+      used in single-word mode, and the last two mailbox channels are used in
+      multi-word mode of length 5 and 7 channel windows.
+
+  '#mbox-cells':
+    description: |
+      It contains two fields, the first field represents the channel number,
+      which may be used in doorbell, single-word, or multi-word mode, and the
+      second field (only relevant in doorbell mode, ignored otherwise)
+      represents the doorbell number within the 32 bit wide channel window.
+
+      From the example given above for the arm-mhuv2-mode, here is how a client
+      node can reference them.
+
+      mboxes = <&mhu 0 5>; // Mailbox channel 0, doorbell 5.
+      mboxes = <&mhu 1 7>; // Mailbox channel 1, doorbell 7.
+      mboxes = <&mhu 2 0>; // Mailbox channel 2, single-word mode.
+      mboxes = <&mhu 4 0>; // Mailbox channel 4, single-word mode.
+      mboxes = <&mhu 6 0>; // Mailbox channel 6, multi-word mode with 7 windows.
+
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - '#mbox-cells'
+  - arm-mhuv2-mode
+
+additionalProperties: false
+
+examples:
+  # Multiple transport protocols implemented by the mailbox controller
+  # configured in sender mode
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhu: mailbox@2b1f0000 {
+            #mbox-cells = <2>;
+            compatible = "arm,mhuv2", "arm,primecell";
+            reg = <0 0x2b1f0000 0 0x1000>;
+            clocks = <&clock 0>;
+            clock-names = "apb_pclk";
+            arm-mhuv2-mode = <1 5>, <2 2>, <2 5>, <2 7>, <0 2>;
+        };
+
+        mhu_client: scb@2e000000 {
+            compatible = "fujitsu,mb86s70-scb-1.0";
+            reg = <0 0x2e000000 0 0x4000>;
+
+            mboxes =
+                     //single-word protocol channel 0
+                     <&mhu 0 0>,
+                     //single-word protocol channel 4
+                     <&mhu 4 0>,
+                     //multi-word protocol channel 6 with 5 windows
+                     <&mhu 6 0>,
+                     //doorbell protocol channel 9, doorbell 27
+                     <&mhu 9 27>;
+        };
+    };
-- 
2.25.0.rc1.19.g042ed3e048af

