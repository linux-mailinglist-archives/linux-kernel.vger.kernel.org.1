Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF022F127A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAKMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbhAKMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:41:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:40:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r3so16272835wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3qbp3ZMuwuzWhmCass4IRAk8ZAQ/ACJDj2q433vAbg=;
        b=P+TwWLiTjF1qmaarNqsVKWNM+dj4npSIcBOUzlo8IeXig9P8wZj61dOgCRFAjWO8dI
         el0XHCO9VI68C3rOzzKgrBlH2CqCgMbd52JSicFo/WvKlqHm+SNqmO9Lm7efZqFPkKRK
         TT+EmyCCHP4O95eF+qg/MNDR6lWwZCW3seProocfEtg5DQ7kPEALk9G8qHYILXkyu3UW
         rW041WasCI9qrc8nELQFX5CAZVP1w3LoT95tvPFMuAC4vHBvLWWhDeDdwVGTI46K4r3T
         Ngd9xSOIvSRo4JPqY/OS7UaQsAiHeHpzSBlUWMuWOC/DxyUxyGyLUlI6uT1E1Uhh4lnp
         fVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3qbp3ZMuwuzWhmCass4IRAk8ZAQ/ACJDj2q433vAbg=;
        b=im0zEuo/ax7BpcXGLv4XDXK2jRpEiLqtKtzBvJ1LPD0gMxjmKfRQthBA+K8870peYo
         3REMV1lxpyGTsNzvZkpsXyOViv7Y+m6TxrCjGSAO6RseNIzZwyG7XIc3pMDhiVY8PPRF
         +O1WdAV53VnBo8UohA0yqrgPi+yDF6d4OMlVgbSbrl8F4zJwNgYpqzwIGsBYT0P4BmVf
         ykIUOeRI8ufPTYWx2K+BD0b4y6ffHqc5+kc2jMtkSlJ7QH4Vvqsn1eZ6+/FkPt5ddMyF
         u77uHtLIrurE4iE2rYxaGJTcDIU1h4YBAR2cRPSaDrLMTSAgYwkyfyqlcbn90BIIJF/T
         EpNg==
X-Gm-Message-State: AOAM530r+tBX/qQpiMDoni9Jfxs2QPHrVJJ3v+Xh9IUZOvL+upyUslzq
        3F0OEK5Y78AdIrP9tP/EZgalCA==
X-Google-Smtp-Source: ABdhPJx98mZybXSuv26a4jd1+q/Aole2pms6hjLnF+Q1HUOM04J0+ZjH3h0TYXXuX0JtSP1HEmYJ8w==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr16060283wrw.73.1610368837747;
        Mon, 11 Jan 2021 04:40:37 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id l8sm26492362wrb.73.2021.01.11.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 04:40:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/3] rtc: s5m: check the return value of s5m8767_rtc_init_reg()
Date:   Mon, 11 Jan 2021 13:40:26 +0100
Message-Id: <20210111124027.21586-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20210111124027.21586-1-brgl@bgdev.pl>
References: <20210111124027.21586-1-brgl@bgdev.pl>
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

