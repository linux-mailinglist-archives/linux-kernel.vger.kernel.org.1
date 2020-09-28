Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3127B7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgI1XOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgI1XNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:42 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED4C05BD0C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:04:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c5so2985600ilk.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TxaMa6inpZ7uMAndoFZ5+P5V8+D5W2ogRawnm+mnrw=;
        b=BPcyw3RouFEeIYSfoGTnzTWR8xIeOLQKB1SaKv/ej7EVr35nbGNbxexqylu4rf19ky
         nFYS9ETsJ4iMHo6iY01f0g9p74z0hpHzlQCj+HE/UUsnrF6n/hbzoM+tfJk3rAqo6mQR
         XcDn58DRckHzTaqKF2FA4QY9+B8VB/UwL/MAUu/vXiC10j0+Xiyv/0K6paeMlS6qGo5Q
         /jDZTO1UeEdNbQ2ZCWnIuk5oHhgvDav460Rvnxd7iBOPpefyJTr8qD8UhDeIz42LLa2n
         OunK8fY4POd7wc7j6KK0yAeP6Oybg69PpzLThmlMaVVDPUNmzi2rOo5P61997S1rVrCp
         fmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TxaMa6inpZ7uMAndoFZ5+P5V8+D5W2ogRawnm+mnrw=;
        b=t6Zj3gez8NImJ4t08J30kGkbbGDs490dfxA0dwLSwOqbKkMkt4qqxbgF9QbBeN6jvZ
         xciDyQlRKhZYtJydmK6Sx0vQUZ6a8QE3TJkpEf6mDz18XZ4JMeL5nK4jvvCIGTVH6xZY
         AWwD0mULZWo6NJM7UcNiYeoTJmt+NTVPV/1j+6pk+xxG5gmTUT9fb9U6c5D3iqECGviQ
         zSLrKI7BAgDJd7n9nrut8JaPgpbBesM3xImFOb6sa7XbMsEJeh7mXdZ2gCviiipEY2bj
         z2/pBPxqzN3IG4qGv4Gq7jyNML27ZX16s3v9Q0rmk/1hRkJiQeywlLCNPx33Mye8xzeR
         VjtQ==
X-Gm-Message-State: AOAM5339yLU6/9k96Z0VkDfdNqQRmWSen+xiXOzONz/GWEiGSO5FLt3c
        bkG2Ci8ic8SEeidQNdLLDv5wmw==
X-Google-Smtp-Source: ABdhPJzYgbfl2gRKfvh0JI7qgLfUaS3kg/2rEtEn1KZRQklmXs/0Dy9g/+zvEanEEUgW/4zYBfWqeA==
X-Received: by 2002:a92:7611:: with SMTP id r17mr599930ilc.88.1601334291290;
        Mon, 28 Sep 2020 16:04:51 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 137sm1009039ioc.20.2020.09.28.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:04:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/10] net: ipa: kill definition of TRE_FLAGS_IEOB_FMASK
Date:   Mon, 28 Sep 2020 18:04:37 -0500
Message-Id: <20200928230446.20561-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200928230446.20561-1-elder@linaro.org>
References: <20200928230446.20561-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "gsi_trans.c", the field mask TRE_FLAGS_IEOB_FMASK is defined but
never used.  Although there's no harm in defining this, remove it
for now and redefine it at some future date if it becomes needed.
This is warned about if "W=2" is added to the build command.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index bdbfeed359db3..43f5f5d93cb06 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -81,7 +81,6 @@ struct gsi_tre {
 
 /* gsi_tre->flags mask values (in CPU byte order) */
 #define TRE_FLAGS_CHAIN_FMASK	GENMASK(0, 0)
-#define TRE_FLAGS_IEOB_FMASK	GENMASK(8, 8)
 #define TRE_FLAGS_IEOT_FMASK	GENMASK(9, 9)
 #define TRE_FLAGS_BEI_FMASK	GENMASK(10, 10)
 #define TRE_FLAGS_TYPE_FMASK	GENMASK(23, 16)
-- 
2.20.1

