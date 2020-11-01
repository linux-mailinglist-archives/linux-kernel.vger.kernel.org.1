Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76862A1B8A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 01:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKAAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 20:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgKAAoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 20:44:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3CC0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:44:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l28so12696472lfp.10
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rlPppp27+bvy8UmoCAeoTdm5KrrOnRi9UbgVqpzDzM=;
        b=zRMDDcRSiGS2MaZMgEdWWSiOSKZ/u0kj8pVKoUVxw+nbm+7nPDi6KMOJEsl3RKH3JY
         o49aijktMAB/3VKG2HOVwqkMpDW2ey3Xo+kAdZx4ZJIj8Sb9zR2HpP4imp6X6s1/HyD1
         dbl/H1x6b+RtFasBcZnUkN6npw+0KBi5m+VawGhBwycdAB48YLP21zvE5YcftSZWiqbJ
         Rpp8estiRRX0JlLX7SVDxpJW0+VGrHK49BSCyeYZB063lLoEz8Df2y1WoPDbo3lrzZkG
         ZHKxSS+AR55JxcnMqmoofHY6qOW4EbkCw1qheqkLxCeXMnTyQNKrpurQ4oiV++Avep6N
         xVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rlPppp27+bvy8UmoCAeoTdm5KrrOnRi9UbgVqpzDzM=;
        b=oEI7fW/uN7Rj2oAg5tZIlmCPhPLimfEWAL++pQDFS7vLwvokFuuJ5FPxyqJKy0yiUe
         jJd6zCg/wwRI+QJ1CgySddatSnzHAv3AhXgeTC6LJ4nWNjo40yDejXYbVyB2Hf2mDwqD
         7a58AAsjh4NNPvFS0CeODlhz23SBh9nK2C6UJ+fBorH34C1ln12nsg5bTvtUQOB9PXKG
         GIG2v4zbGIz8x472H/ZkjyMnF5EFYwWoVyc5RELo+ePRUFatfDfOo7VedguUMZe2J2I2
         guEmLF2lTMm9+9qQA55ScRXn2LXzJakbuPZiySYV1RCp0tj7IzAkhr80ReV+MJkp6Ih2
         mOow==
X-Gm-Message-State: AOAM531Jr2q5JTL6XDTG67iJCObyQdC4DESELusAQG2pJ9d3edY/g0nD
        MEuAsfY0xTe7uBbQu1udVZT8HKA73AkDX15a
X-Google-Smtp-Source: ABdhPJxS8+p0sUA2l0jUXYFW3EbWCIQunjj3feHczf0cW1BQ4RCTDi1dvCDYKauLIT4cksyQefIR8Q==
X-Received: by 2002:a19:2391:: with SMTP id j139mr750445lfj.339.1604191445573;
        Sat, 31 Oct 2020 17:44:05 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id n5sm1178637lfh.164.2020.10.31.17.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 17:44:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] extcon: fsa9480: Support TI TSU6111 variant
Date:   Sun,  1 Nov 2020 01:43:57 +0100
Message-Id: <20201101004357.1076876-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201101004357.1076876-1-linus.walleij@linaro.org>
References: <20201101004357.1076876-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments TSU6111 is compatible to the
FSA880/FSA9480.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/extcon/extcon-fsa9480.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index 8405512f5199..08bdedbcdb0d 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -364,6 +364,7 @@ MODULE_DEVICE_TABLE(i2c, fsa9480_id);
 static const struct of_device_id fsa9480_of_match[] = {
 	{ .compatible = "fcs,fsa9480", },
 	{ .compatible = "fcs,fsa880", },
+	{ .compatible = "ti,tsu6111", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, fsa9480_of_match);
-- 
2.26.2

