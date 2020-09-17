Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630FD26DFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgIQPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgIQPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:34:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:34:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a15so2439898ljk.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8jva5c5Sj9XTJx+Gf5IJgOG4AsL+uUjeQWsqg5Mzec=;
        b=HclnnfTNfyAsfn3sXtP/H81S8TwGSlEHJK7TeTKHXO16h+z6Bdw0HY6H0gdr+nlRlH
         T74a68bSguniGlGwNqIhHCZHS9nYWl7SYwNsYRAzUj/X901BZV19Pe9MT2+eVhk+T0Cp
         xYBi/1SeyYnI8xsOzmkRXKI6k33GmHz2EHZGErpJW8LWb7WehVawfu8LxEZ0qXaXI+Yh
         Lgnc17M6fH6G2DDwTH6LdV90KzIGnKWaYa+QHpKhKJ2x7FZ3wrW5Cn5ZIlsdamSvcT/5
         6pronu+hBZY/20eAAb6n6M4s7GgXBrCkZoHpcyk36nfBrG+qgZNJdLQDvi43pNhPqPrO
         tPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8jva5c5Sj9XTJx+Gf5IJgOG4AsL+uUjeQWsqg5Mzec=;
        b=PNM7AItYzrc3sZEpzvAO3KO78KARrBA5cc3u0CcusXwwqwCn3EnLmUKk7u6gZ4Zjfk
         1nn/qCyBLPzxzFaTD54nujhouwKwEkCYNRAHD0qfULyH9KdoG8esi8D2ipSL7ZjFYbOD
         ZEIziPzER3ffHq2v6b+aGviKdw9HthueV1pl8hyZrLGn821WAjM53cwX7oqL8Gs9a+JT
         NZpRMSP/Ph6D2Tlbu4+9lCW55pw781ac7AYl4AAkt90+ORvDMxslVNGcsUZRyj3yGomb
         SDY5vs0QchNAip+H6CJMRrioN69Fl2voZrEOg6Vib2cHyvQ5fR//AFSptiKtV0cmA6g1
         l9gQ==
X-Gm-Message-State: AOAM530ayf8/Y0BeIUBsV0FvWIXp24hZ055ILWRJWrdC/Dg4ucLZbqQS
        iBVErxC9eGIuW5g7oRu5OeB2rA==
X-Google-Smtp-Source: ABdhPJw/TXwPvxaghC4ozI+hI45HqLKoSmyUppLNzIrZ6itpJF48Ttmsrz17gAzC+iffG78vOHWlJg==
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr9433612ljn.335.1600356849154;
        Thu, 17 Sep 2020 08:34:09 -0700 (PDT)
Received: from eriador.lan ([188.162.64.171])
        by smtp.gmail.com with ESMTPSA id x17sm6159127lja.10.2020.09.17.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:34:08 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ben Whitten <ben.whitten@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] regmap: fix page selection for noinc reads
Date:   Thu, 17 Sep 2020 18:34:04 +0300
Message-Id: <20200917153405.3139200-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-incrementing reads can fail if register + length crosses page
border. However for non-incrementing reads we should not check for page
border crossing. Fix this by passing additional flag to _regmap_raw_read
and passing length to _regmap_select_page basing on the flag.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 74fe7b551f33 ("regmap: Add regmap_noinc_read API")
---
 drivers/base/regmap/regmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e93700af7e6e..01ecc00c8508 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2450,7 +2450,7 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 EXPORT_SYMBOL_GPL(regmap_raw_write_async);
 
 static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
-			    unsigned int val_len)
+			    unsigned int val_len, bool noinc)
 {
 	struct regmap_range_node *range;
 	int ret;
@@ -2463,7 +2463,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
 		ret = _regmap_select_page(map, &reg, range,
-					  val_len / map->format.val_bytes);
+					  noinc ? 1 : val_len / map->format.val_bytes);
 		if (ret != 0)
 			return ret;
 	}
@@ -2501,7 +2501,7 @@ static int _regmap_bus_read(void *context, unsigned int reg,
 	if (!map->format.parse_val)
 		return -EINVAL;
 
-	ret = _regmap_raw_read(map, reg, work_val, map->format.val_bytes);
+	ret = _regmap_raw_read(map, reg, work_val, map->format.val_bytes, false);
 	if (ret == 0)
 		*val = map->format.parse_val(work_val);
 
@@ -2617,7 +2617,7 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 		/* Read bytes that fit into whole chunks */
 		for (i = 0; i < chunk_count; i++) {
-			ret = _regmap_raw_read(map, reg, val, chunk_bytes);
+			ret = _regmap_raw_read(map, reg, val, chunk_bytes, false);
 			if (ret != 0)
 				goto out;
 
@@ -2628,7 +2628,7 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 		/* Read remaining bytes */
 		if (val_len) {
-			ret = _regmap_raw_read(map, reg, val, val_len);
+			ret = _regmap_raw_read(map, reg, val, val_len, false);
 			if (ret != 0)
 				goto out;
 		}
@@ -2703,7 +2703,7 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 			read_len = map->max_raw_read;
 		else
 			read_len = val_len;
-		ret = _regmap_raw_read(map, reg, val, read_len);
+		ret = _regmap_raw_read(map, reg, val, read_len, true);
 		if (ret)
 			goto out_unlock;
 		val = ((u8 *)val) + read_len;
-- 
2.28.0

