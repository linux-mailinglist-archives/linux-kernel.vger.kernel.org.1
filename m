Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80392BC5A3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKVMeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVMeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:34:14 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3566C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:34:13 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so2286008wra.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=K4oU37F+S5u2la2E8RErzVP84vjit/bUrbbraSn+LfI=;
        b=HbxnNFczhXyX5Hvj6SSah4hmxzaoky//NmaUAyI5kze8sidoTK04TngWfa07YIzO2j
         +AtT4qSlyZwS7XWBIk6wXcHIEAKWc8Mu7R9KWeWQh1ukvJ7Fcu4mJCQ1lcgIAqG0GPYc
         Lv5wWhZ7BVMJwGtvg+TY7C66nfkSYKm233japPJTSX0yscNOCC+MbBvjCPKAKD26wnqS
         KDHMoS7Cu5AtPcDCVfflmRvyzv7AF7qSTbRHCsXL5I+GEIOURQxEvAmWZk/pZJr/Remn
         gZoBzhJt38r10F0lJxBZvie6RbUZe99EJrzwUUtOsv0+mB9AmclJEztwKgPhK/1FGzXd
         EyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K4oU37F+S5u2la2E8RErzVP84vjit/bUrbbraSn+LfI=;
        b=J4YjEHknYijVvE4fqvSl6nI2LRDdLmk/EX/KMiwe2kLxp1lSA9xpM7OjszJMWLGmDW
         uKtuQmXP9rdDkkhkDUMPW4idqVZooq6Z1L6cnoC7ghGmURNCwQIOqjwTdvDvFWFmxqer
         9+cnFgqNyBHN622gU1tIQQbw+954yDR/f9TD44P/apP7yslgll/xZp+fWsxP7wgWfYCA
         FyqZdNY8BolqHSnNinteHg1gdd/6nWqPic0+FB5Kv/qIdv0fbkyHePTM8Eyt3PJWmt42
         j0V20ZBvv6ytXk4RG8fSFSLyjtFkSYn2HNbA2NZQEiINnpNzit7FFmuIAgB1j4jflkdw
         IgNw==
X-Gm-Message-State: AOAM531y+qAKs1AjNz6+GgzQRYGhod0YGnkG6yn9zeXOK+E24sLd0+rs
        hzgG+SCfmIAs4GF19OtmvBFsP6RUzg==
X-Google-Smtp-Source: ABdhPJwpmm7iXL/znQYOwSkVzrwF2kCsBEZMhcH+I4hBZyBbIvVcGiwej/hIYajK/yUxzYWZtlnAug==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr26251078wrp.142.1606048452668;
        Sun, 22 Nov 2020 04:34:12 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.228])
        by smtp.gmail.com with ESMTPSA id p21sm11107139wma.41.2020.11.22.04.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 04:34:11 -0800 (PST)
Date:   Sun, 22 Nov 2020 15:34:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: cleanup kstrto*() usage
Message-ID: <20201122123410.GB92364@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper conversion functions.
kstrto*() variants exist for all standard types.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/test_firmware.c |    9 +++------
 lib/test_kmod.c     |   26 ++++++++++----------------
 2 files changed, 13 insertions(+), 22 deletions(-)

--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -364,18 +364,15 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
 
 static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
+	u8 val;
 	int ret;
-	long new;
 
-	ret = kstrtol(buf, 10, &new);
+	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new > U8_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_fw_mutex);
-	*(u8 *)cfg = new;
+	*(u8 *)cfg = val;
 	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -877,20 +877,17 @@ static int test_dev_config_update_uint_sync(struct kmod_test_device *test_dev,
 					    int (*test_sync)(struct kmod_test_device *test_dev))
 {
 	int ret;
-	unsigned long new;
+	unsigned int val;
 	unsigned int old_val;
 
-	ret = kstrtoul(buf, 10, &new);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new > UINT_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_dev->config_mutex);
 
 	old_val = *config;
-	*(unsigned int *)config = new;
+	*(unsigned int *)config = val;
 
 	ret = test_sync(test_dev);
 	if (ret) {
@@ -914,18 +911,18 @@ static int test_dev_config_update_uint_range(struct kmod_test_device *test_dev,
 					     unsigned int min,
 					     unsigned int max)
 {
+	unsigned int val;
 	int ret;
-	unsigned long new;
 
-	ret = kstrtoul(buf, 10, &new);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new < min || new > max)
+	if (val < min || val > max)
 		return -EINVAL;
 
 	mutex_lock(&test_dev->config_mutex);
-	*config = new;
+	*config = val;
 	mutex_unlock(&test_dev->config_mutex);
 
 	/* Always return full write size even if we didn't consume all */
@@ -936,18 +933,15 @@ static int test_dev_config_update_int(struct kmod_test_device *test_dev,
 				      const char *buf, size_t size,
 				      int *config)
 {
+	int val;
 	int ret;
-	long new;
 
-	ret = kstrtol(buf, 10, &new);
+	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new < INT_MIN || new > INT_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_dev->config_mutex);
-	*config = new;
+	*config = val;
 	mutex_unlock(&test_dev->config_mutex);
 	/* Always return full write size even if we didn't consume all */
 	return size;
