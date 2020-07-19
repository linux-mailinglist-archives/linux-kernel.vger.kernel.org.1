Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56811225329
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgGSRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:43:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC0C0619D2;
        Sun, 19 Jul 2020 10:43:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so7929342pfu.1;
        Sun, 19 Jul 2020 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nEbCHjkuXDoaKqNoX/pXlsfKXaRlHFlOyuXXdN/SzCI=;
        b=M+C9Zh9HtKlLDwgIcN5r68LBOJctiR7QDIZ1Xx+UWWURs7OLs2IxO20q5mNV6QQcH1
         rCEqPQWMFLLUxwxHZCPEG4DcWFS7BZ/MabjVNWIVNEQUzN/0TITJZ/WKSmRiqAS1vIkK
         CuYtgYZCiae581v0ew01sVsYu8zcEep0Yr3RQ+I/Br0IK9wGTlpypKPaaZYhOtaXA4sq
         761DyfB7/iwlzm+My8gBiYW48BOHSVeu+l+sdnaAkLL1pNo1idspx1bLAEhVHo2uU2fd
         M1qlFrk2fISjTAmNQqTEVt4BjDf6X/ZPQX94nX5oUu5HwWMcM5S7VkQpYp7EWWjm7mOQ
         SqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nEbCHjkuXDoaKqNoX/pXlsfKXaRlHFlOyuXXdN/SzCI=;
        b=SZ4XvM5dx+M86aT2BSnFvrEJYiCddLzK2CU/2PVF104nVVXOP1jHtkubxhumNz9leM
         8LCCbyDX85T99i3CKRgIT9LvX/b+Ychi3MX/a7pxtxRalOQZYPMEz32eu+vVRSDM3dfF
         BSEcp0gqtm3ad67Anug6u/eqThhkUEyJL8wMwPP5F1DZtLl4sBGT4QdO9BrjQjxm+9un
         jO1rUVrpFPoqRgp5cXSfeL7+kAJXQfi4oxyfozsyDaI+G9IiVp0LT/tCvfCl6quhU/yR
         LuItbCSMnTfoW+6CuBQ92/CALxJRtVTZMQXanEDnJY2GibQ5wL8b3oaOybG6wnjp7LTw
         MxhQ==
X-Gm-Message-State: AOAM531WO0EhhIphvd+/WSHCM0JX2X00w5mTxP1vPNA/D0RUuOZqzZQu
        CqVr7njLVui63uY/LbX9GAs=
X-Google-Smtp-Source: ABdhPJzfMgnt5NuME4q8hdablaBOIAJjIJqyIVtNqpmCQV9zerW5+dhbRf7MElawJJiuB4vNUxVt5Q==
X-Received: by 2002:a63:9246:: with SMTP id s6mr15687123pgn.22.1595180585006;
        Sun, 19 Jul 2020 10:43:05 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.43.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:43:04 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Sun, 19 Jul 2020 23:12:04 +0530
Message-Id: <1595180527-11320-8-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree binding reset constants for mmc controller
present on Actions S700 Soc.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes since v4:
        * No change.
Changes since v3:
        * No change.
Changes since v2:
        * No change.
Changes since v1:
        * No change.
Changes since RFC:
        * added Rob's acked-by tag
---
 include/dt-bindings/reset/actions,s700-reset.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
index 5e3b16b8ef53..a3118de6d7aa 100644
--- a/include/dt-bindings/reset/actions,s700-reset.h
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -30,5 +30,8 @@
 #define RESET_UART4				20
 #define RESET_UART5				21
 #define RESET_UART6				22
+#define RESET_SD0				23
+#define RESET_SD1				24
+#define RESET_SD2				25
 
 #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.7.4

