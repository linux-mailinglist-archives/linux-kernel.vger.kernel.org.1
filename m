Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77F3297BD7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 12:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760944AbgJXK3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgJXK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 06:29:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DCC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 03:29:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 126so2876437pfu.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jB2YadM6cwMream+pM3+MlgDXVVh9JsG5fEzVsDo/5A=;
        b=MDvqFfnftYsy1L4OpJW7xQFu0nkaaYiarDsTibEynzHou/1FnEKWeGkI+5zOlZdUyA
         N7nEG5UiPEGjqzVGtriRGWI6j2y6Bsw8LAo621jAhH9JL8YFN7WieLW0/XI5KvaZQO0w
         N2qlXqOGD6PWjJXZ9+a1RF0eS8jdRgOMVpQo+MgYxk5CqU8vifJQckhue2oRkHkohLYY
         0jVSTpeH3X1UUau/YsT7ZzfqvgpdxbAEm/vw2qH61uh3kG17D0PLshvwEhCrm9LhHT77
         l19UG4asMf01125lGuG4k9fg0iTtC+KF3biB7QAv3igXpsO+GFQ8JaPjCxh02lXG/vqZ
         Yjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jB2YadM6cwMream+pM3+MlgDXVVh9JsG5fEzVsDo/5A=;
        b=OSKGLeLUOOXTn4xaPhz9ZDpDrOO3fpBKspvwBvq7BNOZRT3TEWxxffP2w5aVH/7SjD
         iPUP6rH6oMLHhHyVdmbt33TSZT2cuoplPIKns7DQKAVhOTRavrQHJd3U+v9wI6LIYIu+
         WVYpHT5USY+qqWREjxRPj9uAMgJEqmbT5W9ytOEb5+zJy7w7FEecTih9bcOpS5J1bNSG
         k4uSROkfoHwp0zpe8jngj7sjYPkPvjjL48GdQt39KXFdkqUi2c5gHst4P1VNUeVMA75H
         Voom138GuWnloOqa+kUf+z+Ut91fg7uenMrRdT2q+qJLOa7qGhN8RAMMoiD7zX+3IsN8
         qxvw==
X-Gm-Message-State: AOAM531aKeEBYx2SJY5GPDrAAd90D9yogSPE3niyuqyM7y/3bolTx4xY
        z+ZZL4MC+KObSfJmGz0YAwrgfmCHRyrGipen
X-Google-Smtp-Source: ABdhPJwSNbyioRzwFoRe5ZVwmtIV7k/WxQDvN0QeiD8LRcbJzv7weEzB/1QnHrBWEBmM6x8cnsWo7w==
X-Received: by 2002:a63:ef51:: with SMTP id c17mr5539881pgk.36.1603535362067;
        Sat, 24 Oct 2020 03:29:22 -0700 (PDT)
Received: from [192.168.43.9] (M106185144002.v4.enabler.ne.jp. [106.185.144.2])
        by smtp.gmail.com with ESMTPSA id t9sm4783245pgp.90.2020.10.24.03.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 03:29:21 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] switch "random: fast init done" message from NOTICE to INFO.
Message-ID: <0de3a5be-8b61-9c99-422a-97c919ba73af@landley.net>
Date:   Sat, 24 Oct 2020 05:39:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>

If you loglevel=4 you get zero kernel boot messages, but at loglevel=5
the shell prompt is overwritten on devices that boot to a serial console
a second after it comes up, and if the prompt is "#" it's easy to think the
boot's hung.

Signed-off-by: Rob Landley <rob@landley.net>
---

 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d20ba1b104ca..91daf9113204 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -895,7 +895,7 @@ static int crng_fast_load(const char *cp, size_t len)
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
-		pr_notice("fast init done\n");
+		pr_info("fast init done\n");
 	}
 	return 1;
 }
