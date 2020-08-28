Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58892553D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgH1Egc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgH1Egc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 00:36:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C8C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:36:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a8so1122867plm.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORs9f1UOAtT2viX41nJ/6iEMC1Azc173oplMVvoqxmM=;
        b=f7OeKoa0Pcm7olyIzX+v5pd5mvHCvxUBvrlEDY0ekXqJSlL4WKknpzZqBJ/82maHea
         KQYEcrT0bf2VngjOOMPgDpy3lMHw8iO6VMSDPvzyaMz7GNygLd5UFjB5syxH/fZL3WBm
         0snaJ/U2+xKyKTFiQVQ+HupF+oSh7DNTRE0zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORs9f1UOAtT2viX41nJ/6iEMC1Azc173oplMVvoqxmM=;
        b=HNqzkddzD4x6aA9enc4z18ryToTbORMAWcEp1FZSOJK2QpBFWPRWj4b5548LyKmNc5
         1epDQlBDqZvVIqhh4J8vHqpwfz4V7db8k3/Q/nS470gk6bl2t7Jw93gz7PvARNKlEW9j
         nQLXrtnnLc4Tk5I+qChdnw4mJZCvVOyjfXAvNiK5IWZcVgtZbyCmadZ7gwcISMwtS8LD
         IShDYRUxwqLIXpvcDujsz0cwV+3+hP1RhqM0iZxnU1/g4fl6/3j8jDvc6yROLZEHn/Y/
         2xzXOI+0X88Ap6LsVecGgLARCuZ6BGpnlLpcqMYbbKS3xA76c3zRNeKQQ3uS+8EqRwlK
         4Xeg==
X-Gm-Message-State: AOAM5327TAXWOozZ4wn19AstM0lXfHfjvtD9eUfSpSl1Ek0Litt3sHm5
        EML79QZsXOmVVeKvnmlq4a8yHw==
X-Google-Smtp-Source: ABdhPJwFow1Lq1np1cDfVHJqKmvRPvzRdkF5nhcT1UTIhHeL+poe26lDXUSPP5pAwljJG7edd3FZEQ==
X-Received: by 2002:a17:90a:e286:: with SMTP id d6mr53814pjz.98.1598589390900;
        Thu, 27 Aug 2020 21:36:30 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id u14sm4568098pfm.103.2020.08.27.21.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 21:36:30 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        dianders@chromium.org, briannorris@chromium.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v4] power: supply: sbs-battery: don't assume i2c errors as battery disconnect
Date:   Fri, 28 Aug 2020 12:36:26 +0800
Message-Id: <20200828043626.1247250-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sbs-battery considers all smbus errors as disconnection events
when battery-detect pin isn't supplied, and restored to present state back
when any successful transaction is made.

This can lead to unwanted state changes between present and !present
when there's one i2c error and other following commands were successful.

This patch provides a unified way of checking presence by calling
sbs_get_battery_presence_and_health() when detect pin is not used.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
v4: rebase from merge conflict, amend commit messages
v3: check return value of get_presence_and_health()
v2: combine get_presence_and_health functions to reuse
---

 drivers/power/supply/sbs-battery.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6273211cd673..dacc4bc1c013 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -959,10 +959,17 @@ static int sbs_get_property(struct power_supply *psy,
 		return -EINVAL;
 	}
 
-	if (!chip->gpio_detect &&
-		chip->is_present != (ret >= 0)) {
-		sbs_update_presence(chip, (ret >= 0));
-		power_supply_changed(chip->power_supply);
+	if (!chip->gpio_detect && chip->is_present != (ret >= 0)) {
+		bool old_present = chip->is_present;
+		union power_supply_propval val;
+
+		ret = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+
+		sbs_update_presence(chip, !ret && val.intval);
+
+		if (old_present != chip->is_present)
+			power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -1147,11 +1154,13 @@ static int sbs_probe(struct i2c_client *client)
 	 * to the battery.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
-		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+		union power_supply_propval val;
 
-		if (rc < 0) {
-			dev_err(&client->dev, "%s: Failed to get device status\n",
-				__func__);
+		rc = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+		if (rc < 0 || !val.intval) {
+			dev_err(&client->dev, "Failed to get present status\n");
+			rc = -ENODEV;
 			goto exit_psupply;
 		}
 	}
-- 
2.28.0.402.g5ffc5be6b7-goog

