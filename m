Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D474D2FC23F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbhASVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbhASVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:22:11 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B83C061573;
        Tue, 19 Jan 2021 13:21:31 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d81so27469568iof.3;
        Tue, 19 Jan 2021 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhsDZ9UOGRlQVPZEAGfDhpppuCtmEIDEub6NEX0zatQ=;
        b=Zr5XHVmaw52Wc+WMo1h25ZUL5niz/WInKwAdPM7Z/5kNofoFb+V0Av64cKsL1WW4lH
         IDw7UD9D0GW1CMnQT8xQjSXh4Z4T0zyp1RIZQ3lHC7fAtyC6P44nhNHtZlb8vPMhW2J8
         oqNTHHfLCVTUVA0Dyv9S4YHluG10rNhcuAy7rj0GiWBavIQq4HuYggsYCBiLZFI4QIzW
         vd4KiXUcMYvzmaIQBTvEEj9QT4i4/sHznHPIPFvWGld4zqUfmqTqUNrvE5HZ3UjA8hIC
         E2gDIDoprYyJV0ybLTVx+PX1OhEewItciT0FmSql215i480xIZuG19RaFY2daPrq/Hx1
         oaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhsDZ9UOGRlQVPZEAGfDhpppuCtmEIDEub6NEX0zatQ=;
        b=VUiTHQGksy1BJVg8SY3xlqWwl3uIgNpRaI4nrK/qGBGUSz3SF40g6v+XLrROLszxHy
         G7NSsmuRktxUQlnp34ww0AL1YUnLPQ7lwLKncEbzAPoWbDrHpd+7N8CFOIM9LuZyqEMu
         g/QVTHVLv7FmP7xdv/+CFS4BMVtiLnn9dPEO+ahOq6xh+BgA4/TV0JFCSxC+PcmU073o
         EDR52B0SVfm0VZjUjb6ZDFXrwir4sVT43BUq2mJ1ht0Zz2EHYySfkqTT5wWDIiT+lJ+Q
         o17j+ov07Y1sXcUZvHwXfvd5t6YSiUMFJrnWjKvSLtTueacxpFXmjGJZDLNdQWFbdxO/
         zpoA==
X-Gm-Message-State: AOAM530ltVRq7pkKeZu2loDOwmBOJBA7cHPFTHOIEHPEvzL4dSi4dJ6r
        xI5Nngxop36c61fb+InmHKHQko8CMi02byBw
X-Google-Smtp-Source: ABdhPJxPkYv3XDnlrA4ZQLQEQYx6Ys8qNOMb3BoJf6Geppd4c4PWkfCL8uJtfcxU4hqtaLeFcVoYrg==
X-Received: by 2002:a05:6e02:674:: with SMTP id l20mr5146553ilt.222.1611091290410;
        Tue, 19 Jan 2021 13:21:30 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2386:3a11:421c:65a9])
        by smtp.gmail.com with ESMTPSA id z87sm61418ilk.40.2021.01.19.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 13:21:29 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] dt-bindings: clk: versaclock5: Add optional load capacitance property
Date:   Tue, 19 Jan 2021 15:21:08 -0600
Message-Id: <20210119212109.1064786-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two registers which can set the load capacitance for
XTAL1 and XTAL2. These are optional registers when using an
external crystal.  Since XTAL1 and XTAL2 will set to the same value,
update the binding to support a single property called
xtal-load-femtofarads.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index 2ac1131fd922..c268debe5b8d 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -59,6 +59,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  idt,xtal-load-femtofarads:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 9000
+    maximum: 22760
+    description: Optional load capacitor for XTAL1 and XTAL2
+
 patternProperties:
   "^OUT[1-4]$":
     type: object
-- 
2.25.1

