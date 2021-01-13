Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D852F513C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbhAMRjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbhAMRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:39:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E6C061786;
        Wed, 13 Jan 2021 09:38:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r4so2364695wmh.5;
        Wed, 13 Jan 2021 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAkE89jO3FfCKZpOr20u/UTabJSL17T7VKX/vxjG0G8=;
        b=nQU5HMVuO7efPDVDlQPMblzWC2jGVNtvkW84LkpP+UKthvBbjG6gkTDCWXtzUJ3EvI
         83h4tmoBepekYYw1188atoeNOP/bJXWXuEqMzRY26zg6b1qTVI+f7A4oz/rASFTGToXL
         OtGUsZ8r6Pp5dkDbTROezPWNz6ZFqGti5dfbzcy8NCnRlH4VSdy8I0U+cd4KpNqJu5C2
         3ucu2/agJ9MlxdW3zhyn3Ook2jGJjiVw0Dyp93gF+KCv4VFFOXmMpAWuoM/paZ6Zl5YV
         WaWTH2lckKy+EetL5mFE4TQAjOp/CZpMrAv12fWjhMsiWBFuGMwMIYtyWC27btr9af/K
         VCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAkE89jO3FfCKZpOr20u/UTabJSL17T7VKX/vxjG0G8=;
        b=fZ6G51x8Kftz7UgmuxPPKb8ZUZ76P6Jupsug2LbCUI2qac6qY4aLu457+rQLPQcfA7
         Li+C3pcvUGuZdJLyiYkYnCyjvv3nDbpN6z4sOg1kLFF93HOn3uQvKtwkBtCqGJnA49IV
         oc4DwuObvo+E+84+DFyJkida60O7wuCUdvfzwPSvSH7F19jy6p306lOJCK9emLIz9x5U
         jeE4fNtoH7T4XnvEO5mLNALpfImkVMbMtmYj7GNfQvaXPNzd+Ez507lJwNIclKB778ha
         wlSx1lXjwZ6Cow6gxO6l1UxNx8F+R26pEiVxTRzEQ13N0GAxYlNBLju/S5lmEN4Ptq4d
         yPfA==
X-Gm-Message-State: AOAM531ZUlh11agjWBa5PrTojMN+yZbhEQMBwA0CKP8SFBbEXy1JolLp
        zF8q5V+Uwt3c/Ek6uifKTB8=
X-Google-Smtp-Source: ABdhPJwlIga+FFTv/XL9S+vKs9fF97r8FNup+vxpT+YoIA26a7iEZYFGAW+FsI+nJdL3Ac82DYEwPQ==
X-Received: by 2002:a1c:151:: with SMTP id 78mr372945wmb.24.1610559538560;
        Wed, 13 Jan 2021 09:38:58 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id w21sm3743843wmi.45.2021.01.13.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:38:58 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Date:   Wed, 13 Jan 2021 18:38:53 +0100
Message-Id: <20210113173855.1509417-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113173855.1509417-1-adrien.grassein@gmail.com>
References: <20210113173855.1509417-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nitrogen8M Mini is an ARM based single board computer (SBC).

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cee74fc0c115..c09d58ebb0f3 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -670,6 +670,7 @@ properties:
         items:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
+              - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
-- 
2.25.1

