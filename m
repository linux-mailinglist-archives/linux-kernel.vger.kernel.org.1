Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8086126DF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIQPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgIQPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:19:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E34C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:19:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so2596583lfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9WfxWLWK7UP4uk50Z6ldrKiD+iVfl1yibyN/KGN+sg=;
        b=aBw7OKCAIngtXBCXl3VnKKEtl06yI2tSVZAiByCuQnt/VqhuqkkdPq7UhGXY75svNC
         reO722R0jrNkZC4KYvpFqCf6lgLWcoa24MNjXIzX8sCxJt3QGUm2q9GePFMuyNRiJt5R
         eSL3S+h/2X1b18YAPzugPbz02kNejwFnpJykAJcNl5m7vltngMVlNmY2PK24ad59n5vY
         dPgRA+0I6HxETReCM65AZPrak3wP3IMQTeCy64XWt6ziIIxrSEPB+5MqPdmO2l9wip1Y
         SHYHSOxDhiXPzA7RNyFMioFLi6oT3oHF7PmjAHnkxiMbon7fNbRC5fguzhIXhGAsz6Jh
         /ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9WfxWLWK7UP4uk50Z6ldrKiD+iVfl1yibyN/KGN+sg=;
        b=kK9Pf0kdhWHnEuDie+eyEQhTmMYcDpVGhvYVZE6M0+YJmokIeYacVEDCr+uUmIP23o
         9chb4QGMoZSBMJF27bndjpSG/DY4BYvrKa8FgMz4svrc90D4Qq/GTivKWn3TvYn/c3Ij
         paixobvUZSpmLRU8jNvaObUcto5muM4Yjf2ilPOUPoL7qRF8gKEDQrTFQKpoxtQbjZw7
         uGI9XMKrI6Cq7YtZZsYg+owOryNQ1Ooyg/SMDk3T4DXl/E8XTeM3pbGBkRloLjQ6pd8N
         qNxLs+fRVAZ943AU0b3ukc94xpzA0JOo34YtHs9/0Abn+a5wd6DqrLWVWDDypgetrYDk
         QXyQ==
X-Gm-Message-State: AOAM533Dwaqi0No3ZztJyETCsr6PFj1p9ldHMl78F6SOb7elMHkagSow
        I+kk8G6B4funcpbUthEZi+blEQ==
X-Google-Smtp-Source: ABdhPJxZ+QnXsE+zsENPy0DHqQ+tSpogftEeopUEeJdr/0Zti4RR6pf4drTdLxrLHUerm6iaq6o3vQ==
X-Received: by 2002:a19:cb96:: with SMTP id b144mr10697718lfg.143.1600355966077;
        Thu, 17 Sep 2020 08:19:26 -0700 (PDT)
Received: from eriador.lan ([188.162.64.171])
        by smtp.gmail.com with ESMTPSA id o131sm5291710lfa.121.2020.09.17.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:19:25 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Crestez Dan Leonard <leonard.crestez@intel.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regmap: fix page selection for noinc writes
