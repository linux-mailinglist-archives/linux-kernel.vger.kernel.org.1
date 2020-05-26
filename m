Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F461B8636
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 13:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDYLmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 07:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgDYLmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 07:42:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCEDC09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 04:42:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n6so12613684ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emYQSiWUk9pXC+qgp9CZOobl8THByK9dpDVBfnExNiM=;
        b=sJIa7UY+vdeI0DLQm1TmNiXHCr0jBIRVtQM+ppEoAUS05h7c0CrwrQz2Vf6ZbHQf3P
         tIdmXfazuI5Fr1TzJW8vEB2eADCbLGpEeLd53jXrfK/HdRZF/zZBSJeAXQY4AQFoIaGl
         /fRDDt95a+3Gz1FM6Nj05pPsLST9J5hnCm3wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emYQSiWUk9pXC+qgp9CZOobl8THByK9dpDVBfnExNiM=;
        b=ZnkBoSqPlsr9A5M5YZOJvXsz/sRATNE03zIWm0BLOo/PR8AD5NWhJHifM7SF7tcEpn
         sV/SJfocTXpHQOz+OsgJRe1GNgDYI8OJcPS1gthDOWpeiwi6/zhGlg+Rr0R0HwMibhax
         vrIGwZr2a+BzQDGl4FH5AVz8d8I/gqeSENE51PNJeqCcWFtFw92ljjTsWCLcFvbt7Jyb
         IZtjiaCM3cph2CXPK6zqR1ReCtahEuwGlHwHh5j1RRvrJ+H9NJBvypHvDW9bevWks2wE
         9MUDyzwWYFWo4nH9Kwj1Yonc078j2RAFUck2hkv/UQ38GUWCZ7etx9co+ddu05wDbcpB
         dC7g==
X-Gm-Message-State: AGi0PuZJyjApZ3DiK4cNJT/rX7T5ijRIFvdCd8QzQuJ9mJOSsfwRmdMH
        YhYMM8/qDl5BCkNPqQ5ke/vxNA==
X-Google-Smtp-Source: APiQypLPz9UzCVkQ8qSxyzucGk9+IobObT7s65fPyLJfWUIub59qVOsyT2S5xBcDKj1PRvO4Se50lg==
X-Received: by 2002:a2e:740f:: with SMTP id p15mr7642529ljc.151.1587814918455;
        Sat, 25 Apr 2020 04:41:58 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id o6sm5900082lja.70.2020.04.25.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 04:41:57 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:41:52 +0200
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200425133939.3508912-2-mholenko@antmicro.com>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425133939.3508912-0-mholenko@antmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

Add documentation for LiteX SoC Controller bindings.

Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v5:
        - added reviewed-by tag
    
    Changes in v4:
        - changes compatible to "litex,soc-controller"
        - fixed yaml's header
        - removed unnecessary sections from yaml
        - fixed indentation in yaml
    
    This commit has been introduced in v3 of the patchset.

 .../soc/litex/litex,soc-controller.yaml       | 39 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
new file mode 100644
index 000000000000..b118ddbf04a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2020 Antmicro <www.antmicro.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/litex/litex,soc-controller.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: LiteX SoC Controller driver
+
+description: |
+  This is the SoC Controller driver for the LiteX SoC Builder.
+  It's purpose is to verify LiteX CSR (Control&Status Register) access
+  operations and provide function for other drivers to read/write CSRs
+  and to check if those accessors are ready to use.
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+properties:
+  compatible:
+    const: litex,soc-controller
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
+    soc_ctrl0: soc-controller@f0000000 {
+        compatible = "litex,soc-controller";
+        reg = <0x0 0xf0000000 0x0 0xC>;
+        status = "okay";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 44c1e8b3b3b4..421ede6c4f71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9815,6 +9815,12 @@ L:	kunit-dev@googlegroups.com
 S:	Maintained
 F:	lib/list-test.c
 
+LITEX PLATFORM
+M:	Karol Gugala <kgugala@antmicro.com>
+M:	Mateusz Holenko <mholenko@antmicro.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/litex,*.yaml
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
-- 
2.25.1

