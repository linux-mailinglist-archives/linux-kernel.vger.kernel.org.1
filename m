Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38632275532
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIWKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgIWKJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:09:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B10EC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:09:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u8so21451473lff.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4viOFN1AOqCCqt5yWr1qANumQ+WkRmjnqWbPwJ0Ybo=;
        b=ZzzVGaZK4YyJIbxRbTRbqBi5tRgZwPdyOGXqfQnjHS9yWdkvB5BtrIK2ywbp9p9oBy
         1tnZwRwlm14lxS9kSPHEAgK8UpI0L09THFPK3fKyekhrK1GIaStRDwF4jNaukmtKzavz
         TiBQwKhRPsrjRdKP6iQMX+7zYmo6mG5PVAMRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4viOFN1AOqCCqt5yWr1qANumQ+WkRmjnqWbPwJ0Ybo=;
        b=ldugujAFdAsYESwbwKkJylMypOS7i4Yyhkwc4jxYRPFpTP+/FGorlVOy8LR0yGJgqS
         GZDPUTjyg/9OpBkiC1pETjpt+VPB5lm7E1usvSRrCJwiSAFFeaU1YOjPVzrxF8lQnGHx
         7fUdRibpj3NGI4H8jKtqXCn9YaDVXDXllTJLN8OpEd6OoxmdIXq9ASLCfPYp2eJpsI8y
         GvRMJPpdrW1bcBUB57VH0am1qx5CoM9yZbZgtzaeOtwCWLtgHGD+HfHYQiDGd3Let+YE
         4YGuAujK2I0c4ZcJvzfuzUpkZoRRWTTYES46e1S6HPt/CfGitZHvViGwBpbL51qwEPNK
         iHqQ==
X-Gm-Message-State: AOAM532gDxT7Q8xtVvVfGJz9O0igjRHRib1ia7tfNemMg78sSV9ZQ2aK
        PpgjBNAkGVxHg8WpXwPEDIYQUA==
X-Google-Smtp-Source: ABdhPJycSuMHNtDYdn2y4/qDdOSSgJwMBrNUsk6G7No4thkHuYmNShs0ZhM/nw5a+HqWW83KbRdV0Q==
X-Received: by 2002:a19:9152:: with SMTP id y18mr3490564lfj.376.1600855763666;
        Wed, 23 Sep 2020 03:09:23 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id m22sm4940941lji.36.2020.09.23.03.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:09:22 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:09:17 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v11 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200923120817.1667149-4-mholenko@antmicro.com>
References: <20200923120817.1667149-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923120817.1667149-0-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    No changes in v11.

    No changes in v10.

    No changes in v9.

    No changes in v8.

    No changes in v7.

    Changes in v6:
    - fixed license header

    No changes in v5.

    No changes in v4.

    Changes in v3:
    - added Reviewed-by tag
    - patch number changed from 3 to 4
    - removed changes in MAINTAINERS file (moved to patch #2)
    
    Changes in v2:
    - binding description rewritten to a yaml schema file
    - added interrupt line
    - fixed unit address
    - patch number changed from 2 to 3

 .../bindings/serial/litex,liteuart.yaml       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.yaml b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
new file mode 100644
index 000000000000..69acb222bb57
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteUART serial controller
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+description: |
+  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports
+  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
+
+properties:
+  compatible:
+    const: litex,liteuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    uart0: serial@e0001800 {
+      compatible = "litex,liteuart";
+      reg = <0xe0001800 0x100>;
+      interrupts = <2>;
+    };
-- 
2.25.1

