Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F5F2F5621
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbhANBmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbhANBmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:42:03 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F0EC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:25:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id be12so2089555plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUUWLh/FNK3F0sgi880UceWHgzM8J4m+gkpp1DTJZ2M=;
        b=MuOEK8WfCL9YKsZi8iwmR4D5ghZgnc1kXQ5uaN9wCHI8LaFCwJ3GGH3LxOm5jHvX9p
         3NQMR/DZb44f3CQFSxFM7R1igdI5uz46xFlt/ZsZHJkeGqoDIjM8uhnxMg45Vr1fJ/Uz
         4YSFmLSE8a0mjGDoBDT1m/FxeEvaspjaWXUTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUUWLh/FNK3F0sgi880UceWHgzM8J4m+gkpp1DTJZ2M=;
        b=XphBfuoK3FXRC9axchbKWeD8QINMY4+uB5l3ck0TqX5Ia/gIacBIrs0kKpcyfcFfl/
         YDuD2DEcIVQ2E1nL6ocT87iVPv7g7DK4YlNieOJ535DNFRndv34AB+lWUYA1BT/qz0RQ
         BvfOSrzQ4gVvpxA/baLErD8yErn23+Aw+ZPyqYUOj6IllkR5cFCLpPP0ZQ1b3gAk6EAb
         hfWsa8QNv51olP/6yEd/730nVWvV7Dj7aXJNZBcoFO8A41XzBvuJiKSTwkPPu885/Kbt
         LPOjbkziI/t9KczwoiYymeRRlknBXWY4SEjVjaqYwya72srooxw4aej4WAP8+0MbTTg8
         Cq8Q==
X-Gm-Message-State: AOAM530QMr51dEnsUYE+gKMIRUPua1r/an7Skbong5Mz3IGAaEja5gtc
        S0rvUDIQYMvI9FnB5RkRZiXyK6jBiLYJXA==
X-Google-Smtp-Source: ABdhPJyQ18bA9094rP3M8AhElK5E2LPj18h89tEVmY4bjgqey79H3nl8KiJdN2eZRo40znR6vLf73Q==
X-Received: by 2002:a17:902:6903:b029:da:f458:798c with SMTP id j3-20020a1709026903b02900daf458798cmr5019315plk.68.1610587518594;
        Wed, 13 Jan 2021 17:25:18 -0800 (PST)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:a6ae:11ff:fe11:fd59])
        by smtp.gmail.com with ESMTPSA id w90sm3782703pjw.10.2021.01.13.17.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 17:25:18 -0800 (PST)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Cc:     dianders@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: input: cros-ec-keyb: Add a new property
Date:   Wed, 13 Jan 2021 17:25:12 -0800
Message-Id: <20210113172450.v5.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new property `function-row-physmap` to the
device tree for the custom keyboard top row design.

The property describes the rows/columns of the top row keys
from left to right.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

Changes in v5:
- add minItems and maxItems for `function-row-physmap`

Changes in v2:
- add `function-row-physmap` instead of `google,custom-keyb-top-row`

 .../bindings/input/google,cros-ec-keyb.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
index 8e50c14a9d778..e573ef3e58b65 100644
--- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
+++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
@@ -31,6 +31,18 @@ properties:
       if the EC does not have its own logic or hardware for this.
     type: boolean
 
+  function-row-physmap:
+    $ref: '/schemas/types.yaml#/definitions/uint32-array'
+    minItems: 1
+    maxItems: 15
+    description: |
+      An ordered u32 array describing the rows/columns (in the scan matrix)
+      of top row keys from physical left (KEY_F1) to right. Each entry
+      encodes the row/column as:
+      (((row) & 0xFF) << 24) | (((column) & 0xFF) << 16)
+      where the lower 16 bits are reserved. This property is specified only
+      when the keyboard has a custom design for the top row keys.
+
 required:
   - compatible
 
-- 
2.26.2

