Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6390A2FA22B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392473AbhARNv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404724AbhARNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610977774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R1fTME2Xx4DitCdE2DcFGBglSf88fZqDqOdTt4xA428=;
        b=VlCdwhXHDkTE1FiNU0Huz+F52WnZ+UCMmhQg4MGQ1XF7W/BD3vQkf/NsQd6H+rAQu2S7Uc
        ES1hTN3u62fI+374TgOVVUDwxoDRBD4m/k4FC9fxp7+6dvZj7GI9ryZskQO/MTl3gZyDY4
        ctb2aqN2AMyNgtGX92lcAh978vDOPAA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-tiHrkLwFOL-aVxEvhtIh6Q-1; Mon, 18 Jan 2021 08:49:33 -0500
X-MC-Unique: tiHrkLwFOL-aVxEvhtIh6Q-1
Received: by mail-qk1-f200.google.com with SMTP id b206so17136771qkc.14
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1fTME2Xx4DitCdE2DcFGBglSf88fZqDqOdTt4xA428=;
        b=Evu7c4WMy8YicH/qjPBHUlGXWI+lrbRvD1GaKHx/uKAB/tjwAxC/aQp2pgbZeIQzYv
         KVjhRBzF3z1+HjB2lSlWhBa+t3TYZWsInJ8WeHZ7z3fCJ9rPxynWc0z41G0TJ4z3ossY
         q0si/KMBBMU0y2KcQ9iSOgGYtbAwRXFIsItGt2YiVp5QwOx4Er6jfyv81n4dpoq9JN+N
         kO04vLF6+If6a68LK1h5UTU8UcKAJdPZw1G2XMo60PgnHeAi54THrfPLdsov1+JPWPid
         rWL4gW6w4OjyEMEDzWgXW+uCHdHDIpUz2tm+PEFHz063BhfjH1kckiisVMGMaphIkzAX
         xu9A==
X-Gm-Message-State: AOAM531Gx/AmFH3VYK6Qq7XLGT3mog3rwUNPGkTiCMcWgU1UYl9QGLiw
        2z4IOPWNXTPD4FcVDPGC/c5EB3MSGB8LoGLCLJMeYCszECgTSoiLk2ivgRF/BTMCjUCU8OCALL4
        P+neet2LqAB3CwY75rZAjdhPN
X-Received: by 2002:a37:6245:: with SMTP id w66mr24147611qkb.422.1610977772725;
        Mon, 18 Jan 2021 05:49:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOMC29Y1VqUypHma5nna2hENgFdPeZytx7wLwpCWmcqSXDCFb+/gAcFgfbAQkjPmrqPo9vtA==
X-Received: by 2002:a37:6245:: with SMTP id w66mr24147598qkb.422.1610977772555;
        Mon, 18 Jan 2021 05:49:32 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 8sm10473419qkr.28.2021.01.18.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:49:31 -0800 (PST)
From:   trix@redhat.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] clocksource: mxs_timer: add missing semicolon when DEBUG is defined
Date:   Mon, 18 Jan 2021 05:49:26 -0800
Message-Id: <20210118134926.613931-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When DEBUG is defined this error occurs

drivers/clocksource/mxs_timer.c:138:1: error:
  expected ‘;’ before ‘}’ token

The preceding statement needs a semicolon.

Fixes: eb8703e2ef7c ("clockevents/drivers/mxs: Migrate to new 'set-state' interface")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clocksource/mxs_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index bc96a4cbf26c..55aa6b72d075 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -133,7 +133,7 @@ static void mxs_irq_clear(char *state)
 	timrot_irq_acknowledge();
 
 #ifdef DEBUG
-	pr_info("%s: changing mode to %s\n", __func__, state)
+	pr_info("%s: changing mode to %s\n", __func__, state);
 #endif /* DEBUG */
 }
 
-- 
2.27.0

