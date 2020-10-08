Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67518286E72
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgJHGQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgJHGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D88C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:13 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id e12so3067188pfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pU3ntvw5VhyZXXSja7TGihUxq3Mbbo0tGAqQrbv/0ac=;
        b=AO+qSVcMVuJZ04dE9/iT/5aA9BjaV24JVS38BBrQ0dTuXUAbTbnmmrXwM2WrE4rZtn
         kiATLCnfIwm3X+mWZB6Fa4UHvbxJoOd6triutiLSnsDqFaTlEnpYIFKdcOjcMHWLCKPT
         HFpJp6DGy616Lv3QerL04buG0pAVcVEYUFJUtKxSVVrfeuVpYDP4fwv2XLtENJ6OCi+V
         bdGP5rsHFNzSRjUGoRiw/mA8BJuqZncMobcDpgnHHN/q4WrGIjJTi6SjpBIMwoT9TST8
         w7DV2fq0GVrZv35cJETsShKeDoe0x4Obwx7Y54H31BqUZbptx9N0Jyb/TvMiGoCGOnBx
         0qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pU3ntvw5VhyZXXSja7TGihUxq3Mbbo0tGAqQrbv/0ac=;
        b=O+UOy3JiGwv9e9SBpgE2CY7fLcXfuobzFKEXc/JaatAAC7daPmrRxo83+aFAuOVPl7
         uVYuWC4IZfcPwQ/VlSkeBSzqFAFo95JtHsFy5pKgq4tdSqMDSd/Ny8zQPMEqWdiZFyS4
         UBJprMTR7gOHIkSAc/QIMKsrgDbsgfIHcTTl75PXHRiixWOCl2Fl/RJ9mbL7ljj+nQ7k
         lSUsqHmhnOcILhwP0rqwCTYJ3bDm9hzcZp9O/VbA+3e0M671XPYcqhFChzStJmPWncUg
         X1srvJ47LKGS38IwWalVv3iad00vcvgPd70YbQqUE4KcB2SoMAPeUGRJu9I3YIGyLOPB
         xRpA==
X-Gm-Message-State: AOAM530p+TXDifyIYu/BiRnXSL09HqRTsItdLOA1FDcG7eGQLuUjao5L
        CqWtmXU2irouoQ9trH7XH2Z9FGg5cN8=
X-Google-Smtp-Source: ABdhPJwD/rV3SqOiQdV3MQ6wQLteef9mSzob81GfSTpoiJIuCieKJd9HRFp8oMPGKl92bdbnY4HBTsXIKRk=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a63:d257:: with SMTP id t23mr6247833pgi.212.1602137772764;
 Wed, 07 Oct 2020 23:16:12 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:46 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-6-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 05/15] dt-bindings: connector: Add property to set initial
 current cap for FRS
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds frs-typec-current which allows setting the initial current
capability of the new source when vSafe5V is applied during PD3.0
sink Fast Role Swap.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Removed the redundant usb-connector.txt that I created by mistake.
- Moved to yaml.

Changes since v7:
- Rebase 

Changes since v8:
- Redefine new-source-frs-typec-current as string enums to address
  Rob Herring's comment.

Changes since v9:
- Removed FRS constants from usb bindings.
---
 .../bindings/connector/usb-connector.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 9bd52e63c935..d9f65e81065e 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -142,6 +142,32 @@ properties:
     required:
       - port@0
 
+  new-source-frs-typec-current:
+    description: Initial current capability of the new source when vSafe5V
+      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
+      of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
+      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
+      provides a detailed description of the field. The sink PDO from current source
+      reflects the current source's(i.e. transmitter of the FRS signal) power
+      requirement during fr swap. The current sink (i.e. receiver of the FRS signal),
+      a.k.a new source, should check if it will be able to satisfy the current source's,
+      new sink's, requirement during frswap before enabling the frs signal reception.
+      This property refers to maximum current capability that the current sink can
+      satisfy. During FRS, VBUS voltage is at 5V, as the partners are in implicit
+      contract, hence, the power level is only a function of the current capability.
+      "not-supported" implies sink to source fast role swap not supported.
+      "default" refers to default USB power level as described by
+      "Table 6-14 Fixed Supply PDO - Sink".
+      "1.5A" refers to 1.5A@5V.
+      "3.0A" refers to 3.0A@5V.
+
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - not-supported
+      - default
+      - 1.5A
+      - 3.0A
+
 required:
   - compatible
 
-- 
2.28.0.806.g8561365e88-goog

