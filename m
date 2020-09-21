Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA6272A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgIUPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgIUPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:30:11 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:30:11 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so14514014lfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DkqOMgrTl7zIBI5g2+ZD+/MpKpCbOEtbJ09u4yXxMck=;
        b=Pmxl16sH/7qJpClO1+ChSFj3ZaW7eiGRz+uQkC83Tk31YG2iFaRDELBOwCj9eDRiA/
         oV7CHQReHSIjp44bi6inuRO2dizjW+c8mQDYO2c/ISQp38KgABD1aqt0WTnpoaDwenjp
         UJh3XidzufYBq5wxWRKykvDzLAKrUxhaOq4hGzcC4vqGIqPqMjid0tZOupGcf7NjBwXW
         rbRpdMF0IMMxh8CMWRU4Jn5lAFZ3zhXFzJQS4EkHQ8p+KJfrrkdoHNmrZx66Qr0nksv3
         8xMPqimuwky48DKMsXgVxtHuTNVVPBgFKm0VjaAiHGXPwhFKAqkWrMMlmZJhCgrGv4gH
         pK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DkqOMgrTl7zIBI5g2+ZD+/MpKpCbOEtbJ09u4yXxMck=;
        b=UG3HX74HjIP7B0BB7f6xiIwNV9DjJDqiUUVMqH+VrNekCwvd7qa0+11E7N3HMjfKuA
         CZsfPKlbbUyTznXxjG8OKXdkVSeqORIJk0KczjBp7a4NlHQSfxiFyjbEmQ8VUmOhd2q/
         N4WUMi3+CmfMA0vATwUIBR9sFMwYjQNmDWud/DalNlp1ZTvUkN9b82scOOf+Ja2Sg8Nc
         FnFr/CAs4VcZsffXydKTkBGtMpR4sUJtQF1iS1OxilA0I2HCd6RI0X6JCS9WD9sL2DDD
         xk+2Z4DZL5YzlUHyX+KwDA2uQJtz6w5A/RC0Fmal+oQ/FcFRW2Gr7gOToHBF8mWyxh4/
         R6AA==
X-Gm-Message-State: AOAM532A7SDfyFwiJ5InkoqcMHQu1CmSdet0JAZ7pdoxHl+KUzfuA0YC
        DrsbmUS6kV9UYjSuAHrkQN1HBpNShiDuShtK
X-Google-Smtp-Source: ABdhPJy1eIBGFeYwuQMOuq/7S2ynwqFcHOs7jFpgskY8/IISq6FthNW2ufuKc1hYYw9eWWw3473bPg==
X-Received: by 2002:a19:e041:: with SMTP id g1mr144347lfj.337.1600702209515;
        Mon, 21 Sep 2020 08:30:09 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id b27sm2631635lfq.133.2020.09.21.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 08:30:09 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/page_poison.c: replace bool variable with static key
Date:   Mon, 21 Sep 2020 17:29:31 +0200
Message-Id: <20200921152931.938-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Variable 'want_page_poisoning' is a switch deciding if page poisoning
should be enabled. This patch changes it to be static key.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/page_poison.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 34b9181ee5d1..ae0482cded87 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -8,13 +8,23 @@
 #include <linux/ratelimit.h>
 #include <linux/kasan.h>
 
-static bool want_page_poisoning __read_mostly;
+static DEFINE_STATIC_KEY_FALSE_RO(want_page_poisoning);
 
 static int __init early_page_poison_param(char *buf)
 {
-	if (!buf)
-		return -EINVAL;
-	return strtobool(buf, &want_page_poisoning);
+	int ret;
+	bool tmp;
+
+	ret = strtobool(buf, &tmp);
+	if (ret)
+		return ret;
+
+	if (tmp)
+		static_branch_enable(&want_page_poisoning);
+	else
+		static_branch_disable(&want_page_poisoning);
+
+	return 0;
 }
 early_param("page_poison", early_page_poison_param);
 
@@ -31,7 +41,7 @@ bool page_poisoning_enabled(void)
 	 * Page poisoning is debug page alloc for some arches. If
 	 * either of those options are enabled, enable poisoning.
 	 */
-	return (want_page_poisoning ||
+	return (static_branch_unlikely(&want_page_poisoning) ||
 		(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
 		debug_pagealloc_enabled()));
 }
-- 
2.20.1

