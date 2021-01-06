Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E6E2EC280
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbhAFRkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbhAFRj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:39:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB6C061575;
        Wed,  6 Jan 2021 09:39:19 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w18so3511514iot.0;
        Wed, 06 Jan 2021 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK33PKJf/MTRERbQj/ZIkmb/9ClqjuYx9P7+gfqDtxo=;
        b=osKGV0s+laiUSkH6yFNCAwr9N0PyOo0fh/ckSzMre/J884nlvrFA53AUr29XjdrozF
         zauVzbhbf9QoSyNo7bA39fGXdj1jgGCnRfesWF2VcDFnsmTJWThoBj1TiBDnGYCt2ghk
         +Tm2tdasMChMtP0Rgn0OiVvySkuvHIpJbUW9CfzzobGD9wLxd1xia1SR4E1Aq3z3daS6
         virlVoCAqMCVx0oUVIROlS3u39GJYTSBswdph8GTyN6Gb9ZlBPIa/TPDHD35+qO/rv8I
         RQ+tHPTDeyyU89tt0KmKpaipJ6Tsm5cdvPienDnzbGxBdwwt/EJQ/hCUOiU+25QjI8/G
         D14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK33PKJf/MTRERbQj/ZIkmb/9ClqjuYx9P7+gfqDtxo=;
        b=AGLuxjbWLJyUyAQuFnkT9xlsPh7iEf5pAxGvLzOStNs/A0VesreSIrrEab1oKg7VCl
         XkIb9RPf/wxxRcYeD/IvJzhvy9Cs9OSGvQiqTPyK5dngVHR+KynhzNM3FYHjIFrdH5jH
         W8N54Q3yQ/1GoRW1kFmWQod/5xD/UVgDihJYU4uwHo/y9EUuzU/PY+1W8cvshhic/gGT
         nQ/PJCqVDC785T3ZEBa4gje18eOPSIh2PG5k5X80JHSKUC/WjO2o2gaPr6u1QM1Qov2E
         TLVpIkh8cWYzXromn+gFo5TNUWM/W6Tri6hafHl7DSA7AaCfZgwOpkyNMmSihIRJ8GrQ
         viLg==
X-Gm-Message-State: AOAM531x09PEH/yVW0be4ZQlwKWmmP+MS+ATFzWz8eeMa42I7k1CWHMS
        /3zcQyQn/HCdqdO5ji01/iufhDA3HJD3Qg==
X-Google-Smtp-Source: ABdhPJy6fOqDzZFZlIc2Ih3H30VAGw8YywAZTmrhEX0TQd/tWEWIA8lAr6qMKmfPhS6GqHMujicXVg==
X-Received: by 2002:a5e:8606:: with SMTP id z6mr3664672ioj.91.1609954758624;
        Wed, 06 Jan 2021 09:39:18 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:71d3:d2c6:eb48:76be])
        by smtp.gmail.com with ESMTPSA id y5sm2461132ilh.24.2021.01.06.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 09:39:18 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 1/2] dt-bindings: clk: versaclock5:  Add load capacitance properties
Date:   Wed,  6 Jan 2021 11:38:59 -0600
Message-Id: <20210106173900.388758-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two registers which can set the load capacitance for
XTAL1 and XTAL2. These are optional registers when using an
external crystal.  Update the bindings to support them.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 .../devicetree/bindings/clock/idt,versaclock5.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index 2ac1131fd922..e5e55ffb266e 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -59,6 +59,18 @@ properties:
     minItems: 1
     maxItems: 2
 
+  idt,xtal1-load-femtofarads:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 9000
+    maximum: 25000
+    description: Optional loading capacitor for XTAL1
+
+  idt,xtal2-load-femtofarads:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 9000
+    maximum: 25000
+    description: Optional loading capacitor for XTAL2
+
 patternProperties:
   "^OUT[1-4]$":
     type: object
-- 
2.25.1

