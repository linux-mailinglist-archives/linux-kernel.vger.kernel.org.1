Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314F226DF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgIQPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgIQPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:19:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:19:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q8so2598105lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaeOr5ZlYc7rrTDGzfGCrOVZmXeD+QlzexJUaZVH6TQ=;
        b=OEsbXIMHSskD2BwFoHEBVD0KY7e4Hg/pjh/HAOIBuaoRWhoggQCJ7Hojd3jq9FiBP1
         xKdFpGLjZ+KT13qvR7E+MFbnRPq5vQ6e/qVYLpA1S8ex5Q1kCuFuTQ3rfI3g//6knnoT
         PWTBtYuZnk+WcExRgEjET4CXlN6ged8cmcot7jkbyMeQy/S4XttnTeAhMG2esdQO4GoJ
         8Lc97c08vXtb8m82Lqki2Fod16nMnFlN2Zsh7ZJUA0bd94pk9jrXlHTrgwJntuhCYtYA
         WlW18JMTEeEeR8fTvwJq5o+45b5o65MiRotc5GV9aUKqyL9uAIezDZ3rNqE0IXSHjw+L
         kYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaeOr5ZlYc7rrTDGzfGCrOVZmXeD+QlzexJUaZVH6TQ=;
        b=GgNw3b6ahBMVcjWtjeugQ056jHvvIPIEU3z/d+ruH+DPpy+lFmn3y3581I4QBnk2OI
         x6gh/x5dnDWFnteb0ZX9IuI1u6YW8CPtv1J+whD/7vsJ+/fiHpitkyh0XOzrq2Z7XxCI
         F2DeFd7+ecLHvtaKB+HYjbN0k+xtLfkzmGNtSuojHgBOJq5W1D1WUDIibB4iZv5TS0i7
         Mzto+hlf3/AQd7U1FErRLEGx+MMlo3DkXrgUs+aI8RUbeac/kxJARYz6MthRem3CM5O5
         nnPnC5SNUUCyTuzu+nCqYlbC41G4hIT06kYztYmLwkGmIJLV3pyjHXmSolBtTAHT0J7L
         n1ow==
X-Gm-Message-State: AOAM53269U4sKlIVmtdGfNvllNRBbpY3W28kEopl1X3M+BI41UBO7Q8a
        r+HqHEovhbzQB/tzT63+ZW6MOg==
X-Google-Smtp-Source: ABdhPJzW/55l3mhl27lnglzgD57SElYIe3XHa5wjGHtML/VQfUl0W+gHyQRiwJ2Eu/kaEJbq4V0Btw==
X-Received: by 2002:a19:4281:: with SMTP id p123mr8899659lfa.398.1600355963839;
        Thu, 17 Sep 2020 08:19:23 -0700 (PDT)
Received: from eriador.lan ([188.162.64.171])
        by smtp.gmail.com with ESMTPSA id o131sm5291710lfa.121.2020.09.17.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:19:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Crestez Dan Leonard <leonard.crestez@intel.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regmap: fix page selection for noinc reads
Date:   Thu, 17 Sep 2020 18:19:19 +0300
Message-Id: <20200917151920.3117566-1-dmitry.baryshkov@linaro.org>
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
Fixes: 74fe7b551f3385fa585d92616c85b3a575b2b2cb
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

