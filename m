Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F52A3B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgKCD6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKCD6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:58:04 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BE3C0617A6;
        Mon,  2 Nov 2020 19:58:03 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so12625160pgl.5;
        Mon, 02 Nov 2020 19:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/I1Zw4H3dYx4LoYnfze2QMgf89zOWPqxz/+LXrdwq+s=;
        b=o3vVIH8+fjHyHItJzmdHX9QlszM4LCZfgD2qJ5mjg7UL8q3GcFkJ3wLroRDerD4mSE
         uouS05UfQsx6Ga+VN3KZM//ldxuVcSzqb34BFsd2dLdWwEj/LnWbwmFBbEXKjTowApHK
         zwmePBGUsKHfko0upsABba/hozkkCy497gpTXpGIGpOwqh2ZMpZHPXQLfozxLA7LoUnK
         CGiUjRyCBXlwkKC22wzF7PEKJHHe/BybkaH46NockOdV372Ls0RGFL/Csf5V19BJ6/x+
         eeb8+kCXS5OfbvA/SymxjWjxt2cMqWo1J0z2RSXpBjLtSwBB2nUCa/878zn1ROQ5x6Hq
         cfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/I1Zw4H3dYx4LoYnfze2QMgf89zOWPqxz/+LXrdwq+s=;
        b=DzFhHAb7T0Q1vUGduGUFia+npzxNWQ3Ofb6QBSUihSi61yuOow6RpbgoGoXIkw4RH6
         X1eVUbiNTQ/5NBjR7AaTgdRFhDmM0RD4uaxrhM4TZFO5m8QCf7QSaU0a79s8FwJG7xo6
         k/qAb4vhvUp2I0xFaLs1uCvdW/++8/uxmL0kBmAMiheUbess33tGJ65GeON7i7PiPGL2
         nzAj5/RNgaUhLJQl91ZOruN7Zpx8rSuNOTE2CEn9efXWQ/AOx+CjD9N3AV8tB7OLYuQP
         p8wXnvyVJTKNV3FWIVx7Gsydsygk8AkAj9p0e5CmVo3H+8riSqyjZPH3VGJKw6vlb2sN
         U1TQ==
X-Gm-Message-State: AOAM531A3FtAC3VnwwR5qgYhO/dXP65+i/eO0kvzJRuSk+2Ezw7q2K7U
        4t9BELCqSDbBf3kLKeb/Fg0=
X-Google-Smtp-Source: ABdhPJxHwRHCzCNEc0EpldiedT5K4k9Gg1EVAQvLVO5uUCuN6/rZwBjgA+fiElUSdwEmkWPoeWcZ7w==
X-Received: by 2002:a17:90a:2e11:: with SMTP id q17mr1622412pjd.5.1604375882635;
        Mon, 02 Nov 2020 19:58:02 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id jy19sm1098303pjb.9.2020.11.02.19.58.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 19:58:02 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] usb: dwc3: core: Replace devm_reset_control_array_get()
Date:   Tue,  3 Nov 2020 11:57:43 +0800
Message-Id: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_reset_control_array_get_optional_shared() looks more readable

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 841daec..b87acf0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1490,7 +1490,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	dwc->reset = devm_reset_control_array_get(dev, true, true);
+	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
 
-- 
1.9.1

