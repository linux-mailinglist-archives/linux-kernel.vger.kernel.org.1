Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D42B7ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgKRN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgKRN6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:58:37 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB42C061A48;
        Wed, 18 Nov 2020 05:58:37 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o21so2892072ejb.3;
        Wed, 18 Nov 2020 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
        b=ItuNwInc2MBwj4FPc/vi8+RT3PaxeSvrL0xAoc2Um/9NAI/K/r5esaAf8vYLZvfi2N
         Gn5FdFm8AcWSkuEj0mecew0gSpzUcKx2bY5Ys2T/SRcbCzEslZloWfRO9hpVGkfPdAUN
         e4812uni4BzgCCh4xGpbNRXbyq9JcguzIWoNBt+64GLcVPlTtcMixYIZyjl4x64n2LhW
         t5ygd/OxZWeGUFR8o+rwptKuSqP+1/EAkhuhHNw0Jz3yVtNr1I78EelRvf4MTthuMFaU
         Susaq2zd7AYwogwUmtCBT0TwDkRMqBHNpGjG58LoW+PDY4Nf9gt7ECy3xXxAXeb4KMEw
         DRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
        b=qncbOoiXIPmt6A8SU1ZPUHwLiOjPT/KyTRz2OYNlxEgNDTxwxuyV6+qZkNOorwD3pw
         RuYLUjS8MdSnVWz02Es3PYa9fDM8t3BhrcvVky8xc7f8S8en1Z0iD8egYGdKaOA1id9z
         +H6fP7WuCNaZRQTqp+PwAF88E5aVCPmPwdIuYbjBz/oZkjcjv9UIpI1l4Jivx9LXsJwf
         9kwEkMaJvguJY1NvFUEUQMkZq1fxLbUCqwyKpcqq+iPxy/79g38TiArw0Rz5mmnsKfJS
         CUjpfBRBkNdpLlu6FEjjO7X1NoLO+eijfpM4Or4Vu54hpH09WaGxaNQcH30u/o2Uca2T
         icAA==
X-Gm-Message-State: AOAM533bm4KAjtoHtWtaxO7xpxqbUIhTqsukE1iDMoK2W991lIwsmaaE
        NxxMoBsrXNFjE/I1QRxzTgE=
X-Google-Smtp-Source: ABdhPJy6FxHe0EbiFMLb69ag6/AE/2uHZ1fKsTWtsbK6CS3f8YZgjTZfbNAGLYo8ILiVxlTQhXgfRQ==
X-Received: by 2002:a17:906:6b86:: with SMTP id l6mr24155838ejr.524.1605707915976;
        Wed, 18 Nov 2020 05:58:35 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx6sm13721384edb.61.2020.11.18.05.58.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 05:58:35 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/7] ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node
Date:   Wed, 18 Nov 2020 14:58:20 +0100
Message-Id: <20201118135822.9582-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201118135822.9582-1-jbx6244@gmail.com>
References: <20201118135822.9582-1-jbx6244@gmail.com>
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

