Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9F293845
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405807AbgJTJhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405571AbgJTJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:36:39 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FFCC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:39 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r4so1042726qta.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AbwKAlpRbBzxsSe5kAQOuBfb52JpqxZSOcBoGgGmeso=;
        b=sl1B9B4vv5eN+xZj8B9SY5vK28/8Nz1jwaPbrJE/msIPNNFFrSoEQqmU27cNWPsj7y
         Cyss5ayFY76AwKFLzGi94YERh8DiK3EOWwCSXg1atpnwpbZc2K4KfOT2WhTDHrlxoPYV
         QoE1lckmwc9BQVRE+r6PwlNae93PF0QRYcHcETgJwYKZ40VJLrSCR0Da/3+WEfNwYLtb
         LUy+A76xKqOuZ37h80XOimz++QLKGagjQR1UeM06nwzTRcoY6lIZJP7SnzCbVBUCj4eY
         UZe+MMDdbJ4TJ2MpI9eSuu6wWjp80QdchZ6TdsUmQ6JHRJ2T2EdCpe4IDuikDEWeV7pw
         g48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AbwKAlpRbBzxsSe5kAQOuBfb52JpqxZSOcBoGgGmeso=;
        b=AfsVsMBcWN9AFedcKmbrpaf3I3FNTVioYVDLRwnET/lRVwqoe2QaUITfMVoeFfiP0s
         wYjo8jSDUzvseJWsNKHhFTFntCuXGp9iPU50V8BbuVVPq2QtKZQNM2V2/cS5oywVL3yg
         UkaFYNnnmVw01pl+SwWhS3NnvRKv8ZW3/VQxdTYwJnHbgzvSzrN5e/DNzy4qBHOkL/2v
         mGfk582GKK5DUGyOCPNda65jJU21nMlr4PBO0XqEKr7pPLVgf8fNGT5/hzadcusn5JwB
         PboiLYHosC9ipLUXbDaln6+TZF8hTB72v2maw/3jyrNWse/FswfQZ3LAXSdLZs+4bT9b
         2Bvw==
X-Gm-Message-State: AOAM5320Q7uaWy4SFdw0UoEA979VTPFaYTrYUvf/s+OuC4IfvjBLwZsC
        MBlX8Y6HfLzJpNVn4iKLINYj0AT1hlc=
X-Google-Smtp-Source: ABdhPJzu69fZ64i2g+ZoQbQGoUr1mjfdEBTdPzFBtfaMMP+XumcOlSeSNGCvZcEGbNqKAO/YAfp54nsGZ/Q=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:5184:: with SMTP id b4mr2229953qvp.26.1603186598658;
 Tue, 20 Oct 2020 02:36:38 -0700 (PDT)
Date:   Tue, 20 Oct 2020 02:36:20 -0700
In-Reply-To: <20201020093627.256885-1-badhri@google.com>
Message-Id: <20201020093627.256885-4-badhri@google.com>
Mime-Version: 1.0
References: <20201020093627.256885-1-badhri@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v11 03/10] usb: typec: tcpci_maxim: Fix the compatible string
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
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing compatible string to include the part number.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
V11 is the first version of the patch.
Introduced to add chip number to the compatible property to address
Rob Herring's comment on dt-binding patch.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 723d7dd38f75..82cc257fefd4 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -481,7 +481,7 @@ MODULE_DEVICE_TABLE(i2c, max_tcpci_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id max_tcpci_of_match[] = {
-	{ .compatible = "maxim,tcpc", },
+	{ .compatible = "maxim,33359", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, max_tcpci_of_match);
-- 
2.29.0.rc1.297.gfa9743e501-goog

