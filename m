Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD928C196
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgJLTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgJLTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:46:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C843C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:46:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f21so18213760wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJUgYY1wIsYehEysHd2Kh8lV4o685yjBc0pclwWahLQ=;
        b=xQrjEJD7DwGgvhsePMttKT1lbjtB/P+TL5KwJS6udeu8lwG2/PiJwn0HQIIk4EVLPw
         3Aj2fF36QqZwby7SLpRW3F1hTOLziJPhbnv/qnWYYWWpy4e5RFkRdola0lwLjODrTxHi
         W/U3wFnc5gz/qqlA93pG1CIw0XxnJjjvhQfas5lMnWUh7HgNoZfok7DW+c+4IuQg5Q4N
         sRXW96q5CyL1vReb3Q9Db0lwCZigR2AeoOT6YDzCB6atz5quv7BCwvUqU0uCraF1hKhZ
         O6yHHgx/nol8/hUBpVhIeihEXKfu5LkfVHVZ9W98lAQ/vUiEtCu+AraE+VGhcAmkkzAB
         xY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJUgYY1wIsYehEysHd2Kh8lV4o685yjBc0pclwWahLQ=;
        b=sPG+n9Xt51n84zIZzBEvtq2m6PNhVZ72UF1j+Ca18A1vFd0aQp2xEhd3EbwmMAhKCw
         CtlemdhY98cPWxRH9erAaO7H9sBlxiPUz4XMuEC9nIvNAEWt09VHfdCZ8vkf5JY0AWXE
         v4wQj+F/DLg1O94bQx7J1UZXG6PSFOA8RbtHGE1HizhyewjD3Uhu6lIPR78d6tnh8zO5
         ME0ZELCpQN71DnwYDHP8QDvpGsCxSUCoPlm5RbwbdwMGrDHKFxjtJDL9331FHb3O7he6
         Sf78l5lqpZn0YW8+yVFbDU1moMqY7R0TQUWhh5BbbGiyt7mPjyg1UbyIG8Cb/j6HWjl5
         IIxw==
X-Gm-Message-State: AOAM533dlc3o2jphSwmQGP4c1sjmCHdnXVRt+9zkr04OXlJns/PE3KhJ
        V16KH2vHIono6z6kX2IVJxt4HTXEh+f8Ncmm
X-Google-Smtp-Source: ABdhPJxE4rAMqZqFJQmBSrB789tdjZKukj9/n7g9ecDb/QcaExAQWtKUFEeX0l7QGMLG2PJ1ll5eMA==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr293583wma.150.1602531982526;
        Mon, 12 Oct 2020 12:46:22 -0700 (PDT)
Received: from localhost.localdomain (170.175.185.81.rev.sfr.net. [81.185.175.170])
        by smtp.gmail.com with ESMTPSA id p13sm24590363wmb.5.2020.10.12.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:46:21 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc:     chun-hung.wu@mediatek.com, alexandru.ardelean@analog.com,
        matthias.bgg@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] iio: adc: mediatek: fix unset field
Date:   Mon, 12 Oct 2020 21:46:18 +0200
Message-Id: <20201012194618.2170970-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_comp field is used in a couple of places but it is never set. This
results in kernel oops when dereferencing a NULL pointer. Set the
`dev_comp` field correctly in the probe function.

Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index ac415cb089cd..7bd48377cd79 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -276,6 +276,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	adc_dev->dev_comp = of_device_get_match_data(&pdev->dev);
+
 	mutex_init(&adc_dev->lock);
 
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
-- 
2.28.0

