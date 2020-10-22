Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36208296630
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371968AbgJVUvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371946AbgJVUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:51:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A5C0613CE;
        Thu, 22 Oct 2020 13:51:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so1963297pfp.13;
        Thu, 22 Oct 2020 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+P4ia93LhSu+lP7GMSkhv9Sc8m7veE5fgntwYlKJ/sg=;
        b=vJ8O6EUmRNMgBoRpOaiw7+6cs4oAN+Mybl/lJZTCAz94doUVdxcoJkKiQk7XBAOqGI
         uOLUFRh4MpsXaxSwrDh+NjmMdSE4eQCQqs5xtAYJz2hSGQxRAXXyAiM3/jcBB2hrAQ7l
         3CrEJ+oBh/3+Oybklwab0Fcb6l06kFshVN0p4dhlGUA5t+rGxnyErmDuZGVZzA4AQkBH
         SjOtbxJhPvTz6V1/EmEgDzdK+B2AXvP34jbBBIL6yFI6DL9+XxE4aA7FP0kHY1C1Xo6d
         0WU1k32RvWkvXb8negDrmr9nbttjr0qOp3YpffzAxy0EzXyQnURUYRSkgye5lSmkI/Jy
         W1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+P4ia93LhSu+lP7GMSkhv9Sc8m7veE5fgntwYlKJ/sg=;
        b=Qd+p211zLGm/3lMFkxxDu+P0vzld0VHML42nLkiPP3DgdgLTCiXEMom456S6JQSZsk
         2qEw+rDmR0eNtiJ9EK1N7d6CP5ko8Cxdb3tHjTtmcumURdKq1OBQZCuJRPw6UtnUQ5Jn
         VtnrNG7gPsJ5KiptP2VPLztDqCqPHBWSiHjdcdctFUh9JlmqlCPjLk4FNIMm8Jq+bDDS
         uTCdsElDh07Z0Iqajw3JTyD970Xl98jEfJHhI5NyemPAFyIqE8wQWTebR5JcWdSARpdN
         lgHanzRsKpasavl4t5NNGmr3FgzQPwUbNUFhsDle3YKDyY+xI5GurnP3HfVqRHo4nCAK
         Punw==
X-Gm-Message-State: AOAM532HXvdp8OlQDLMbSlskycCWs7xtIfA3ubnU4PCt7WIu+5WSoJq6
        YUxL64i5OLR9bGARaN4f17VJszPLrUo=
X-Google-Smtp-Source: ABdhPJxHpoPt/yCplYcvHIHIkdrHIlGeZFdG+4/PR7SwTMSpfUAxQ2f5M4lVhKJSewMiVyqTIXiloQ==
X-Received: by 2002:a17:90a:d795:: with SMTP id z21mr3800492pju.56.1603399863915;
        Thu, 22 Oct 2020 13:51:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id kc21sm2890803pjb.36.2020.10.22.13.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:51:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 1/2] dt-bindings: phy: Allow defining the SATA AFE TX amplitude
Date:   Thu, 22 Oct 2020 13:50:55 -0700
Message-Id: <20201022205056.233879-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022205056.233879-1-f.fainelli@gmail.com>
References: <20201022205056.233879-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document a new property which allows the selection of the SATA AFE TX
amplitude in milli Volts. Possible values are 400, 500, 600 and 800mV.

Acked-by: Rob Herring <robh@kernel.org>
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

