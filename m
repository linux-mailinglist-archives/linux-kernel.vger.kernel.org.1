Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0BE2A28CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgKBLMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:12:16 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3A4C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:12:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id y12so14094996wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQvi/kqzob40VtdqOOqNP3ghVTrtkQCbD5i8pv5yTaA=;
        b=W9C7s2pT4ecR+c3J9BAyR83UWEmtcEAFYGpIO6uEJJnj6JqhpaN7yy+pKtQV5otQt8
         Xmv0w/xwdfcHn3UZdBYMP76YNRYO2Ha8ryNo4yoqxBFlb/f5QFWexKr2tkFFWNzKEYnn
         TH+XoesO/nN2kUMUHZ9mgQ+FxriadKcd9HmqVkOiJF6S2+W665382n3mmnd4y48A8Zyd
         kHrX5WB9TY+ywcX2tNzvqcEUEjHCAaChJwQ3BgWZtHJojzdaJJrn3529vpJz+B/CySCD
         djsa89u/aVPUyWcEr5/u0JU/3ijZyHEJsHKBlp2+a6luWMFmsvtgTNas9lWdXA3KTbUD
         cuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQvi/kqzob40VtdqOOqNP3ghVTrtkQCbD5i8pv5yTaA=;
        b=T/vHyTsC8yv7rh7yLzZuaXOB2s92DstZgGpSDg1Y6KArR3cBF2606TlBRO8ZtnzbmQ
         oR0wdqCkrKQByJLrHuoR9SEVVcC+9vp9qpj43wdU2qkUSEFdxG04dF6ToLbNQ11rEcli
         4mBvTklz1Tq0BEE0ge6zEoldLWkNSvHOcgY7drQleITloso/WsnDmWrw1pJLbZFSlhB3
         aP62/F4oSVprGr9aDy3K56nrr4bayhGAcI7oGtMQ0viO6Ec45AQ/WPy/0doglE70t3Ld
         xBEGU9fckAvFPZYA6cFUuQn9eOXZotM9m0p3BQ3BhXsZ1E58mzc/nKw+LI6G/Zcb+uEO
         FCFg==
X-Gm-Message-State: AOAM5328YAuUMJFMerbZKoMK7fijZRJ+5Ce22b4L9gRxJr2p4UgDERlP
        O9dbLC0Ui79njtmVKAP4HhlGjQ==
X-Google-Smtp-Source: ABdhPJwrbLHtKPR0NFfII3ySOaz9bh53YW2YflvvQfJspoHY+OSSW7FeoDEcmQCB4aIibAT6eNrJzQ==
X-Received: by 2002:adf:c447:: with SMTP id a7mr20282657wrg.101.1604315535135;
        Mon, 02 Nov 2020 03:12:15 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v24sm22431972wrv.80.2020.11.02.03.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:12:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] misc: c2port: core: Make copying name from userspace more secure
Date:   Mon,  2 Nov 2020 11:12:10 +0000
Message-Id: <20201102111211.1047972-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() may not provide a NUL terminator, which means that a 1-byte
leak would be possible *if* this was ever copied to userspace.  Ensure
the buffer will always be NUL terminated by using the kernel's
strscpy() which a) uses the destination (instead of the source) size
as the bytes to copy and b) is *always* NUL terminated.

Cc: Rodolfo Giometti <giometti@enneenne.com>
Cc: "Eurotech S.p.A" <info@eurotech.it>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/c2port/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index 80d87e8a0bea9..b96444ec94c7e 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
 	}
 	dev_set_drvdata(c2dev->dev, c2dev);
 
-	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
+	strscpy(c2dev->name, name, sizeof(c2dev->name));
 	c2dev->ops = ops;
 	mutex_init(&c2dev->mutex);
 
-- 
2.25.1

