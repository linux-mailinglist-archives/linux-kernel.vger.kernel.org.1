Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6492FBE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392169AbhASR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbhASO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:58:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFF7C061575;
        Tue, 19 Jan 2021 06:57:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c5so20020859wrp.6;
        Tue, 19 Jan 2021 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v1fcpvnUYPI/nQja+D/H69Nwe6mpUxULCJd6j/AG/F4=;
        b=Byg8/tHEodzmLL86FpTJLixTBpbHAUztcvN7SPKf8dz4tuMZufNgeLi82a2mLrrURo
         NC9XYjeHhd50imztA6ghDQF4J9ZcEWH4hSX8PVfF8siXtvAxMbRUFZnl1jzirqdFcNSe
         n873a+o741Kpvhzya/CnMmSRXURQ1L8xBHlFTRupYlvrPiTXwEnGoYYxI6V1OIerOePN
         eBP5pb5kRhKtxdgknSGldys243eZceoDNcPlQnUj1sCap+RIGPO+l+Q6FTdTIcpzI4wg
         YUQ7pYVmJWdbbi11t3smnWhcGQqytj8mhx1sJSyacw2K11oyYOZ6kkbgZFSSyiDTj22z
         fFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v1fcpvnUYPI/nQja+D/H69Nwe6mpUxULCJd6j/AG/F4=;
        b=QhX2sKjJ4B40UigAtxz1MaT5QpD0K12ApHxJRP1FRYL0rWwckZwRHg4oY03VrxKlMH
         L1077O0nPJ1oPzMmKaHU/oMaTYoaXlEqB1y45HoWoIxbLqA9w0XI8E5jauRIIytkj/fB
         hdAd9R/8HhztlqhVZrZ9vO7zFkD4gP2FZkF28oCAKrkPa+E+BFT9YOatKP/RxDY4PiQT
         xJ5/82XzhtaSM0ts8z8vL3uvwGGng6CAD8vbu4CLcOL7gruORU9csFBJBHEyQMZGyQEF
         WnK6y9uHh5/CGqud1ODjn8lmdC3Ww+YfhbTJ0Lt+iAzw+DakmHXt3UW9HQX0nDL4NgVE
         THvw==
X-Gm-Message-State: AOAM533OiZAKbeoY8k1/ECzeaWr5QRLkYkuB4RvLaiQAd2a48WzgY3Zb
        pD3Z+wGM61xQ3yEDv/3HBOo=
X-Google-Smtp-Source: ABdhPJxYxibfTIpBNikpwutwBO3WkgharOYrPB4r8vQJGAxjzMjogW9/ubDSI56HVXTanCGLeAA2Gg==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr480940wro.98.1611068260925;
        Tue, 19 Jan 2021 06:57:40 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id s1sm36786893wrv.97.2021.01.19.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:57:40 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: add support for the Beelink GS-King-X
Date:   Tue, 19 Jan 2021 14:57:33 +0000
Message-Id: <20210119145734.12675-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210119145734.12675-1-christianshewitt@gmail.com>
References: <20210119145734.12675-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
board with an S922X-H chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 3341788d1096..6bef60ddda64 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -151,6 +151,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
+              - azw,gsking-x
               - azw,gtking
               - azw,gtking-pro
               - hardkernel,odroid-n2
-- 
2.17.1

