Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8765C25B90C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 05:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgICDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICDE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:04:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0DFC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 20:04:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so1058960pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6ZbavePedjhnfU79o3iQRLIDz1F7LpY5/tY3kRYH2I=;
        b=ZOK4yYlBIO8Z0jgxrFvwOCT/sjcNTC39bYH6ajJhH9WN8TBngwyJVUB27jctJ4Kvok
         va0DKBExk4lXAXHlId6x0RrPy4dya1A8Eg62cS211NLG4W+Zc8j6BbbeS8WsMCInVNA0
         1RuxtjONt7HjtlqEy1GaBxfkvGWqArrkpvI+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6ZbavePedjhnfU79o3iQRLIDz1F7LpY5/tY3kRYH2I=;
        b=LfompwMXgw0z1EKqtWXIuLvGuLNN7jirwOQkiVQTadvGbh/qWPQUGx6juR48EMplv0
         VPkpo/CqP0NFLkD2cbEBHb7UQOXhgc/wJ/MDa/03zLIv4xpfiWOquIkDAFL19s9nqo0+
         kEGoRiDAPwk2uuRb/uefTrUpm/VCjxTv7EvYr3c1mqezP2Kprz/qsakAI+lR0p11dzbT
         2OP1uxZw6Uujd80wJ59vQe1kTR94UYRawwg8i4GwB9YFTpa1Ko7p09MKeaq0AFbHJz9T
         d/u1JD2KREwlL3RooWHVLKo1jCxy/R0dliMy5simY/ByvM4FuIFXGa0DYpufWzT0IKj3
         dYBw==
X-Gm-Message-State: AOAM5328DpzWZnowyPk6uhai6ZICtEljPLWnAvyRiCDvCm6Tijpalxmf
        0K4mqZbKtG/MhQ5rEXLehvOP5Q==
X-Google-Smtp-Source: ABdhPJwdWm3XvRRulvRARovi0fdDDyEZakdEq37nM+b/0BRaKbYUMSCt7KjLe+/u59Y7pOIGeuPyPQ==
X-Received: by 2002:a17:902:6f01:: with SMTP id w1mr1529786plk.49.1599102294791;
        Wed, 02 Sep 2020 20:04:54 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id b203sm955960pfb.205.2020.09.02.20.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 20:04:54 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        dianders@chromium.org, briannorris@chromium.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] power: supply: sbs-battery: keep error code when get_property() fails
Date:   Thu,  3 Sep 2020 11:04:40 +0800
Message-Id: <20200903030440.2505496-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200828155843.33xb2ig2gpawigsw@earth.universe>
References: <20200828155843.33xb2ig2gpawigsw@earth.universe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c4f382930145 (power: supply: sbs-battery: don't assume
i2c errors as battery disconnect) overwrites the original error code
returned from internal functions. On such a sporadic i2c error,
a user will get a wrong value without errors.

Fixes: c4f382930145 (power: supply: sbs-battery: don't assume i2c errors as battery disconnect)

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
Sorry, I missed an case with present state unchanged.
Sebastian, if you're okay with this patch,
I think this could be squashed into original commit c4f382930145 in your
branch.
---
 drivers/power/supply/sbs-battery.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index dacc4bc1c013..13192cbcce71 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -962,11 +962,10 @@ static int sbs_get_property(struct power_supply *psy,
 	if (!chip->gpio_detect && chip->is_present != (ret >= 0)) {
 		bool old_present = chip->is_present;
 		union power_supply_propval val;
-
-		ret = sbs_get_battery_presence_and_health(
+		int err = sbs_get_battery_presence_and_health(
 				client, POWER_SUPPLY_PROP_PRESENT, &val);
 
-		sbs_update_presence(chip, !ret && val.intval);
+		sbs_update_presence(chip, !err && val.intval);
 
 		if (old_present != chip->is_present)
 			power_supply_changed(chip->power_supply);
@@ -976,19 +975,14 @@ static int sbs_get_property(struct power_supply *psy,
 	if (!ret) {
 		/* Convert units to match requirements for power supply class */
 		sbs_unit_adjustment(client, psp, val);
+		dev_dbg(&client->dev,
+			"%s: property = %d, value = %x\n", __func__,
+			psp, val->intval);
+	} else if (!chip->is_present)  {
+		/* battery not present, so return NODATA for properties */
+		ret = -ENODATA;
 	}
-
-	dev_dbg(&client->dev,
-		"%s: property = %d, value = %x\n", __func__, psp, val->intval);
-
-	if (ret && chip->is_present)
-		return ret;
-
-	/* battery not present, so return NODATA for properties */
-	if (ret)
-		return -ENODATA;
-
-	return 0;
+	return ret;
 }
 
 static void sbs_supply_changed(struct sbs_info *chip)
-- 
2.28.0.402.g5ffc5be6b7-goog

