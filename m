Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2EA224910
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 07:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGRFpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 01:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgGRFpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:45:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52CC0619D2;
        Fri, 17 Jul 2020 22:45:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so2880130wrh.3;
        Fri, 17 Jul 2020 22:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3oYWHEmLW5s7KbA+l575vtPAkEWPi2PPTZYrMFMNqDQ=;
        b=rl90+3WwRZrv/R9/B5pJfTLLA76r1jpsCq5y/2hvR3rfIgQQtX72aqr4C6jru4K2U2
         z9i9D6dmVSJkFJJRGe2PW1BrfewDTXF4ST7Z16K6Lqw3HU3Aafq5U2UxBTNfNzAybxs4
         vkT8nXzXkd7PBTrmPIH0rAcBRkduxh3z7Md9yaf4MAMd+g2656B7Sb66MVPSULdp8s5v
         mZPGOm89Fis2QPrOhskoZYeo3ZT9Qd+0nYQQXu+nyVSVvVJhkbXYso7gv+AJ2wzKkBMr
         oyAsR70Htl9MiM66aqQnoLlF9LJ8QBgxjmdh4rbWkoQwarn9lsfyeywWx1vUNQhZ1tWs
         BWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3oYWHEmLW5s7KbA+l575vtPAkEWPi2PPTZYrMFMNqDQ=;
        b=Bm0GA+FBvGrH2RC+oOchyht4QVmD7NzcnxkVjg2rhUDM81O2dUFo/cz3J3PCW2Wegj
         vMQt8s6CiOGsmSWvqav3i4Zo+vsxTUABqHu4NnYQkC9eINezWOi9xXve3xvLEPzmql3x
         R3Nw8GKgjvaBrnFwh303xtt0P14Xb7+bBasbMQkHQ6dUESY2XMqW81tfCxd5QzhuJdXM
         M+wvku+YVtvPWHjOv9vWO8IJVFM5S4ev/MHZfsIKJSWGy+hrExrJouaCKDKlRcOplgAq
         qQX2DQMB4HpasTmHb89iOAE3S6vrpF4Ooiwv1Pd4Yjtt8nka40UnAo78vTZJ9XrmKR3x
         G5/w==
X-Gm-Message-State: AOAM530rtm0HftSLzoJl3IUehAQMNQSp3CNJHUuGHXCVE5tjSz8BG+07
        1F9UrJi3ZNVsOLIGRLfKzD3W/9d/
X-Google-Smtp-Source: ABdhPJyaiTeH7lXyaFaxsJ1ijc2hXhd94evVQetqFIWG5Q8KwT+medqxNHw8dGjRnsXqi+3Q5EOgQg==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr13075188wru.8.1595051109672;
        Fri, 17 Jul 2020 22:45:09 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d13sm18735481wrn.61.2020.07.17.22.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 22:45:09 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: update spifc node name on Khadas VIM3/VIM3L
Date:   Sat, 18 Jul 2020 05:45:05 +0000
Message-Id: <20200718054505.4165-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIM3/VIM3L Boards use w25q128 not w25q32 - this is a cosmetic change
only - the device probes fine with the current device-tree.

Fixes: 0e1610e726d3 ("arm64: dts: khadas-vim3: add SPIFC controller node")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 27408c10a811..6b75157265e1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -360,7 +360,7 @@
 	pinctrl-0 = <&nor_pins>;
 	pinctrl-names = "default";
 
-	w25q32: spi-flash@0 {
+	w25q128: spi-flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "winbond,w25q128fw", "jedec,spi-nor";
-- 
2.17.1

