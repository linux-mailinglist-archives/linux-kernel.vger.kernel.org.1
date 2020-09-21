Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA627204C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIUKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgIUKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B67C0613DF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so12017224wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+cq9oU9Ma9PInvC8Tn3Mmy1QNY/EmZQ8V6ofB5bAgs=;
        b=HuZV4z/aX5wQwktepBLxIaWp4Yua59yuPHG4i1pRHYu5zWrhN6JbZt6XBHolFvoph1
         AGJKWr3LxB2xHduo0DMKAlTMuLT6QQB4sxpj05Nk1jZcwHCqAXrMuTpLw6i7jmTww344
         M7YshZYYHApDueyyL+n+z1JwwFJnMqsEbbITkEQf+TrFw7ktx4RMPXlZI6U/3qKVjkVE
         +OlMHSBX4sOClJoqZimOJvv2dtYQOuj97gkYJ/TU60o4YbzlJVMOPL12pSJ6q3GiTdFp
         aaRh7jtdDmnsG4ffnrCfP+gZz9TfavAGqvD3EMR4TB+nd6REzA3wUQJKFtB1Mls2Q/9a
         lZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+cq9oU9Ma9PInvC8Tn3Mmy1QNY/EmZQ8V6ofB5bAgs=;
        b=Uvaf6X5Shqm64TlsW4nTqfWiQsgOnlRodb8SOSF3V6/Py2ygKWT8nu0EEoyUwlu9BL
         PQrhg2C5OajdjcOPf+wWK6Exehfv9IeOi5TA2heyWs5ha5oRUdmk8sT5zXHufNavK/EI
         NzwNBuPXS/1VE6EEbyee4xpzHwcMcuGZ6sMpMXQOHznsGWSYMXd1RNtqRMuiSovImEzH
         MLmcydoqXN/o8PoI3wHWjjn+tH1YKY042Lq0U4YU4vceuRvRqJqWYhVqOSONeC0lnhO0
         rojNLDR40tMzj0Y1x4mto6luO5h6/qz1FU5F3nLS/aRf+sL1Xuuwl7NBXUq6HBF8JMud
         tVmQ==
X-Gm-Message-State: AOAM533+5k4MwrQXdppyB5ztxVvAA+W1Joodck+2KAMdyuktd3TJhuxT
        dVANxI2jejhT2GiXPOXR2/ghOg==
X-Google-Smtp-Source: ABdhPJzh07AdoC79L31ogzqdfpLSo8Vo99PgY8VHgWZwSZisNeA806uMbcHsomMmjB2Z+5Zfy8pl9A==
X-Received: by 2002:a1c:4381:: with SMTP id q123mr28356129wma.108.1600683646253;
        Mon, 21 Sep 2020 03:20:46 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 14/49] staging: media: zoran: use VFL_TYPE_VIDEO
Date:   Mon, 21 Sep 2020 10:19:49 +0000
Message-Id: <1600683624-5863-15-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFL_TYPE_GRABBER type was removed, so let's use the new type.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 02af426cf94e..34841c12c224 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -957,7 +957,7 @@ static int zr36057_init(struct zoran *zr)
 	 * another day.
 	 */
 	zr->video_dev->vfl_dir = VFL_DIR_M2M;
-	err = video_register_device(zr->video_dev, VFL_TYPE_GRABBER, video_nr[zr->id]);
+	err = video_register_device(zr->video_dev, VFL_TYPE_VIDEO, video_nr[zr->id]);
 	if (err < 0)
 		goto exit_free;
 	video_set_drvdata(zr->video_dev, zr);
-- 
2.26.2

