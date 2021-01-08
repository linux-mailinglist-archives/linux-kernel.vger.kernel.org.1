Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540E2EF200
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbhAHMHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbhAHMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:07:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C45C061236
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:05:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id b9so14312010ejy.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFs6/+FJLSG4qiE+8mi/knnWkI+pTLrRTmRKqckIc2s=;
        b=hud0CQ21g/5fjig5pwansOFfly1FL14n01Qbjz7w4LQiQVwIBV8XIs+P2wQ+9WZMED
         2rOn245UIuTSB+ybF73xx54nzO8I6Tf5OqTwJjevRRV4hRPvRFGYeHAKO/O/skHt6Dkp
         1Vapo1nUZv7u4WEFP6bqADIgQ9/RQfxI4JO+p3RpP5ty0iItFbQhP6Oc6BTc+4K1MuMs
         TfBNZvv7FKdMZbW/8+MWQPjjK9EgwyPWErP/MTn/+x0Z4e4UUQWxEYqm2sGfT94+bRLQ
         eRREXuWFDoRpYQAZ0T8RT1bLhcopl7xdagjIPGwGgK5Ep6ACzZaWlZ9lHDED75ufuK9X
         7Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFs6/+FJLSG4qiE+8mi/knnWkI+pTLrRTmRKqckIc2s=;
        b=kTIc9Ti3R7V/a+I749jfmgwJLM3bAx86sB5VcPCyBPsZ2K0yENFeYFFfIXjzqTDy37
         iJj6QdaDmGTaOl8kLrQ0CLj+KNluTggV4ea/D+IvxIT6Jgdx3ctPVnPjhfxUkBK1ix9R
         ohQpfT9oZTERWEYwK5gH7CcZLJCs8p+kdeFaGQ202RhAKLq+Grn3Kn4vMzQdcM+zV7e2
         SFf3HIuEMxOcUVm1UfOY7qnGt7kRfkrk8d+zerw9RydIsq+oYAP2eAOJFlM858VjbNT/
         K0CA8R4U+eHrzYORNPOTsjuaC8nVUpr3IOxK1OXod5Kaw6Sk/Ns9CZJmmqOVDAnMuPgj
         EkJw==
X-Gm-Message-State: AOAM533RdHGrI2bJv+efjcC9MmdoCEwzcRxrN3HSiSl4O77grmb/mffT
        kwI5rMr4D3d2HAH5m/JNwBkADA==
X-Google-Smtp-Source: ABdhPJxygpTem02DHmrZY5igvqqpHoL4tEyHDE1YfBzD0Glr3H81338pNvYVXJnP20wpTXqOjbiUTg==
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr2476409ejn.214.1610107522720;
        Fri, 08 Jan 2021 04:05:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:bb2e:8b50:322a:1b9a])
        by smtp.gmail.com with ESMTPSA id i18sm3674498edt.68.2021.01.08.04.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 04:05:21 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        arnd@arndb.de, Anson.Huang@nxp.com, michael@walle.cc,
        agx@sigxcpu.org, max.oss.09@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v1 14/17] arm64: defconfig: Build Qcom CAMSS as module
Date:   Fri,  8 Jan 2021 13:04:26 +0100
Message-Id: <20210108120429.895046-15-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210108120429.895046-1-robert.foss@linaro.org>
References: <20210108120429.895046-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build camera ISP driver as a module.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 838301650a79..cb224d2af6a0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -640,6 +640,7 @@ CONFIG_VIDEO_RENESAS_FDP1=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_SDR_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_VIDEO_RCAR_DRIF=m
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_OV5645=m
-- 
2.27.0

