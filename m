Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CB2DB566
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgLOUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgLOUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:49:43 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED70C06138C;
        Tue, 15 Dec 2020 12:49:02 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so488639wmf.3;
        Tue, 15 Dec 2020 12:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FuWKBbuI2QrcYow2jw9wMk/c4blHSJRjjF++nhJIH+0=;
        b=RZxgSOhqmUdTYzQNcp9NnMMBuzlHHZZ7Lpwh2ZpLm36gUDqPmA4cTMblOnE7CuUPwA
         xafKpEZRSxzM4eOQNX5v6ePXL/ZZI8MvPlNMlp1MdSSvJ/r8FPqxgjiSnpt9NONkOWnW
         1sU7uBg0raXIshnn+mqRsVSTKJ/uf7RBlMWL1LkzykJ08AcxmRcBF5lf82deof3X1psF
         DRh2qZCZotc4WQVFfELoQVLMcGV9/FcYdihdc4rj8a52umtkaYMRGmsulZ8xiJpFiec9
         BGqby1GQl8IqOi9MmKrfdY6LVKbT4g5QAsn7+yhX8LXnHBn0YfzTGHaevQedix2JV65b
         cmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FuWKBbuI2QrcYow2jw9wMk/c4blHSJRjjF++nhJIH+0=;
        b=gibWx2vSDkuPWt2E7irvaf8z00QAbjwKM9Sd45Ow+R6c0+XPiUc90IofdfNgsWMQOF
         dKOpl2qQPpDyhhevhE3HfDnVEifHBtrGI/q950hXOWUzCoO5ymMptyVvFSF4XVIppWx6
         qf8uXz+6GFaKJ/i4JEEKUBnEsF/cE2h7cvZGFmOqtwZf29batbf2/S+zK9k1xXl0ElEU
         ygo3Kkk/XuxVSBQk8ysygHDhCxDRCsJmMv2F4KRlptVKUHlSdiovWKlXtKymnnvgFPrM
         lpp1I5ib+/H2dXck1TF7QvTGx5gDh+LDK2b1f4cDL4PeJbbavk1B1/UlFrj6x/9H6+oc
         uFzA==
X-Gm-Message-State: AOAM53259wfHCrTyCJZXN1zJOFHOIbGlU5DSsiPKhNmbA0W1A2yj1p8R
        1Wa0g+TWjwb2OyIEn1Qu+fQ=
X-Google-Smtp-Source: ABdhPJzB2CiZ/gUPR8e2Y3reValSQRaCquDCIHe4W1ubwsfNBx+0Uo68cgDHC3bsFcX82jwjPgrXdw==
X-Received: by 2002:a05:600c:21c7:: with SMTP id x7mr555551wmj.75.1608065341419;
        Tue, 15 Dec 2020 12:49:01 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id i16sm37199246wrx.89.2020.12.15.12.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:49:00 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
To:     broonie@kernel.org, jagan@amarulasolutions.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/6] regulator: dt-bindings: remove useless properties
Date:   Tue, 15 Dec 2020 21:48:53 +0100
Message-Id: <20201215204858.8186-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215204858.8186-1-adrien.grassein@gmail.com>
References: <20201215204858.8186-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator-name is a generic property of the regulator.
Don't repeat it here.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../regulator/nxp,pf8x00-regulator.yaml         | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index a6c259ce9785..913532d0532e 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -36,12 +36,6 @@ properties:
         description:
           Properties for single LDO regulator.
 
-        properties:
-          regulator-name:
-            pattern: "^ldo[1-4]$"
-            description:
-              should be "ldo1", ..., "ldo4"
-
         unevaluatedProperties: false
 
       "^buck[1-7]$":
@@ -51,11 +45,6 @@ properties:
           Properties for single BUCK regulator.
 
         properties:
-          regulator-name:
-            pattern: "^buck[1-7]$"
-            description:
-              should be "buck1", ..., "buck7"
-
           nxp,ilim-ma:
             $ref: "/schemas/types.yaml#/definitions/uint32"
             minimum: 2100
@@ -94,12 +83,6 @@ properties:
         description:
           Properties for single VSNVS regulator.
 
-        properties:
-          regulator-name:
-            pattern: "^vsnvs$"
-            description:
-              should be "vsnvs"
-
         unevaluatedProperties: false
 
     additionalProperties: false
-- 
2.20.1

