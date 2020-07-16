Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B22224B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgGPOBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgGPN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC5FC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so10402587wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flrJT/YcyExs3gnOvBVqb7JaX/eYc6iKr9Cf7OgkhEk=;
        b=wS0BLgIoPnbCQkZrXfPKQCSXFoiUZxoYipHxFRAE33/mAvOLnVu7yFQ5sbwKriIkUH
         HaqdPg5/jKLApSB0peSU5MC0FZCwGmuMay52MFsdLeYRMk7Qh18Xng369QJt9Ahq4qFt
         O5ZZU6Ub98tlZzMphocP7D8hIjr0+FT/Ic/BfMDkHBqjL6FAGRWylXn+QtE3iRFQt/rX
         1Q1eoCA2b0VKZqUL8pDfo6odHkw/AJ62+lrV1CZeDeQ5spwTNIzc7Y9LSZM7gNB8BwAw
         Z+FO/WtjUgVU1bZbffGf+QlocR7C/OaUmwg/Bf8ratfG9EO83NM8jfmI1+J+T/mrMy8q
         Q8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flrJT/YcyExs3gnOvBVqb7JaX/eYc6iKr9Cf7OgkhEk=;
        b=IqI7I2HoyLM9Bj9vfr7qXkkWGsNuuwOLl1zMRR2Gz2w2X4U2BjprkkCSb/nMfh4LMj
         xK7EAmArxTA9mq08xd1rNiX+eIfM0eKIXtcCmi36vy1F/0U9rVZlXhUcW2miDrfoUB2f
         lENnHWzwnWOelOL/3mGGlK83O4u/zlhNfTAgt/nfV8NW0aWFzjgxziMnmfr0aSRlEvpp
         YGvicuaugLCkqNIZyrG0OypXKOcZGaaUZJp9GjEsP4Cu0WJIb6hqFfNw7X/x+TqyvNeg
         94T4hVwrCSR84V5EDsZ/Q3QyK82IS/wyzJ7aG/mes4mB4NDNfTKs2QfLL0PH2FqL8Eq0
         1qzg==
X-Gm-Message-State: AOAM531NTkkCRN4MG1K+Em4P9eCg1/VgAMG7NNYq8Edbc0SgwmRjvnc0
        kUl5Bd8e7P81VwmGqMo9cHOO+g==
X-Google-Smtp-Source: ABdhPJx/50JaeJmar/WoY888whwoEjYLb4pSl9pY8jhlqdCaKnqD/sdyxRSfozZ617lS40LrO4b9jA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr4303416wma.7.1594907987075;
        Thu, 16 Jul 2020 06:59:47 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Barry Song <21cnbao@gmail.com>
Subject: [PATCH 12/30] iio: gyro: adis16080: Fix formatting issue and compiler attribute ordering
Date:   Thu, 16 Jul 2020 14:59:10 +0100
Message-Id: <20200716135928.1456727-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format and
gets confused if the variable does not follow the type/attribute
definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/gyro/adis16080.c:49: warning: Function parameter or member 'lock' not described in 'adis16080_state'
 drivers/iio/gyro/adis16080.c:49: warning: Function parameter or member '____cacheline_aligned' not described in 'adis16080_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Barry Song <21cnbao@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/gyro/adis16080.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index 1b84b8e112fe1..f38f9abcccbb5 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -38,14 +38,14 @@ struct adis16080_chip_info {
  * @us:			actual spi_device to write data
  * @info:		chip specific parameters
  * @buf:		transmit or receive buffer
- * @lock		lock to protect buffer during reads
+ * @lock:		lock to protect buffer during reads
  **/
 struct adis16080_state {
 	struct spi_device		*us;
 	const struct adis16080_chip_info *info;
 	struct mutex			lock;
 
-	__be16 buf ____cacheline_aligned;
+	__be16 ____cacheline_aligned buf;
 };
 
 static int adis16080_read_sample(struct iio_dev *indio_dev,
-- 
2.25.1

