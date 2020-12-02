Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00BC2CC929
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgLBVuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 16:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgLBVuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:50:17 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC6C061A49
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 13:49:37 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id j13so1707326pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka6Z/ZcsAkJmAuTwn/KM+k744pqQbZeoUCVLzEch46Q=;
        b=LUrztAYpFrGpLXuuYeTwq4AHlrAqLvdqXN5M+I/DSiGZQdEvyqyBcGGJvTdYKGs7Bw
         6pKhk2/PgqdLHDyY3pCumHAGJtohG8vaFV4zvd70F1Kulw3D4ZSzWEu5Hpj9zYG+GkKJ
         HxHILlU+2mBzOkFgzbmtwwhL90bQbzt85nSPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka6Z/ZcsAkJmAuTwn/KM+k744pqQbZeoUCVLzEch46Q=;
        b=PknW4lwqsRYvv2/VBIQEJpX/1a5ojhR+UYGvDVm6o2GMaJDXkpF16drEFT42hZ1lXp
         olHmcOFrNtpot2JTWt9w3e94/xHXZ3qwxTavjLbWsHPIak4MdMq03LOXnfRzlEUkeeKk
         MS5/vuujrvr3SDzcKq3Gjg7XVK141BrsmaD+rAKH31BWwKgmjK47z5XPKSGGnSber6h2
         aouoK5lBKtwOAFJvnhYQhJmn8IapRLAphobyWapJGK+CSIQcj40B6CujdOdSD3dIgLlx
         QcvDWAOnszwPj6BLbdSXRSoAU2illOxs1452a04354s6XejY71DDdpb1ludb35nt8oIc
         owMA==
X-Gm-Message-State: AOAM531QxSpTLQXZtObqr696Y3+bhFzzpl7EQNOLqZVBqSIyK+BSZ60K
        KKziXZP+Fch3R7j1HqateRHApw==
X-Google-Smtp-Source: ABdhPJw7S7EAt3ICR9MGBNyO9g8s8Th1B2Y7e+RpQELxDFNRwEefTjFRoNfHUTulqwODlvC+nntrOA==
X-Received: by 2002:a17:902:a503:b029:d8:e685:3e58 with SMTP id s3-20020a170902a503b02900d8e6853e58mr91635plq.68.1606945777199;
        Wed, 02 Dec 2020 13:49:37 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a5sm55371pfg.140.2020.12.02.13.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 13:49:36 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH] spi: spi-geni-qcom: Use the new method of gpio CS control
Date:   Wed,  2 Dec 2020 13:49:35 -0800
Message-Id: <20201202214935.1114381-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's set the 'use_gpio_descriptors' field so that we use the new way of
requesting the CS GPIOs in the core. This allows us to avoid having to
configure the CS pins in "output" mode with an 'output-enable' pinctrl
setting.

Cc: Akash Asthana <akashast@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 25810a7eef10..c4c88984abc9 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -636,6 +636,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->auto_runtime_pm = true;
 	spi->handle_err = handle_fifo_timeout;
 	spi->set_cs = spi_geni_set_cs;
+	spi->use_gpio_descriptors = true;
 
 	init_completion(&mas->cs_done);
 	init_completion(&mas->cancel_done);

base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
https://chromeos.dev

