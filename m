Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E612DE814
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgLRRdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbgLRRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:33:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C6CC061257
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v3so1738416plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRhRZVtQaTMtklLhGYfbei+QaPodzo2py0ncJTxvT/s=;
        b=tNpsREt+XbPPv5QuoOhm9OqsITxalLxxOZfgF8GTLq+WJ8iOk5xzuavWPKfg58ioVE
         vBnZIyX/ncnJ2y40CyDTmSENMfPGcJewYu8oc3kJ5gXDZkQ35Pan0ThRHaPR4j8bNOFr
         dTa2k+0iXIbnE8vX66p/PMHDMBGHZkIVXf63lWQg4QHZsaFAbrdfmUqSzPgzV3SkxCiN
         cW227HbMVgiQ4M8uIXZeAKla3krZ6TzWemIzYMDGTUV1n5M6UZwJ8ZU3XQmivnqsNLFA
         EXNaCAd9JvVPPXBHFKQ7X9WuYH5XIhAaGzy5Z0igOM8Fo4zLsHKrqv0pq7vRF5UwrOUn
         I7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRhRZVtQaTMtklLhGYfbei+QaPodzo2py0ncJTxvT/s=;
        b=hlaysDQbLI8mGJXnH1I+ShSAJu+qy3Tsm9Eqs7cp1igu9dcALTFMklNvgNAa/RTqJf
         +flOFKOGbkZ1D29yaeUnI275rN1s+o+UrlD7+tKX40ZpDYmd4UH3ElZnIDVLctTZOCzA
         wcie+sJPJv0rXNlqaxonEZSKnB6fUb9XHS0WKM5/UDcsMP08T823u0GT9SgpMvg1V0Bh
         qP/lKbVTl10FNr/BYuIgSlEWJAT6bnaCDc8AskTa2tta+H1v25xZn+JYEXvIqWU6y1OJ
         1qUqQdsdq5I7DGAKaBpdlCCNFhzF3UI1z2MQqPIJEaDgaxrQlcJkXN3dfQGjBUn2EodW
         9Spg==
X-Gm-Message-State: AOAM530vCIf9fNVoGVng4QDYKbqpp9dtgQnFr4HfTzaHMUGsCdDAI6WM
        Imsel2DgP0ZC2z2ZylDBrQS3OO4wDjEs6rRP
X-Google-Smtp-Source: ABdhPJyG/NZO9JMMo4KBjMYKSaNOPJm7mR6yfpLRHFGp5pZbF3G299VUhTFYpP1iX5qT8HulTiUHVA==
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id b13-20020a170902ed0db02900dac83b5f40mr5444448pld.20.1608312751595;
        Fri, 18 Dec 2020 09:32:31 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:30 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/17] dt-bindings: remoteproc: Add bindind to support autonomous processors
Date:   Fri, 18 Dec 2020 10:32:12 -0700
Message-Id: <20201218173228.2277032-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a binding to guide the remoteproc core on how to deal with
remote processors in two cases:

1) When an application holding a reference to a remote processor character
   device interface crashes.

2) when the platform driver for a remote processor is removed.

In both cases if "autonomous-on-core-reboot" is specified in the remote
processor DT node, the remoteproc core will detach the remote processor
rather than switching it off.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../bindings/remoteproc/remoteproc-core.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
new file mode 100644
index 000000000000..e8bb8ef9031a
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/remoteproc-core.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding(s) for a primary processor applicable to all ancillary
+       processors
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+
+description:
+  This document defines the bindings used by a primary processor to determine
+  the state it should leave an ancillary processor when the former is no longer
+  functioning.
+
+properties:
+  autonomous-on-core-reboot:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When specified the ancillary processor should be left operational when
+      the primary processor is no longer available.  Otherwise the ancillary
+      processor should be made inoperative.
+
+additionalProperties: true
-- 
2.25.1

