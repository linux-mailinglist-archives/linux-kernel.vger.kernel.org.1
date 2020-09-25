Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444F327931D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgIYVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIYVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:18:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:17:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z23so472760ejr.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PAQL73JxnyO64OF/vV552MTwfHMx4yBDlPAMR5RmT4=;
        b=TuI+K5EVjlYAKZzjy64Udjow3kM9Y76TpG769gzwOWYXYEnYdWeuo9J56l8DASw367
         ZqOY4MsYSqzrUnwb3W72LXTY/eRde/WezRymRajG/sidYLVnmN3NLOtE98JTv9HafGDa
         Ivzw3daQW/9OQURpJFVm4E70ln87m6BjB2lIjzlZeBgp3Ph2ER22CmYknxBV6zi8r6wI
         t3t/DF7E/VsmKBxPL2J6FLbpGsMMqNf7NMK+Wxv/ahVB2a1SDQBPhaJMXQma+6t1K/l+
         n6aJ8ADAnXKtGmuL8QhWMobfOjk7DqhJQnJ1+K6XxMR7v+gYxfGWENjZD2pD2BkV7TgE
         lBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PAQL73JxnyO64OF/vV552MTwfHMx4yBDlPAMR5RmT4=;
        b=VdwuRd2ZIf6kuoRkK/iOJgFanZON8ZiJV229hNxheCGXyyM5p3ZqKdl4zMzOnL8UhT
         M9jq8dPJm4G9kfVxk0mfxJcZS5GSkMYYc1Ci9ADDk81OdDxwa3DJ3MWTZ15tkAkcT1Dq
         5Lk62z05iC/vpAm0mZPqnx9Sn9d/HIDBwcBftSRkgP6JaTMmy02PS2Q25LZWHZ875air
         et0J3ehjCLczYwXXJ9wEpxp4+JMvUlCnhByaV6HFKX2uSCekmZ3lzQ/j2Fo6H74QxAVm
         IQPZ7EWs397HZW2o9Ty6yP34UMjf3Hu5nppr/pJl7ytpWHUszuFjMF8dIGVONEtAhA9x
         d/4w==
X-Gm-Message-State: AOAM530Nz5V9wU6oxRVI1VQgFY6FwgyJ6/F3lL04aCtq+ocamMc0f9fi
        DQrz5w2YbFJsBRM0m32EzPE=
X-Google-Smtp-Source: ABdhPJx/Sl4V+qETIIIaZG/LmfKXs+Oe/amH7m1chwyu5aoMo+BXwwx8BulxQJyrKwM8Y7lEAd9RYg==
X-Received: by 2002:a17:906:d11a:: with SMTP id b26mr4568914ejz.191.1601068678647;
        Fri, 25 Sep 2020 14:17:58 -0700 (PDT)
Received: from localhost.localdomain (p4fd5dca7.dip0.t-ipconnect.de. [79.213.220.167])
        by smtp.googlemail.com with ESMTPSA id c8sm2710057ejp.30.2020.09.25.14.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:17:58 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] arm64: dts: amlogic: meson-g12: use the G12A specific dwmac compatible
Date:   Fri, 25 Sep 2020 23:17:43 +0200
Message-Id: <20200925211743.537496-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a dedicated "amlogic,meson-g12a-dwmac" compatible string for the
Ethernet controller since commit 3efdb92426bf4 ("dt-bindings: net:
dwmac-meson: Add a compatible string for G12A onwards").
Using the AXG compatible string worked fine so far because the
dwmac-meson8b driver doesn't handle the newly introduced register bits
for G12A. However, once that changes the driver must be probed with the
correct compatible string to manage these new register bits.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 1e83ec5b8c91..d4e7cd68170a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -209,7 +209,7 @@ map {
 		};
 
 		ethmac: ethernet@ff3f0000 {
-			compatible = "amlogic,meson-axg-dwmac",
+			compatible = "amlogic,meson-g12a-dwmac",
 				     "snps,dwmac-3.70a",
 				     "snps,dwmac";
 			reg = <0x0 0xff3f0000 0x0 0x10000>,
-- 
2.28.0

