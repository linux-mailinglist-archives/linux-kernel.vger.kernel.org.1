Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A32B7ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgKRN6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKRN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:58:36 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CF7C0613D4;
        Wed, 18 Nov 2020 05:58:34 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id dk16so2828952ejb.12;
        Wed, 18 Nov 2020 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cfXI1Q85bb28+McjuHeu3xbkODr0lp86DQ42QSmzooY=;
        b=fdF8xUVo3uIdHc6YyB775KnYhOIlFrGskqvtuYUq0+H0LEDxRf2FSjmE3MejSgdHTb
         8WJWYId6ImRG9GGecYu1B32uSQt7oWDTxH2x+PqtWNUitn9YCxWI0EEes+tXEV1MP+XU
         8D+YacIFqFcQzMWGR+LX6Mc6ITalnds5Ff3PCpT9y487iyq4fM4+FYc0vNpudn6aT1nA
         f/tKSRmWc1iauHA8/2II7cKUJ/ro4adTzpQmNEnWYqgZZVVWV6vKzi91xqrWu/9Z/Wbk
         IjGH8CQrSMvry7JmgYbGqaLBDpacNYpdVh4K8kq5qc3bN/DiIm8VHGvt37d6TGSFQwVl
         vKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cfXI1Q85bb28+McjuHeu3xbkODr0lp86DQ42QSmzooY=;
        b=lRTtTtkKLPnm7v9OJJXN1G4bdnAeLe4UizenXZ5NF2tv0nP3nJv47ojkeNQdHjckBK
         01vanEy45Dhl0YaYygLIBPVtQIiHPHcvF+PdVp9yasRp6L6OPrG7J1PtzliOuTNvsb5I
         cjlCWglvbM64WnJMNFc+Gk1Rc4OlDjqegvXe8BNGDVCrxGPrBErjEXsPU5swiwElXSr7
         0+dbVtwLaOmkhpd1RoG4vQ5sL3Hm++xzOcJy3E3eaHSG2HX+iwqv40eTyL6EbmDDBEsa
         FgHHiM289RswEcfghNM7rp2D0udiwGOebDLwdngUt/b9++3hGQlGN5oN+CTrzKhRZjEI
         32aw==
X-Gm-Message-State: AOAM530MwqGLViaYclTuDI3WbAioKBYKE1JiSMb6vSl4uDlwzNoJQ2/n
        jWL715LX7+MsxzYdp5dJw5U=
X-Google-Smtp-Source: ABdhPJwPUth9fHvvDX++NfqTDXzoOCsJv1H/KeHB1Jjd8310pAuysjnHkPHT+Mln9kBpRXazl3YUgg==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr23483362ejz.97.1605707913682;
        Wed, 18 Nov 2020 05:58:33 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx6sm13721384edb.61.2020.11.18.05.58.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 05:58:33 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/7] dt-bindings: display: add #sound-dai-cells property to rockchip rk3066 hdmi
Date:   Wed, 18 Nov 2020 14:58:18 +0100
Message-Id: <20201118135822.9582-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201118135822.9582-1-jbx6244@gmail.com>
References: <20201118135822.9582-1-jbx6244@gmail.com>
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

