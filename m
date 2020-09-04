Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD93225D466
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgIDJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgIDJPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:15:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CD9C061244;
        Fri,  4 Sep 2020 02:15:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so7596630ejb.12;
        Fri, 04 Sep 2020 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2LMSq/YzffTbgrpx4Wic/tfmfolWAmyQMf47ukY+FY=;
        b=ghLIk1Z6cjUJpspIKGhD7yHPKofS+e1eO9MWem061ZYh2/nUK/8BHKrLzeI6KW2CUS
         KpzCrbcO23gCxP43hYhvn5irPvjju4XUMeow4aiswQjgEQMq+infzImEnEX4NBCthiFP
         FKcfA/6yaprqwQu6vqDrvWRwzTZj7gDiGn6Pfd5edWYPig58LrYJPz+MEMmYJyqVawUE
         1ZT5qd8amYxAJtCQTNkDMO8QWzgDso8vKGErwhqmLMYxgM5zFRldq+JNhV3nEScB0nXk
         q/FuXrpeVkNa7X2ll1q3eSuwM7qrovSOLxeHXfaCGbBBLEIXeWAxMeJu8VXGzb9I7dwk
         e4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2LMSq/YzffTbgrpx4Wic/tfmfolWAmyQMf47ukY+FY=;
        b=IHY6/Lfkixmiyir6kOYeBoPoCju4klqc08vXBWDu6sbNjnoSwsgb1v8elfE1LizZDb
         plVwfOMoe1zN2lViUnEejpUaY6aEkS6C0H62Swk1Y7bxnzONwZx7oxlMvO2WxrkIwmsu
         eGxeizAFsrxdMu4c5shkmDm1CF6KRia1jNgCHZUYVgsTs5/YD2eJK+TINDdmODmfVU3R
         bThRmLK3GJcftMXI7QFL3JHlRPlaJ3HBF+MliR3KCZMvUCJWoWbjEsKHXwAZVJiKL1w0
         3MEIepnm/w9CzTCvuIlvIbMqyVtWeIhqdLn2az4dMvXR7r1Jaqr4eNdKQk4KRVN83JAe
         CbqQ==
X-Gm-Message-State: AOAM530AG2JOcnb+aOevGIr70ciztREndqZoZBLbNezDobIYeuvJyksD
        Hni+6eeaU/HpM6cghbi3ahapA9xcXu0TKA==
X-Google-Smtp-Source: ABdhPJzBzrwrJSW5I+yni8sT23GJnwVM1HBagGGj+rftz4cCEZ4N3Ui1gIyAPffrBSiRmPXIUTMNVw==
X-Received: by 2002:a17:906:1ed4:: with SMTP id m20mr6531947ejj.460.1599210950551;
        Fri, 04 Sep 2020 02:15:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b904:9293:1d41:83f0:a723:a7e3])
        by smtp.gmail.com with ESMTPSA id a26sm5562066ejk.66.2020.09.04.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:15:50 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 1/2] block: use generic_file_buffered_read()
Date:   Fri,  4 Sep 2020 11:13:40 +0200
Message-Id: <20200904091341.28756-2-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904091341.28756-1-huobean@gmail.com>
References: <20200904091341.28756-1-huobean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

do_generic_file_read() has been renamed to generic_file_buffered_read() since
commit 47c27bc46946 ("fs: pass iocb to do_generic_file_read").

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/block/sunvdc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 39aeebc6837d..06262e990c9b 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1017,9 +1017,9 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 			 VDCBLK_NAME "%c", 'a' + ((int)vdev->dev_no % 26));
 	port->vdisk_size = -1;
 
-	/* Actual wall time may be double due to do_generic_file_read() doing
-	 * a readahead I/O first, and once that fails it will try to read a
-	 * single page.
+	/* Actual wall time may be double due to generic_file_buffered_read()
+	 * doing a readahead I/O first, and once that fails it will try to read
+	 * a single page.
 	 */
 	ldc_timeout = mdesc_get_property(hp, vdev->mp, "vdc-timeout", NULL);
 	port->ldc_timeout = ldc_timeout ? *ldc_timeout : 0;
-- 
2.17.1

