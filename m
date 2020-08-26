Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA82531B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 16:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHZOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHZOpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:45:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE34C061574;
        Wed, 26 Aug 2020 07:45:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so993166pjb.1;
        Wed, 26 Aug 2020 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dy92T63KJ9Q9h7SiErNQEXUlQ8OKcTJsbD/s/H02xn0=;
        b=fvklMTl2auqGqE+SBvACHUKPWbFXsam2tzn7UcYmNAVOzHFjkMC7MSpsQY/Benw2lA
         9p3SEyXDCInCdMug2N4B9SU7n1dFfAInLV6MTrAHd6lvO2vb/GHHn+76+YLXMmlUwb+e
         Qif0rlucZ62ioFBP3BP4wHfnbxjx092UVcvdE6EkRw0KEAMMybEghcZv8dec/XwPpSSt
         p7ltEv8pDxY6oIrjHEkarSat8fh0xo6NsYrNU8WeOjUd5eTCvCaoOF6uysYUvJiYiiDf
         JEVkSm5FDJebXOvcOhzUsiuB2/fzrVB9DmdFk9LSG24pddyB5/zpQwenvHoFxhgytrTS
         zHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dy92T63KJ9Q9h7SiErNQEXUlQ8OKcTJsbD/s/H02xn0=;
        b=Aofwkar8Bym7MyLL+JnZq1lykh+hKcrQ6vqMjmmzzr7+uZxW5s9br7aNPUTqDC9sBF
         W12ZuSQrG7KXH1tXEtmcZw3CXlBB1L6LmTkfzPzRhaHhJuRasMnpGwpI6XsZmvkvyok8
         Zvau/FZrT9FOWCN2OxcumNgeXGnico/cduFZRohzEfjbGtvpI4+burQ4WoCuaGn9Erh9
         xyIkLitp0tD7v71dl5Y9v0186y/tyB2g3htAajkK3QrZntTCDhqnQZaPOFpsT9P7ZSMx
         ELBGa3eKU8Xv+0dQuMSzgauWHeAewuKo12fAaSQr0Cp7oaoMaZRUlyTHH/WTycWKjIdG
         FPuA==
X-Gm-Message-State: AOAM5302Sc9qvGpQLkCBi2JrdPBEHDc+h987zdJ0Wm0iyFBwguYMw5+S
        /r1m/GWAi0xydbB8/oze8Q==
X-Google-Smtp-Source: ABdhPJz5C8TKsukA3b1o1I8Av5bkzcF9Bzvrc6yl3VHd2AxHSqhgS3tdG4b2plRg/55UjC+HcS47fA==
X-Received: by 2002:a17:902:c284:: with SMTP id i4mr12024270pld.287.1598453111944;
        Wed, 26 Aug 2020 07:45:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:cfa:a9b5:1951:3e81:92cc:b4c1])
        by smtp.gmail.com with ESMTPSA id o66sm2561214pgo.25.2020.08.26.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:45:11 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     jacmet@sunsite.dk, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] usb/c67x00/c67x00-drv: Fix Data Race bug
Date:   Wed, 26 Aug 2020 20:14:59 +0530
Message-Id: <20200826144459.8245-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Currently in c67x00_drv_probe() IRQ is requested before calling
c67x00_probe_sie() and hence if interrupt happens the reading of certain
variables in the handler can race with initialization of the variables,
for e.g. sie->sie_num is written in c67x00_probe_sie() and read in
 c67x00_hcd_irq().
Hence, this patch calls c67x00_probe_sie() before requesting IRQ in
probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/usb/c67x00/c67x00-drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
index 53838e7d4eef..2e816d5ca0eb 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -146,6 +146,9 @@ static int c67x00_drv_probe(struct platform_device *pdev)
 	c67x00_ll_init(c67x00);
 	c67x00_ll_hpi_reg_init(c67x00);
 
+	for (i = 0; i < C67X00_SIES; i++)
+		c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
+
 	ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, c67x00);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
@@ -158,9 +161,6 @@ static int c67x00_drv_probe(struct platform_device *pdev)
 		goto reset_failed;
 	}
 
-	for (i = 0; i < C67X00_SIES; i++)
-		c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
-
 	platform_set_drvdata(pdev, c67x00);
 
 	return 0;
-- 
2.17.1

