Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D020F2C78C0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 12:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgK2LKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 06:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgK2LKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 06:10:01 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF52EC061A53
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 03:08:27 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so4893990plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSxJk69Cd2LemrQN9ehPZlO0F43/6TrspTvKZvZYbs0=;
        b=ffUK02opWwOFvHW21tRs0l4+Mo38eIrN56iqqYVXgFwGevSQSh8qK2fv8dEfQTxpvJ
         mpiJo9gnnIfv/ntuqs6s0NG0qUrvjYXlDFghdoqhaG3hqTkM8uFe2cLgJnABDDQbqk+b
         JqmG4htvg0K3vSGvdkAruDhmMg4CU4VXpXRUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSxJk69Cd2LemrQN9ehPZlO0F43/6TrspTvKZvZYbs0=;
        b=FoVBWYaFdWoMJVOKTfbZ8kElhUEQBB41Pab8ukd1ViGlRdxL6/rdVziq9p7elC9geG
         Ukp9VUk3gYHYEo8rgD325BfijE57kUTBRZay65hRO2fjLbqXB2rElzLigym/fEusMpW4
         I3jTWUMOZAnw4JRQ484W+S7eeup5PX4Hdx6cIdMPq8yVF/Qi5jZAgVUof+cEz07/2Ys5
         dVAS+nhPqlxHCfiCKSJ3z8eGTw3lr0zsJ+fWsztzSC5D6C2IRqGEntvHY9DvfFN1mEkQ
         jai8cqIdZQfFUI1+03dseCx23TEUxc9ZFIsjMLo6VGhN6YfAbWzhkspRCUzuLYAzcCbw
         Ryjw==
X-Gm-Message-State: AOAM531vvCYsZqUiQkres+vGI0JdUDAYwfn14SoaFx3Oy6Hw+ZIkrIL1
        1yJ5sxGbKwg40d9VR6VZvW0T9g==
X-Google-Smtp-Source: ABdhPJzib+nYFpwBxldfEI+z6vafVcrbaAPzvzvDZh07vXmrjbJ1TdqRII3WABzDnjub/RJWE7p+rA==
X-Received: by 2002:a17:902:8691:b029:d7:e0f9:b1b with SMTP id g17-20020a1709028691b02900d7e0f90b1bmr14505268plo.37.1606648107325;
        Sun, 29 Nov 2020 03:08:27 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id 21sm13095653pfw.105.2020.11.29.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 03:08:26 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v4 5/5] ARM: mstar: Fill in GPIO controller properties for infinity
Date:   Sun, 29 Nov 2020 20:08:02 +0900
Message-Id: <20201129110803.2461700-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129110803.2461700-1-daniel@0x0f.com>
References: <20201129110803.2461700-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in the properties needed to use the GPIO controller
in the infinity and infinity3 chips.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/mstar-infinity.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/mstar-infinity.dtsi
index cd911adef014..0bee517797f4 100644
--- a/arch/arm/boot/dts/mstar-infinity.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity.dtsi
@@ -6,6 +6,13 @@
 
 #include "mstar-v7.dtsi"
 
+#include <dt-bindings/gpio/msc313-gpio.h>
+
 &imi {
 	reg = <0xa0000000 0x16000>;
 };
+
+&gpio {
+	compatible = "mstar,msc313-gpio";
+	status = "okay";
+};
-- 
2.29.2

