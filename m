Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958B12F8F86
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 22:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbhAPV4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 16:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbhAPV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 16:56:13 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3DC061573;
        Sat, 16 Jan 2021 13:55:33 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d13so22170386ioy.4;
        Sat, 16 Jan 2021 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpCvkHzpZP61955aUi+AhO8oazmglG56bzhfKCazjxk=;
        b=bdSuMeBqz1oGDvNCPwwtJejUbU5B8R5VnhxUFepoOwA2DzVRsAxZGPSz33oKuEciXv
         iJyRAeejHf31KEwq0Z2uOUturS80dxFW0PzZoNuGsZBiSJ+3toTILhM6jV1wMjyQuJXD
         I8GGEY/TIpmhGmGoqgtL2l8SQ0kb61Jntczv5TiUBWx3OG41J1ZaNuDECXOTTCCqfFsh
         FyAZLWThRUqjy4kV9rFcDOR5rvPwIHQnSRlr2UN/NKWRIrmCQ+ZABRNU1V9nKDDx2Uxe
         ZKJO/l3gkF8VVn6r9gZJbVJgDGx6f75UQFrSNmBIgplHda9Hv0QqieibjyjxGMh/hAGz
         nxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpCvkHzpZP61955aUi+AhO8oazmglG56bzhfKCazjxk=;
        b=snOgA2htR+XICE0UcyWK2fzO0rvoXBVYdpFblLaSYDrNGU87tYAegcE5d0qenmsOmt
         G1j9Srhf01JitJEGpmILygIEudx2MufBOwvm0s//F/UcqU2TIHvfVc/jNDV4ZUIclPiX
         HyXJLDD6ncdEKh/NzSVzt6cT/IibNEKX+Jil5WtZEUM4/TX+2VI/hdFnSNBQM1aRCsYq
         Qwp9G8l4YSg68ar9NAzj34jDDDzJTBHYqUGUNdf4CkdGjarJdSV8rXHv1vyaM4OZLKJ5
         hVIvwAwXDYx0gGQppTwqryMOKRJqj913tmLkTgWSJAqP4SDGZgtV40jjwcICtGFQJTux
         0BVw==
X-Gm-Message-State: AOAM530mAmCXKrQ0wZ5YjNpyidWMQ9nFb0rUkkwpx2EATzZWxpqCN1lb
        TzUUxzTG1DMHotk46vUkRIFoSH5K1l5+3g==
X-Google-Smtp-Source: ABdhPJwR7K2ntzwTHIiqpPIvh+eO+Vlz//g9La2dGYjW/R4YHFh2viSn88xVFFxXJQDr/6ipJLO0sw==
X-Received: by 2002:a6b:9346:: with SMTP id v67mr12687442iod.108.1610834131989;
        Sat, 16 Jan 2021 13:55:31 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e50e:b7cb:7c2:91f9])
        by smtp.gmail.com with ESMTPSA id r9sm7544300ill.72.2021.01.16.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 13:55:31 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clk: versaclock5: Add optional load capacitance property
Date:   Sat, 16 Jan 2021 15:54:50 -0600
Message-Id: <20210116215451.601498-1-aford173@gmail.com>
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

