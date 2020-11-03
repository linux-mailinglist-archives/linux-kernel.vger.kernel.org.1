Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6762A3FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKCJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:25:14 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC787C0613D1;
        Tue,  3 Nov 2020 01:25:14 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r186so13239127pgr.0;
        Tue, 03 Nov 2020 01:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d4/h03zDOqgw/qAdyGs1ZWYJc/s8UVCZlQD6aAR3ofs=;
        b=CFHG3pIrXH/BjoBalfhiCV8O5Ha/FfKxT1XF4T5PtPV8QH+tVrqYCyt3e9tnz58lPo
         kF025AXuyvxpElsbaAID6c074+MCB8Se7Ogms+g3EamLMfJGkdQlm8IZwr/yqUQOZ6JM
         AssRqicOLhbDyMmpQJksIa79rN7PWXokyihhi8g4VtN7IqKDRfsAx2vT7Db30thiGsXK
         DjEjqg/1LW7I+m4b2EnKN6SYMB2LsaUneNlguP/qWoJ3cODk1r/5Pf8wyzQGQMYktCNa
         QT/RhG6Xa1gbIisTkeh2fSR+IgqjknsX/BoBmxAqTh3+ZGQ2OehDAC4ZL/GD3K3o2v4S
         dFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d4/h03zDOqgw/qAdyGs1ZWYJc/s8UVCZlQD6aAR3ofs=;
        b=pizIrDir6o6wJ6xFYoXitLVeCwdSgCzZj/D894+hp0mdUZyyVEQ99BmGScCMOOWu1B
         B4rfCmoFPdMRSP2Vihl22m9N9DmJBGWBNX1UdaPcgJc9ioiXvRjYtDn/60rYTlXWLUym
         YDv+Mexu8bz1p1yCeWrS5UCl7z0pxw6HcAzJr2N0NJZeNxdp+wANMzgmvt0BQOJ8dTPH
         XEoqJMDZ94lqugi51WMNaZRtQ5RmstIuevaXiMp/MyYjlEDku5knejtNwFG8F6WlF8Uq
         R++rwK5biByMEIVESi6EvKKYWXcGorqCZDX9f55Om8W6UNT2+ss4cCvtF3N1GNL9bxSV
         E2Mw==
X-Gm-Message-State: AOAM533cFeV3B8y064moK0BJroMc6spkeYcc2rov2K65PiS9VdKiELpS
        /gkrh1EpeCiNnYWOBqLNARNqN3/ur2k=
X-Google-Smtp-Source: ABdhPJzzSXkmwpVed/iaZEeYmHrj3yrsBkXxQTnEj1IHfu/kslP0zHmNkNF9kljvj+cMOG01pc9dDA==
X-Received: by 2002:a05:6a00:850:b029:18a:a8ce:d346 with SMTP id q16-20020a056a000850b029018aa8ced346mr15585894pfk.73.1604395514273;
        Tue, 03 Nov 2020 01:25:14 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id b3sm16045356pfd.66.2020.11.03.01.25.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 01:25:13 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] usb: dwc3: Replace of_reset_control_array_get()
Date:   Tue,  3 Nov 2020 17:25:00 +0800
Message-Id: <1604395500-8086-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_reset_control_array_get_optional_exclusive() looks more readable

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd2..e358ff0 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -52,8 +52,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
 		simple->need_reset = true;
 
-	simple->resets = of_reset_control_array_get(np, false, true,
-						    true);
+	simple->resets = of_reset_control_array_get_optional_exclusive(np);
 	if (IS_ERR(simple->resets)) {
 		ret = PTR_ERR(simple->resets);
 		dev_err(dev, "failed to get device resets, err=%d\n", ret);
-- 
1.9.1

