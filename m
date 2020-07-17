Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F42240E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGQQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgGQQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF1C0619D4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so11792921wrj.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0NdwY9SbjwHcTXsovlQ3v7LbQPLWjEb4KHf8LUGjbY=;
        b=sOXt9VbPlc5N0UZ4A4vCRWgtuBbT/N0Cs1uY6oUQWBDzdCPYc9I3EUBsJ95AWLQQsu
         GbjmozZBJ4upGfnc1kkJk2MjNUqZU2a1ffzF8z/w2Fs+iuvoyVfBx+Gx+qdGqhT2LAQA
         mxZPTYpRDMTmJMnqhoJVNVqXJ0dwiQ8FZ4b3GmnGn2To1L2WMslwLpjP7IZ9VbghGxqa
         gzzBN1Diq5Epf+1OTF3zOHVeiq85oExuTc8CfHdmBoNPC1IHwdipDyJ5qQMHDDguiCu4
         87MbEySCThUvuSCjBgDqYRBg0NXqbuPn8MdGHj/va7T6rUxlxbrMwFxaj3TJDy7DkGaI
         5kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0NdwY9SbjwHcTXsovlQ3v7LbQPLWjEb4KHf8LUGjbY=;
        b=LLW2HBbRQxBc3Lii+dSpd5iWs5/qhk9cU3RhuHTZQ7QmIyI04UlBIy6VG+vMcH1sSI
         dOjImTiJm3N0DiD7scGlc3P/PBypIjrkecN41uUXcfi8oojDn3B7RtnGGQddF8C1Gt31
         ujPeF2m6qYH2Rf8WBBE+tTnavOtqSw/K14tWNWOltQylz30EtCd479HZ7dNbnFks10YD
         dSm0fkbwdcJK6cU1EoMMlVyBujZT+Il5Bce33OX51IqKzI4na3MqU+lokVGCNDENtHyz
         hBgOYRGNLYHWWdLUMosyeYonUIKWvMijwH59eEGj5MNuGMTiRGnWVKc7Ld2/dUAztFMx
         DrQg==
X-Gm-Message-State: AOAM531T5F/+vtE5hpKsg+pulpL/QlxwIUT3OhqsubnnRMhtMf0XaydQ
        dnXb6+AklLqcG8wbQzKfUr7AbA==
X-Google-Smtp-Source: ABdhPJwgRPbtjNyvrRZZorKrXJsoK0TE02TWb6iUUdarbMSRUJWwlu4GZ6e7rfb/OwhWQRKDjbkOFg==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr12302586wru.158.1595004959310;
        Fri, 17 Jul 2020 09:55:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:55:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rachna Patil <rachna@ti.com>
Subject: [PATCH 01/30] iio: adc: ti_am335x_adc: Remove a couple of unused 'read' variables
Date:   Fri, 17 Jul 2020 17:55:09 +0100
Message-Id: <20200717165538.3275050-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ti_am335x_adc.c: In function ‘tiadc_buffer_preenable’:
 drivers/iio/adc/ti_am335x_adc.c:297:21: warning: variable ‘read’ set but not used [-Wunused-but-set-variable]
 297 | int i, fifo1count, read;
 | ^~~~
 drivers/iio/adc/ti_am335x_adc.c: In function ‘tiadc_buffer_predisable’:
 drivers/iio/adc/ti_am335x_adc.c:346:21: warning: variable ‘read’ set but not used [-Wunused-but-set-variable]
 346 | int fifo1count, i, read;
 | ^~~~

Cc: Rachna Patil <rachna@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ti_am335x_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 9d984f2a8ba74..93b67bb165044 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -294,7 +294,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
 static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	int i, fifo1count, read;
+	int i, fifo1count;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN |
@@ -303,7 +303,7 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 	/* Flush FIFO. Needed in corner cases in simultaneous tsc/adc use */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++)
-		read = tiadc_readl(adc_dev, REG_FIFO1);
+		tiadc_readl(adc_dev, REG_FIFO1);
 
 	return 0;
 }
@@ -343,7 +343,7 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	struct tiadc_dma *dma = &adc_dev->dma;
-	int fifo1count, i, read;
+	int fifo1count, i;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
@@ -358,7 +358,7 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 	/* Flush FIFO of leftover data in the time it takes to disable adc */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++)
-		read = tiadc_readl(adc_dev, REG_FIFO1);
+		tiadc_readl(adc_dev, REG_FIFO1);
 
 	return 0;
 }
-- 
2.25.1

