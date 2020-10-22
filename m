Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0929616E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901121AbgJVPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508330AbgJVPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:08:24 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00713C0613CE;
        Thu, 22 Oct 2020 08:08:23 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w17so2020958ilg.8;
        Thu, 22 Oct 2020 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFpFjBeW2UJa8NxmOhUDnOAN1N87W5tmSfgqtGWazXE=;
        b=KnAMn+XpJ4JRHVFA8cVoQh+5s/lejE5yw9P0rqisgRL5PAnMlVNjAmb0UQu7CFcAB7
         dDk6c5Gt60SHJMTvJTd3XwMk9fbA3YAadACsJ5l5DiSQ81XJnHeBB5dAB3y15rqS1Stf
         WW6hwV5vPc7pMYAyHepoaNUgmOlH8vpIZYw3npHkr1VP5DVD+5Ktyk4F7Febf7hJD0gR
         nOYFPnWq0H5Wyc+3NSFJdDx03lMs4Q277gBWIKs23m6UOUOM+0OPgG1NsxB3IA++jo0b
         uDFXFrJRYqne7eehntZp3rvEqlyknsI0NuwTGgP+CZyhMtEoaTAGHthglLPUrZ6HvrzF
         GXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFpFjBeW2UJa8NxmOhUDnOAN1N87W5tmSfgqtGWazXE=;
        b=tI6V3B4UF/FHr8BfAmqG9H/2X8fB7NfBSge8jr0H9nJRi0kyN7WQ9xDh+2W4/haeWV
         H5X4Aw6cktce2bG6LDtXjjNpj/On6FEgs+BRTtaUZqaHxy7uzeXkfEoQJcJ7GSoUJcvW
         h1HijsvVnZ6KKtCs+JKOe7klx2skk+vpUw3fI5x5UTz4UPucvvOSx8Cp8w5YeAPzHNui
         J3nq5bpOI7oVCkMq+3hRDDLE/nOawMy5k7BlaSHIPQ3XcxVDT1r3FzVnG7znc9M/0mAR
         1fKXhpNFpZQASLFX5tJAv4r+nd4oxaSYVNzM1fUCOXD3ze61yAED4qTRGerjgT7Kf/zj
         kFjg==
X-Gm-Message-State: AOAM532OlPg3Sk/nyrz7bmvOnfT8EKxF8pEGnK6ob/axF2SKebDvZgMr
        EmpVsR9C6lQz2tBEghpbkNg=
X-Google-Smtp-Source: ABdhPJy6SQVW1cYIyZ96kMBa7w0PCrmCPl3uwU0XrP84PxWIyts64xm0/gApfT2P0FvuW184ZjboMg==
X-Received: by 2002:a92:d390:: with SMTP id o16mr2033038ilo.213.1603379303242;
        Thu, 22 Oct 2020 08:08:23 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id y6sm1233816ilj.59.2020.10.22.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:08:22 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, l.stach@pengutronix.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: add defines for i.MX8MN power domains
Date:   Thu, 22 Oct 2020 10:08:04 -0500
Message-Id: <20201022150808.763082-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022150808.763082-1-aford173@gmail.com>
References: <20201022150808.763082-1-aford173@gmail.com>
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

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index 8dd86f67c210..e71a01a541ad 100644
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

