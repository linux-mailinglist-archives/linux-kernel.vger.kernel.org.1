Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EEE274915
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIVT1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIVT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y17so19311254lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYcqdmFs1PmE8Rv5grjsTkZpEbMvl8+RIYQHgKvNpbA=;
        b=FcS8F4BQ6OdTY7D13hGLupoqkrDNRBRA7PAdb5aftII63YWwwufoBJU2BwwYBESv1Y
         MywbEkMbiVbM4OHLMFgnUrmrwi9G850KZVUrFdnAgdlt3nAH/D/gQzNJ6L9P8z2Sqn1R
         3DT+K6Vyxci/PiGJLFkV/jujxI30QaMKiWWQoGs5oNxqHB7kMusa3G+plK0JtQb3SQUv
         y9KxcLQRpgW6KjACtzkkGBdUkywzozNEBus2FF+WzBTwWrZzvDcTWWieZJSgFnejUqUz
         JjE2Lpaj7Zce0EzwMbmfaNGIMQq3euNsqmajt0xrsY+xtazDCUHm/rVsOtQM5K8/s+jq
         mo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYcqdmFs1PmE8Rv5grjsTkZpEbMvl8+RIYQHgKvNpbA=;
        b=SLSTjI+SJdwrqZCgtfY9KTqbFFpAL/LjNrW9f9G2Ryy1OndlmTNM0RM8Zc/4qk5+Bi
         Q42ly4uj8oPM0aZQugLyeO7wybtbfzbqHdrY+lTUxs7IdrbDTqBg5SGYWHq12i+OPXwM
         4DMqm/+Rz4slfFYO9L56d8iFqBETDyXIW5FbHQJaD31HdVrLaNa32FomWA5VjfOLlsW6
         GudUQy03NVVKehH9U5mhKb0GnPH+IwT4aqvCTGocfCExHuiRyizAA7W7gKkyFRe5+Fl3
         gxrZ+EPLbGUcsOeO1Kia4/BTAU4u9+eytbX1FGu4PEm07Z1M/JYqz+UbqjSxa5rVqCUU
         2D4w==
X-Gm-Message-State: AOAM5325onPFHgEPSyc3rdXBgMzEBc3T3M5BZvcns0zXgxBrDqP3qwO4
        BCD6n18BarApnB/KoXQVZJA=
X-Google-Smtp-Source: ABdhPJwI9VD8Aq7kDcCDJVzdjuObccQg/G9j02U96f/ZdmiJhwH9SW6Qiwmr0CwwFVK4y7jO3ieaCg==
X-Received: by 2002:a19:4319:: with SMTP id q25mr1868947lfa.505.1600802837129;
        Tue, 22 Sep 2020 12:27:17 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r132sm3770013lff.167.2020.09.22.12.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:27:16 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/8] mfd: sun4i-gpadc: Constify static struct resource
Date:   Tue, 22 Sep 2020 21:26:58 +0200
Message-Id: <20200922192659.14535-8-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify adc_resources[]. The only usage is to assign its address to the
resources field of the mfd_cell struct. This allows the compiler to put
it in read-only memory. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/sun4i-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
index b346fbce3c01..aaa233d916b2 100644
--- a/drivers/mfd/sun4i-gpadc.c
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -18,7 +18,7 @@
 #define ARCH_SUN5I_A13 1
 #define ARCH_SUN6I_A31 2
 
-static struct resource adc_resources[] = {
+static const struct resource adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(SUN4I_GPADC_IRQ_FIFO_DATA, "FIFO_DATA_PENDING"),
 	DEFINE_RES_IRQ_NAMED(SUN4I_GPADC_IRQ_TEMP_DATA, "TEMP_DATA_PENDING"),
 };
-- 
2.28.0

