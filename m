Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6731926FAEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIRKuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIRKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:50:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A745C061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:50:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so2687231pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SjJAe3oHt3KB6nicp1+OfBnUkZSTnnqwPcXU79zsAk=;
        b=hsBfe8JpIqrtVpXHClIotMnGmF8MLANIpzy47YnQwH6vBh4m7+H9ViOyn968gEo99N
         SxLL4jFxEEzYroPDWKNJmDw70vk074JP8Ht9lc3LmeK2bEbRqJEWmu+FQfybutwUiGUP
         4bsAEROc1iTABId/osWel8UIiNxRZ4mTNLAqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SjJAe3oHt3KB6nicp1+OfBnUkZSTnnqwPcXU79zsAk=;
        b=nYq3AQ2NS3jYD1+M+HavV0O1h6z9spMOBs7J6uUqGlWmlZyPUi4IZECVtqOmJOYqg2
         /awS0kv+P/yta47XIG4OayCEy3ZoAzf52rMzKDwzmECpGajnfHmFle5POfNr3/0CGGmk
         8NcRwZ/7l5IYe8w9gfmshwrVpyv+cTQ0KAV3bPMxUPgSOfj8ck19efDL+QcaY28aPJ81
         VoOBaIiz/o+gRABMkaxcMMWTrI2RJhlG2jOGQaAL8t+ruecDMd8Kptl3v5r9nD19c9x8
         1LLiyp0Wg1/1yoJLvgMoS2il1f8awJYX3v61XkW8lCVYuYinC0Zf7708oD3oUJBDHFLi
         uRMw==
X-Gm-Message-State: AOAM533TVzFy0AutNdr1AzUhobtDjpbIRaRRrEcnbLPC+L2DVkDRtm+6
        Ws2S6pVUs6x3kUaAFVNryMbAhA==
X-Google-Smtp-Source: ABdhPJxyI4PPpjpXADcRz1XOVLqFWT7TkGrb1NIZOy4dGeGDQVLvAEU1rYTOFwezD/vjKjOJCOreyA==
X-Received: by 2002:a05:6a00:1b:b029:13e:d13d:a101 with SMTP id h27-20020a056a00001bb029013ed13da101mr30584368pfk.29.1600426204120;
        Fri, 18 Sep 2020 03:50:04 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id 131sm2857634pfy.5.2020.09.18.03.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:50:03 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, mark-pk.tsai@mediatek.com,
        arnd@arndb.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/3] ARM: mstar: Add interrupt to pm_uart
Date:   Fri, 18 Sep 2020 19:49:49 +0900
Message-Id: <20200918104949.3260823-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918104949.3260823-1-daniel@0x0f.com>
References: <20200918104949.3260823-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now have support for the interrupt controller pm_uart's
interrupt is routed through it make sense to wire up it's interrupt
in the device tree.

The interrupt is the same for all known chips so it goes in the
base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index aec841b52ca4..f07880561e11 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -113,6 +113,7 @@ pm_uart: uart@221000 {
 				compatible = "ns16550a";
 				reg = <0x221000 0x100>;
 				reg-shift = <3>;
+				interrupts-extended = <&intc_irq GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 				clock-frequency = <172000000>;
 				status = "disabled";
 			};
-- 
2.27.0

