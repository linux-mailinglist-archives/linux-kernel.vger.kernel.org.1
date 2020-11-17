Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C302B6F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgKQTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgKQTpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:45:23 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C2C0613CF;
        Tue, 17 Nov 2020 11:45:23 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id w13so31098757eju.13;
        Tue, 17 Nov 2020 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
        b=inLULAMdL/crFcKk/opBy24CIVw5O1FrAWbNTOXuWYPxS7W1sK/ue9rhC+EUcZvv8x
         5oK71otzs3JGFWd3SPpaJyZzCe+g2Af+lbI1sgA9iD90rw8hHV/K54bYfrCnNTLCHdpB
         uR7n38MCdhSdQIQyEdezQ6fVHTEyA15pMbbgwIJ/S55HlI49y0V/45KRI3roAtO84qu+
         4yiFI6gV9z4ZSTXBQNTQIyc4lj3nk32hDXocZyw9tUger/J7P14i6H3/zEJJdxtMARTg
         5aKaPeXDmT41dmOZAWuB37/c18WCDKfK8pdANfnvoFLNwg8X8+If65Uh6awTlUyFgDKF
         nXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
        b=a6OedNFpZ3bu5ofm5vEska87zN5u4n+gxvYfnY70cXGP5cg8zW2xxs8iij1fcWUyWF
         srkjxJvktlv2ogoSeNobS5QL/IuKh/YUB29rQgt0WmkiNALFaUm1S0FCivSROblvjwe+
         59BZWiaGR0YGltMwty+HEso/SrrGzK4jvEhEEKOyD9suExFN1uv3BCEAMQr0bGLYH743
         OEIqI54SP/suKpj8OrK/ifYGH75rED17+c72KcZDpnxpi9GglBkd4i+BS06uCtydBAgh
         VU2vTQBxnsTlbzeEPN/32w7Fl9VMp63Xq18BmgbRGfz9gxRAED9OrrAB4qut3l+WE1sc
         +6fw==
X-Gm-Message-State: AOAM531NBLckSBngyqaU6dLb8KBSKXT51MA+u5cK0/T3snv9WWzrhYoc
        fL3dGqqtEJ/Kv+20WSEEjO0=
X-Google-Smtp-Source: ABdhPJwr+w87CiPQMS+gZT4E2SCcWJAhpf3wLEmXdGSKKFZjrhCgeFmYqXwu6gLajtyK923OBX5Law==
X-Received: by 2002:a17:906:3a1a:: with SMTP id z26mr20294782eje.519.1605642322124;
        Tue, 17 Nov 2020 11:45:22 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm727972ejc.109.2020.11.17.11.45.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 11:45:21 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node
Date:   Tue, 17 Nov 2020 20:45:05 +0100
Message-Id: <20201117194507.14843-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201117194507.14843-1-jbx6244@gmail.com>
References: <20201117194507.14843-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to the 'hdmi' node for 'rk3066a.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 252750c97..67fcb0dc9 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -124,6 +124,7 @@
 		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
 		power-domains = <&power RK3066_PD_VIO>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.11.0

