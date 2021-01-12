Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEF52F24CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbhALAZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404240AbhALANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:13:44 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9303C061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:13:03 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c22so218482pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0LU5ZswwTCJKm0ifYQA74K9PKuPMTkTpEKcptV47c8=;
        b=fTRWWqx9e8Az3Is+SwJeweEueiHH1K6iIJWo+y6HcsWR7NYRY0e7X0OW88ialGbn6r
         SRw3Vokb/9Ic/nebzngGm0cOV9lR5mereHanT53ruvCPacYpLG67oRMsffthEXUQYuak
         bOoad+2qkXMXFNtiLJZg/D/dVy0X5tXAfvQfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0LU5ZswwTCJKm0ifYQA74K9PKuPMTkTpEKcptV47c8=;
        b=k9b0nz2l36Ieea867Aq4yqOkYvu8ziQCKqjuveaMaVKLAu6N0zQfmFMEcS2jf77DJ4
         /gx7kKyLJVHxzmYx8qmmuGezu0wtunfDHcYjBJwTT5P+Hzwr4t9lvSgIAt9+nwwBE9tv
         IM194oEpObA9eh/HlPjajaVKMGYS4VJSD1LE0x8ZyI0tH6MRwwqNrJPoCDHIirSqfhBo
         D7O9BCR4iYCCJszaLgT6gqr1OAmHJeadFM+OkgIXVwhscJg6/shF5ljrFjR5GIjI/yPQ
         QC9PzOgkpCV2mpYXMXyvqL+DHEizD78nYKC1n7a/Do+xvx00qMUc/Nz84O4F3DliTHfV
         nyPA==
X-Gm-Message-State: AOAM531qukYIzCzZQxsnKYZxeQZjWxGoGZJnYVd8A4al7mqICM01gcm4
        eL9ZUArWZsttOqzLKmIIHWlWrw==
X-Google-Smtp-Source: ABdhPJzl19kwY6GZo/KlpQ5s+4aLpeSkGxR+LgQ4X8j2U29ON0ID5doeXzjRwTwK6v8H4uBA9iAh4A==
X-Received: by 2002:aa7:8708:0:b029:19e:924:345a with SMTP id b8-20020aa787080000b029019e0924345amr1867834pfo.54.1610410383239;
        Mon, 11 Jan 2021 16:13:03 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a131sm820570pfd.171.2021.01.11.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:13:02 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH v2] spi: spi-qcom-qspi: Use irq trigger flags from firmware
Date:   Mon, 11 Jan 2021 16:13:01 -0800
Message-Id: <20210112001301.687628-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to force this to be trigger high here, as the firmware
properly configures the irq flags already. Drop it to save a line.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
Cc: Akash Asthana <akashast@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Rebased onto v5.11-rc1

 drivers/spi/spi-qcom-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 8863be370884..1dbcc410cd35 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -511,8 +511,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		return ret;
-	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
-			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
+	ret = devm_request_irq(dev, ret, qcom_qspi_irq, 0, dev_name(dev), ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request irq %d\n", ret);
 		return ret;

base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
https://chromeos.dev

