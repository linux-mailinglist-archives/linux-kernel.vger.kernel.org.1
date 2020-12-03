Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4412CCB85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgLCBRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgLCBRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:17:33 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C6C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:16:53 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so183935pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqgRVATL9EVQEmmklghH4p+JKc4J2djksQxSoW4Ye30=;
        b=IHMUQWYSgsFg4fZCOCdeYBTqtcZd/eIAir7cr8BA6og5RhWDVO8K1i7LgkXRvelpei
         +Bz1Z3yfJ1eLM3RwKE0rIBfjO0buM2hnOCg4qVn8/X2O0T9/R/uE2Bec5U7JrlkEcxYf
         RIu+oAn3NbSBcy3Pf5vicS6jfP67+swtzSKkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqgRVATL9EVQEmmklghH4p+JKc4J2djksQxSoW4Ye30=;
        b=K5uybvuNWS9uACRwX2sqa9RNkLpzPDEn8vqTpZJqwhMZSupq5LrD7iMKXkdY2RFDi5
         oEtEdkxniLYYjYz5sG4q2Kldn7IJoWcyWQpgpGleco6zAr/lTwy5y1kyA2Tv5v//hIv2
         TOdWJOambJ+4kqAxKypRpj9vuc+pO1e096O8WWj2bJwqWz2OrRw6X1Lc/p/XEthqhgYl
         GJxtUI9+9TD9C4ku2o/350x/W6ObqebreFlVfBRtwBfK3JlbFPPTg51hBbzlaz5bHCOz
         pyNA0xqlPOjkFVzc8VRt0B4dSPAWy/xP5VRPMt4gzggimhuCtYB5vGiII8RRKD/NcbQW
         6HaQ==
X-Gm-Message-State: AOAM532mqxBJTUTf774CXyQvX7NGg9BxIwnSwdvjg0nA7T4XWxqIrqUt
        +ErVlRZLrC43UNsm5xk2hYZL6Q==
X-Google-Smtp-Source: ABdhPJyJlDQsAOTY7hHjqF0jHTjfmctYNoYU43/UVcoVyjAHpg4Py9cxH/Rvu//V0qicDP4ew9xgOQ==
X-Received: by 2002:a63:e20:: with SMTP id d32mr926217pgl.94.1606958213057;
        Wed, 02 Dec 2020 17:16:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id d19sm123292pjs.0.2020.12.02.17.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 17:16:52 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_spi: Drop bits_per_word assignment
Date:   Wed,  2 Dec 2020 17:16:49 -0800
Message-Id: <20201203011649.1405292-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201203011649.1405292-1-swboyd@chromium.org>
References: <20201203011649.1405292-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already handed by default in spi_setup() if the bits_per_word is
0, so just drop it to shave off a line.

Cc: Simon Glass <sjg@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index f9df218fc2bb..14c4046fa04d 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -741,7 +741,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	struct cros_ec_spi *ec_spi;
 	int err;
 
-	spi->bits_per_word = 8;
 	spi->rt = true;
 	err = spi_setup(spi);
 	if (err < 0)
-- 
https://chromeos.dev

