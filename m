Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B507426C0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIPJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgIPJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:39:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:39:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s65so3606045pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8AkzaxC++FhteIS2uJYfThdR+e4UohlwkKcMuwBI6c=;
        b=JqccLoP0WFWnngf08Ztmi7m6wSbuMixdwIc4ZLcHLmZBTvtysKHRt8CLHEmglfF0h0
         yEx33j78CKWyy+7AqA4k0iCvPm2Wqi9biduejIc4TziOXcNcsMMESt/u9ao83muvBJxb
         H+mpNqiEhWOrKKOABom1aKusMcAX3NlEwaXs3hXgY5ZGOysp4wzq1NUHlgcdpUL32Q5T
         t1UGMTEavf+KxnOMby8SXAjBGrrbQE8rY8m89Vd8W521336ErWKNAXE6GvWYr6OPhCr6
         /EmgoxOhkBnL3XSZDyQb20wtt6W5cyj1rbgS7WZlGxpEfLyV1Zb+UL3bSGOrAPlT01ef
         SL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8AkzaxC++FhteIS2uJYfThdR+e4UohlwkKcMuwBI6c=;
        b=rlqpwWd/5b71JoAcw361/SqCZdYEQhtEpWhgvO0OPqs/158/GRKMALmNZKiD/UiFqH
         XnTswvkk41VYO/FWKkr5rCegdzWZGkAqwgHTCRTDJE5WaPDBuMliVXig1mhQ8jFyfnOm
         g8k+RlFXZ3driisJOKyEujXS7KcAhajR/G3mQdT4Zq6OL3Fl7j6dXDwRzrDU1twDa+HD
         4crA7ZfPTBGt70ubqE1wy2Xa1rQCkTkstKo58ALbhGgMNHprN4zPvByHpZkuWxbH9+JR
         ORyDP353A6XMx9DbT6G0dthYuAnsNbvLJMf7Gm7WdPkEnK/0OGLX0YfzKx6JeXfdT1J6
         C5Vw==
X-Gm-Message-State: AOAM533f0tCucIY4rt4EVoSM/1IHL31yF2ieFQPn3q/k1KBDOHXDmv3D
        pA/7kGUvTnQboEitLPV8IprsyA==
X-Google-Smtp-Source: ABdhPJyuMf787MIcMjuhcVoXuvXR7cJupPF8CNqVVrY93x3EpThRI7V1lJFiMAiFewJ1LdsZSw4mmg==
X-Received: by 2002:a63:7841:: with SMTP id t62mr17348017pgc.183.1600249179169;
        Wed, 16 Sep 2020 02:39:39 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id v6sm16215933pfi.38.2020.09.16.02.39.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:39:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] dt-bindings: mailbox: add doorbell support to ARM MHU
Date:   Wed, 16 Sep 2020 15:09:18 +0530
Message-Id: <7f4a98d4dac9257d9577e48992cbfb62a968f127.1600249102.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org>
References: <3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

The ARM MHU's reference manual states following:

"The MHU drives the signal using a 32-bit register, with all 32 bits
logically ORed together. The MHU provides a set of registers to enable
software to set, clear, and check the status of each of the bits of this
register independently.  The use of 32 bits for each interrupt line
enables software to provide more information about the source of the
interrupt. For example, each bit of the register can be associated with
a type of event that can contribute to raising the interrupt."

This patch thus extends the MHU controller's DT binding to add support
for doorbell mode.

Though the same MHU hardware controller is used in the two modes, A new
compatible string is added here to represent the combination of the MHU
hardware and the firmware sitting on the other side (which expects each
bit to represent a different signal now).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V4: Added Rob's tag.

 .../devicetree/bindings/mailbox/arm,mhu.yaml  | 60 +++++++++++++++++--
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
index 2c8df7979c22..d43791a2dde7 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -18,20 +18,40 @@ description: |
   remote clears it after having read the data.  The last channel is specified to
   be a 'Secure' resource, hence can't be used by Linux running NS.
 
+  The MHU hardware also allows operations in doorbell mode. The MHU drives the
+  interrupt signal using a 32-bit register, with all 32-bits logically ORed
+  together. It provides a set of registers to enable software to set, clear and
+  check the status of each of the bits of this register independently. The use
+  of 32 bits per interrupt line enables software to provide more information
+  about the source of the interrupt. For example, each bit of the register can
+  be associated with a type of event that can contribute to raising the
+  interrupt. Each of the 32-bits can be used as "doorbell" to alert the remote
+  processor.
+
 # We need a select here so we don't match all nodes with 'arm,primecell'
 select:
   properties:
     compatible:
       contains:
-        const: arm,mhu
+        enum:
+          - arm,mhu
+          - arm,mhu-doorbell
   required:
     - compatible
 
 properties:
   compatible:
-    items:
-      - const: arm,mhu
-      - const: arm,primecell
+    oneOf:
+      - description: Data transfer mode
+        items:
+          - const: arm,mhu
+          - const: arm,primecell
+
+      - description: Doorbell mode
+        items:
+          - const: arm,mhu-doorbell
+          - const: arm,primecell
+
 
   reg:
     maxItems: 1
@@ -51,8 +71,11 @@ description: |
       - const: apb_pclk
 
   '#mbox-cells':
-    description: Index of the channel.
-    const: 1
+    description: |
+      Set to 1 in data transfer mode and represents index of the channel.
+      Set to 2 in doorbell mode and represents index of the channel and doorbell
+      number.
+    enum: [ 1, 2 ]
 
 required:
   - compatible
@@ -63,6 +86,7 @@ description: |
 additionalProperties: false
 
 examples:
+  # Data transfer mode.
   - |
     soc {
         #address-cells = <2>;
@@ -85,3 +109,27 @@ additionalProperties: false
             mboxes = <&mhuA 1>; /* HP-NonSecure */
         };
     };
+
+  # Doorbell mode.
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhuB: mailbox@2b2f0000 {
+            #mbox-cells = <2>;
+            compatible = "arm,mhu-doorbell", "arm,primecell";
+            reg = <0 0x2b2f0000 0 0x1000>;
+            interrupts = <0 36 4>, /* LP-NonSecure */
+                         <0 35 4>, /* HP-NonSecure */
+                         <0 37 4>; /* Secure */
+            clocks = <&clock 0 2 1>;
+            clock-names = "apb_pclk";
+        };
+
+        mhu_client_scpi: scpi@2f000000 {
+            compatible = "arm,scpi";
+            reg = <0 0x2f000000 0 0x200>;
+            mboxes = <&mhuB 1 4>; /* HP-NonSecure, 5th doorbell */
+        };
+    };
-- 
2.25.0.rc1.19.g042ed3e048af

