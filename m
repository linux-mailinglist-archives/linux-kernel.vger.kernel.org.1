Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2FD269B22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIOB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgIOB3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:29:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD9C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:29:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k13so469552plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+LDE3L9Rd8xod+nf/fpSOnkKm7sgObU6S8Jc8pawso=;
        b=F1z8pHLtsMKTgjLCJwEKW1if7OlBk/BJGXliEkqJtz1XyhXOnJ6eq+idoYzutmORrC
         MCYok4vVyi2rIjFcZ+cmb/RfEJyO5ApwdANGHg+08822wHnGrMQFMnljHKnIuE1MtpZp
         +JUPGEicjz4uFX/LVv9vOLH1UhhJB5h9qw1xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+LDE3L9Rd8xod+nf/fpSOnkKm7sgObU6S8Jc8pawso=;
        b=rGBU3y4PwatctaKChPjbfButnU7nAHUQoA+GOfYRSuaNi45dkf0HZGsJPO/FlvDN/K
         EHgARqV8g96bKJysqUTdCIB+qcYa28Gu19k5Y5v8F+GqNKj4i96o4ya6refv3VPV0K+D
         B9CWvrz6Uj0oschjELYWFCK3F16JLyx1W7GOnkRRyijIG1AV2AgPGqqEsfr8hB6oRicV
         wawlSuDM7ej4wP9VrO46XqxkrDm2XL8/T6ViE5im70pjwkcxl0kCN0MZVBRfEhOk2YM7
         TuJCWfqjS8tdwPYss52m8e08EAjxY5VhCSsqbXO4J2bLXHsl/lhEhjyEFieWkGAxxjIC
         FV6w==
X-Gm-Message-State: AOAM5300JtJ64O+aza09HanGIlYV15JbCQ7yfSuHg2SLjpZ/Djxt6mbO
        tIWSjokydflA4N7jfNd/hE6R0p/QFooR0JKn
X-Google-Smtp-Source: ABdhPJy+etAFBiDkHJSo/6zbE90jCDLyZuj1RY6mOM/cNh2QN369FMFz48olkXcBWv6vXwIGmu6wrw==
X-Received: by 2002:a17:90a:ca03:: with SMTP id x3mr1945421pjt.92.1600133358893;
        Mon, 14 Sep 2020 18:29:18 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id bx18sm10173790pjb.6.2020.09.14.18.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:29:18 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH RESEND RESEND] remoteproc: scp: add COMPILE_TEST dependency
Date:   Tue, 15 Sep 2020 10:29:11 +0900
Message-Id: <20200915012911.489820-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will improve this driver's build coverage.

Reported-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
Hi remoteproc maintainers,

Second resend as I got no reaction for almost 1 month on this one-liner.
Pretty please?

As explained in
https://www.spinics.net/lists/linux-media/msg175991.html, we need this
patch in order to merge a driver series in the media tree. If that
looks ok to you, can we pull it in the media tree along with the series
that depends on it?

 drivers/remoteproc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c6659dfea7c7..d1fcada71017 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -43,7 +43,7 @@ config INGENIC_VPU_RPROC
 
 config MTK_SCP
 	tristate "Mediatek SCP support"
-	depends on ARCH_MEDIATEK
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select RPMSG_MTK_SCP
 	help
 	  Say y here to support Mediatek's System Companion Processor (SCP) via
-- 
2.28.0.526.ge36021eeef-goog

