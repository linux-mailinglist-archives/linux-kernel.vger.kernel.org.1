Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580E524B6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgHTKpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgHTKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:44:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98AC061342
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:44:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x6so920336pgx.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Unw7a1Ns/qnZTpkEKrE5+CVHDBMwx2azmJ5ZvPCv2dM=;
        b=sU8Hrsb4MRIfnmL+kicatBveHr6TQM9RoJNr+RAbh93aHXDZrQv9ReuauGVZpjxDNt
         ASiS4rhFQ/GrsH/okv8NaiVqAUFe0ihnPbuHzsOb15CGUIFTzCojgI3ZAJiQBy2EEqYi
         GlAbVVpZkoQP1G4AsoljriGSJ5dCA6RwIdVp5h8FwYkner29DM0aMSHjcR0MO3+DkGNu
         sM7SwLparwQvQQg1fbd7SKH3yXqUxBrZ6CdrCGw+Y4Um8ZyydkwrNL+xFW5rfIf/ZwSm
         kMTDd8kinv2lcd0GxAr4oqWr00Lz2DZ7gIThbx8asjQE64BdDJJ2YiDiyxRfMCpB5Vb6
         YZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Unw7a1Ns/qnZTpkEKrE5+CVHDBMwx2azmJ5ZvPCv2dM=;
        b=AdeAQpb+el2/hHJ4RCn1ID0bnrBBhguezbhwAYqIRVJWGt17U/VkC9kFZYKqPEXR9L
         Pm/wpj43vejS1NOGCCOUNFTMsSMktkFeXc/QzK0huSA45MLAn6GG6nap9SZ335VvgraK
         I4gqm95OFe6xZkDZyp3MmuFrWvUgXgNQrWntNKu+MlhVnh5slIX9rkG2vCbjmom+ZWSd
         RHy4YmFPoD5VlKGBt52xs1fvGLckYlFqT17WpuWxuFMnK5yqgL8UfzgBDUbr7/0c9Kn2
         kx0QAW4kk4xud4x3bLdnUeJMJyH+V7kxxAcgGMBIfNKjCRnhD1O9LZ8sMUgVe7RjZSSe
         +mQQ==
X-Gm-Message-State: AOAM532/ZJedPew/PfVC3PvLA6/tYMwi0UO2Kc+qLQT53bdVoPCaKHt/
        /JVIAwJ+SjTKE90yUhqiTpFzJw==
X-Google-Smtp-Source: ABdhPJw3lWm2gvdvqEFJvs9I9h8XevmviefGFlp+suPuncq52jE6Q1kcFXUraBxX4h2bkgjQy+0Dgw==
X-Received: by 2002:a62:7c4f:: with SMTP id x76mr1854639pfc.124.1597920276683;
        Thu, 20 Aug 2020 03:44:36 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id a17sm2418743pfk.29.2020.08.20.03.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:36 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] tty: serial: qcom_geni_serial: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Thu, 20 Aug 2020 16:13:56 +0530
Message-Id: <607b871b70f64f5364f5d3dbb3ad2efec7dc55c5.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3aa29d201f54..e4c90a76e6ac 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1433,9 +1433,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return PTR_ERR(port->se.opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		port->se.has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
 		return ret;
 	}
@@ -1478,8 +1476,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	if (port->se.has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(port->se.opp_table);
 	return ret;
 }
@@ -1489,8 +1486,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
 	struct uart_driver *drv = port->private_data.drv;
 
-	if (port->se.has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(port->se.opp_table);
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-- 
2.25.0.rc1.19.g042ed3e048af

