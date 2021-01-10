Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67B2F07A9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhAJO56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:57:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A55C0617A2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:57:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d26so13727430wrb.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hcaFtiURG/NS3AAflpbYe0/hOXn7VMFj1kny+bzRPg=;
        b=HgmpbuMzrESRq6si0vRd56r6mAvgQtq0CClnTJjvRWQNbX4CbPLVvQy8mrXmo5hUlh
         xBGBDBxLnOsSlqx8ah6MOV6kvb0YfQQdC1OpJSdTmAiNuikU0EXVTUujChDnVgFuUdEq
         8lrH6Sd5Y3RxqAzVboKyF5/N1rRn/nExogXFvemJIAXb9C7ZONISwuoh5pOreUhPuFgz
         uqLD9BiLTslQYjslYTM9c82+0bB/ggWG8QfyslSU5TBbAE0XjDvVhYpEmso08DgJCGcQ
         e+qr0CiX8xiIl0dZyq4StxYeBUqvpXEwdJXjtzkx9nT7yh7wyvUcGQx1mSevoNfMKPNq
         Vk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hcaFtiURG/NS3AAflpbYe0/hOXn7VMFj1kny+bzRPg=;
        b=UlOQIv7dy1hU0Y4DMCXggrAz7V6RLZbq8NHJ0z2epX0CxHjRVHWuKZWRedBcJ38xbC
         KhYPPVBJ7h0Gc1bGmbKgOCLG2q1tBOVcQotTmg6HIynetsF5ngvy8T6h4fj9bRgpUKOi
         P5+vHOCfqW81stTVfDHRezI0vFx+ouo2ib7Cj3v5mKkIHQuaRzwJxZMvDN9/xNnR8c8V
         alEEgu2m+ViAXmaSzABmn00JjQXtoiCkiSb0MlXf9r1+qawCueiiSGLMziNnPCHgdbks
         H/T/56eGChMGsxErdos4+/y2tBozJke7ec9VhJwcfA+SXKodOR0RTWoCO6X797JA5D5g
         jebQ==
X-Gm-Message-State: AOAM530pPBhQWey0YL+mKRgZnok0zeutgr01bhWJAZqkBpS/jI4CLiSL
        h7E7PAyQ8PObZoYs48mTvZWl4kmsYPw=
X-Google-Smtp-Source: ABdhPJwnyEbeUrqW84SIEzimnuDDlUWR6HP0dnIueCWGtwGVhp62bn3M5hicQOHqRDGRoeiPMQunww==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr12525649wrv.397.1610290635964;
        Sun, 10 Jan 2021 06:57:15 -0800 (PST)
Received: from localhost.localdomain (242.23.159.143.dyn.plus.net. [143.159.23.242])
        by smtp.gmail.com with ESMTPSA id b13sm20611260wrt.31.2021.01.10.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 06:57:15 -0800 (PST)
From:   Joe Pater <02joepater06@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Pater <02joepater06@gmail.com>
Subject: [PATCH] drivers: base: change 'driver_create_groups' to 'driver_add_groups' in printk
Date:   Sun, 10 Jan 2021 14:54:43 +0000
Message-Id: <20210110145442.15301-1-02joepater06@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

driver_create_groups doesn't seem to have ever existed. Change its
mention in a printk to 'driver_add_groups'.

Signed-off-by: Joe Pater <02joepater06@gmail.com>
---
 drivers/base/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index a9c23ecebc7c..a34ba825bad7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -633,7 +633,7 @@ int bus_add_driver(struct device_driver *drv)
 	error = driver_add_groups(drv, bus->drv_groups);
 	if (error) {
 		/* How the hell do we get out of this pickle? Give up */
-		printk(KERN_ERR "%s: driver_create_groups(%s) failed\n",
+		printk(KERN_ERR "%s: driver_add_groups(%s) failed\n",
 			__func__, drv->name);
 	}
 

base-commit: 2ff90100ace886895e4fbb2850b8d5e49d931ed6
-- 
2.29.2

