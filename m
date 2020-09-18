Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1A26FAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIRKuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRKt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:49:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537BBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:49:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s65so3258693pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6W9k3ndaa9cRCwcQ1M/asEuo1OK8FOTIyDJ+tvTfSmU=;
        b=n2ydSm+7ddUwC2Ld9ZS1KciG6GPQvVJj/GCzCnVuylYK7y5jH/cv47ZNeJgab4lyRX
         Eulik6P5RMjcTYvrE2870Kq3B31FifCYq6VZHHo4SI79NUzqc7omtxaeO+79cu+XojAN
         fsLXtvXzrrZF1jWefDNCGCYF8zB58Ye70Qtks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6W9k3ndaa9cRCwcQ1M/asEuo1OK8FOTIyDJ+tvTfSmU=;
        b=r8bMGyyjdfWQzpWZyK1q05Lcc7V6h11NNKKquQNrRO/Z84T8eV1FNCsNpLSnrMfSc3
         UttLp1nV7wohIW09crinYEYx8yzDo7i2KQPVSr5bxDHfJA82ZVhlGOJNQ8TjgN5Y4eXE
         TkYQ1MdgdtdPtYCijHjDYzgvE+bD/BncalugUO6aW/axHPytirfxX+RzOU51bmJuW6pI
         d21x8lnuRT067AzbtDjckXAIcYD+Ww9GqreHMq4Tqt32LdXGFeBFfBx8NBIRxZTehivY
         +qWGW3QBEESMH5U8CbUFnHZb9+pQCtQatJBQaI4svUb0glfJKWO6ziRCk6tD3n5In7/8
         MgHg==
X-Gm-Message-State: AOAM532uY+FCEGrC+bK4JoaloIiV22a1uKmNm7/D3Dawi9+yOiHRkTTe
        3IBAs7Ad2eMa8joOVkZNe+XJqQ==
X-Google-Smtp-Source: ABdhPJynwrKmtSuRYqDXyegk2R40XjWezA9fHh5970NfD8b9O6/r4n09jzKoHCriDD+Jj3q6Wtr+hQ==
X-Received: by 2002:aa7:9522:0:b029:142:2501:3986 with SMTP id c2-20020aa795220000b029014225013986mr15493774pfp.75.1600426198861;
        Fri, 18 Sep 2020 03:49:58 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id 131sm2857634pfy.5.2020.09.18.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:49:58 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, mark-pk.tsai@mediatek.com,
        arnd@arndb.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/3] ARM: mstar: Select MStar intc
Date:   Fri, 18 Sep 2020 19:49:47 +0900
Message-Id: <20200918104949.3260823-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918104949.3260823-1-daniel@0x0f.com>
References: <20200918104949.3260823-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek recently introduced support for the MStar interrupt
controller that is also present in some of their chips as well
as the MStar/Sigmastar chips.

Almost all of the peripheral interrupts go through an instance of
this controller in MStar/SigmaStar Arm v7 chips so we want to select
it if CONFIG_ARCH_MSTARV7 is selected.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/mach-mstar/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index 52744fe32368..576d1ab293c8 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_MSTARV7
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_HEAVY_MB
+	select MST_IRQ
 	help
 	  Support for newer MStar/Sigmastar SoC families that are
 	  based on Armv7 cores like the Cortex A7 and share the same
-- 
2.27.0

