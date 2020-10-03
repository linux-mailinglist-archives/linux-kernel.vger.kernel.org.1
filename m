Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829D3282301
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgJCJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgJCJUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 05:20:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63290C0613D0;
        Sat,  3 Oct 2020 02:20:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so4335911wrx.7;
        Sat, 03 Oct 2020 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfJWJZcsMuNcrMRD3jVt9Sft8ffdGBBEbIpSbSgv+b8=;
        b=RMBKy3cfFe7fUnx8l79nZyB2pK9kPivrD63ZrvvFdiNAw9S2rppD9VLWE51E39FhFR
         N4z4Ap5IxxuZPaMxouREjcf682JleHIrEIO6tzfdSorPDzi5vEFHztMiF3KEid1S8bPb
         P+g7BJo8h+MqHeJBmdCV5GtgJtlxrGdThUQsmD71GUQjpXqldlhjA3RK8sKmBl6Q8EOt
         2ZGvSKl4dlXbOa6dOnY4Rox+LHVaPANYK2ZM4q4A2ByUFCFLvHZU87nNwyOmyiRJBEoR
         Eewmo2aY60rKLEPzQz2VrK1Ia+8XuJI5L+RMc0RDxNlkZv7H9ApaE+AEy70kxK1ZoU8j
         4yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfJWJZcsMuNcrMRD3jVt9Sft8ffdGBBEbIpSbSgv+b8=;
        b=Ky8ggv0mmnuWbN02iBmEEVUymCj1jHVbifnsqyHzpP11Jijr+fwZiatf4VOYC1bhwP
         ju338Oc47wvZu/wXdsAL8l1VigTS/xWj8vMbuUjqwGma8tv/pM6gIlJl0ddTjQ/n4MF2
         5l5Qku8AjIiX8m5nxCmFDZe99eEjhcuBL/wvOABqeSBCKDRToIWaUWHgBvP0XRCB1ioo
         UGrXD4YuUnpX2zddzjq1DFK+DbKwXwkpNmI0emvSE3UKT1SOE82kA0krW9V3EqqzT9fv
         MZ4bYYskfOoOqp4XFqb+ecLAM+p8rSNHlpVRS4sK+N77FxW/r1Z/Y8WNTlIfe8GtG4gD
         bkiQ==
X-Gm-Message-State: AOAM533u6OoTCs/EDrt4gxOohyIRoiZw7RfuuKWZvkzrHprBqls0+5DC
        CApkD5lT288ZZol9oCjKvq33wMUD4UHp2w==
X-Google-Smtp-Source: ABdhPJxYKxN1u9v3l81xEnluOHupj6j+KUgmGmJbgPdWJdSSwP0G8Xt7em2U6peAB4wfuZhxRalP3w==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr1339624wrm.355.1601716812964;
        Sat, 03 Oct 2020 02:20:12 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id t6sm5282985wre.30.2020.10.03.02.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 02:20:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property for Beelink GS1
Date:   Sat,  3 Oct 2020 11:20:01 +0200
Message-Id: <20201003092001.405238-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunxi MMC driver can't distinguish at runtime what's the I/O voltage
for HS200 mode.

Add a property in the device-tree to notify MMC core about this
configuration.

Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 board")
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 049c21718846..3f20d2c9bbbb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -145,6 +145,7 @@ &mmc2 {
 	vqmmc-supply = <&reg_bldo2>;
 	non-removable;
 	cap-mmc-hw-reset;
+	mmc-hs200-1_8v;
 	bus-width = <8>;
 	status = "okay";
 };
-- 
2.25.1

