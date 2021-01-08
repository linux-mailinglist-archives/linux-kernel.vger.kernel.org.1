Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114AC2EFB6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbhAHWvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAHWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:51:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3985C061786;
        Fri,  8 Jan 2021 14:50:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g25so7545145wmh.1;
        Fri, 08 Jan 2021 14:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCW93FwLsL6N6oiIX3yAfaWwuZ02R+spflo+eRFZf6w=;
        b=QPbNGB4k/GYs/E+8BuvBqbkPJsIdg4u0T3aqxjPuPXCABnHM3NDUaTaHJvP0FPNd+N
         zljjqTh+FkP0DSM8a0n5tqQLCndRStDKEOeV1KDWNSWbH/1JBCG9hfWfkztrUjMaieM9
         c7rHvOqdeFUYyJNkTpT3RXSqcf/pLSwVGlJuLSs9NY7wly7EyyFAhcn220N4e4OC6Fu2
         iPz8AAkCJ4m8j8Q1MzxTOrpYxH3U8FEt422OBo01o3ZFo39F35GRVcJo/OU2hFVBh5Mh
         iS3jXXuopazdgp5hJKS1+g9/mibG4QP4+8TTKbOTLuRQHg2pxSeHvtrbk7xs476MeDrb
         r09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCW93FwLsL6N6oiIX3yAfaWwuZ02R+spflo+eRFZf6w=;
        b=J+ggz3gmihQi8nMNsNl2e4QF+JFA/J63Ahgfk0AghM2dUuimVDQj4uBq7F5YPhGrLJ
         LAy6T71hrRhqAUchT9DDNKX2IzvPMPvQYr5O7MaXdLcAx7avasL1BUYEKinCrm2XsCMg
         uYsBVjNz+eF3gCFyL3Nc+ZHAel8Sg10B2BAnuDZZhyzyRj7eSyo9VwS/dELa+NxW3gQE
         Qgx0AspeMs7mV30qEJ1iZQVhsz/E5CuXzkigkLWZh+Jbtt5JYZuNBdU+N9Vrj45K9kbQ
         9sGm/lzZtZelWFQ7ojlL63wz742mAWzL5uwHJGqzzOz6rEYxEZw5M6wY3hG7vSSkfPB0
         /eeQ==
X-Gm-Message-State: AOAM530XRHfFqmfs60jygUVdrJJG+IT4mkE9WKSLx/EKjb71U+iiN773
        qiz+WRaJeRNS8mahTqBmMvLZ6UegjXQ=
X-Google-Smtp-Source: ABdhPJwumdwfKYVp622MpKu+ZHSaDqMdi0tyJXdK9G4yeJ1HCpeGU5NB+G/XS+WnBuzKO+hbMLjwEQ==
X-Received: by 2002:a1c:7d58:: with SMTP id y85mr4886405wmc.50.1610146252713;
        Fri, 08 Jan 2021 14:50:52 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270094076597458eade1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9407:6597:458e:ade1])
        by smtp.gmail.com with ESMTPSA id o23sm15900644wro.57.2021.01.08.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:50:52 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 2/6] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
Date:   Fri,  8 Jan 2021 23:50:02 +0100
Message-Id: <20210108225006.153700-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108225006.153700-1-adrien.grassein@gmail.com>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nxp,phase-shift is an enum so use enum format to describe it.
Minimum and maximum values are also wrong.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 956156fe52a3..095cfdae7b67 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -73,21 +73,11 @@ properties:
 
           nxp,phase-shift:
             $ref: "/schemas/types.yaml#/definitions/uint32"
-            minimum: 45
-            maximum: 0
+            default: 0
+            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
             description:
               BUCK regulators phase shift control in degrees.
 
-              Listed phase shift control values in degrees are,
-              45
-              90
-              135
-              180
-              225
-              270
-              315
-              0 (default)
-
         unevaluatedProperties: false
 
       "^vsnvs$":
-- 
2.25.1

