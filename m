Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382962DFB88
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLULc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgLULc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:32:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D29C061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lb18so6007813pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6R6A8Etc8hyt0q7ACP/cUsk4p17+yJdkd6xu17NqmR0=;
        b=ZgKNM68KFkvDjNj+DNF5qyZmgu01Wjrdtuow549ln51MMW9uTaStpu8Mg6IcltBLkp
         2A9E5po+P9xh6+mNNu9lJa30fa0cTZo9tSFC0OluMQmqqynW2CB12l0GmcXxvqVeQqfL
         /vegrwvJlapiIAXMpWoDTJ2tZ7SleS1ojf9pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6R6A8Etc8hyt0q7ACP/cUsk4p17+yJdkd6xu17NqmR0=;
        b=PdfnlfDsgiim9zOusmW7QbAkCqATXQZ5nbTgT5A1AlKDNmjWPJtzRms6nEPDSw9b31
         cmfURUGKgfyRS3NtFTzG65gWqbHobK9O9vskFIJEaLyq4GNyNYWIMkc1v1ApAd5SVZVu
         lBPC61dl9H197i6/gzE1S/EDIoAWHyzKBe5Bv9pA6UFFQzTpHEuEnvgpXyxYAaKYuSxh
         eObA675yJGwOgkvoVQDX17bCbFJ+GmaO1Ckf1j4p753/PIPxufxjPWYBPxZoKQfpn8+8
         E36c8nN65uOhxTDTo6z2fNs0a4C3SNmAA27P1i/i2o6IxNHe8nq37ruHPoDWXq/Y31zR
         WhdQ==
X-Gm-Message-State: AOAM533qzoYOu/l/u6fLdccWX8ki3neZ2Pfh19SmgqsxUy9CMW/IIM/g
        JmBha6TbXm7AwHJsa1T3tfNdMtVsWjggT+xI
X-Google-Smtp-Source: ABdhPJx2k57ZZyVOmRB8LiENmcfg/+eFDdN2OHq3HFCN+xe3wKNpsJQABJKk5g/QdV36Dcuf9de4fw==
X-Received: by 2002:a17:902:7292:b029:dc:ac9:25b5 with SMTP id d18-20020a1709027292b02900dc0ac925b5mr16252531pll.2.1608550333484;
        Mon, 21 Dec 2020 03:32:13 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:b9d4:ed90:a69c:2530])
        by smtp.gmail.com with ESMTPSA id 197sm16714859pgd.69.2020.12.21.03.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:32:12 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/6] arm64: defconfig: Enable REGULATOR_PF8X00
Date:   Mon, 21 Dec 2020 17:01:46 +0530
Message-Id: <20201221113151.94515-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201221113151.94515-1-jagan@amarulasolutions.com>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PF8X00 regulator driver by default as it used in
some of i.MX8MM hardware platforms.

Engicam i.Core MX8M Mini SoM is using the PF8121A family PMIC. 

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- updated commit message

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fae83673c3c3..e952c76ee970 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -594,6 +594,7 @@ CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_PCA9450=y
+CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

