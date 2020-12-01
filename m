Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB02CA42E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391165AbgLANpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391135AbgLANpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:45:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59BAC061A49
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:43:46 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so1125256pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TdRqXYI9+LXautyFSgQZPVbiKxi/AYNw4/5pXTCk/R4=;
        b=RM1NldzBUV9eilnHZx/H3MAmxMfGI28r9EeIMlH6hqjZCvYEFhQy3qUQw11icYoss1
         FMw9JD/wlHbe5sr6+x8tAyfmla93e6MUxcZLwvjqWsmfCsGIfJ2Ch0E6O+eklS6yZzTR
         4gzxI2q6rs+2PS7LC3nZvBkN/Aa69HTvyKO7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TdRqXYI9+LXautyFSgQZPVbiKxi/AYNw4/5pXTCk/R4=;
        b=elDIL/awNlaDjZaTcDCf0e3m05wxjAYrtXVlMm3Pf7wF7Lo4/Abn9R6suOnJp8UlIJ
         MPFK+BwP0glL9SR4ABuhN2nH29LU6jkzN8DufHiAzDQlgX5VuQd7eF5Cnxbs4aqRmc6b
         Grl01VDR+VIxYd3t+2aAjGzrkhz43LdR/tEAXmQtUleWg37M5AiDKPrNSZBVJq0bs4i+
         uIHiAhONzCyz/g4w58LOwsmIjPhqiejWlCNUyZD1u+ZwwqrCWo5+aqLjJn/eI2+D8B+a
         Or0G8NAxH6w/ipsXcD7/Sy86InxivejAwrNCr0ttpjBvJ3+ZvCiroE7QVtWPzuzqChUn
         kZ7g==
X-Gm-Message-State: AOAM532E8JHZ4mxuVy2SrK78wBHOskLtbwdKEH9p1Y5bII3keK8909EG
        M2aHyJiVkc9BewyHLXWtra0ltQ==
X-Google-Smtp-Source: ABdhPJzTIgKg7pAUw9IZNPEUcFY3ziV2gQbl96vChMSNwAgbfi0peMLDJMiAe0RBB4RvEnGDI/f/VQ==
X-Received: by 2002:a63:f20:: with SMTP id e32mr2301093pgl.130.1606830226259;
        Tue, 01 Dec 2020 05:43:46 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id g14sm2839248pji.32.2020.12.01.05.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:45 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v2 03/10] dt-bindings: mstar: Add Honestar SSD201_HT_V2 to mstar boards
Date:   Tue,  1 Dec 2020 22:43:23 +0900
Message-Id: <20201201134330.3037007-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201134330.3037007-1-daniel@0x0f.com>
References: <20201201134330.3037007-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Honestar SSD201_HT_V2 is a full size devkit for the SigmaStar
SSD201 or SSD202D (they are pin compatible).

Currently only the SSD202D version is supported as that's the one
I have.

Link: https://linux-chenxing.org/infinity2/ssd201_ht_v2/
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/arm/mstar/mstar.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
index 7c787405bb2f..61d08c473eb8 100644
--- a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
@@ -20,6 +20,12 @@ properties:
               - thingyjp,breadbee-crust # thingy.jp BreadBee Crust
           - const: mstar,infinity
 
+      - description: infinity2m boards
+        items:
+          - enum:
+              - honestar,ssd201htv2 # Honestar SSD201_HT_V2 devkit
+          - const: mstar,infinity2m
+
       - description: infinity3 boards
         items:
           - enum:
-- 
2.29.2

