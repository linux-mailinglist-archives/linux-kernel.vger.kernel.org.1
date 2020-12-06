Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201A2D0537
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgLFNev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:34:48 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3D3C0613D2;
        Sun,  6 Dec 2020 05:34:08 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id u19so10821125edx.2;
        Sun, 06 Dec 2020 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cfXI1Q85bb28+McjuHeu3xbkODr0lp86DQ42QSmzooY=;
        b=rTYlIsnBZhZ1gkeFipGqwBYR2ZwA9h+V8hdArOoD/aqyF5pkPdp8UG2LN6I69z6Z8o
         v/qbG4Tg4fZZwxqHLkJYXWphkFevKqRhcDiftdm7cW4FMW5B019iie6IKUAuqmmYoUAC
         0iceP/n6IV1kELlWzcM85oQXUlG0r5De0IpNKYpyCZHCEDp/DLhjlp1GZVhocDQQDnMl
         u2Oz4gy+73Xl0m0TmM47nRaMMFdcR46by+7wcEOQ/GWQwlNrIEZiODOYsEyHFCbh4lB6
         5SQr9x1xqbwElGItP8zmvF7oCyhW0zak8lRn7Iwsp+b+GoTEOWX/A2ymxinWVs5hZywF
         rk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cfXI1Q85bb28+McjuHeu3xbkODr0lp86DQ42QSmzooY=;
        b=dN5VabStjLbwuZDwBpwyklrswE7QsdvfD9hbJxoX6VwHUFX2NhP0Cz7cgZSrIDuUQt
         U4AJjfaHXHfqFevOIbx3yVLGgoaT7kbbmjZ1sxcM9+NJsHZq65KLOnzFLGGgkIy0BddP
         ccCOPkZFm4jC8wfdGVlx8XJuL0PUjvZxA/quHCRRAepnSq0XUDq8CFI1uXPlXyjXYiO4
         7ah+5792IfR2L60YGVwaFd5Ru/h9v8Kl12fPkIauwbMeByWbmTTpPg4ZHO56mXOs8A78
         r6AMN4qAYcyqGPZrBpIWw0gcYySEsKe8wLNNycTYeVPVJtfAg0Z/SMeB6aK1X8Ua2/wS
         agMQ==
X-Gm-Message-State: AOAM532TReAKDTxxSMP7UMvescwXvcJKqbn8soPiWbm43rxAnU4ZaBFI
        Q3L3s+KjiS9uYej3A8nSOvw=
X-Google-Smtp-Source: ABdhPJz+2tgBllNF3mr0DriE1oUWiJyqUX1uRzwk3HN0LdYKtYRiu18qL/KrCGFwmIWGbACXPv7meQ==
X-Received: by 2002:aa7:d99a:: with SMTP id u26mr16355837eds.32.1607261646808;
        Sun, 06 Dec 2020 05:34:06 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qh23sm7770129ejb.71.2020.12.06.05.34.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 05:34:06 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] dt-bindings: display: add #sound-dai-cells property to rockchip rk3066 hdmi
Date:   Sun,  6 Dec 2020 14:33:51 +0100
Message-Id: <20201206133355.16007-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206133355.16007-1-jbx6244@gmail.com>
References: <20201206133355.16007-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property.
Add it to rockchip,rk3066-hdmi.yaml to document that the
rk3066 HDMI TX also can be used to transmit some audio.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
index 4110d003c..585a8d3b9 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
@@ -42,6 +42,9 @@ properties:
     description:
       This soc uses GRF regs to switch the HDMI TX input between vop0 and vop1.
 
+  "#sound-dai-cells":
+    const: 0
+
   ports:
     type: object
 
@@ -101,6 +104,7 @@ examples:
       pinctrl-names = "default";
       power-domains = <&power RK3066_PD_VIO>;
       rockchip,grf = <&grf>;
+      #sound-dai-cells = <0>;
 
       ports {
         #address-cells = <1>;
-- 
2.11.0

