Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88D92DFF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLUSOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:13:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D8AC061285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v14so10719859wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYNvrmyBcR24qaTBP8yatBcY626HdS4K9apXn77mSNM=;
        b=lD267zahUVgA3DLau9u4L0oNjrXSi3d0rZHEzzA3ci0+hZfHJbDbQeSqa8dyZZgm8A
         Qiha3IP/O97P1NRVUm0/yueKbU9MfRiUZHURyi+oJEyoYaZM7wI6vFuICqR6Gc2kZRdw
         FwOC3bM/EiuB+KT3rgLfkgO+GNvW3GF6mmoRWejfhG1mIfGBt4ybgUSmynzTnDj25MP2
         JrWt0W1TCL+AK9vAssOHE5EH8fl7HjedxcbAkXmylnqJweqfKLeZK61Lywe7lAnDG9N+
         Lzlq+ssfe7dKMtc9646Gzs9+XgQ4WV6b5gJbQ7QGW1Mv/Az/unY+Zh2fkPyDh56cNYGW
         9jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYNvrmyBcR24qaTBP8yatBcY626HdS4K9apXn77mSNM=;
        b=DzC7TIq/f9L2yZjgWNHMaJjjMcPZ2BQXiatHhnDtuCS/Oncl4ZCKO+2PGl9Bkngs1T
         uAhPa9SJmIcZZo8lv6iYzBKfb/lHu8QFNC/cQtXxIDPeBpFfPiJl6Gj9c2gFa8fZnWyY
         tRZJ4IUnLX58lCE2s0MSRLBk7FVuch8Ggj/Etwkiqg/nFl03TKLRqDbLJAUpX4KbrFOg
         0/b3rP//4P1n50yG3QGR28XGeJ5GCbtnvjSHUAIlCFtQh09kTs7EDrvcwiHljyrHssv3
         x04+WQScQi4kzGm8Xuj2xprTuLIHeV8ang6xpvBv8YqGfSOrVVxNw/pyEXFIG+uB6chN
         C7/w==
X-Gm-Message-State: AOAM531oH8SMuaPtWx3BuOPzKq59FBa6Df/oxwrl0PV3N7HwT2JusrRu
        ecv1poPnWBKA0Js2LW8GFpbF3mXTmlI=
X-Google-Smtp-Source: ABdhPJxbLR3uHnt07Oa6Z3aVJYz+7qis1B/0BHuj/Kq0dNDM4BADbUR3yfKav7Fm5wX8dC42z5Lizg==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr17698718wmj.104.1608574422400;
        Mon, 21 Dec 2020 10:13:42 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id m11sm23434936wmi.16.2020.12.21.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:13:41 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/5] ARM: multi_v7_defconfig: Enable support for the ADC thermal sensor
Date:   Mon, 21 Dec 2020 19:13:06 +0100
Message-Id: <20201221181306.904272-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
References: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit Amlogic Meson platforms are using a special ADC channel to read
the SoC temperature. Enable the "generic ADC thermal" driver so this
data can be used to cool the SoC for example by reduing the maximum CPU
and GPU frequencies temporarily.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c5f25710fedc..0a55240ce2fc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -515,6 +515,7 @@ CONFIG_ARMADA_THERMAL=y
 CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
+CONFIG_GENERIC_ADC_THERMAL=m
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_DA9063_WATCHDOG=m
-- 
2.29.2

