Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F80126DFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgIQPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgIQPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:34:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFFC061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:34:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so2630137lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWmldhPElw5Vvo98eOZmWF+knCiL0y0+ETP3EoKXFzY=;
        b=BXFPQHV2cTjm6rHyUxXK75fkj2rJoUkJF0Q+TVKXn6Vtia/t6XtD6TzXTM9DrZpqRU
         GzhBORLbBOO1A9PXEzUCsfQTWNFm8hz+AYTmCl+6U1RSpXsOre5KLxslEgSoKdTcxRWt
         DBukw9ucdiQktfpUNpbBD38LvOx75sQ1iFkW++BDyiO0/QWeiV55cjbtzlrAsIxqIrrM
         N8YNZRejSjfyp9n2bG2Xj9+6+XtsRcARKIZG0TbvvLv6lmf5I6sKz6Q/JlCD9Z3N4aIF
         TKSZSWiDcdpWdHzj0x891qOQbpEbFKxxQrRkbZu8DFlDjDi+sA4PEXWP/1NCCfsDdZ/z
         laPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWmldhPElw5Vvo98eOZmWF+knCiL0y0+ETP3EoKXFzY=;
        b=VQeqYC7BPU9KTjNAdmMBmdYgj8WMQE/pQ+Tjqxyp9lunhf2OC/t3roAJBx5Lm2hhiJ
         taCeDCANJGEqOFAWI3ukxpXKVnwDCOLi8EQP4n4APbjEStZDwRo2hVYFAGUn8knT4pyx
         HOH8U49HeswHYehYQPUcBrTWFl1824OnmD51/fXKD/c8ZjdN7vB8XPym+doDOIpqr61z
         z6Ow0l104Mo24ZuN4N1c4vXI4rBhmGW31ZyP/bjtz8zQwT9vyLLO9w2Hv57O0/2h0P+D
         Fp4D7U0ua4t1qW4PeJVTHPSpnQy0m8yCsOduOQfKksUWMXm4qqit4r0KizSxcqVP+FEy
         KIqQ==
X-Gm-Message-State: AOAM531+Bjxnhb1Pta6OtpyVgRa4Gsdpzvo72NLJOafQVfVqQMDVdK5i
        Stq7ePEsCDQ2Dwn1tbsfBNmkbO4vM7pvrw==
X-Google-Smtp-Source: ABdhPJzYi/UTXm7DYsAlnCHF10aDBBM6XhOjqz8c9w9FAKyPKaoUrT3lpsS3M/vr4x/BcmlERWdCnA==
X-Received: by 2002:a19:606:: with SMTP id 6mr8678963lfg.407.1600356851020;
        Thu, 17 Sep 2020 08:34:11 -0700 (PDT)
Received: from eriador.lan ([188.162.64.171])
        by smtp.gmail.com with ESMTPSA id x17sm6159127lja.10.2020.09.17.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:34:10 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ben Whitten <ben.whitten@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] regmap: fix page selection for noinc writes
Date:   Thu, 17 Sep 2020 18:34:05 +0300
Message-Id: <20200917153405.3139200-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917153405.3139200-1-dmitry.baryshkov@linaro.org>
References: <20200917153405.3139200-1-dmitry.baryshkov@linaro.org>
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
Fixes: cdf6b11daa77 ("regmap: Add regmap_noinc_write API")
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

