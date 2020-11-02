Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494372A2C91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgKBOUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKBOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:20:06 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:20:05 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k18so9665650wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3vl3ikgg/nqdcwb0Z1fZz7Yat725TZ1aEiG5hTv5aFg=;
        b=YPwf3FZq4fwBZKg+//H7OJXfhenPlkGUhzgIZpGiaPolOLrg7ijf3UE9gK188uoTWN
         cke7qIKS2+ENZz6fB6UkkzU1yvyeoGIbUailkLuF9COyN4NNuYVY7jItmg08DCSrIqpq
         y7fBIG28If6KW/QmRop9KtLL87HMQb0IPuiBwVYvPL1t15Mpf//hfAprBhrrMkiBxNs+
         MtGTGHGtsnFTJcfd9Xb8sUyM3vsnv7a8gQdMmsiOKsQorwkt0V4iq2tNzbq84BOYnRX+
         HoLHKKOKPsb3sEMvUpVDj9mYc8hC48FNezK7ojumLRzTopd5Km4WlIloMcGv7GutIoZd
         V1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3vl3ikgg/nqdcwb0Z1fZz7Yat725TZ1aEiG5hTv5aFg=;
        b=N8hVskEVd64jPZk5aNNpPsetJoRReG3/SyeRy92v/TINCxrTT0eYj9SRHxARz/GQ5w
         s9O1Rklg4AABWsCAwIWuwSdUjS9az/1IgVc7sVD5g81eDVeuL9K0dQVd/xoQ6esfO8he
         xDLtR3uZrVzv71dzaBIOztX6mB77jj4kJ9HmmR4PldRGlQTalwDG6p5McaPgzXm/u+FT
         b0d5AljZAAZSEvOrJuEv5KJZkSw6PmuWq3o9N1CRGJ+lQ+9EO1o3zx2+W1t7CYHtbh2m
         2I+cWf6VxwV4s0j4tXJGg/Zki+pSRCyL0iTJ8RILdesmyCkG6GTUx49ckpfrVELl9hCI
         3M6w==
X-Gm-Message-State: AOAM532aNVB9mGPUFA7te/2b/C/q/lw0L4idxWRrfjQLsi2nx95dafSl
        2228UsQLQ367ahwGcVqZlIWLcIviqNYk3w==
X-Google-Smtp-Source: ABdhPJyKv8R8HQ2TFn+NTbQLztzo+xVxhH8E7zhzMFnh/8PCP2l8iuV8LBU1kryLKYXqixfXAX/sYA==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr17704963wmf.164.1604326804465;
        Mon, 02 Nov 2020 06:20:04 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id 30sm22331472wrs.84.2020.11.02.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:20:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        David Laight <David.Laight@aculab.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] misc: c2port: core: Make copying name from userspace more secure
Date:   Mon,  2 Nov 2020 14:20:00 +0000
Message-Id: <20201102142001.560490-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the 'c2dev' device data is not initialised when it's
allocated.  There maybe an issue when using strncpy() to populate the
'name' attribute since a NUL terminator may not be provided in all
use-cases.  To prevent such a failing, let's ensure the 'c2dev'
device data area is fully zeroed out on allocation.

Cc: Rodolfo Giometti <giometti@enneenne.com>
Cc: "Eurotech S.p.A" <info@eurotech.it>
Cc: David Laight <David.Laight@aculab.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/c2port/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index 80d87e8a0bea9..fb9a1b49ff6de 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -899,7 +899,7 @@ struct c2port_device *c2port_device_register(char *name,
 		unlikely(!ops->c2d_get) || unlikely(!ops->c2d_set))
 		return ERR_PTR(-EINVAL);
 
-	c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);
+	c2dev = kzalloc(sizeof(struct c2port_device), GFP_KERNEL);
 	if (unlikely(!c2dev))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.25.1

