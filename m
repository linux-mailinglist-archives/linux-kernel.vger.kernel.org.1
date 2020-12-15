Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A342DB79C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgLPABP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgLOX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:57:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18F1C061793;
        Tue, 15 Dec 2020 15:57:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w5so17756414wrm.11;
        Tue, 15 Dec 2020 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FuWKBbuI2QrcYow2jw9wMk/c4blHSJRjjF++nhJIH+0=;
        b=jVWCsPWQf7rWLMvDh8kIUGDNt8L32T1n9qGA+WLNP3W4n8CfNJt9aasD2fcI42DFA3
         xE89PgsvQqXa0U6g9ohboEPzW0aU44+bqSZpwrYfaBXjKsMhIEvUK2AUKuuDmkr61i8Q
         JAXNfzjigowdOWuSTzbp6SK0H3dBfTaB/9I8S5Hsu6ZYUUaDV6AEh29w9wYC0J1U/j9c
         LsHU4v8NhfRwQSy5HB/rj0dfing/NNyjSkEFs7uC7y+WikHt1PavBtg+N8Dqk2Jb1XK7
         zOYMLLZjuY+5OKi5HcTXeR2Nwj7aBGu0+Iw6CU+txeyq6IwxUFmKeAeOw/ZqwcX1mRxB
         OSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FuWKBbuI2QrcYow2jw9wMk/c4blHSJRjjF++nhJIH+0=;
        b=swxKRYi9SL7tr6H14ilLzYasE4aBMWlZkJBVLbhzKI/gNVuOrUkcoJxBaDsniZ4+cd
         mJRWrEg0hOvnIyLvSUdI4XJcE15HLTrxLT4ZwTpHyoaWwiWe8kwCjsrRTEovyckiPpnd
         6s1bpC4x74lHRHyDFwYflMIIbiqhjH8bKBJlKiPRPYeHihtK7tCj746UZuqT2DvlHUhE
         TTk7GBbpml2zD93pANAxZYop47LxQO0T7NYep14nw5rD3M+5zZMH5XfP8aDTmC7bIa1n
         k8mD5/y2RpT+/gFXqriI5uLqgUE1ufL0L9kvwaK0lDfIHF2xOvlIdn7FDlqJ3TodXev9
         NILA==
X-Gm-Message-State: AOAM532KYbb6n6R4EtNDE6E9oopzYTvQtjlhIoDurI0bL1tx6+E57n2s
        DQZh+JSOzS8rdEnOMBJ1lic=
X-Google-Smtp-Source: ABdhPJwnQzvZbMTp7pMulecS34pOFMNYtngKhS0U0zjzspIo5p/ft0OZrl/87B/1VDeH34E+7Xgkpw==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr37105151wrq.189.1608076619501;
        Tue, 15 Dec 2020 15:56:59 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:56:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 1/7] regulator: dt-bindings: remove useless properties
Date:   Wed, 16 Dec 2020 00:56:33 +0100
Message-Id: <20201215235639.31516-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215235639.31516-1-adrien.grassein@gmail.com>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

