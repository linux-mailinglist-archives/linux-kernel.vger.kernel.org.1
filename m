Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE02F4992
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAMLFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbhAMLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:05:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B5C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:04:56 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q7so1277797pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLHbOXH4nbuBN6h6p0MVX+joNFlUG/98KAoeMAkYOnw=;
        b=PS2Yd6r9tWcUr03Sq0GLtVUZ9p4vz58fFMZK2kbTV8ie8SWmf/zmMkJRNHB+dPeMTc
         Ipy6RcRlujAnAU9ll4E2BWxvhUIMU5eHHDqrhTsUQCbYufTXlu+ZvROEUkqs538UilZG
         cLmw2Fsx63WmQdnQ4Q/c+tioZyf/eo6nVzQxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLHbOXH4nbuBN6h6p0MVX+joNFlUG/98KAoeMAkYOnw=;
        b=lg1sQdkdvDmNhzvrodN2xHIMXUbukzY2hlSo3IJxzCsveAK2wcTD/8jYFm4PHpuwOI
         gHtFg+1n5ND4R0k6+iCNiqxf3RbXLhL/6Ef+6xEiimqkWBgUfFR4jOlymVg7QtuCjSYS
         vhgBWBgHX4dHwq1GCGMJBqawnuPD0grhxsUqKTvZvAgJvo7vplK6OydG4h2gdwPfkNZc
         +kXdsGRoFFAX63JyZBNKKsk+bxSCdza7FCS7x+lBzgpMThZXMV9N9A1oy9xtV0UHnDy2
         zBJive1KgV6TUJs3EVrLtMWS0lm63tX+Qwj7D6krlaqLwv+r1YN9OAdrrCHFFgU4GTne
         nEJA==
X-Gm-Message-State: AOAM530KICEn0XkJ81wTy2EHcfp72iqwC6TmEYKhszyuyg+D8flS9Hh2
        aervEFWfl3XbT1l5CfUYb4++JA==
X-Google-Smtp-Source: ABdhPJy1Nmtvwm+ysoYiBbZxGn74kio6/JJQD7aH5m5K32k4tpZ9j2MayfbF+D31+2yPw/Sy9hZjTw==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr1562711pgr.221.1610535895946;
        Wed, 13 Jan 2021 03:04:55 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id o129sm2114749pfg.66.2021.01.13.03.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:04:55 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] dt-bindings: arm64: dts: mediatek: Add krane sku0
Date:   Wed, 13 Jan 2021 19:04:03 +0800
Message-Id: <20210113110400.616319-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210113110400.616319-1-hsinyi@chromium.org>
References: <20210113110400.616319-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krane-sku0 is similar to krane-sku176 but using a different panel
source.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 53f0d4e3ea982..93b3bdf6eaeb7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -120,7 +120,9 @@ properties:
           - const: mediatek,mt8183
       - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
         items:
-          - const: google,krane-sku176
+          - enum:
+              - google,krane-sku0
+              - google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

