Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BD2DB7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgLPABU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLOX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:57:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432CAC061794;
        Tue, 15 Dec 2020 15:57:19 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g25so867152wmh.1;
        Tue, 15 Dec 2020 15:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VTRHWDF/2KFgz+UyGUwNoRUZJFyka0YQ/YywpJD5p8=;
        b=dBA6fWPWMNAwgaevOTUZw8nmjr+yECDlOnqFLRrntM4nXNkH2WJggWqWxwJDVyIzoE
         BiIj3bvHoAoycxej5Kw3m9Zp4AJ5J0JYgkTWhdm9pJDLpYMaHWd4nOeqKmeY6Lat2EDU
         8p42PoMbqxc5AmTVCIIOr6s6kCmrpWxGVCRb5kZVi4oSlLyPSaDQwL/oG2m22xScpMHR
         m4FJJ+PPoPVPIC20NxP8VQgWIjcQXnATiezxPm4zM0/gdfdRHbPkonwQK/BgiX+zrja9
         dmW1QEV+dThWsisF4/9DR170hr4mRNRur+3O4DgunEJc+LHBXNDRWLC2Lv+nkJHxkBkM
         kv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VTRHWDF/2KFgz+UyGUwNoRUZJFyka0YQ/YywpJD5p8=;
        b=kdyyoa509Iywl0Pvy2NVbBgmg8Qd65Zdh2FoZzp1vLfl3kU11K1ARBCLZs5CxcvrfX
         JtDGqXrge7LIRoOqbuktsE+sLwSHiIAeqby4PQEoT2TOK7PVvS26W1yd2OaSSovgeElw
         xQIrMH8KbuZggmnC1TjgWDyzkVii4MB9nbuzjgXh3a+32tpOtqm/tdftA84RgdEFKa1s
         D3fFSDoYb3beEi9ZDyDZPQ66mLajZUTE26159+eXLvL9i1V2Eht+B0Y4KUYskrpw6rt3
         glRR/ygrmb423hfxVwC3N9r8RXdupkjpSQsM8+VOUR36iQLPSTR7eusE2Z20JLWtERm2
         cXTQ==
X-Gm-Message-State: AOAM531WIo2I4iPCliL/mf8l0s6ef3Mi9XwE4Hhkf9pC0IpJvubY06nY
        gqTjVEJGT8K9qcqJWuLTf3Y=
X-Google-Smtp-Source: ABdhPJyo9tc2O4SNvpKV6vYv7g3YRUn1zOLcY9RcMdiwSbpEsHkhWaEvLjOsJ2ocBu8oU08INFQ8iQ==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr818996wmi.91.1608076638066;
        Tue, 15 Dec 2020 15:57:18 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:57:17 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 3/7] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
Date:   Wed, 16 Dec 2020 00:56:35 +0100
Message-Id: <20201215235639.31516-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215235639.31516-1-adrien.grassein@gmail.com>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
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

