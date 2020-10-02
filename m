Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB1281EDA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJBXGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:06:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41152 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:06:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id q21so3008388ota.8;
        Fri, 02 Oct 2020 16:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8icZj4hEgMYPGnu6djFDfO4kVfOVNNZz4guaeBxZlQk=;
        b=LYEc4yQX4ftZLJLDQwVLJgH4BlYoBgkKMUPH9Y0YIsBUDkNZbsfyy34xtKyfuHbO+A
         HijVPqyLZFQJpQhdJ3adJNw4NB4yvhKCaoUkLBV7pMWBlYogOag3Ed13l3yLiBderfdK
         LFhtfKdyls/s7WiBkCnFtdaRR8xMQMaJlPjb7P3LCBzzicMZZYmfg7SMSkrtTWmx2ZAV
         w6hXcWfJpOXuYh7wtzPxw4PyJjojU2Fy/97afsoLMwShqMBIwVaLk9f/BeCt6UsOU1cS
         uz4A6ty0piQL0MrEhFGBZhGhUEkCgovBmZLeekS2L1N01jbITO7v2TY3MglGYIw8vSv0
         muig==
X-Gm-Message-State: AOAM532TCWczxypwLVQAPryjOVr63/R+nF8e3yzs6PEtrG7e+K6Z5ecO
        FTyDs3WUrXuUdEmIiUpoLTrx3Gn3ztne
X-Google-Smtp-Source: ABdhPJzqW5kwnWc9Fl5H+NJEZFjjiEGfuEFl+J9e2DFX2oL7ZOabri6pCagOQjSVzDsV+ngXjH1O3g==
X-Received: by 2002:a9d:1442:: with SMTP id h60mr3562972oth.35.1601679968090;
        Fri, 02 Oct 2020 16:06:08 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id i5sm743036otj.19.2020.10.02.16.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 16:06:07 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Fix incorrect pattern property
Date:   Fri,  2 Oct 2020 18:06:06 -0500
Message-Id: <20201002230606.3522954-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pattern properties go under 'patternProperties', not 'properties'.
Otherwise, the pattern is treated as a literal string.

A corresponding meta-schema check has been added to catch bad DT property
names like this.

Fixes: e0f946915b23 ("dt-bindings: mfd: ti,j721e-system-controller.yaml: Add J721e system controller")
Cc: Roger Quadros <rogerq@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index c8fd5d3e3071..da3d9ab758b9 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -38,8 +38,8 @@ properties:
 
   ranges: true
 
-# Optional children
-
+patternProperties:
+  # Optional children
   "^serdes-ln-ctrl@[0-9a-f]+$":
     type: object
     description: |
-- 
2.25.1

