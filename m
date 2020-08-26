Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9987F253783
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHZStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:49:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41354 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgHZSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:48:57 -0400
Received: by mail-io1-f67.google.com with SMTP id m23so3207027iol.8;
        Wed, 26 Aug 2020 11:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNZy6DyKFktw1S4IEMG7/aKvHfRAsR8jlYGJnThSK/w=;
        b=UX5DbWNL5Rt3p2nQWLnaQ2KLHq/EuP7NyrvLTzihq3d/Vfwo6dCPM4rcMFM3kCV4eV
         Up2BIuzHY4/tS1EoEHjPq1rPNz+Plz9CS8oozZhenqEjACQzD37zU5QgV6IoDBZDsX/T
         kSrBnVU1rgoy03rkBWqAPmX8Q6m4hHDmbbEtX9fjanIeFKHrLz9FJdA+dkdC9xTVcQuk
         PjNDg+tXSUhUj0sIv4CxKOu3wFIO2wRNbjT+7VpIeLuZl4XuPCwflfbsSQwzEB4ePgGq
         5yzGcfsviSdIJSjqXWgUE7zdJ0bjbgZSBCXosVlJrGgpDvs6YL01vxr956ruhItZfCzf
         dlfQ==
X-Gm-Message-State: AOAM531PvWBrK954HaGfvtEaYgpv9yM8z+6BJ/hfEm1PQP0KyJNVWyHK
        AKRFDx49OhcwkxCrMot8cgxutmLOT75S
X-Google-Smtp-Source: ABdhPJw3rZMqtCEoM6EXfLvn7ToJRVHLjEfMDKOeyf9q8tYTAfxr69JwYoHPnqFHtMqcAqf/pXRbgA==
X-Received: by 2002:a6b:2c1:: with SMTP id 184mr4171903ioc.137.1598467735776;
        Wed, 26 Aug 2020 11:48:55 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id c2sm1609226iow.6.2020.08.26.11.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:48:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Griffin <peter.griffin@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/3] dt-bindings: phy: Remove phy-stih41x-usb binding
Date:   Wed, 26 Aug 2020 12:48:50 -0600
Message-Id: <20200826184851.3431531-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826184851.3431531-1-robh@kernel.org>
References: <20200826184851.3431531-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was removed in 2016 in commit fb954c48aea6 ("phy:
stih41x-usb: Remove usb phy driver and dt binding  documentation.") and
somehow the DT binding got dropped despite the subject.

Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/phy-stih41x-usb.txt          | 24 -------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
deleted file mode 100644
index 744b4809542e..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-STMicroelectronics STiH41x USB PHY binding
-------------------------------------------
-
-This file contains documentation for the usb phy found in STiH415/6 SoCs from
-STMicroelectronics.
-
-Required properties:
-- compatible	: should be "st,stih416-usb-phy" or "st,stih415-usb-phy"
-- st,syscfg	: should be a phandle of the syscfg node
-- clock-names	: must contain "osc_phy"
-- clocks	: must contain an entry for each name in clock-names.
-See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-- #phy-cells	: must be 0 for this phy
-See: Documentation/devicetree/bindings/phy/phy-bindings.txt
-
-Example:
-
-usb2_phy: usb2phy@0 {
-	compatible	= "st,stih416-usb-phy";
-	#phy-cells	= <0>;
-	st,syscfg	= <&syscfg_rear>;
-	clocks		= <&clk_sysin>;
-	clock-names	= "osc_phy";
-};
-- 
2.25.1

