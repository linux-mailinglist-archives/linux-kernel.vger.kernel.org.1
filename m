Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB526356B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 20:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIISFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgIISC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69115C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 11:02:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so3302947wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JBHpUxsz/6P5yzvpQERIIkha4hHWCaWm+jZoH6iuXM=;
        b=rrI3g/mR+NgJqXxOQLcNeGsz9f7rIFp88zeuBFJHbNmYn4aHzZphNXotSaZ9dPqcxR
         Z1BSSLRfhBRgQ9qQ1OJoYT3UDfxHBcbEfbZ1FsBHC3Mdl7C0EYRyz98pAeBaKhpMp9j+
         GAh/Jw5UWF3cjDf9uKslMuh09w1270mxmv3K68nUm5tZh/Xag2KeBIcX7lccPXctMpNH
         4x2L2qxn8LXRDqEKV9cTCiwTirl4dmsX2fzjtfrmChZlqv6ymn9VYvLLCWyVN+fT3uKa
         tzNAvsrer1sbcUzu7pqi+ZYlIHzQ+wjPstP8R/jnU/LzDK1O363RK4FP7UFcgTxfYEmN
         hcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JBHpUxsz/6P5yzvpQERIIkha4hHWCaWm+jZoH6iuXM=;
        b=TzJK3fbTQXDELKhV2tc6V3hkN+V/RhSN1uH7ru4B5cOysm9K9TVwoCFPH2fYwUAy7Q
         UfZwpUzj79HKGimaw+5S39R5ycsto9z1jcksAU8a/httUk1vsJI5WkkohuWULHNdp+Z/
         4YMyPJr15yYc5vz0Wsqy4zw6HIrb55P+d6e/peFuCikJ8yyU1SMomlsRgozKboatnW9m
         1fUzh8OV5re5Yr8fWikauUzZ/HALhz1YMeE0QCVLy1uV7lROrbbzbhsETtrUqyRIAUTC
         ZSR8i1NLidoJpAO9BJj4kkN993iBBloQHHPXTFL4L1uOGLSqXCes7iATjJJ/F1Tos2gk
         1TZw==
X-Gm-Message-State: AOAM532BWtebSNfFOUCnqeb80fBcKgEOAHgjvBooLAdnWa9Dqb0KZyN/
        HAAXq6sbNl+0x54WQzmcTuIHEg==
X-Google-Smtp-Source: ABdhPJzalKLeWZ9jQ+gU/msEk6sJa6LYMGxsNUeC2rNvK9kdYs76zxX/RdGCZzo4Q1PdO7i52Yu1oQ==
X-Received: by 2002:a7b:c44b:: with SMTP id l11mr4622522wmi.52.1599674571125;
        Wed, 09 Sep 2020 11:02:51 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a74sm5207433wme.11.2020.09.09.11.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 11:02:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] platform_device: switch to simpler IDA interface
Date:   Wed,  9 Sep 2020 20:02:48 +0200
Message-Id: <20200909180248.10093-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need to specify any ranges when allocating IDs so we can switch
to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.

ida_simple_get(ida, 0, 0, gfp) is equivalent to
ida_alloc_range(ida, 0, UINT_MAX, gfp) which is equivalent to
ida_alloc(ida, gfp). Note: IDR will never actually allocate an ID
larger than INT_MAX.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e5d8a0503b4f..194c36e3f37c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -559,7 +559,7 @@ int platform_device_add(struct platform_device *pdev)
 		 * that we remember it must be freed, and we append a suffix
 		 * to avoid namespace collision with explicit IDs.
 		 */
-		ret = ida_simple_get(&platform_devid_ida, 0, 0, GFP_KERNEL);
+		ret = ida_alloc(&platform_devid_ida, GFP_KERNEL);
 		if (ret < 0)
 			goto err_out;
 		pdev->id = ret;
@@ -600,7 +600,7 @@ int platform_device_add(struct platform_device *pdev)
 
  failed:
 	if (pdev->id_auto) {
-		ida_simple_remove(&platform_devid_ida, pdev->id);
+		ida_free(&platform_devid_ida, pdev->id);
 		pdev->id = PLATFORM_DEVID_AUTO;
 	}
 
@@ -631,7 +631,7 @@ void platform_device_del(struct platform_device *pdev)
 		device_del(&pdev->dev);
 
 		if (pdev->id_auto) {
-			ida_simple_remove(&platform_devid_ida, pdev->id);
+			ida_free(&platform_devid_ida, pdev->id);
 			pdev->id = PLATFORM_DEVID_AUTO;
 		}
 
-- 
2.26.1

