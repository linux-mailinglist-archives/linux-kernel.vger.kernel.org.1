Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9D23E2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHFUCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 16:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:02:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0067C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 13:02:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so27545644pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y6WcLYjf0CU0iVN4Q9GedmvZXdsK8JgwGS0sL53z0KA=;
        b=FSNR9s4dMJqLdikbJ7ztdA7Pc3gB6eHveHHSW/Z1O5T8Mxz64Jn7BAZ0O+v2c82Kc7
         OrwOfX5GfZzOAWnQw0WKofOrkhuOP0oVFwHKtDbxGNXKLn6Ip6/BX/fuThjIBbaWokht
         qX7N+5AMA+kUDpoZLYgpKcNcyV39bEiWJKW1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y6WcLYjf0CU0iVN4Q9GedmvZXdsK8JgwGS0sL53z0KA=;
        b=JLIs/z/FPSEzs5KqN2D0PA9k4sbg7Z23CSSUIVtfQrHv6C4dAmEXoUwTT3DzBPHQG/
         nfQT7PryYvTEGAQ5LTxRISNzfwFY5Auvkz9js5WR/a9QMaR0XTUh5coHWiYb+uyjCWoc
         XnCpzLqT4S/7HdiEOrmyDa/yLsmRcFnFd/vAkOlFKFrVDNHzo1pHXW9iXsPol5I7u4UQ
         fC+S0UMbc86KNRxo+2Ag9eauzV77KKgUsT4u27Q8HOFWptyGaUUnL9E8Ny7TMdt8v1TO
         tZACo7v50KGnvpvNH38F0Fx1gHfRNkdp81qJrm5y9vpDtn8oLQMMUAKAWQIK1wcO+CvN
         qogw==
X-Gm-Message-State: AOAM5330R/7toZIM6qNn0BaRHVDZwA50TK2Otqn00wyKSQqnEJ4tzQX+
        ByVxDnkAIH1B4WyJ/maVVq0Z+A==
X-Google-Smtp-Source: ABdhPJxhkPxXi4g1/LUWtikGFy2euAdY0VwMTB8RnKsrwCYod3B6LIF43md44gYapZuhzzj0nMEFcQ==
X-Received: by 2002:a65:6817:: with SMTP id l23mr8744061pgt.428.1596744167100;
        Thu, 06 Aug 2020 13:02:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id y29sm9322179pfr.11.2020.08.06.13.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 13:02:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: debugfs: Fix comment typo malforned=>malformed
Date:   Thu,  6 Aug 2020 13:02:26 -0700
Message-Id: <20200806130222.1.I832b2b45244c80ba2550a5bbcef80b574e47c57e@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silly typo.  You go squish now.  Was introduced in commit 299632e54b2e
("regmap: debugfs: Don't sleep while atomic for fast_io regmaps").

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/regmap/regmap-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f58baff2be0a..51ed8fd29c79 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -467,7 +467,7 @@ static ssize_t regmap_cache_only_write_file(struct file *file,
 	int err;
 
 	err = kstrtobool_from_user(user_buf, count, &new_val);
-	/* Ignore malforned data like debugfs_write_file_bool() */
+	/* Ignore malformed data like debugfs_write_file_bool() */
 	if (err)
 		return count;
 
@@ -514,7 +514,7 @@ static ssize_t regmap_cache_bypass_write_file(struct file *file,
 	int err;
 
 	err = kstrtobool_from_user(user_buf, count, &new_val);
-	/* Ignore malforned data like debugfs_write_file_bool() */
+	/* Ignore malformed data like debugfs_write_file_bool() */
 	if (err)
 		return count;
 
-- 
2.28.0.163.g6104cc2f0b6-goog

