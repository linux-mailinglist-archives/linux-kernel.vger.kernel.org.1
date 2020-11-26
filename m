Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D702C5D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390838AbgKZVGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733136AbgKZVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C2C061A49
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:45 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so2593307pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b8dSpVOpxPRkH7Ii5MIpuEJbpdKoro7QaAmsugruQCw=;
        b=P4PfmXE+FyQXDHy7FgUHIsP5Zo1vGXgGcprWj5PB8cHTbClbTLHEi1OyxOAboyn1li
         UGdIfos4P/stI6PNO6eh333PBp7DupwMLj5qpZjiNbCU5QYrFTXJK7iMkCAwRLzjUis2
         JkUnprHv5osDdjPK3iaQvipXGPnbkACZ8lE44zJLGy6KMKpxWj+cg23jKpvYnC7D+Pz7
         KA1pmb0JW09uAluqEE/mmr6hHVVyZ+dgkCXOGEV7tjTSYy0InNz909L+DGT90b/vpnIx
         mzw6jQdyXneVb8u7SHkkrnloKV8FRa11JJ3EwqN0s4J/xJFb6Y1mhqORAkhNXfck3kVM
         7nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8dSpVOpxPRkH7Ii5MIpuEJbpdKoro7QaAmsugruQCw=;
        b=aWeS2+uVHHdC7F6xbi1H4Cz/ed1scOFFD26F5OngYNPCwJrzIUKG4swybLOYu1M5t9
         GTpY2Qg1dxBl92juXD//DWsZl7wY6IK8tZOIksHwy9sHOKcqvI02tGGGvK7JCh/wKDU8
         wKoQ0zhk70Gpl2v2FHauZgOyJJ4sFxbTLT8AE7h2LsJu+GX4f0kCAt9d6CcJMIhZPg6J
         Vk12PsTRTt/AFcVwyEkgE1amQUkAwAQwRwOdomBq/bg1hGR3fgSIfGeGncuisUBo9Ub8
         66X1VJFn4vP/MGSc8vdgw5k4dyR+WIQtvCfgrp1omyWWtuASIK/hOdOfvmpjkvdrMNro
         jt1Q==
X-Gm-Message-State: AOAM5332k2xmpgs30+crZNutA3724vuVrU45hnj4J992LB/LinVpd7k0
        APr8ecTCX0YNcOOFLaNUEtZuIw==
X-Google-Smtp-Source: ABdhPJyLy0T5HMCS0PiytpdYdYbOO1InxoG7sEnAYMH/+Vu63BhfR4ArQGA3dOHVMbwpVqehSA8Tmg==
X-Received: by 2002:a63:1704:: with SMTP id x4mr3933109pgl.65.1606424804717;
        Thu, 26 Nov 2020 13:06:44 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:44 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 01/15] dt-bindings: remoteproc: Add bindind to support autonomous processors
Date:   Thu, 26 Nov 2020 14:06:28 -0700
Message-Id: <20201126210642.897302-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
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
 .../bindings/remoteproc/remoteproc-core.yaml  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
new file mode 100644
index 000000000000..3032734f42a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/remoteproc/remoteproc-core.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for the remoteproc core applicable to all remote processors
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+
+description:
+  This document defines the binding recognised by the remoteproc core that can
+  be used by any remote processor in the subsystem.
+
+properties:
+  autonomous-on-core-reboot:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Used in two situations, i.e when a user space application releases the
+      handle it has on the remote processor's character driver interface and
+      when a remote processor's platform driver is being removed.  If defined,
+      this flag instructs the remoteproc core to detach the remote processor
+      rather than turning it off.
-- 
2.25.1

