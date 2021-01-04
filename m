Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC22EA09B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbhADXRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADXRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:17:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A889C061796
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:17:07 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c12so17294006pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xliuBhcuCe3LSKs+KrKKbN9fo/wqGAuOpx2UNrHRZkk=;
        b=JOnWYsRK4bSbUHEcEXNRkoDq9Fi70xM4vQ4N/H8RPYf5vGK1gSLM9RVTDbV63eyynl
         6/Gts371aMJTQifFdsTT0+GBUW6Gx+CBHSMj7gCO5hCvWExi2ZMWIZ1EUqzdomzwnBVM
         EEZb9bMVpaRXARkzuAx1qXMRtJEbYStZuuxRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xliuBhcuCe3LSKs+KrKKbN9fo/wqGAuOpx2UNrHRZkk=;
        b=A6AIupG9z/sH58Tr6SK2nHYxFYEMgjNQ/JvZPxdHGmte3Pf4lvDmyfRSkU7X0DnJMQ
         VPJb0IzbEjIzlVFy4Gd0Tlz5A4Nbwu20+5NtxKQPEFlF8LBUZHvEeXjc1/xmbWQ+teWU
         voDxkEqo0s6thrKkOmnJ1+Bn3bMijOXv1p/Pu8z50T9nzge8IE8AGUbR69rHV2Mo0Pbw
         kKoSv0PyFHSmhlpJ6dyvpG46jpTzk0d5pXnGltgYIFHnNYboINRpZ9QdpnTCngLCynBs
         e4HeAo0Z4W/1KTuT4vg8swoYwEET1q/JeFJHmkk7XCB3mXUBYLFCfD0C+8LhVGwFjKLi
         bvtQ==
X-Gm-Message-State: AOAM532z/SGlRUv0Vgi67Fdb98plLaFzjp3ZlECbeqVjrZ3QcaEaFpgp
        rzr50uYTedt0TBEbw/41d5nbY+wJjseVNQ==
X-Google-Smtp-Source: ABdhPJw5l29/rMCZWKLaxBlGZMOSAsBMwtjWdgHqylhZe6I6D8inwCVFRAk5Pxc13ZfvmnZmZdBLew==
X-Received: by 2002:a65:458d:: with SMTP id o13mr34537142pgq.450.1609800938587;
        Mon, 04 Jan 2021 14:55:38 -0800 (PST)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:a6ae:11ff:fe11:fd59])
        by smtp.gmail.com with ESMTPSA id c18sm54951051pfj.200.2021.01.04.14.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:55:38 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: input: cros-ec-keyb: Add a new property
Date:   Mon,  4 Jan 2021 14:55:31 -0800
Message-Id: <20210104145523.v2.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
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

Changes in v2:
- add `function-row-physmap` instead of `google,custom-keyb-top-row`

 .../devicetree/bindings/input/google,cros-ec-keyb.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
index 8e50c14a9d778..7acdb33781d30 100644
--- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
+++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
@@ -31,6 +31,16 @@ properties:
       if the EC does not have its own logic or hardware for this.
     type: boolean
 
+  function-row-physmap:
+    $ref: '/schemas/types.yaml#/definitions/uint32-array'
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

