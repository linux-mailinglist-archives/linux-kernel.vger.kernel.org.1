Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5E2D8B99
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 06:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgLMFad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 00:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgLMFab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 00:30:31 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F45C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 21:29:51 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so10205584pge.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 21:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIRFinfbgbZO50AJSCxLN6fLNwVVOhGqRKpbkplO8ug=;
        b=GdgXpGFH+jNsbOUFmm8A+ht+nCz00rdXqYsd+AUSbdipXdCw26nOkJKHb11QeQKAWs
         DjO9KXWtR8dCEofzaRIg9CsTIZnm6HMUs/IR471Sm1tyBNm0/NGtEMARWk7HTxYsRlfB
         8ewXopKQm4y7VM/axMqJDhV4ul5T/vhuwYas8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIRFinfbgbZO50AJSCxLN6fLNwVVOhGqRKpbkplO8ug=;
        b=WXTbRS0aLz47ZcFfABruY3Mo3QHSq/QJPjYBGVLlY1HYiTyckwjmUk/rk5jJ3LP1Pn
         yH62xUn/OGb/rSnNeplgfNDyvjWJ3w+5pQEbVPhbLHDSEP0yvy/Ke10GiJUAg6RqMuHE
         A53Hg/oKsAl/pvboEvUy7t/YUADyQJPAmfi1VMQW8YwVsWlYpRFqazwdUmQGokMo3Osv
         Pt6mdELdOPP0+BH5XlqpkpAYFvYjOU/JKakzbho00Vne02o9/rI19sWzuhbI1iiXm7gb
         WAyBMU/AIDw00zuSe/CFRLMP5dKfe7BJ2BJv83XJZT6aVPNOplw6Ary8NmwNUSjYEerk
         y1vg==
X-Gm-Message-State: AOAM530CAzPeOExnNBtR5FDfwzcQlm1U4ZmQVopqUz3TxJkaoevBvdKP
        uSU/HaNycf+f0ZHVN6tsaMvJ+A==
X-Google-Smtp-Source: ABdhPJzzjIM+frmXipKHf8je8MLsddRzOudjIcl+IK083vh1hHszJcGuzYLOdc+NV9K198oULyFJNA==
X-Received: by 2002:a63:cc4c:: with SMTP id q12mr18838228pgi.361.1607837390716;
        Sat, 12 Dec 2020 21:29:50 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w200sm15862917pfc.14.2020.12.12.21.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 21:29:50 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH] spi: spi-qcom-qspi: Use irq trigger flags from firmware
Date:   Sat, 12 Dec 2020 21:29:48 -0800
Message-Id: <20201213052948.308263-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
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
 drivers/spi/spi-qcom-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 5eed88af6899..8e70f5e63e0b 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -516,8 +516,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		goto exit_probe_master_put;
-	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
-			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
+	ret = devm_request_irq(dev, ret, qcom_qspi_irq, 0, dev_name(dev), ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request irq %d\n", ret);
 		goto exit_probe_master_put;

base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
https://chromeos.dev

