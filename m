Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8AB2ED10F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbhAGNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbhAGNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:42:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307FCC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 05:42:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 91so5683121wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3qbp3ZMuwuzWhmCass4IRAk8ZAQ/ACJDj2q433vAbg=;
        b=rZXJ+p7nRYeGl9SWPfS1whanzVkdZoIbBxEWvnNvDx/P/T0FRcoy/6H3OM1Frz/1nx
         FGRs5WxCLAFOz+d3ap5a+xHiHJQD2cWlqY4yVKXYrNzLqpg3RnnIJt6LT8ApD8Az3bQj
         u2besmmV3asVZJMii9cWrsryRvCpxgytlYSBlxswLNANwutC01QhPpzXGitSwWh/SjPU
         TZJIcYYqyWT35SBhhjUnFOInUGdeiQ312TAL/EM6cwWnyOLROZxRXoQtLHqCSCymLyG6
         zcYVQ83WNbjUOk1j2HifRpdEzc4SKVFMrBfOsWF0yCzIquI0NwYUyKHcS4q7zK6AFU+O
         oxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3qbp3ZMuwuzWhmCass4IRAk8ZAQ/ACJDj2q433vAbg=;
        b=aufka6+hvSorglq7C6xTyhTNyFOkdJk8/xEtmTX5mf6JAznNAS0e7KCLZowQjnKy8Q
         I3vKrH0gR280J+6NrLESpxCP5zKi/UOEKQG9QQgUo8mlmbxzatNHLp2BTszki8RBx9r2
         nlVPy2OaY8S8603B+2oZaI5aOxuAFhfXVo7U/lkIogqTNVCbSEA1yGwnBjK4CbibM38U
         ucvKl3nVKzmhuBY2l4ewtwTbqgrOYLC7ZztfIA/WgdD5k5aI/ULa3px2iQayL5/5UIiP
         GTlXcD5wiKFUt7wGUdyBwEbNd9pdAE0+2rEqtVHlB6WxFXkydgjqRM5cAq5pgoILSSWs
         +aVA==
X-Gm-Message-State: AOAM532q+ShV+I5pPJ8YrvDrusgyW4JkH+K+Va2Ye0eoavYoEsfzDKPF
        F+08DFmRV/TMbpI70TQKFN32YcT6cp36CQ==
X-Google-Smtp-Source: ABdhPJyoOYIbXOl7BaXgxmBR2MYncdd+LZgqtPeWdOiP64bRsHmgX+TEX8fh5IC7i0elOaJDb61gew==
X-Received: by 2002:a5d:4dc6:: with SMTP id f6mr9216369wru.336.1610026926883;
        Thu, 07 Jan 2021 05:42:06 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id g184sm7852710wma.16.2021.01.07.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:42:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] rtc: s5m: check the return value of s5m8767_rtc_init_reg()
Date:   Thu,  7 Jan 2021 14:42:02 +0100
Message-Id: <20210107134203.9388-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This function can fail if regmap operations fail so check its return
value in probe().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-s5m.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index eb9dde4095a9..e0011d3cf61b 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -791,6 +791,8 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 
 	ret = s5m8767_rtc_init_reg(info);
+	if (ret)
+		return ret;
 
 	device_init_wakeup(&pdev->dev, 1);
 
-- 
2.29.1

