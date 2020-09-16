Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86E626C0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIPJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgIPJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:39:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83A0C061788
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:39:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so1303928pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nr0Ojg9qAm8OgCLg703zoT+O4V7LKzhMDlCC3KmmLNg=;
        b=QFPsiDrSq996so456fe2hEy11ROjrzTSirvXwjTWUbB0rEdhiOQjI4tomWcFP1Xg9L
         wxALwetR6UBN1FADOof61gUOubuN37oHzcfBGT/7gxfQhV7KK1Lp9OIAbhfChlO3vqqi
         qbgqRORkRCbuqi4TQXDSldkr7LqKe6XtkVOk2TA+OD0GW6ZdXEyXZfOAYMq1VcwspbOC
         oW7lKgxY7+AUKbunAGXu3qbC37aFxZYuvE5QfYj3S8hY0uiTPtsfX+FuCSaZcn8eFKk7
         IBX0NrbdEGQSGpDW5PxC+zXSV5Lasqu3e/n28ruFiaahhr/kOTIloZz9SPCDpwoi8JOy
         omgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nr0Ojg9qAm8OgCLg703zoT+O4V7LKzhMDlCC3KmmLNg=;
        b=lXG0b2GOfljqb5JZhDlDLGJOFbBi/CVk2eR1Q3+5n6eeZSEhU0T/MKk9q9tc3yoXIQ
         10bl43YNx0DRBMgBT7ruhv438KT2i6IFWm5mq6YA2/SiAeCYocdw9uLxkSubMQL3UGvn
         J0VVhNJlBSxXwbmuQB1slmeXzWhpagWd+j08bnWuRBkNvisl64xfOzpXcy15yP1t14LT
         mnKXd12pMvAoSBuAUtbb7/D9QWT1S4EeMmf+Q6Ta878OsbzwVR7v1vePLVBOBC0tBOob
         6bRWEsPSGqMHMpU2sXzw9W40lenBPIpOXCaaQrbl8dpa0lfI4dxYscjkUJ1BKjVMfjDZ
         +gtg==
X-Gm-Message-State: AOAM531ISkxff9WWF+sMYMNZlAm/snnlFdW4Fu5jdQEvaLXb48eKdiVm
        iMZzwkys7HIqVUOZB3VCSqdoUQ==
X-Google-Smtp-Source: ABdhPJwSVIVzhThJa6Q/i/XfC6Ul63jDkFWo9o7W3fnYJt7Jp/wh93ksP6TD9gQu8R5g/A4TI93Wwg==
X-Received: by 2002:a17:902:ea8b:b029:d1:7ed9:55c6 with SMTP id x11-20020a170902ea8bb02900d17ed955c6mr22671038plb.19.1600249173383;
        Wed, 16 Sep 2020 02:39:33 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id i8sm2069029pjv.43.2020.09.16.02.39.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:39:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] dt-bindings: mailbox : arm,mhu: Convert to Json-schema
Date:   Wed, 16 Sep 2020 15:09:17 +0530
Message-Id: <3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DT binding over to Json-schema.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V4:
- Dual license
- improved description for interrupts

 .../devicetree/bindings/mailbox/arm,mhu.yaml  | 87 +++++++++++++++++++
 .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ---------
 2 files changed, 87 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
new file mode 100644
index 000000000000..2c8df7979c22
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/arm,mhu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM MHU Mailbox Controller
+
+maintainers:
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+description: |
+  The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has 3
+  independent channels/links to communicate with remote processor(s).  MHU links
+  are hardwired on a platform. A link raises interrupt for any received data.
+  However, there is no specified way of knowing if the sent data has been read
+  by the remote. This driver assumes the sender polls STAT register and the
+  remote clears it after having read the data.  The last channel is specified to
+  be a 'Secure' resource, hence can't be used by Linux running NS.
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,mhu
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: arm,mhu
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: low-priority non-secure
+      - description: high-priority non-secure
+      - description: Secure
+    maxItems: 3
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  '#mbox-cells':
+    description: Index of the channel.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhuA: mailbox@2b1f0000 {
+            #mbox-cells = <1>;
+            compatible = "arm,mhu", "arm,primecell";
+            reg = <0 0x2b1f0000 0 0x1000>;
+            interrupts = <0 36 4>, /* LP-NonSecure */
+                         <0 35 4>, /* HP-NonSecure */
+                         <0 37 4>; /* Secure */
+            clocks = <&clock 0 2 1>;
+            clock-names = "apb_pclk";
+        };
+
+        mhu_client_scb: scb@2e000000 {
+            compatible = "fujitsu,mb86s70-scb-1.0";
+            reg = <0 0x2e000000 0 0x4000>;
+            mboxes = <&mhuA 1>; /* HP-NonSecure */
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
deleted file mode 100644
index 4971f03f0b33..000000000000
--- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-ARM MHU Mailbox Driver
-======================
-
-The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
-3 independent channels/links to communicate with remote processor(s).
- MHU links are hardwired on a platform. A link raises interrupt for any
-received data. However, there is no specified way of knowing if the sent
-data has been read by the remote. This driver assumes the sender polls
-STAT register and the remote clears it after having read the data.
-The last channel is specified to be a 'Secure' resource, hence can't be
-used by Linux running NS.
-
-Mailbox Device Node:
-====================
-
-Required properties:
---------------------
-- compatible:		Shall be "arm,mhu" & "arm,primecell"
-- reg:			Contains the mailbox register address range (base
-			address and length)
-- #mbox-cells		Shall be 1 - the index of the channel needed.
-- interrupts:		Contains the interrupt information corresponding to
-			each of the 3 links of MHU.
-
-Example:
---------
-
-	mhu: mailbox@2b1f0000 {
-		#mbox-cells = <1>;
-		compatible = "arm,mhu", "arm,primecell";
-		reg = <0 0x2b1f0000 0x1000>;
-		interrupts = <0 36 4>, /* LP-NonSecure */
-			     <0 35 4>, /* HP-NonSecure */
-			     <0 37 4>; /* Secure */
-		clocks = <&clock 0 2 1>;
-		clock-names = "apb_pclk";
-	};
-
-	mhu_client: scb@2e000000 {
-		compatible = "fujitsu,mb86s70-scb-1.0";
-		reg = <0 0x2e000000 0x4000>;
-		mboxes = <&mhu 1>; /* HP-NonSecure */
-	};
-- 
2.25.0.rc1.19.g042ed3e048af

