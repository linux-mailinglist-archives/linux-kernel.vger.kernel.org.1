Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F72990A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783348AbgJZPKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:10:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44526 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783310AbgJZPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:10:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id t9so12995053wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rE6pPIb6qrpXHbauEm5oZimdEfL+h7F83+RcbN7IlEs=;
        b=vqcm81q2T5QtEGT7x0RRGR+K1KtbGNE1yQVAeSNWeuUSp00DPWG1kkj4IxlWOaQVZK
         vF8CVamDCIdfjJfQBq4mJSPPZmugpACAuyZEx1qOG2uekDsA+5RG6vZj4zEtHxwpUgpD
         PHMf188TR37aXN8lcXNZj9+Nh3asuufPU6fRNf5j2aW4Yl2zzLxCpDPuUwBhkQJ111mX
         Y5d7sLj8TS5wSd7R7ohUE9ZCGePKVfvd5RJ+kuBxkwNrGgscza17ReEaXV12kIU83uvh
         09l8g+2j4S6P+MOoHRD0ViVCGdLrO1RzC+z+Eb7V6y8gweINvlr4GO7NhDEFsCwXc9sK
         YJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rE6pPIb6qrpXHbauEm5oZimdEfL+h7F83+RcbN7IlEs=;
        b=i4mUwtlQLcJpAhGx55USzEvkx1uZy5j2YSgikEtNKM4yjOagMG2ICOL5A1yTwAAUM3
         je1S2WRu1YDA1iOOARc7VtTa6R7gR/mCHoFVc/sihI8w88pAejV111hix8Z+xH1GIElE
         sLiP6IkfzwZWYPwSPW+VQtBZhiO/39RSFAoosIt1Kx9YtKiFywZo2B3YtM8943yQPuM+
         IubH+9Icopgt0fmmC9aIi05DIviw1OhNCjAhLplmJ5oXtdYro2M4ufjABjVHUZCzTV7q
         HS28aaWXHYBDw01URbWmgn45IkOBsB+Aaa8WiE6vBaUFQzPf4KiRmG69D1vlrBFZbmyP
         u7Hg==
X-Gm-Message-State: AOAM5329FcOi8bi/BnFA7F5gNVQLMebBFwjDCZ2eY8iDNQqSBwUwfgS3
        1Mst0zirq15dEv4NYGmdCDsghg==
X-Google-Smtp-Source: ABdhPJyIQkQcV2ilixJeqjbVUFhfQYrQSv9Oau6DRKh8cBQ+EG9QxeRiPeU0J+oo6nmCBOqOfqvTWw==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr19761773wrp.394.1603725021634;
        Mon, 26 Oct 2020 08:10:21 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u15sm23552151wrm.77.2020.10.26.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:10:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] regmap: provide regmap_assign_bits()
Date:   Mon, 26 Oct 2020 16:10:15 +0100
Message-Id: <20201026151015.15527-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add another bits helper to regmap API: this one sets given bits if value
is true and clears them if it's false.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Hi Mark,

I'm sending this patch without any user yet but we have a use-case over in
the GPIO subsystem where this will come in handy soon.

Bartosz

 include/linux/regmap.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e7834d98207f..62099e7a3ed6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1148,6 +1148,15 @@ static inline int regmap_clear_bits(struct regmap *map,
 	return regmap_update_bits_base(map, reg, bits, 0, NULL, false, false);
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	if (value)
+		return regmap_set_bits(map, reg, bits);
+	else
+		return regmap_clear_bits(map, reg, bits);
+}
+
 int regmap_test_bits(struct regmap *map, unsigned int reg, unsigned int bits);
 
 /**
@@ -1554,6 +1563,13 @@ static inline int regmap_clear_bits(struct regmap *map,
 	return -EINVAL;
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_test_bits(struct regmap *map,
 				   unsigned int reg, unsigned int bits)
 {
-- 
2.29.1

