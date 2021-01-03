Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B702E8D53
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbhACQ4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhACQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:56:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EBEC061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 08:55:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q75so15685437wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 08:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1aRDcbBG3mRHaeKBTVSperXXNk6AyaNqHYz5R0wfuo=;
        b=LMC2ROl0E7632rImDC/83Favg9udu1eiIshM+zGX05kjPOGA1p9hul1OqyY8gaVS8e
         O3/52rWPjP8nx7NX0vB5cqZfLQhtUrypHHniBA0XGcTvgZpJY8OieKjQkoBQJz/dWU59
         lAtDO7yWU5F1wSyTjkyPjprBkPrstkJbFOsG1S/tQhg5JoDQZzqVCd+8qE0M+IWEKLyL
         0FFwYcLH0OoR66O4VyFObgM3UywFvio72+JLSO7rJAPm35PczL+DVewHyPt+tl6U2dSK
         jwLfbjAz4Hz90A1MzRo5XeJMJU9pd6hPC1WALu9+edtK0GYIUy6kkEcsWZQuPCnMxsVD
         hNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1aRDcbBG3mRHaeKBTVSperXXNk6AyaNqHYz5R0wfuo=;
        b=h48dWbwtHlYboLSeuCCna9oi42vBaa8Uszr9q7hOytohMiRJzKNubajINfx3INNMAm
         xKEKgqPVU/XSOQ6CHnf+VYXeYPmJ+N1unNOkQ5GSUNM4Kkjc/IW8DS1hkfx+Dp4z0VyR
         asjiWvC//ZXglJtuPJN5+JvqmRRoddscVyG4AIC7mczH8dXUBtCxuP5qUO18ZjvWlemq
         ahZKVqlDHGPSu00bj21zJjw3Bgf9jowxmGuLx9PvlukWgmkzUooaicZQ72n2154QWwBd
         RPRJnw0zQOsxk70Zi+kdXpdtzY7slDBtJS83+Lh08oPiDBoCrFoEfkOXYse8fFxKGum/
         K1KQ==
X-Gm-Message-State: AOAM531tx8aQSHq7oqVqk8FriHtwhcVO6kNtaeJSRimGjWELqwGQL7Di
        f3v81A3ZReJTVvecElvfd5HRYvLZhRPSa47x
X-Google-Smtp-Source: ABdhPJxiAH70Jdw6Of/xd8FUHQ3AAT1+JeYgaRSLHDE69F/PDjxHmNXNURyfdirtze681LG7Xh5eBA==
X-Received: by 2002:a1c:1bcd:: with SMTP id b196mr23556335wmb.70.1609692957675;
        Sun, 03 Jan 2021 08:55:57 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm31223695wme.11.2021.01.03.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:55:57 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com
Subject: [PATCH] regulator: core.c: Replace references to non-existent function
Date:   Sun,  3 Jan 2021 16:55:41 +0000
Message-Id: <20210103165541.784360-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function regulator_set_device_supply() is referenced a few times in
comments in regulator/core.c; however this function was removed a long
time ago by commit a5766f11cfd3 ("regulator: core - Rework machine API to
remove string based functions."). Update those references to point to
set_consumer_device_supply(), which replaced the old function.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ca03d8e70bd1..fee924158091 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2020,7 +2020,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
  * Returns a struct regulator corresponding to the regulator producer,
  * or IS_ERR() condition containing errno.
  *
- * Use of supply names configured via regulator_set_device_supply() is
+ * Use of supply names configured via set_consumer_device_supply() is
  * strongly encouraged.  It is recommended that the supply name used
  * should match the name used for the supply and/or the relevant
  * device pins in the datasheet.
@@ -2047,7 +2047,7 @@ EXPORT_SYMBOL_GPL(regulator_get);
  * regulator off for correct operation of the hardware they are
  * controlling.
  *
- * Use of supply names configured via regulator_set_device_supply() is
+ * Use of supply names configured via set_consumer_device_supply() is
  * strongly encouraged.  It is recommended that the supply name used
  * should match the name used for the supply and/or the relevant
  * device pins in the datasheet.
@@ -2073,7 +2073,7 @@ EXPORT_SYMBOL_GPL(regulator_get_exclusive);
  * disrupting the operation of drivers that can handle absent
  * supplies.
  *
- * Use of supply names configured via regulator_set_device_supply() is
+ * Use of supply names configured via set_consumer_device_supply() is
  * strongly encouraged.  It is recommended that the supply name used
  * should match the name used for the supply and/or the relevant
  * device pins in the datasheet.
-- 
2.25.1

