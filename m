Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F0F27715D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIXMqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgIXMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B2FC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so3416860wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzdeSPZJeGTtYjqmJjzQkOcYxUj4rBm77F8rc/oVHWc=;
        b=UuUzWIPjiaOvPYB/eX2yS5FYTp0FmzDSmAg2JrvE8s5N5WtWJuiBIkp6YpqR1eA0oY
         9QsKJJJMuSV5euuVGDgOVFEu4qMyoY2zakE/+Z0a6knE9eP4Hmdd2pnRUpjBKh4mdGFq
         i2jfas9P2b/UQMjn6ZkLLdg5ZjGm4i53qXUDsQBlAI8IGN3rc0F6oH3M1ofMMmkNaa3T
         9YZnggJukkPKu/u4aCbxVLY2CjcUH32KcNkdP31aDgBsOl1EGTU7znHJnkS4Y87Jux20
         BwMxZo3HQ6hnrVEelGaQOEFkNTTBsjZVlP63tx/vYxcXL2DgnWmjBDwyhCq2hzpw9PIt
         O51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzdeSPZJeGTtYjqmJjzQkOcYxUj4rBm77F8rc/oVHWc=;
        b=LzqtBUNsAxNmPIu7Vy3Mjx8+3Ibk+M3cF6wyox3xkS7pamWlV+Fq+leyDJAbLMU8A/
         lZqEIyLTkOO6Q1srLID//AyidYlPMUQaXqsGgFkH3S7TP6xBR23iQ1M5a8V6x0EZLaag
         vZIcdEVGEagA3C8Le0iJDh6x/u3S1S4eNIykvpaFmdWjWfHeDuaAzz0mU5zbHkGvUIKc
         DOVczeFKoSAL2o6IdEgl5FM8cXJeGjR50D/6YrVGtZ884uRBp3Ml/Q4O+rlTHHGXwXrW
         bP7zxkR/uHdtYuEntf27BOt90wcKTBeSW4dE4ijiOAAv+JZvWI/SXm15xeoRZqcbsMAC
         2N/Q==
X-Gm-Message-State: AOAM5306PKNGdWw98SAifhc22L7Dqli/JzwJYlq5/wDgly48wFXQZhBI
        5K7VbLyUp6Z4Uiv3k3p1Lk24Fg==
X-Google-Smtp-Source: ABdhPJx21HzgUM2kot/MLzjSG8P+cwVfuKygvOZ5lUWXW+3CBbHyvBiW6R9OMqqxcxV6T+sYoNbG2A==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4431010wmk.153.1600951541664;
        Thu, 24 Sep 2020 05:45:41 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/12] samples: configfs: fix alignment in item struct
Date:   Thu, 24 Sep 2020 14:45:20 +0200
Message-Id: <20200924124526.17365-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Aling the assignment of a static structure's field to be consistent with
all other instances.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index 924b57258af0..3e6f0e0b0f72 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -172,7 +172,7 @@ static void simple_child_release(struct config_item *item)
 }
 
 static struct configfs_item_operations simple_child_item_ops = {
-	.release		= simple_child_release,
+	.release	= simple_child_release,
 };
 
 static const struct config_item_type simple_child_type = {
-- 
2.17.1

