Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1E27F827
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 05:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgJADTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 23:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgJADTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 23:19:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897AC061755;
        Wed, 30 Sep 2020 20:19:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so2865293pgd.4;
        Wed, 30 Sep 2020 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tng4piIL6vPdUHSkgFqD3gzlD4hSYHRKcykhP0/QjUg=;
        b=Hdtsjbu4pvHdsnZuaQX93nXxidJ08590Rvjt/HVZPzooMBoDfofHOhtqJPjDhsJuWg
         E+HdUWNZbcceiCRVQRzYOFVO4KyHl+8cuevDBGgooznGxFxM0FQWNo3T08ATc3oFAW0x
         HVcGBYsyoZs5z0hD5dDZdVgGJPiypqaeEuz/HiRS5QmQZe1nYr2ipOid/mBcwzZR4NMx
         KAdo6QEEZywSAK4UAfm62FM4k/L9ajXDpx2DgqIAqEyeXld+RhMDimxopKf/DycG0hq7
         xSfOnARaWthpLfn0S6N3AAvC/LdjDuSSi9Xsj9dagaJvYQE5iubZNa1WkbW+SVouj2mP
         PnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tng4piIL6vPdUHSkgFqD3gzlD4hSYHRKcykhP0/QjUg=;
        b=PJBUjo2XxJ9Yq/zQsJjfFCu93RtA3V0RrBXqXwpep3+8Xx1jt51hcgbSgroyOR5qiS
         aGBKXRK+mgpvuLcChctcy6CfV6066j5xfiw7GAiS/j9ZyxTKo0m4iScpuu8KJIz1Zwck
         CnY8gT/730PYtQoODWp1b9Kk7PgmSLKHjpRjNb2HyAom+T7jMisAY4lxzVyzD4KH6i88
         ff7dOxWTPWU4199w3Qi5uRhqnKn7Yd4oL91R9nJ2/kLxYhMDXfR4FKvrFseGP7QVd28v
         vjmSrudx0vFj+0jnmLU6NWgD3hdLUfgWDlzMzfy7Z5U0fWLFc+du6GuEi72SgAXbgnMh
         5THg==
X-Gm-Message-State: AOAM5327OEW6TFY5wEps2lz7pc9t4573jmPk/BURVMqR4ZF945ntp+UK
        avqUGCjML5juF9GACT6rE1Mtv4dSNXIRGA==
X-Google-Smtp-Source: ABdhPJykCs8zr0+zkdSESjdqEeA+iB4iFhUzVHTRm0vJwKUNf995tXTcWhmkkpUevZWbvw4YzyMIUQ==
X-Received: by 2002:aa7:93a2:0:b029:142:2501:39f4 with SMTP id x2-20020aa793a20000b0290142250139f4mr5029535pff.67.1601522374215;
        Wed, 30 Sep 2020 20:19:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17sm3369242pgd.86.2020.09.30.20.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:19:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 1/2] dt-bindings: phy: Allow defining the SATA AFE TX amplitude
Date:   Wed, 30 Sep 2020 20:19:15 -0700
Message-Id: <20201001031916.411999-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001031916.411999-1-f.fainelli@gmail.com>
References: <20201001031916.411999-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document a new property which allows the selection of the SATA AFE TX
amplitude in milli Volts. Possible values are 400, 500, 600 and 800mV.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
index c03ad2198410..e5abbace93a3 100644
--- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
@@ -38,6 +38,9 @@ Sub-nodes optional properties:
 - brcm,rxaeq-value: when 'rxaeq-mode' is set to "manual", provides the RX
   equalizer value that should be used. Allowed range is 0..63.
 
+- brcm,tx-amplitude-millivolt: transmit amplitude voltage in millivolt.
+  Possible values are 400, 500, 600 or 800 mV.
+
 Example
 	sata-phy@f0458100 {
 		compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
-- 
2.25.1

