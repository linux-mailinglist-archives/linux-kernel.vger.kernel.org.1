Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854DD2C50CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbgKZI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbgKZI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:57:25 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC8BC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:57:25 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so1054424pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMxUrmRGx+y3NjZPjFrWddmFD+gsX++Ce0FYPnjlkxg=;
        b=OiW6GzvmiuKkoLaqQWM9z1gn+0abOqn1aNE+dGD4U8KlXEput0gbHsFwlMHRTDMZSc
         Ejm8oxWCB34DrtOcfOS21SvZZteasv5ThHqDdmZoCxteBq6L28Zhs4mnzTbQSTswkQVQ
         2JFglFvMzV5j38qKkatgudRvvub7zJl73Kjy2AanZxjcxwXFm7PqHztUNecoEqgs8jNk
         1gowIElSJeUNQ0kQKvLvHdYpOjDhEhNykhr/uhmFDRImVZ6rK3R+31DtIHd1DIjnP86F
         OiG7W8bbNh5yZSYjU5kKwp0vlOswI/Gt4XkKKSj5P3qcYrRC6gULiwOKwos3k1rgb4xg
         t69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMxUrmRGx+y3NjZPjFrWddmFD+gsX++Ce0FYPnjlkxg=;
        b=fYDq/LC9IVcy8HLBcX4ySAyLmBUlWnqpuiq9uiRpkxSR7gz7BH5u0bTDI3LoBb0Hzt
         yDYZqwZunJmG2VMNF0qmJV8mTtt+P/BRbkeKDbhAqaZ2JatETDamW5FFkgFkzIPEyOue
         cxlgvGupNJbJvOypib5pvtL82xxhYyahLcJiSqwOXX/Hq8MHeLyxSrGxzUGLJkVcHzL5
         Xuqi1l10jF6/5LZmZ5wL+suqeA2/K4VMhD2XMVacOJZKfttHG2A/xYX6/kgnCLVzKCRx
         76N4NXsFSnExAM1C1+rIwcXNo4G/oYVkvZaKudi+vDBlJ5thHm6Uvd5Z+7x72eVPRJ1d
         oAcA==
X-Gm-Message-State: AOAM533j1ay1frz4erq84FoiyrRH3xbjl4ar5XDNt/w8jYhcMkOohkXX
        EMz9dvqtDJb5XCANwrdTEQ8w
X-Google-Smtp-Source: ABdhPJxYOrYdgbhzUl+CCPWqsQZhcQ6M1BDB6k4vk0lPomfm+IUwdVrGTdkh6Eym3uZYklFC/U9SgQ==
X-Received: by 2002:aa7:972b:0:b029:18b:89f:df0 with SMTP id k11-20020aa7972b0000b029018b089f0df0mr1893902pfg.39.1606381044561;
        Thu, 26 Nov 2020 00:57:24 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6e95:f2a:3996:9d7f:e389:7f7d])
        by smtp.gmail.com with ESMTPSA id e29sm4025603pgl.58.2020.11.26.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 00:57:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaprak@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: qcom_nandc: Add SDX55 QPIC NAND documentation
Date:   Thu, 26 Nov 2020 14:27:04 +0530
Message-Id: <20201126085705.48399-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126085705.48399-1-manivannan.sadhasivam@linaro.org>
References: <20201126085705.48399-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SDX55 uses QPIC NAND controller version 2.0.0 with BAM DMA
Engine.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/mtd/qcom_nandc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
index 5c2fba4b30fe..a971db361678 100644
--- a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
+++ b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
@@ -8,6 +8,8 @@ Required properties:
                             IPQ4019 SoC and it uses BAM DMA
     * "qcom,ipq8074-nand" - for QPIC NAND controller v1.5.0 being used in
                             IPQ8074 SoC and it uses BAM DMA
+    * "qcom,sdx55-nand"   - for QPIC NAND controller v2.0.0 being used in
+                            SDX55 SoC and it uses BAM DMA
 
 - reg:			MMIO address range
 - clocks:		must contain core clock and always on clock
-- 
2.25.1

