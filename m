Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8B2A8503
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgKERfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:35:48 -0500
Received: from foss.arm.com ([217.140.110.172]:38314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKERfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:35:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF75E142F;
        Thu,  5 Nov 2020 09:35:46 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79C013F719;
        Thu,  5 Nov 2020 09:35:45 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] dt-bindings: dvfs: Add support for generic performance domains
Date:   Thu,  5 Nov 2020 17:35:39 +0000
Message-Id: <20201105173539.1426301-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLKSCREW attack [0] exposed security vulnerabilities in energy management
implementations where untrusted software had direct access to clock and
voltage hardware controls. In this attack, the malicious software was able to
place the platform into unsafe overclocked or undervolted configurations. Such
configurations then enabled the injection of predictable faults to reveal
secrets.

Many Arm-based systems used to or still use voltage regulator and clock
frameworks in the kernel. These frameworks allow callers to independently
manipulate frequency and voltage settings. Such implementations can render
systems susceptible to this form of attack.

Attacks such as CLKSCREW are now being mitigated by not having direct and
independent control of clock and voltage in the kernel and moving that
control to a trusted entity, such as the SCP firmware or secure world
firmware/software which are to perform sanity checking on the requested
performance levels, thereby preventing any attempted malicious programming.

With the advent of such an abstraction, there is a need to replace the
generic clock and regulator bindings used by such devices with a generic
performance domains bindings.

[0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../bindings/dvfs/performance-domain.yaml     | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml

diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
new file mode 100644
index 000000000000..fa0151f63ac9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dvfs/performance-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic performance domains
+
+maintainers:
+  - Sudeep Holla <sudeep.holla@arm.com>
+
+description: |+
+  This binding is intended for performance management of groups of devices or
+  CPUs that run in the same performance domain. Performance domains must not
+  be confused with power domains. A performance domain is defined by a set
+  of devices that always have to run at the same performance level. For a given
+  performance domain, there is a single point of control that affects all the
+  devices in the domain, making it impossible to set the performance level of
+  an individual device in the domain independently from other devices in
+  that domain. For example, a set of CPUs that share a voltage domain, and
+  have a common frequency control, is said to be in the same performance
+  domain.
+
+  This device tree binding can be used to bind performance domain consumer
+  devices with their performance domains provided by performance domain
+  providers. A performance domain provider can be represented by any node in
+  the device tree and can provide one or more performance domains. A consumer
+  node can refer to the provider by a phandle and a set of phandle arguments
+  (so called performance domain specifiers) of length specified by the
+  \#performance-domain-cells property in the performance domain provider node.
+
+properties:
+  "#performance-domain-cells":
+    description:
+      Number of cells in a performance domain specifier. Typically 0 for nodes
+      representing a single performance domain and 1 for nodes providing
+      multiple performance domains (e.g. performance controllers), but can be
+      any value as specified by device tree binding documentation of particular
+      provider.
+
+  performance-domains:
+    description:
+      A phandle and performance domain specifier as defined by bindings of the
+      performance controller/provider specified by phandle.
+
+required:
+  - "#performance-domain-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+    performance: performance-controller@12340000 {
+        compatible = "foo,performance-controller";
+        reg = <0x12340000 0x1000>;
+        #performance-domain-cells = <1>;
+    };
+
+    // The node above defines a performance controller that is a performance
+    // domain provider and expects one cell as its phandle argument.
+
+    device1: foo@56780000 {
+        compatible = "foo,bar-controller";
+        reg = <0x56780000 0x1000>;
+        performance-domains = <&performance 1>;
+    };
+
-- 
2.25.1

