Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35E29E451
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgJ2HYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgJ2HYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A45C05BD35
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:32:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z31so1361006pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IoB5J93gR+QUze+mf8kh5Lkrb9ZTRoUgNDrcGrdGKf0=;
        b=Bjc7EFVW6XPepdSF7ku0VsGSN6t7tPM1ahLGmVXmJVJT45tQlAHhg8333I+uUQpCx3
         /OkWRMBtly2rxTmJGaAPu8VKSG1R0+CNUrOxQ2pfQNh988x1rB2z/FW0MGz9HpTMRqxE
         3uU/7EqqOfiGwr7tvP9fg+xOi//0THL48cuZPYYcYpJ8cE6ePgn5hFtScifeNWbRDpxW
         EwxnVWbj/BaZYXQ/usgr2b1iEcU4T5uDdFSB+dAaV8ZQFEPGRlnbxQYfJSqLbd5zUmgJ
         DMpI0+zPmsnCMNsqL9yJPjeNojVxZwA/NhSJTiacjsvpI3+Ol/I85nabFzNFNmPVPV2B
         TNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IoB5J93gR+QUze+mf8kh5Lkrb9ZTRoUgNDrcGrdGKf0=;
        b=Y89blsAeSZC56aLkDGk2Jl5bNHcELbMiHAkUmubSva9/SEXX/VL4Mf89F2owWuHjNe
         C7/HXk8yxupUQRd7zN5Jot3PlD3JFNLbuO/7vPWsGVOeGRdHvT41b2AECJiCV6peXVZ4
         jzaL4HwBnr6/VTJ7umJfFuZKOc+8fBsu6ANZUAGzoNG0m0zdlVGGnv0FfHpEWOXp+vNp
         63DNb3ClEaXQcQgeDuzQM362uAJLtgPJYCvOJOdCDnQByA/INsYSbAdfML/nYGnC+PUm
         qmAsEJrGa3ZBdOuek0aiyB0grVGt+ZaXPaAJcHVIURMnLI9qh/4eVxdq6FHvqYzKaMqd
         /oiA==
X-Gm-Message-State: AOAM532kSJIiXl1Ule/lzIKrLL3xL8/HlyMwzOKCYcsqVN0HF8RoLQ2+
        VTQwC/bTEdh8IE1/wjI2mVog2Cplvlk=
X-Google-Smtp-Source: ABdhPJzk09EJJdAKs9QaD6gdc9DEDB0lt0+OJt3h7YXZUQ0mQGXkJoMjlfxQmpHos1KMQ4s5ZEG6YB0tO3Y=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a65:55ce:: with SMTP id k14mr2735983pgs.65.1603953124910;
 Wed, 28 Oct 2020 23:32:04 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:31:38 -0700
In-Reply-To: <20201029063138.1429760-1-badhri@google.com>
Message-Id: <20201029063138.1429760-11-badhri@google.com>
Mime-Version: 1.0
References: <20201029063138.1429760-1-badhri@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 10/10] usb: typec: tcpci_maxim: Fix uninitialized return variable
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New smatch warnings:
drivers/usb/typec/tcpm/tcpci_maxim.c:324 max_tcpci_irq() error: uninitialized symbol 'irq_return'.
drivers/usb/typec/tcpm/tcpci_maxim.c:407 max_tcpci_probe() warn: passing zero to 'PTR_ERR'

The change fixes the above warnings by initializing irq_return
and replacing IS_ERR_OR_NULL with IS_ERR.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v12 is the first version of the patch in this series.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 536df4a7901a..c1797239bf08 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -343,7 +343,7 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
 {
 	struct max_tcpci_chip *chip = dev_id;
 	u16 status;
-	irqreturn_t irq_return;
+	irqreturn_t irq_return = IRQ_HANDLED;
 	int ret;
 
 	if (!chip->port)
@@ -445,7 +445,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-	if (IS_ERR_OR_NULL(chip->tcpci)) {
+	if (IS_ERR(chip->tcpci)) {
 		dev_err(&client->dev, "TCPCI port registration failed");
 		ret = PTR_ERR(chip->tcpci);
 		return PTR_ERR(chip->tcpci);
-- 
2.29.1.341.ge80a0c044ae-goog

