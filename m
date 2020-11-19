Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D252B9682
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgKSPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgKSPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:45 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC8CC0613CF;
        Thu, 19 Nov 2020 07:43:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so7163857wmb.2;
        Thu, 19 Nov 2020 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhiGf2+miDL4vNktmWcMghT5Zn6/WsNTcEagUPj9ukA=;
        b=rWk6W3brv88vsU/iYyjfsBOdXNSyUqUV7naVeiUdWaqxxC8HC/GhM42dtOeH3t6Dus
         L2oE7+8R3eC1G1NWnZUHZWO80BhIVO/YFL7i+wG7+hpzXtU3kaThvHBXzrshG9DA21Vk
         8nqaC794OPFnhRad0GaYHSYxsFWM5cuJIcpcJgZSQ958t84cGfP5rXWaVdIeFoB6f2iI
         gUuPpysYmLxu862HKapfYM7JcGlhKsOlA6TxJWP6S6cC0DxlfmtFLlWLXaJb3OCrQ5pG
         M3Y9IalyIOdtQCPvh0MkHuPK2ljRal51iKDO3j9443z6ne3TevqhUjONZeplBSNxojx6
         uBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhiGf2+miDL4vNktmWcMghT5Zn6/WsNTcEagUPj9ukA=;
        b=i/TTPiufp/HHsI/RWOTtGAB6nesK+NfNvz/vfYYexNVtbZJ9mR9NgCOhvZQQxr7beV
         9Ai3KNiqZDHyydrRhTpAadnU82iUYJxEKdIwmOZ0ZSb/ehvvn1ba2bDNGb7NMiZ5LPv+
         pAx8lkn8oX/pad10N2dwy6T1/Yb7FRg1LGgczdjC6BQxcZC4e0ycJa0eYtMWQUvH/KTj
         XsIVDH0M5pP9dni67jmSTzZxQTLsbqf16SwcZnPqs3X9udg7eLTwZUIRG9rrbzaQoCgP
         Yk4RXeq5qfWm08II9sc76pSgtLJRt7fyB/13H46AMtHBD/ut5Qd4fwIxn7jTXl/OqDwa
         z5TQ==
X-Gm-Message-State: AOAM531X7mOUmEsSfRpGXKQKUf8l32oZ4wWee/U6PnaD2uCcrBMB9T3E
        vLMBxyqSYrRYhftUyc9Uc2Y=
X-Google-Smtp-Source: ABdhPJwFPG6ozjMnbbPsPZjXveE/2g0qc66JnSl0kmSBRhn9RIEIQwYzmmQkiRZp8BbX6UvrROmgVA==
X-Received: by 2002:a1c:230b:: with SMTP id j11mr4909760wmj.12.1605800623834;
        Thu, 19 Nov 2020 07:43:43 -0800 (PST)
Received: from localhost.localdomain (234.red-79-158-79.dynamicip.rima-tde.net. [79.158.79.234])
        by smtp.gmail.com with ESMTPSA id w10sm181303wra.34.2020.11.19.07.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 07:43:43 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        devel@driverdev.osuosl.org, neil@brown.name
Subject: [PATCH v5 3/4] MAINTAINERS: add MT7621 PHY PCI maintainer
Date:   Thu, 19 Nov 2020 16:43:36 +0100
Message-Id: <20201119154337.9195-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
References: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as maintainer for mt7621 pci phy driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefbbecfb266..31f808e58e73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11100,6 +11100,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 F:	drivers/i2c/busses/i2c-mt7621.c
 
+MEDIATEK MT7621 PHY PCI DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
+F:	drivers/phy/ralink/phy-mt7621-pci.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.25.1

