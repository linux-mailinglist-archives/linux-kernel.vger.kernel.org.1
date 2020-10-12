Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E273928B034
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgJLI0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgJLI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:26:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E672FC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 01:26:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i5so16012985edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=guf7LBZB+jebJNmvNlxvwGiiPJ9suzGx8GM0b0zPjxw=;
        b=Y3i0PbWi5gCOEobDoUQ47XbFH8pfiryrMx9+NFIEfYi3OpKW3hrCCeDNhMzfjjHj2g
         bsVMn+AcSV2p/xaYAtbpSc7kMpA66T1A+udaBv83krh2l0TmCnc9iNOLkUMB9Cfroe6P
         jV3rjuzJ7ZLlDy5C2i7CT0VOCJu7GYP5TDPF/e9OQn4Nw9ABdZjYA6g/W8TI37YLwAAV
         x6y8dRF3Trj6jYjWwDhttKflcth/o23eEvvIWuCYWA7sQ5qqdhIjh5HTzMhifWV0IqJH
         um/Fn/8OX9Ur1aRs48dujEQGoWhY/IJlkvHmTbqriOcm5S+QIZbLwFyFqIbFxGokTH/U
         93Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=guf7LBZB+jebJNmvNlxvwGiiPJ9suzGx8GM0b0zPjxw=;
        b=NwlTubz/wPT558vYubyD1fCXVdb3aFyj/o6QJ2rH6gko/6GYTFUeD0D/XvWxCso0Vj
         LN6IyD4bmPSrEX5fdjH0wmebcQzeYBUB0u8xP6IuTHW7Dp3/kgSPhKvPLF+7ZqeP2vHU
         lGNrjySa+WfH0ox8z4njEn4K1r4WJSHuiCMASh1i4+QfdkCqOcWBKYtPm6UTyRXMWWqn
         AezfKtJr7K5TP1NPy+XJHnUrG9EbVGowjhXl4XWOdJwtMmCVGDaGiV4OoMB6ofx8LSgv
         CQfuwwa5vNbhCtz3GTXFaSo9DlWy4qyox8gtByzyf7/dHi95Nv2YtgZYHymYUz5UIzMO
         vmKg==
X-Gm-Message-State: AOAM5313Cs4S3wBMgetKaIAvjnfCoqCneFANBccfnS4qIWc0AGfo/w5V
        NdTh04oJJAhOBU3BGB9DQXOiqIiaGHc=
X-Google-Smtp-Source: ABdhPJzEE/sIzeUVWPJX6M2mgMFt8PgxnDCWQXy9ux+8j7tm/Akoe7Hi4vLRlhfTwDSZNQsBhwMF2Q==
X-Received: by 2002:a05:6402:187:: with SMTP id r7mr12442680edv.360.1602491193520;
        Mon, 12 Oct 2020 01:26:33 -0700 (PDT)
Received: from localhost.localdomain ([185.200.214.63])
        by smtp.gmail.com with ESMTPSA id t24sm5440859eds.76.2020.10.12.01.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 01:26:33 -0700 (PDT)
From:   izabela.bakollari@gmail.com
To:     gregkh@linuxfoundation.org, jerome.pouiller@silabs.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Izabela Bakollari <izabela.bakollari@gmail.com>
Subject: [PATCH] staging: wfx: Spacing and alignment cleanup
Date:   Mon, 12 Oct 2020 10:26:30 +0200
Message-Id: <20201012082630.275118-1-izabela.bakollari@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Izabela Bakollari <izabela.bakollari@gmail.com>

This patch fixes minor issue with spacing and alignment.

checkpatch message:
CHECK: Alignment should match open parenthesis

Signed-off-by: Izabela Bakollari <izabela.bakollari@gmail.com>
---
 drivers/staging/wfx/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 3f1712b7c919..83ccbab50899 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -32,7 +32,7 @@ static const struct trace_print_flags wfx_reg_print_map[] = {
 };
 
 static const char *get_symbol(unsigned long val,
-		const struct trace_print_flags *symbol_array)
+			      const struct trace_print_flags *symbol_array)
 {
 	int i;
 
-- 
2.18.4

