Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FDC2248CF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgGRFBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 01:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgGRFBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:01:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E69C0619D2;
        Fri, 17 Jul 2020 22:01:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f18so13163379wrs.0;
        Fri, 17 Jul 2020 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EfRpQHmTESiZa6dhnw2iqpiFLGjitNFlRILsGoZarsc=;
        b=dIll9+b0ojdGaPeKMBKId83+B8KbMveTAmCWS1sIQmbKhYv8QwbEcBX88GtnAtcDKv
         FUoewwWUnKer4iV05EGQsLinBue5HL6U3sa3SkxirQYiFaLEPnWGGMjqM5e8CYhve+JS
         ix6Hk77ztollOD1W1ESVneu68fgPsY64nA3lRp9oyT3QQ5Celvfl8a0acW3e+r7EmjBw
         8cJc7YYUhQRhKjQZBc17hsOOx5t01JHiPKQ70IYwT4vek02kRYfAtXE9p0anP+h9y+Mc
         +SZesfDtM7OHablnUiOHNlNunhjbByEecKA1j1qoxm/WV2WoIr5mYC4HA4OlQ4I0oE8n
         c9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EfRpQHmTESiZa6dhnw2iqpiFLGjitNFlRILsGoZarsc=;
        b=eHQc1AChJPZGLkEiNl1iLQ1ak7PxSdmRQTV2FnGkhFmYEbVGOKb0JyZlckfCGgBSdh
         r2QGHFlDA/V2hSX2PrwAynn6TYJ8OgRxlEWXYqdvlo+45kC5R9hJ7VscMLdWPF90NnEK
         PRMOCejynWHDS9dVkCeRau/WBSGROiOfwp8sL4u2uDIz/r7YfYqi/benj/3uTJJxb1yy
         bWw+lHEcuwxvepeIuo/vy+UgL26ML1uI7E9SdtAZTwUngVX4S+2X4oB+/1lt3AkEqb9f
         8zOqk0ceCQKJp2YIM3M/YeNGzWtzaNcMrN4Zmx3Q0j1WBcgpUBbrWP3+XhPyjqnmr+o7
         NHTw==
X-Gm-Message-State: AOAM532INpL/lzv1ppolbcC/iElK64k1lR8vXxSdjWpIM8Je7TYpNZar
        hYRtjnUl9N4MN6Rec+SyuYA=
X-Google-Smtp-Source: ABdhPJx/2ArNMwm6dr01jNjTNfwVaYpjTt1gM76uZewiIW0Z7JUdHnjE5jkMaZ8Q+8Ht+cjuxUblGA==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr12728799wrs.287.1595048459891;
        Fri, 17 Jul 2020 22:00:59 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 68sm18179815wmz.40.2020.07.17.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 22:00:59 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the WeTek Core 2
Date:   Sat, 18 Jul 2020 05:00:55 +0000
Message-Id: <20200718050056.1713-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WeTek Core 2 is a commercial Android device based on the Amlogic Q200
reference design using the S912-H chipset. Specs:

3GB DDR3 RAM
32GB eMMC storage
10/100 Ethernet using Realtek RTL8152 (internal USB)
802.11 a/b/g/n/ac + BT 4.1 sdio wireless module (AP6356S)
2x single colour LEDs to indicate power
1x power button
1x reset button on the underside of the box
HDMI 2.0 (4k@60p) video
Composite video + 2-channel audio output on 3.5mm jack
S/PDIF audio output
2x USB 2.0 ports
1x USB OTG port (internal)
1x micro SD card slot
UART pins (internal)
IR Sensor

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 378229fa8310..5eba9f48823e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -121,6 +121,7 @@ properties:
               - libretech,aml-s912-pc
               - nexbox,a1
               - tronsmart,vega-s96
+              - wetek,core2
           - const: amlogic,s912
           - const: amlogic,meson-gxm
 
-- 
2.17.1

