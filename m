Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E3A1E3883
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgE0Fty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgE0Ftw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:49:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5325BC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:49:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so8745631plv.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+dxUIMKQyAy42JBGRTdVZGwXErKP5C2qIWqyTzCWlw=;
        b=AinJ5BZdSrzd+mqf3e3TrKJ/RNxB4EpQKs3USnJ4HMNONq6kXq+IHalLSvmSioC2n5
         IOI30WTz7y4sjD8yg0VZecK93wmNY7SovmM5O+UwPjmndzMmELDVJXCXEJtIuzsf0NPz
         iPN8iJ4ZZbawoSEE5M/BfN5RC25bt1lrdMI7L9zQJi7UrlJYkE9u7i3AX8w4pGAQZJE9
         tFfNYCuA0NNZnlWO+cgPG5oQVEVCTK59WoxoRU0Q0qBD5j7wB7DhwgFHyfXoMRigEoTn
         rQDEMIej3kdjwE/UFeaH1Taes8njY4ZhB1Y8P+6919JBNuKrloxXHdWDxZ68xPme6ZKQ
         ZwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+dxUIMKQyAy42JBGRTdVZGwXErKP5C2qIWqyTzCWlw=;
        b=FsdOXPB+UGu4lNCXiaqfuJ4Dnst7NKzI3p0mzoGHCaO21z99zJ+WPGGkOHqyicJHcb
         uAeNYjzYMmkOQ1IGk+dq+1f/y/nP4pWgedBv2s1Bd8n1eilvcfhe1Ov+7RXDPu7LD1tK
         KTHOh2oM52gzGzcdF23edZDxySyfkbC4JUm4LyWeS4sOoft8v0notCVeOelQUolpk8rB
         RcxExKOpM04xTx+EErbMdcNbZLfqND6ejmF63c7G3Sdc+u0uQJYvyCwFiNCzxL8oAF1r
         CJ3U9d+mlBBtuytVoMYxkloNtGFvqyEKI3dR6BOwsoRuLUmSx/lPrZ9MpMd/WxM5ddck
         tLGQ==
X-Gm-Message-State: AOAM533wd4yfnAHAvi9VE/JIeoR639GStkfVSAptUIn4kAm0Hn1jcgYz
        I/mPlyyy69+ImfidfAd1cZt2tw==
X-Google-Smtp-Source: ABdhPJwHDrxBY9CDpCjhMdKuXpvS3HOC+JAK91j6QON6YO393fqoeurzBFq9A3gzs5voZpgS6sbQxg==
X-Received: by 2002:a17:90a:c791:: with SMTP id gn17mr3183530pjb.46.1590558591829;
        Tue, 26 May 2020 22:49:51 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 206sm1015873pfy.97.2020.05.26.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 22:49:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 1/5] dt-bindings: remoteproc: Add Qualcomm PIL info binding
Date:   Tue, 26 May 2020 22:48:45 -0700
Message-Id: <20200527054850.2067032-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527054850.2067032-1-bjorn.andersson@linaro.org>
References: <20200527054850.2067032-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding for the Qualcomm peripheral image loader
relocation information region found in the IMEM.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- Picked up reviewed-bys

 .../bindings/remoteproc/qcom,pil-info.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
new file mode 100644
index 000000000000..87c52316ddbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm peripheral image loader relocation info binding
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm peripheral image loader relocation memory region, in IMEM, is
+  used for communicating remoteproc relocation information to post mortem
+  debugging tools.
+
+properties:
+  compatible:
+    const: qcom,pil-reloc-info
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    imem@146bf000 {
+      compatible = "syscon", "simple-mfd";
+      reg = <0x146bf000 0x1000>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      ranges = <0 0x146bf000 0x1000>;
+
+      pil-reloc@94c {
+        compatible = "qcom,pil-reloc-info";
+        reg = <0x94c 0xc8>;
+      };
+    };
+...
-- 
2.26.2

