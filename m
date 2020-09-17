Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7572C26DD45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIQN4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgIQNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:54:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA5C06121D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so2125676wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoTwgcJHCiN12qhXXsWAZQ9cL1lknXX7tKKcNmydNqo=;
        b=BmPRtRyjw5x9JTXVjCslbOu/dNgHLkaxjtMplzNc743B5TULUqdAhm3G8ZEIAmRRRX
         flNz27ag0sXQRVoTrc9Rvpatv/VYTtBHXAn6x53p31PWex6Y1ArdZLGYZaXteaYZ1UNu
         LRsjNHI0/InI9guh5a0ZyA4gfdHnZ4ei2Q3Nj4m9c+GONwBfCqPNbFmSnJH6WBBtdCZn
         RUg/n9USEDBVp8W+DTyE9RmRTeIsT5L0WOQbqLB2BbdhkqLdw7Etpcvy4pi13j/tGCE/
         AGeU5r8/sEkCuvGF/xj74LNDmFtCTPWK4zhOJwVoU8S0zTZINE7B/QJ5hW9D2iDutffz
         GcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoTwgcJHCiN12qhXXsWAZQ9cL1lknXX7tKKcNmydNqo=;
        b=d5gd0WDyMU0nQEq1GtSLkjcmV1R3WVgGift0NXQdg22Dk6f5EzftGCn1fE7SOJi3Dh
         BbdzdcgSFVaDwbnjhaHS3LtKBrzSp8XW75R7Vo0zPhqzT+lNFpMneTN9+PBZuESPrv2w
         OBqjkMUl/Lm5h8obRMgTvrKC36svtdyyWIL44aqHfwlENba+sJ4T2mdZywszgZOxaFY5
         HexqKdN4pEZSDNIfRg0fY3DmBbH5ugOPs1x7RI0K9jatczB7ORMwSZ+y6xQuJgoXcZJy
         QAvd2VLX+vW6Bgf38pUd60wG8JOfu1QFeaXkh3qDS0nlbmPlXiupv5N2VaoM9ObXW0Is
         CpWw==
X-Gm-Message-State: AOAM533K2uGrweXbEbe34pHN+yg+DHUktTJQ7ADDrKdyFvuIkBo9/8xL
        OuVLs0LMyTBxhb4uqg8sgY0n3g==
X-Google-Smtp-Source: ABdhPJzSd5ZSDQlEeejl4AtFMW/GTCs6vW9E2g9tSl2Ci/fjDtcCQdTPjfERjKGZivkfpw1TU4wG1Q==
X-Received: by 2002:a05:600c:204e:: with SMTP id p14mr9741371wmg.182.1600350293095;
        Thu, 17 Sep 2020 06:44:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q15sm36892406wrr.8.2020.09.17.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:44:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] nvmem: core: fix missing of_node_put() in of_nvmem_device_get()
Date:   Thu, 17 Sep 2020 14:44:37 +0100
Message-Id: <20200917134437.16637-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
References: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>

of_parse_phandle() returns device_node with incremented ref count
which needs to be decremented by of_node_put() when device_node
is not used.

Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 96ac8a632a7a..ab57289fe593 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -835,6 +835,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 {
 
 	struct device_node *nvmem_np;
+	struct nvmem_device *nvmem;
 	int index = 0;
 
 	if (id)
@@ -844,7 +845,9 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	if (!nvmem_np)
 		return ERR_PTR(-ENOENT);
 
-	return __nvmem_device_get(nvmem_np, device_match_of_node);
+	nvmem = __nvmem_device_get(nvmem_np, device_match_of_node);
+	of_node_put(nvmem_np);
+	return nvmem;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
-- 
2.21.0

