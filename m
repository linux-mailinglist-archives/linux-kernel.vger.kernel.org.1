Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB32E2E048A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 04:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgLVDA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVDA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:00:28 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A23C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 18:59:48 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id n142so10840408qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 18:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVwzRkT9t+vCLbJimoRDlmlmCV0mO3Zs8Jqmvw/7+kg=;
        b=V8jLwdl3yBMgUkp36hPLWLMm65BnJDMsVlJN/lOEUnuaDYJ+UrkR5MKkLhTR26T+9l
         WxuLKOTSxfvD9sPQUfM9YYbJjc+AHXBWYoIX00ZG49bfgf2Agsk+K/7p2iz20asEXSdd
         loq4hCKoduEuKjndn0Jn/jyPiG784fLf+Vywr5QWmJcbD1POYywQTRbYj4dzUUzACdDX
         Qpd7eA9/sLOERHE/OnCCUNmY8tMoVmsxQNbJvxmvavM+ZKhM9vWrOFMSIgJOW26olznX
         hC3H66yzPOr2VCwbR3sYjA0meeXucCA7SQ1jFwX+OImHZchUM6ZmWlT54kitH3lOSgbA
         XMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVwzRkT9t+vCLbJimoRDlmlmCV0mO3Zs8Jqmvw/7+kg=;
        b=IznwhacEgwpNp6hrS1+dPRjS2sF7c7lgR95BQxcdBRz2BC2kXNvwcykWP0oKWwzvHH
         P14f1gNXDNHjQW3DIa3hoV3GX9wymBzVCYKcO9Pq9Ii+MNNvlRhGbWZTKUuoHPjXT3kD
         6gUlFdLe3AtLyyasCnjZQRABWQIzpH7QybQ8hqgJ2Kmpj3s82GugCykvHaTrK1yaOaCR
         7hnx+a6cGmg+mj1zPq9POnF6N8ADZFMuC7rA7XULYzRpV+bgsnpWNvUaF3hPRLkq+X/8
         7v1C0Q9jFwn7lTtNaRhilbM6RwJwqDbvHe7MJ3c2YG7H7edGZRPu4KxHU51lmvSYcLCH
         xGjw==
X-Gm-Message-State: AOAM531uzAWdjWQGaCDpE2f9zlF1wPbE5zSNpn4ZKVV6eaoZGFURM7my
        WJIV8cdcEJ6MTIkNlngNc7k=
X-Google-Smtp-Source: ABdhPJzxpUX1DxDch3nTQKlRm2htJs79YIpaRQXm9tksW306M1+41tCMJtI5oENQAc/x5llZ0ByucQ==
X-Received: by 2002:a37:9f82:: with SMTP id i124mr20338981qke.264.1608605987162;
        Mon, 21 Dec 2020 18:59:47 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id x47sm12104745qtb.86.2020.12.21.18.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 18:59:46 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] i3c/master/mipi-i3c-hci: Fix position of __maybe_unused in i3c_hci_of_match
Date:   Mon, 21 Dec 2020 19:59:31 -0700
Message-Id: <20201222025931.3043480-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

 ../drivers/i3c/master/mipi-i3c-hci/core.c:780:21: warning: attribute
 declaration must precede definition [-Wignored-attributes]
 static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
                     ^
 ../include/linux/compiler_attributes.h:267:56: note: expanded from macro
 '__maybe_unused'
 #define __maybe_unused                  __attribute__((__unused__))
                                                        ^
 ../include/linux/mod_devicetable.h:262:8: note: previous definition is
 here
 struct of_device_id {
        ^
1 warning generated.

'struct of_device_id' should not be split, as it is a type. Move the
__maybe_unused attribute after the static and const qualifiers so that
there are no warnings about this variable, period.

Fixes: 95393f3e07ab ("i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning")
Link: https://github.com/ClangBuiltLinux/linux/issues/1221
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 500abd27fb22..1b73647cc3b1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -777,7 +777,7 @@ static int i3c_hci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
+static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 	{ .compatible = "mipi-i3c-hci", },
 	{},
 };

base-commit: 95393f3e07ab53855b91881692a4a5b52dcdc03c
-- 
2.30.0.rc1

