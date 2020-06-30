Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C5020F5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbgF3Nen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732724AbgF3Ndx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so19613124wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qGhRYBFyg4w70/+i8v0aKH3im1q1Wu84G6qHkN10ns=;
        b=m5TXu/t5DKfMXruQKZB68+3bIMiutcLyKBEStN8LN7fnI7W31+Ke2AzvBR8VwgqjKR
         LqwayMuHUVg/5efbOBN+c7Jr5PsEe+CE1FN9f+EDZU+XR2HKF77dvsLsvNzwSw9+Sszb
         /3M/mw8soiSberSwHv7Zi15ZVc7HUq0eVnUrtWiLDFwj5IJXDUbjclnJKU9rbOXe+LbB
         ONz02j168Rt3Gw6tn+TFBAHJ94k922AEa2refrxFnJrzSG1Zr+nOH/sHdeKLyXNxx50T
         hfXn4EeRnGQ/vOjTI860tqbnIymxlU+3sB0X9hZgmUyDUB3MDcTHNcsEB6oyKaSQOmbo
         Snvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qGhRYBFyg4w70/+i8v0aKH3im1q1Wu84G6qHkN10ns=;
        b=Xuqd9DcMy4aZgoITRKTIUuLlYhPiGEXsLM5uk/Bv7UZlamMmjHr7HnOJluampuN70Q
         Mia76AVWQNcAUJmA/XX+tHS33HRIwWD0yE+1gSKIJhRikIVJodwfL0ZiIIRscUUocIf3
         Ji72wIMnc6dPJY/GWDdrrZMOUUJGaZNy7+o1bKzzwEZamYtJQIaqGYwqs/Hxz5d/M14t
         6/u0xaz8BQKhS4guFA/NwMaGpEvxdCTpi5MgJ1hhK22tP7HKQ4PxkKiuMsuVMrvurY7H
         Iugh0WZ96bznXS+0sCeyip9Dsq9qGG77gjU7Qa7eYEm4L3cPSmolsxjduxqVdrYgBYxV
         ASCg==
X-Gm-Message-State: AOAM5321h/y5QSZZaiEgLl19RcKjp0VqUS1yA8zDHTz5KpZ5l8yzMs5A
        5DR4Ch4OO+pjBoGyGtIRQwRK+A==
X-Google-Smtp-Source: ABdhPJwxspIcxssmP1G2rn5ofE8vN2GTlugAs3HTO7L+/ydE6J3tNErrAGTO6z80v51SGDcQuZLyCA==
X-Received: by 2002:a1c:16:: with SMTP id 22mr20990748wma.42.1593524031756;
        Tue, 30 Jun 2020 06:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 03/10] gpio: gpio-ml-ioh: Fix missing ':' in 'struct ioh_gpio_reg_data
Date:   Tue, 30 Jun 2020 14:33:38 +0100
Message-Id: <20200630133345.2232932-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct ioh_gpio_reg_data's 'ien_reg' property is missing a ':'
which confuses the kerneldoc tooling/parsers/validators.

Replacing it squashes the following W=1 warning:

 drivers/gpio/gpio-ml-ioh.c:63: warning: Function parameter or member 'ien_reg' not described in 'ioh_gpio_reg_data'

Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-ml-ioh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 92b6e958cfed5..53d4abefa6ff2 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -44,7 +44,7 @@ struct ioh_regs {
 
 /**
  * struct ioh_gpio_reg_data - The register store data.
- * @ien_reg	To store contents of interrupt enable register.
+ * @ien_reg:	To store contents of interrupt enable register.
  * @imask_reg:	To store contents of interrupt mask regist
  * @po_reg:	To store contents of PO register.
  * @pm_reg:	To store contents of PM register.
-- 
2.25.1

