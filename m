Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00462AA59E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgKGOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:00:33 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5641AC0613CF;
        Sat,  7 Nov 2020 06:00:33 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j12so4958382iow.0;
        Sat, 07 Nov 2020 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZ0zZauDPYcHJm61ikQGB8Z52hdKv7iVnqdM1PesCOA=;
        b=dFG7ZwhQgPVQN9ohIm1pVpuizYMFO0XW/xHjHgu5bbU8P09nzoUUL6U+0fSANQrmAg
         iwy/SMGHXEbhDFRO9JeosIBDTz3L/BEa888UPBDBJpk6hwlPn4Hy2bbjoegJ0NEX8ZxA
         h9qn+EeHP/P29qFlMHSmgptexNAXHK8FDLcMbwDo7HZ4aGkUdpEDThuX72dCDtcoxrUU
         xZUX7sKwFyxV6b1B41kjOcCBnA6U1IpuAxTy+JXGHsQ9XVqj9dP3GnpuV3T3IRzH8EWg
         mNll6XBLQgsxafydv2+3VNkUAtt4rxoW2HIGZ/ExX5xm5kPe+UDkJp6LZ8XzWRB5F7EJ
         L9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZ0zZauDPYcHJm61ikQGB8Z52hdKv7iVnqdM1PesCOA=;
        b=aW4zcIRFB1serMHQJO06j4OgRvUfpdy4WAHqiYmhas45WTSg6QCe5RufFy9l9cNIAy
         CuyH4KLrIeuah9Id6/n69hI0r0FaBCmTdzWtjf0EdyG5JdmU3u5KJhxaLF9IlzkvsTdG
         MzvgzYDfhzKUQ9ru6BkouNs+9/TeQybfuudoA+CnYmKw+jiVT5pCSyQmSg77z99YnXfr
         icewZ9txsgkcsFSJpqwneavXZMihE8lS7qGBPVTK6AfTcSJl2IOxB4b3XeDIuhAVsOTK
         Y5W+4KfjOoDdskwaAUUzNzDT2m0e7p45bSc3uO6SzBZaFx2aaWWlApQNZV747YsoNip+
         JJtw==
X-Gm-Message-State: AOAM530VJgBlsw1pcG+447RlvG9ro4CcVCPPlHCs6MHKGQJW8hX4yZLS
        ITwOhEr1+wA8LdIzBy7FSqKyMLuK3AxVdA==
X-Google-Smtp-Source: ABdhPJxgWCcJKr9Dr/VXJkuFZcAnbq+I/xboyOJEr7AVueBO+2AF6aYSlvB+KvD1NjuGZIYHsTgckQ==
X-Received: by 2002:a02:76d7:: with SMTP id z206mr5326447jab.77.1604757632484;
        Sat, 07 Nov 2020 06:00:32 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id g5sm3030257ilq.33.2020.11.07.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 06:00:31 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] dt-bindings: add defines for i.MX8MN power domains
Date:   Sat,  7 Nov 2020 08:00:21 -0600
Message-Id: <20201107140026.1974312-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has a similar power domain controller to that of the
mini, but it isn't fully compatible, so it needs a separate binding
and power domain tables.

Add the bindings and tables.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---

V2:  No change

 .../devicetree/bindings/power/fsl,imx-gpcv2.yaml  |  1 +
 include/dt-bindings/power/imx8mn-power.h          | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index d3539569d45f..a87c44c15ace 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     enum:
       - fsl,imx7d-gpc
+      - fsl,imx8mn-gpc
       - fsl,imx8mq-gpc
       - fsl,imx8mm-gpc
 
diff --git a/include/dt-bindings/power/imx8mn-power.h b/include/dt-bindings/power/imx8mn-power.h
new file mode 100644
index 000000000000..102ee85a9b62
--- /dev/null
+++ b/include/dt-bindings/power/imx8mn-power.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2020 Compass Electronics Group, LLC
+ */
+
+#ifndef __DT_BINDINGS_IMX8MN_POWER_H__
+#define __DT_BINDINGS_IMX8MN_POWER_H__
+
+#define IMX8MN_POWER_DOMAIN_HSIOMIX	0
+#define IMX8MN_POWER_DOMAIN_OTG1	1
+#define IMX8MN_POWER_DOMAIN_GPUMIX	2
+#define IMX8MN_POWER_DOMAIN_DISPMIX	3
+#define IMX8MN_POWER_DOMAIN_MIPI	4
+
+#endif
-- 
2.25.1

