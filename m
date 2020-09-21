Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7552272EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgIUQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgIUQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:48:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C7AC061755;
        Mon, 21 Sep 2020 09:48:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so13518332wrn.10;
        Mon, 21 Sep 2020 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5GCDsKNMm0crC/13Tia3MSEDqi1WuVHUk9Ul1hJUNs=;
        b=RQxuPlOrkzXWovUSsFuNqPOsxYsbQ/JXZmSxK5pqis19Q9Ev9LoSMoAWpuK6Cgfp4s
         kG5CrAsV4KZGCwCQ/1gUqLEJGGZnAjS+zqmrsvQpQtbnNUuaKkUF4nQvzbntdi14H2BH
         uIla4huegJUCwhxrgWEkOgfxuwz4//EgGVdl1on1HmmX2sgAEGGn5S2PlTS1ez/B/MOf
         4EUPQQfyM3iJ2rM0H4x1DjKn9b8owTDR5M1fgBkfcxAZI1g+0s40Kn10sYqM9ttNsHnt
         ercjO10lIxCVG7pWKuJFvscOs1vzFpTFZwnWgTVhOdtodz43LBfHUGCCT40Rk14yaYgo
         /Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5GCDsKNMm0crC/13Tia3MSEDqi1WuVHUk9Ul1hJUNs=;
        b=mv3j1c5hwAFIWx9LvQarRtO/65pR7O8QO/370O6yQviJdGInkzLSpWJSeWmU4U2TDJ
         8tqrAVczoC5o2k6wEe9IGavV4859XngE59n6IgqVLlhNfewSgVTkCb5Fu8F/4a8DfpdX
         gtpklZUVz0SIqCqY/7plxwVF1zwQbgkE1fL2vBuNEae7ABiNu1Hwb+dEpbMrDm0Fh4Mr
         l+akGY+m9iK4vH4vTVN48Rh+prBpidW9HnyckzJ6R+geaov2vzW+XFBBQAxk+uT07cKN
         ryNX84gKy2d15fkAOGniYmJVXKBvdRvmBjPQlV17GejTQKVtht3MjJ9X4h1o2v1q3Nbu
         eUCA==
X-Gm-Message-State: AOAM530UeK4GXB8BxNTDItODgfOcZE5siVDuHr7juXbUll42LUky7p+R
        FjnV6cXiwalbUyJIJqY8VXY=
X-Google-Smtp-Source: ABdhPJw478T9S1AjqsJlNz7kjoLsJf4u3WXjJntB/an+L+6uABuiCg1bQhK/LvMF0JUtRN5uzWdL/g==
X-Received: by 2002:adf:e385:: with SMTP id e5mr643206wrm.129.1600706913316;
        Mon, 21 Sep 2020 09:48:33 -0700 (PDT)
Received: from mamamia.internal (a89-183-108-204.net-htp.de. [89.183.108.204])
        by smtp.gmail.com with ESMTPSA id d2sm21741415wro.34.2020.09.21.09.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:48:31 -0700 (PDT)
From:   Andre Heider <a.heider@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: espressobin: Get rid of duplicate serial aliases
Date:   Mon, 21 Sep 2020 18:48:30 +0200
Message-Id: <20200921164830.499548-1-a.heider@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The included armada-372x.dtsi already defines these two aliases.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---

This goes on top of Pali's patch:
"arm64: dts: marvell: espressobin: Add ethernet switch aliases"

The resulting .dtb files are the same.

 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 0775c16e0ec8..3169a820558f 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -17,8 +17,6 @@ aliases {
 		ethernet1 = &switch0port1;
 		ethernet2 = &switch0port2;
 		ethernet3 = &switch0port3;
-		serial0 = &uart0;
-		serial1 = &uart1;
 	};
 
 	chosen {
-- 
2.28.0

