Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33B82A7CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgKELSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKELSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:18:32 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:18:31 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y184so1699091lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xr8Etnt0om9PsOUNVkw+aXNjAauI9wTZAxVpVWoVW5Y=;
        b=nrS+R7zQOGNIad0W4DCyUiMbBDhaOzjCBxiqWijzOwMYLqIxVXgJqSi8mPf/pWcDcD
         44ZKQwxpOg8FwfTrtIybebGzTwH513EZ4cZ8xis0+MHUeNnN62uwc1LBqjwAvI7MRPFf
         tWbULl5zBObn8wCW22OVZGaqdfnVG5PdwMefNSVJhzRPx53wBiHQg324TI/EW54WpcV2
         lKu+8/BYUVYthmr83c+qEZo8c66aY1OE4TkxEMCh+5pcTvEMXveJrmo6w9HN8mutufYV
         PT9heWL6TEYC+odmOJNXQTcj/D15RacQ8pbwBZCOHEbxS9bV1PXj7IvEZ8lYr89shX2q
         SByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xr8Etnt0om9PsOUNVkw+aXNjAauI9wTZAxVpVWoVW5Y=;
        b=JOR6wNuWp4cGZ8cdaxa10hZ20FX2eBkzJhh6T3rY2dD1SiKUOK5358R968rEznDOh7
         9XH0lEWQv4eDQ3HtpeYDspRroYUZfG5M6kkBQ98LYA8Jpo5kPNEJ55K96hE8pku3lOC1
         jxdBr2Nt2kA1n1hPzJHF25Bq2q2+8udWOWXGiTZJc82zYcD4HmO7gwC0c/lVQQyUmrCa
         QXI2HVv2oAq4VE5jL/ilqTuaj/Qx0xVlkEt9wPXR9JtTesE58Es4iRzhB0wyMehjHqH4
         d5M8bXHUon4gEW9mLfQiwf9jl4LX6JErTx0Sc+lCmt9NzuyvjMc2EM/6ag8r959jcJQt
         aJRA==
X-Gm-Message-State: AOAM5334FDljslzPGFXm4zJY2xff1C0tZv90nAPivb8iiymeM6uXVHgV
        42vfrqMuSZCbl9LpPZqBhHlu4w==
X-Google-Smtp-Source: ABdhPJyO99WAJFi3WIONOHNT9vEfbRGdCrmUs6rmtjq+pR78LYGw0yPRNFM6c9YX4nfQf/QssU5z6g==
X-Received: by 2002:a19:c212:: with SMTP id l18mr747517lfc.399.1604575108659;
        Thu, 05 Nov 2020 03:18:28 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id j17sm6066lfb.114.2020.11.05.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:18:28 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: dts: freescale: fix typo Makefile
Date:   Thu,  5 Nov 2020 12:18:23 +0100
Message-Id: <20201105111823.1613337-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to do 'make dtbs_install' the following error shows up

make[3]: *** No rule to make target
  '/srv/src/kernel/next/out/obj-arm64-next-20201105/dtbsinstall/freescale/imx8mm-kontron-n801x-s.dts',
  needed by '__dtbs_install'.
make[3]: Target '__dtbs_install' not remade because of errors.
make[2]: *** [/srv/src/kernel/bisecting/scripts/Makefile.dtbinst:34:
  arch/arm64/boot/dts/freescale] Error 2
make[2]: Target '__dtbs_install' not remade because of errors.
make[1]: *** [/srv/src/kernel/bisecting/Makefile:1344: dtbs_install]
  Error 2
make: *** [Makefile:185: __sub-make] Error 2
make: Target 'dtbs_install' not remade because of errors.

Fix typo in imx8mm-kontron-n801x-s.dts change file ending to *.dtb

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/boot/dts/freescale/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 876bf484bbe6..6f0777ee6cd6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -32,7 +32,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dts
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
-- 
2.28.0

