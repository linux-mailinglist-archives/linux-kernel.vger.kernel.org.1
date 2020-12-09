Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A32D434E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgLINda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbgLINdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:33:23 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:32:43 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so2135061ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yISQlKdDdQEs0rtCA572V+GjrNXLUJl3S5cKMAgTTQQ=;
        b=VAkDTljn67tjle7mF1B8R2mxdtZP5EQIuxGcTWvyzZ/4QkBTfafez9leqhcRR9YkE8
         +3tezKLppEv4UZLbgeV9aSGzoN0kW+x8EWw6/Hz6cZidYZzRf/zL7ncXg/JepZbMhvjc
         63jA+AVWp75z0L0GAcz8I6mTRUCiwjSwYUFSGxXgBKid81GYAzSXIkxwHu/Cl+Ut9bHd
         DuMg2OY9KpqnEtlHbEGrcw56p5wEFGTavzUjTLxFDoJzpuJaGOFGZiNI1cMRZin6us69
         AhJbVKh/Lkp9rO5XJ4I5uuD9n5+wS2IV19SWCdBDx1sKP0W/xvJr9BHN23zZHkfv9xhp
         TdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yISQlKdDdQEs0rtCA572V+GjrNXLUJl3S5cKMAgTTQQ=;
        b=Cge1HtnHgDXk6U0c+94pYEsm9xzrZENJjj7i/qXRpJDVJemGt/GejrqgVEKz9FOpED
         A5cNHrEZeahK37qPjj91pl6O0V0NbpgbUOVK2BVV/Gx6BIpGxEkNk5Cs1wPlq7G8tYZB
         WnPT45TAC/AybniKU4tifW/ot+ngF28CQ1V8oiGQbKQUt7efpU2gefEvXKxlIiBcTte1
         f8D1fmYXiaJ+sGMIWPA9BH6KL46lYz6JKet+jPm6ZF8red25ah7qlmpkjgLhNtFaKxsy
         iXzlsA2wyETY/L51OKa681TYcS6ZqP6NPDvr/STO5Y7uNBhOGbtFU/iyhi2VCq+q/r9W
         R9gw==
X-Gm-Message-State: AOAM531rhcGt2BD5Dnfri0qgVawsbNa7tRGbvQnG/lmKqxnqLng1c0rO
        pPBbOdaCZpFB+YK8Cq/2G8jPWRoBDTF3eA==
X-Google-Smtp-Source: ABdhPJy7erseB4aaSf7rBqmFXKIkLTwJ81qA/owJwMdJ1Yk4vNWGCUjUn2gUuTyFbtEhRZC1F9pDSQ==
X-Received: by 2002:a17:906:924a:: with SMTP id c10mr2046210ejx.113.1607520761731;
        Wed, 09 Dec 2020 05:32:41 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id bq20sm1490646ejb.64.2020.12.09.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:32:41 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: power: Add MT8167 power domains
Date:   Wed,  9 Dec 2020 14:32:36 +0100
Message-Id: <20201209133238.384030-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains dt-bindings for MT8167.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
This patch was made on top of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.10-next/soc

v3:
	* Remove MT8167_POWER_DOMAIN_DISP since it was an alias for MT8167_POWER_DOMAIN_MM
v2:
	* Implement on top of new SCPSYS PM domains driver

 .../power/mediatek,power-controller.yaml        |  2 ++
 include/dt-bindings/power/mt8167-power.h        | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8167-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index fd12bafe3548..ad6db377f943 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -23,6 +23,7 @@ properties:
 
   compatible:
     enum:
+      - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
       - mediatek,mt8192-power-controller
@@ -59,6 +60,7 @@ patternProperties:
       reg:
         description: |
           Power domain index. Valid values are defined in:
+              "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
               "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
diff --git a/include/dt-bindings/power/mt8167-power.h b/include/dt-bindings/power/mt8167-power.h
new file mode 100644
index 000000000000..c8ec9983a4bc
--- /dev/null
+++ b/include/dt-bindings/power/mt8167-power.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2020 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8167_POWER_H
+#define _DT_BINDINGS_POWER_MT8167_POWER_H
+
+#define MT8167_POWER_DOMAIN_MM		0
+#define MT8167_POWER_DOMAIN_VDEC	1
+#define MT8167_POWER_DOMAIN_ISP		2
+#define MT8167_POWER_DOMAIN_CONN	3
+#define MT8167_POWER_DOMAIN_MFG_ASYNC	4
+#define MT8167_POWER_DOMAIN_MFG_2D	5
+#define MT8167_POWER_DOMAIN_MFG		6
+
+#endif /* _DT_BINDINGS_POWER_MT8167_POWER_H */
-- 
2.29.2

