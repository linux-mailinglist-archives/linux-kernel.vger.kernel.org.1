Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF912DB567
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgLOUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgLOUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:50:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596B6C061285;
        Tue, 15 Dec 2020 12:49:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k10so479457wmi.3;
        Tue, 15 Dec 2020 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VTRHWDF/2KFgz+UyGUwNoRUZJFyka0YQ/YywpJD5p8=;
        b=S0X6e589DYTi4PVJkYpf+CDECq0mAL8QkFGoiHOumrxnodJbQXuxKECyUqs1oRg/eR
         WdF6EMGjKnGDTUhfE9N/UDY89v5+JTs+Er8XInxf2qEaoiy+7kSJbO9aRCVbfZgNH8YF
         cGwtXOm06elEw12ofGa5TICaFXwyCPWiwfCeHWm0NIWWROys8TClew1UAVPAZmf2TUwg
         kZozT1nWJ+DIYThDXj7J6jFZwwERPBRs46bqaEINIKPFD86MK4R8kWsDA4z/KRWxEOU1
         c7K4FIkUypm2BKHA6uT4UXiE/T/l5qjN7xNiRYYzefQvPIgpy219VELdyPU75xaUoe0W
         sLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VTRHWDF/2KFgz+UyGUwNoRUZJFyka0YQ/YywpJD5p8=;
        b=qmhcfnV3b/+U6+e5dVnMVueOEX+4Gepi7NgLcOIguhVOsjNFKt7B3XbtN3HBvi6U1U
         nkYgORltRbDP6lihdhwAzx48N2RgMznJ1zeTx4MydFusH1nPijyN5uLLgNEZPxbV0kQy
         QLANemWjh48WvSMpUsaFgV/Nmk1AMb+E9s35hQ88Z8cffMVHzfsyOcIrkNJ7RsgDPLh9
         bZTibpJcBwi9aBvvxN+ooJxejG7H2gd0d7jNwYGctyTrjPLYLU2JntfWb6/mhUB9kBrq
         G7zQoxU027Me+p1fWwKEC9qfKVzCxscsuzRArOJTewA7a8rc3FZlgwoobr3FxfTspVsE
         VTiQ==
X-Gm-Message-State: AOAM530wXVS8UXRsx38bHck4uQi06k6PK4JCHkTowO4HE69QfNG4D90r
        T44A7ZDos/SGXhbvYUPY4UA=
X-Google-Smtp-Source: ABdhPJyBFXIWASCdxuc1OtWoxGR0ElQXxJX9s8HcRjFwanbcpfvIu1sUQk8LOZIK6zs/XO9WHdH03w==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr547422wmc.167.1608065343152;
        Tue, 15 Dec 2020 12:49:03 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id i16sm37199246wrx.89.2020.12.15.12.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:49:02 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
To:     broonie@kernel.org, jagan@amarulasolutions.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 3/6] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
Date:   Tue, 15 Dec 2020 21:48:55 +0100
Message-Id: <20201215204858.8186-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215204858.8186-1-adrien.grassein@gmail.com>
References: <20201215204858.8186-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nxp,phase-shift is an enum so use enum format to describe it.
Minimum and maximum values are also wrong.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../bindings/regulator/nxp,pf8x00-regulator.yaml | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 913532d0532e..1da724c6e2ba 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -60,21 +60,13 @@ properties:
 
           nxp,phase-shift:
             $ref: "/schemas/types.yaml#/definitions/uint32"
-            minimum: 45
-            maximum: 0
+            minimum: 0
+            maximum: 315
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
2.20.1

