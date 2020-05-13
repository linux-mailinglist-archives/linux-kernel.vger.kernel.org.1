Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68421D1298
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 14:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgEMM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 08:26:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34586 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:26:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id s9so13449971lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aNNVeixqiqZ91E3FL7w05+hn4W4WoR4dAov2fW/Uqz8=;
        b=ue7HrhHndfTkhM/B1tk3L7ish0F/54LUYJYO+ADiBA7zOagKE2UenbQte3BzCwzuVB
         h58UaCIZmkdg7kJ+QRwaS99y9aUvT3WCaVLwmBBaAQXieHAHwKI16OmLSXzCv5sgCgtV
         sLr+EMKxf13WSN9liqXIdqvjDRgST/jGjqrsf9DxG96qXAYriH66tZIGAOIYOHmK+DQF
         1wqXNj+E9q79eMcNNSq6PUSPqEJe0SVIQz98COTeoDsfs8XOimw43iRGgiyZlTU90nca
         p7HcpVU+MQN2qzZAQWFyx1QZmVNydQ5mOx9PU/e74dhFwPWBNZm+P01+GzoStKmpLb4h
         JfbQ==
X-Gm-Message-State: AOAM533T4HFORZHr7RhASj04rjSF9KfO+lXkKCWGAprKBekK8ZBZvX5p
        BweHwGSfP6kzdekyC4/dh70=
X-Google-Smtp-Source: ABdhPJyVJum/zdD+PcYoJCYKvDViRaKMBxvSBlVAMvCu3WtWaSKa32U3YEMMhyP4iLoQgrA1X24FnA==
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr18130997lfr.77.1589372763124;
        Wed, 13 May 2020 05:26:03 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a24sm14576237ljk.10.2020.05.13.05.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:26:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1jYqSa-0004Qi-7q; Wed, 13 May 2020 14:26:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] clocksource/drivers/rda: drop redundant Kconfig dependency
Date:   Wed, 13 May 2020 14:25:48 +0200
Message-Id: <20200513122548.16974-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2f8a26c166eb ("clocksource: Improve GENERIC_CLOCKEVENTS
dependency") all clocksource drivers depend on GENERIC_CLOCKEVENTS so
drop the redundant attribute from the RDA-timer entry which was added
later.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f2142e6bbea3..ef5331ce5fda 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -120,7 +120,6 @@ config OWL_TIMER
 
 config RDA_TIMER
 	bool "RDA timer driver" if COMPILE_TEST
-	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
 	select TIMER_OF
 	help
-- 
2.26.2

