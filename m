Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310E626DD52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgIQN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgIQNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:54:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F409C06121C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so2140017wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrZNCEGNjD+/SfhYHdKUTIwracqzA0831IxWB57gtM8=;
        b=NM0v5YaFrlbySuP87pjz/g6+rPWgq2O34ja200m1d3PSTKWSCRgjTVcUK6J7SiMYRR
         lg75eekw88GDuDSm/8WyaYs7+vhvBfL7vWzv9B8QQFbqmnyhggLVKGCbjQtrrUM01Zle
         kJf1ZTYuCaEoohxId3ZcEIdD9WdIIa+QxeSfSx+YDgbrCraj+5EKrtVb+F6S/4hLD6lN
         D6/Xa8Ud7QuL0oOSE+EUg0o4bbnJZkjZj2UVVvgbJQ8bWZIM0Zd/GqK0rn12ashcw4T+
         AJoY+TqFiTAsYxUf2HEslrRXf1SwBlXuJAKsHYJ9X37Fhz9WNrwZLFIjpgzN+tWNm77p
         M0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrZNCEGNjD+/SfhYHdKUTIwracqzA0831IxWB57gtM8=;
        b=X+u5CBP8ynexeivFK3w/XY9O3shoqpLV06IDmLzN9gt8cETuPpbWBXcA/QyEJ5ErsY
         pPC1Mp98xmOp+UL1zN7X0EUX2cslsOVvjtMceRFfb613olFMsqHSS6/BkWcmeOgbiA1n
         TCDZke/n3yg5AsCD1OGeUQBTD13ap1TGfWsYxoeRiAUAynLHWlR39ATH9Tu/FFcQVNWy
         0xPqi3iDNr3uIMos4HiojLWpudkVg/4b9PPffEPjQhe2mLvQsVJS1SvR4C0k+IPcuF2B
         mBR29mKFrZNiu+gdpkiCTNEl254hi5hTmmAnBUot1mQsMc+DKZ2b6LWTzHQ2XQp4+Vhk
         mCDg==
X-Gm-Message-State: AOAM5304gO5+r9OL6vk0ST0/ZJRg1NriKE9Mw4ojVR3gGZF39HROOiiU
        ivfLlnNDrkyQNlcF8q4zs/EX7Q==
X-Google-Smtp-Source: ABdhPJyKZBbi6xBQaczh2/1nSEfN2M6tCn/MT+FKRA/z6CaqZ94HRiFnLj9qhBiR1lbokD8T/i5WZQ==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr31114028wrw.378.1600350290439;
        Thu, 17 Sep 2020 06:44:50 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q15sm36892406wrr.8.2020.09.17.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:44:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] nvmem: core: Use kobj_to_dev() instead of container_of()
Date:   Thu, 17 Sep 2020 14:44:35 +0100
Message-Id: <20200917134437.16637-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
References: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

Use kobj_to_dev() instead of container_of()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..7641e56a17bc 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -128,7 +128,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (attr->private)
 		dev = attr->private;
 	else
-		dev = container_of(kobj, struct device, kobj);
+		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
 	/* Stop the user from reading */
@@ -168,7 +168,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (attr->private)
 		dev = attr->private;
 	else
-		dev = container_of(kobj, struct device, kobj);
+		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
 	/* Stop the user from writing */
@@ -219,7 +219,7 @@ static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
 static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 					 struct bin_attribute *attr, int i)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
 	return nvmem_bin_attr_get_umode(nvmem);
-- 
2.21.0

