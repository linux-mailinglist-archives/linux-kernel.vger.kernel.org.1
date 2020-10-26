Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3D298CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775115AbgJZM1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:27:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36588 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775108AbgJZM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:27:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id x7so12285169wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MCnq8BmFjuuQiWlm9eCLlDK+PBQ3cEnax3hxzmA1BQ=;
        b=ar94P11IWiyu+ZMvtAZ0o8i4GpU+IiVeYFg89QsdI4Fl/IfyIMiNvV/ZBSWjvk12JL
         58V//LBZI+rtWYw0X4Bn2oQNQLHEXiQT+aA1o2ncEPIO5ySDB1Sasg6ygemtGS+Yf6E8
         Deuk/6Lq84fTVm91LMKsVd7MT+EPyWJS7L+b6GF4Q7qsSfgMUI+t5nwiDO698lrFFbYG
         UY6rhFiTw9d+amHmlcN5VPEXfiCbY2b88eOhowYD2Kka+QGuLhT40GFSLTnfNR4mOcSp
         R6GNaOoy354+YRxF730RTb7Gtu2Yenz4VT+Vp/CMiz0T9gr87B3r8tAE3xpKxj6Rc3TN
         uW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MCnq8BmFjuuQiWlm9eCLlDK+PBQ3cEnax3hxzmA1BQ=;
        b=hYUflz0YteTv5DjkIunLsR9uAkAjqEBvEHIyBDWn3Pb3Si0nQthXlAx6IDIhEvC/XY
         qJP/Lb4/4lZfKu+tXglsROAYxDC7WEAa5Y8X9EYdhnxyu6pUQKwBgn8R6QQCqHPYu//U
         tdpWC+NjAkhnQCd3tWVM7fQuh3VGkRRWniKNYcvhLjMfTO6q4o8MPbzRLKKOwqtln3dM
         9brruFLauKNu19qhiG+CjcKOE0qjgOVcy9XLI4Uc1/K26I9lQCGYYZNjuOERCE+/WLQW
         S118+m+lesMiAh5HVszIQoQBHQBFX/q0rNcRXfc91bygE6mjmuZwhztu06oHGcDPvd+k
         a2CA==
X-Gm-Message-State: AOAM532ptY9F07EFUqBRojemuQ2w3Vk4TU3kB2utnx8x/bdSokocakQf
        GE13siYvZYFB0ihOWcMAtXXAxw==
X-Google-Smtp-Source: ABdhPJykqsUdvqnzDLVx3Y6zQHVZGy66Nmr5/EwbDk99qg/Yz+ltenhMndi6h/B+t6ruiV5vqxcNmQ==
X-Received: by 2002:adf:f841:: with SMTP id d1mr17571389wrq.297.1603715255563;
        Mon, 26 Oct 2020 05:27:35 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id p4sm23401025wrf.67.2020.10.26.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:27:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] devres: zero the memory in devm_krealloc() if needed
Date:   Mon, 26 Oct 2020 13:27:28 +0100
Message-Id: <20201026122728.8522-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

If we're returning the same pointer (when new size is smaller or equal
to the old size) we need to check if the user wants the memory zeroed
and memset() it manually if so.

Fixes: f82485722e5d devres: provide devm_krealloc()
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/devres.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 586e9a75c840..e522ad5f8342 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -895,8 +895,12 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
 	 * If new size is smaller or equal to the actual number of bytes
 	 * allocated previously - just return the same pointer.
 	 */
-	if (total_new_size <= total_old_size)
+	if (total_new_size <= total_old_size) {
+		if (gfp & __GFP_ZERO)
+			memset(ptr, 0, new_size);
+
 		return ptr;
+	}
 
 	/*
 	 * Otherwise: allocate new, larger chunk. We need to allocate before
-- 
2.29.1

