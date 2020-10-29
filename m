Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8929E435
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgJ2HgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgJ2HY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4057C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:48 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a27so1396423pfl.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NlA2Q1plJiXwee/bURImWwW/NspPrk3H/x9qNMDU45U=;
        b=IXq8Lkth1DgtGhxxU++wRNHNtTarSAIhhkxHYxbzunphsM38u/04C5L6HuMTqKCRib
         KrnD5sA3YR6eQCk/xvfa0ENEjAuZHtL13ib2Kp45EJJlij9Tb+iBnlzg+6kim8uzaag5
         36HkTacBASFUPVXdhdcb4FiA99mLJoSZzJBmbYylzMA0bVFw+QgVL712zNKHcriuENDR
         7yBeIx9Xyn0thPYexVaNDZTPmvBRyeefzeODnjyxXn54NBxk8WjkPsM0uEEQXtGuos+m
         A0mcjQJN5qUOx4k+vT/xVYv+3uDAafmzp45jYOmdenmVN389cBWQPY2FDfj9y9piqBA2
         GAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NlA2Q1plJiXwee/bURImWwW/NspPrk3H/x9qNMDU45U=;
        b=eom10PXX5QdmfJb6/wYHplcV5l9Kvlq8/AnKnZHFxqtISkAW93iWjGvwN/+eCE4boD
         clDmAjNQVUkhyJn5MFfsP8GN4SY+kClnEDYbmAjEk6J01bM64VORUwsS3aBSD6QKQnkw
         fmvdtCBjmDQHBfgp7aLUWH/dtsL/CPuFCbjfsdf+fYd/p84GSFYvohjKTllcKwd6xFIx
         Up18h68pkzsDX1pNMr/LWqhfiO6+9yIntc/XYzZBmdW2bLURf6LmH1gTnJgy4p2qOutX
         8U0ZLxNrKq2TDERHD92X0Ftq88fisgaxPCOVu8YPqq4th5xgW7IFpW+NFAUsq5qG99WS
         nv4g==
X-Gm-Message-State: AOAM531vLry/eIkagZ70q/YnK5VFTm42/rR3scbS4HlPL/M4xbvWurEt
        Sx9TE7Z5PDUA/0neg6iWwacE6vHq3bY=
X-Google-Smtp-Source: ABdhPJyDg7/xASjhCuThx+DjiDF6mhdbWThW7djCT8831GwkNZwkEVnqwdncJO2LoLf03eZ5mI8SDUX0Ho4=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90b:1081:: with SMTP id
 gj1mr2013442pjb.15.1603953108066; Wed, 28 Oct 2020 23:31:48 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:31:30 -0700
In-Reply-To: <20201029063138.1429760-1-badhri@google.com>
Message-Id: <20201029063138.1429760-3-badhri@google.com>
Mime-Version: 1.0
References: <20201029063138.1429760-1-badhri@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 02/10] usb: typec: tcpci_maxim: Fix the compatible string
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

Change since v11:
Changed compatible property from maxim,33359 to maxim,max33359
to address Rob Herring's comment
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 723d7dd38f75..a5014c3b51d5 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -481,7 +481,7 @@ MODULE_DEVICE_TABLE(i2c, max_tcpci_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id max_tcpci_of_match[] = {
-	{ .compatible = "maxim,tcpc", },
+	{ .compatible = "maxim,max33359", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, max_tcpci_of_match);
-- 
2.29.1.341.ge80a0c044ae-goog

