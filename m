Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1026DE28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgIQOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgIQNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:54:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67587C0612F2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so2119694wrl.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TD4+9iw5f0guEsDm/c+HK3Ocusvfch9PhoEaUy5Bk8=;
        b=vHQsjfi3TO+BgGONL/X32Hu4+02s11T31MxOnZyowhQ9TjJ1ienzYwe/0ez3hVVnWr
         CWBYu54aNesZC7n556nAq5h1o/vXYnypGiu8CYcIkOkgkEqx5zaAHGZd5Hlrqx4WDp6K
         GQZDZp5FsciRI9DXdtiZKOhXU/TRkufFJCN/5BsYqo61TF2tJGJoNx1SgLQYXOhzOvxI
         pxR0xkMqC3fyilz3LJJVp+CjqbwsNsbyA0Xsc97j1dQRodGq4F2TMWAvgFjylL8uP0/h
         prJFSuVQB/P/AjLCf29yBHCppNN+BCtCXaRM3hF0kQOPLtvm8KqNAVvzxkDUJAKiwlSi
         1n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TD4+9iw5f0guEsDm/c+HK3Ocusvfch9PhoEaUy5Bk8=;
        b=PJ370lo0JSczjfCx1X8fHC8htKcbHjLDCNyJsxUI9rG1qsfepmcTDec9Da0NnJlqyj
         5qmGN8liBFnDpB6q3MIEdLvHgmSrXDrF9cQB0/AjKPdtHLl/91A1+4xJRASg6ng15pql
         qOFQIL9iPF5wY16noW+tpm8yAJkwDe4DDmdoJhKXwmt6Q60WYoVSdr0p2TweT64G/rdf
         NjLeySptg/0wzTVhBWblLUJms7qgCf0Q9EwtoMyMXyIs8rWA/ruprsrCUcCvjTfPWILS
         MzOZfyPVtoJWSg+GyJhAUDNTViwxXi/lF+NV3OunnASL0XWA8wXgVkKNL5x7FJWAyt2H
         xKdw==
X-Gm-Message-State: AOAM5300URZqY/B68skXYeprioEDBPPlR8ntJdA0VeQYvZr9E3/lEHUY
        5tsr/KLxUTPd8c8eNye5xi/0Bw==
X-Google-Smtp-Source: ABdhPJyTQ+Dr1MDyC6o8ysMkW0o1KRqHQeDqFvxE+c6tBU3npeOvrboz/4cTCc9Z0J6JCZ6IrLz4ZQ==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr31109336wro.86.1600350291765;
        Thu, 17 Sep 2020 06:44:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q15sm36892406wrr.8.2020.09.17.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:44:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] nvmem: switch to simpler IDA interface
Date:   Thu, 17 Sep 2020 14:44:36 +0100
Message-Id: <20200917134437.16637-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
References: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7641e56a17bc..96ac8a632a7a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -321,7 +321,7 @@ static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
-	ida_simple_remove(&nvmem_ida, nvmem->id);
+	ida_free(&nvmem_ida, nvmem->id);
 	gpiod_put(nvmem->wp_gpio);
 	kfree(nvmem);
 }
@@ -596,7 +596,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
 
-	rval  = ida_simple_get(&nvmem_ida, 0, 0, GFP_KERNEL);
+	rval  = ida_alloc(&nvmem_ida, GFP_KERNEL);
 	if (rval < 0) {
 		kfree(nvmem);
 		return ERR_PTR(rval);
@@ -608,7 +608,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(nvmem->wp_gpio)) {
-		ida_simple_remove(&nvmem_ida, nvmem->id);
+		ida_free(&nvmem_ida, nvmem->id);
 		rval = PTR_ERR(nvmem->wp_gpio);
 		kfree(nvmem);
 		return ERR_PTR(rval);
-- 
2.21.0