Date:   Thu, 17 Sep 2020 18:19:20 +0300
Message-Id: <20200917151920.3117566-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917151920.3117566-1-dmitry.baryshkov@linaro.org>
References: <20200917151920.3117566-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-incrementing writes can fail if register + length crosses page
border. However for non-incrementing writes we should not check for page
border crossing. Fix this by passing additional flag to _regmap_raw_write
and passing length to _regmap_select_page basing on the flag.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: cdf6b11daa77d4b55ddf0530842a551cc5562a93
---
 drivers/base/regmap/internal.h |  2 +-
 drivers/base/regmap/regcache.c |  2 +-
 drivers/base/regmap/regmap.c   | 21 +++++++++++----------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 3d80c4b43f72..d7c01b70e43d 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -259,7 +259,7 @@ bool regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 int regcache_lookup_reg(struct regmap *map, unsigned int reg);
 
 int _regmap_raw_write(struct regmap *map, unsigned int reg,
-		      const void *val, size_t val_len);
+		      const void *val, size_t val_len, bool noinc);
 
 void regmap_async_complete_cb(struct regmap_async *async, int ret);
 
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index a93cafd7be4f..7f4b3b62492c 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -717,7 +717,7 @@ static int regcache_sync_block_raw_flush(struct regmap *map, const void **data,
 
 	map->cache_bypass = true;
 
-	ret = _regmap_raw_write(map, base, *data, count * val_bytes);
+	ret = _regmap_raw_write(map, base, *data, count * val_bytes, false);
 	if (ret)
 		dev_err(map->dev, "Unable to sync registers %#x-%#x. %d\n",
 			base, cur - map->reg_stride, ret);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 01ecc00c8508..f102c8dc5f24 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1464,7 +1464,7 @@ static void regmap_set_work_buf_flag_mask(struct regmap *map, int max_bytes,
 }
 
 static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
-				  const void *val, size_t val_len)
+				  const void *val, size_t val_len, bool noinc)
 {
 	struct regmap_range_node *range;
 	unsigned long flags;
@@ -1523,7 +1523,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 				win_residue, val_len / map->format.val_bytes);
 			ret = _regmap_raw_write_impl(map, reg, val,
 						     win_residue *
-						     map->format.val_bytes);
+						     map->format.val_bytes, noinc);
 			if (ret != 0)
 				return ret;
 
@@ -1537,7 +1537,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 			win_residue = range->window_len - win_offset;
 		}
 
-		ret = _regmap_select_page(map, &reg, range, val_num);
+		ret = _regmap_select_page(map, &reg, range, noinc ? 1 : val_num);
 		if (ret != 0)
 			return ret;
 	}
@@ -1745,7 +1745,8 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 				      map->work_buf +
 				      map->format.reg_bytes +
 				      map->format.pad_bytes,
-				      map->format.val_bytes);
+				      map->format.val_bytes,
+				      false);
 }
 
 static inline void *_regmap_map_get_context(struct regmap *map)
@@ -1839,7 +1840,7 @@ int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val)
 EXPORT_SYMBOL_GPL(regmap_write_async);
 
 int _regmap_raw_write(struct regmap *map, unsigned int reg,
-		      const void *val, size_t val_len)
+		      const void *val, size_t val_len, bool noinc)
 {
 	size_t val_bytes = map->format.val_bytes;
 	size_t val_count = val_len / val_bytes;
@@ -1860,7 +1861,7 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	/* Write as many bytes as possible with chunk_size */
 	for (i = 0; i < chunk_count; i++) {
-		ret = _regmap_raw_write_impl(map, reg, val, chunk_bytes);
+		ret = _regmap_raw_write_impl(map, reg, val, chunk_bytes, noinc);
 		if (ret)
 			return ret;
 
@@ -1871,7 +1872,7 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	/* Write remaining bytes */
 	if (val_len)
-		ret = _regmap_raw_write_impl(map, reg, val, val_len);
+		ret = _regmap_raw_write_impl(map, reg, val, val_len, noinc);
 
 	return ret;
 }
@@ -1904,7 +1905,7 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	map->lock(map->lock_arg);
 
-	ret = _regmap_raw_write(map, reg, val, val_len);
+	ret = _regmap_raw_write(map, reg, val, val_len, false);
 
 	map->unlock(map->lock_arg);
 
@@ -1962,7 +1963,7 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 			write_len = map->max_raw_write;
 		else
 			write_len = val_len;
-		ret = _regmap_raw_write(map, reg, val, write_len);
+		ret = _regmap_raw_write(map, reg, val, write_len, true);
 		if (ret)
 			goto out_unlock;
 		val = ((u8 *)val) + write_len;
@@ -2439,7 +2440,7 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 
 	map->async = true;
 
-	ret = _regmap_raw_write(map, reg, val, val_len);
+	ret = _regmap_raw_write(map, reg, val, val_len, false);
 
 	map->async = false;
 
-- 
2.28.0

