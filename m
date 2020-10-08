Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED82875F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgJHOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:24:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40073 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgJHOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:24:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id l4so5623271ota.7;
        Thu, 08 Oct 2020 07:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbwKFYHPbp5GTNdG4T4mKLQORc21DXouN8jvpsAfWQE=;
        b=FgvH2f6QjvZIcmax70DpEToIcuSy63ovD5WMv2yVk6/dgBFjE5PazSEnY8qRGmcGzH
         AHCB4VuXZ0J4XvfrN3HQAVbpsjxAzqltNKqI3zfjNzRbvnte9j0l4rDYdrTpgzVWWP7S
         SRQrfu8JxWTqAMVo6idCAI4dXVwJYyAiBx/rIIbozQEH5+VHcx5VrbCeickZIuWkdvWE
         RdVH+pTPCcokGwFJWP1eoGyL1VW/KWVPyrCAK1UxP5UI9WR9SwEmoQHZkx4dCpqPFw8O
         sDQPlNf8bP+jBra/WOa4MgAW105h2ZpLhbEWj1N1Nrh8GVEL1E1f8cum68ffQOqBliBN
         bLyw==
X-Gm-Message-State: AOAM530yiwVoZuEw+zeMmLMEWsatKnTK+7p42uuzJ1xwTyuAlMkm2+yi
        C6Q/3aLH4RBMDtEbEyNGstHl3g7JbTXr
X-Google-Smtp-Source: ABdhPJx5CFACMyMhsVj5wqDOr7VXjzKJ25j6nM0arqd7ipXHZQY8NH6go4gbElQF585d0rhOybv0Hg==
X-Received: by 2002:a9d:7c87:: with SMTP id q7mr5365330otn.140.1602167063432;
        Thu, 08 Oct 2020 07:24:23 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r131sm4880609oig.50.2020.10.08.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:24:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] dt-bindings: powerpc: Add a schema for the 'sleep' property
Date:   Thu,  8 Oct 2020 09:24:19 -0500
Message-Id: <20201008142420.2083861-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the PowerPC specific 'sleep' property as a schema. It is
currently only documented in booting-without-of.rst which is getting
removed.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/powerpc/sleep.yaml    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/sleep.yaml

diff --git a/Documentation/devicetree/bindings/powerpc/sleep.yaml b/Documentation/devicetree/bindings/powerpc/sleep.yaml
new file mode 100644
index 000000000000..6494c7d08b93
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/sleep.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/sleep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PowerPC sleep property
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |
+  Devices on SOCs often have mechanisms for placing devices into low-power
+  states that are decoupled from the devices' own register blocks.  Sometimes,
+  this information is more complicated than a cell-index property can
+  reasonably describe.  Thus, each device controlled in such a manner
+  may contain a "sleep" property which describes these connections.
+
+  The sleep property consists of one or more sleep resources, each of
+  which consists of a phandle to a sleep controller, followed by a
+  controller-specific sleep specifier of zero or more cells.
+
+  The semantics of what type of low power modes are possible are defined
+  by the sleep controller.  Some examples of the types of low power modes
+  that may be supported are:
+
+   - Dynamic: The device may be disabled or enabled at any time.
+   - System Suspend: The device may request to be disabled or remain
+     awake during system suspend, but will not be disabled until then.
+   - Permanent: The device is disabled permanently (until the next hard
+     reset).
+
+  Some devices may share a clock domain with each other, such that they should
+  only be suspended when none of the devices are in use.  Where reasonable,
+  such nodes should be placed on a virtual bus, where the bus has the sleep
+  property.  If the clock domain is shared among devices that cannot be
+  reasonably grouped in this manner, then create a virtual sleep controller
+  (similar to an interrupt nexus, except that defining a standardized
+  sleep-map should wait until its necessity is demonstrated).
+
+select: true
+
+properties:
+  sleep:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+
+additionalProperties: true
-- 
2.25.1

