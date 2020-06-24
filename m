Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1372076C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgFXPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404243AbgFXPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA7FC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j94so2667226wrj.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBe/FTv7QFeWNcu1NrkE8EgReU1liqjk61nWnJ+d1XE=;
        b=B+Hgbe6AnZtssQEQLO8+i8LkJ9djlesDYCv5WY7N1bZuonlujQTgxUVX+EIDPO9kgQ
         5AKudORu/oeiJMDAlTmAdQnVSJtqifT2wniOLK3q1GFfQk93QfIsuzrKKUAJz+R1dzcR
         suKJvwEPmlDTzNaH7TNLdu1QwMrKr6R6f0HGqXMtOHIuPYgZ/bfkULjSw9PNFIctmDEE
         P9MNElqmSRzhWWNxy9kXXWmZrxts/dMGERsWqgdpr7/2Q/j5WLhhJJ9Qjt92oI8GBpVN
         1o+nBw/CBOEzI7oFe9mzJ7P343F/2Dh04W8EOjuETfcBeVenRb9twG5OwYOW87+Zz/XU
         XelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBe/FTv7QFeWNcu1NrkE8EgReU1liqjk61nWnJ+d1XE=;
        b=klVhZTTk6Yx2qSFHapi75VcBzCjs6XFBfDMvfq9UHoowWoRChrLnEj5diRVtVdaTNd
         PjwYdXGdxesei9Nr1Sln4eLep2ZIDRWTkLD+HE0m5sAqVPPPETvpyPeT5IeGtm06Exhh
         f1IW/rNWeW15cgGC+soI9mviZ8+e4/RDFhOY5J62JXUiPv/qOEYEfsGhIVuF26n6TC82
         TVMIw2pIqG6B5qnx2mlQPcSPBjX/23yIoSL4sZEpN5TNymdJGuaBsongkiQN966mJ6a6
         CWPWsUs79FJnKKPhDBIcL5BfCkGG4Vji5Y3xA2992t8K2oQl1VLKuzQoPxFyF2mN7j+y
         0s3g==
X-Gm-Message-State: AOAM532esl2DIWeKvF5cAwI/9b6mrFKxvenzlV39MfyG1GP/Y/ZUjBn/
        1NWZi2Q/478ZD9K6nZ8enpLc/A==
X-Google-Smtp-Source: ABdhPJwq4TiHFC0om0P4LKPqRz2iWzOotH8E+e4+wuBw1cN25FayJM197IkFVa1gMyGlfOZuFjvacA==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr17946513wro.124.1593011242694;
        Wed, 24 Jun 2020 08:07:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 09/10] mfd: wm8400-core: Supply description for wm8400_reset_codec_reg_cache's arg
Date:   Wed, 24 Jun 2020 16:07:03 +0100
Message-Id: <20200624150704.2729736-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624150704.2729736-1-lee.jones@linaro.org>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/mfd/wm8400-core.c:113: warning: Function parameter or member 'wm8400' not described in 'wm8400_reset_codec_reg_cache'

Cc: <stable@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm8400-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 3055d6f47afcc..0fe32a05421be 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -108,6 +108,8 @@ static const struct regmap_config wm8400_regmap_config = {
 /**
  * wm8400_reset_codec_reg_cache - Reset cached codec registers to
  * their default values.
+ *
+ * @wm8400: pointer to local driver data structure
  */
 void wm8400_reset_codec_reg_cache(struct wm8400 *wm8400)
 {
-- 
2.25.1

