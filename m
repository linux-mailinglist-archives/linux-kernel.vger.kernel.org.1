Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BCF2C55BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbgKZNdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390197AbgKZNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:09 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD115C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:08 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so2138226wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkVHgZnw6Lei6IsVvRK9pUiVE1+hhckfR+9Br4cSPrE=;
        b=zuKRkBMwy4QWvvpBfeIKLgYNHdWx20GaFtYVQXPS2ejG2VPOKyj03aNPOtjX+Fj0zi
         txJPDSzeDZUh8AxFzvuhREUkFOifNLME+G4mGIh1qsRZlj5ZKR4ZZ5TKLfU33wAjw49O
         WHNRmyDRN5QZytnQ0PNHwhnOaSyWjF+hyxH4DGD7epSjYqZRKDYoriPREbd1hMOTSQXz
         X39+Qobaoshhe8lrepXEoh9tQzPEaKyKazBTzHf8K6VTgHfQDPuKuB6Pt8ZRe8KKms2d
         tOq/lR/1+QXwebzXTbyIR41NGMNjl1b0m/NmtJh7lY4y8UPHc4VZST5te0Z0b/N2Qk3b
         ir4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkVHgZnw6Lei6IsVvRK9pUiVE1+hhckfR+9Br4cSPrE=;
        b=O+9arE2Fw9SwT3HZpAm3xpXdkVLiC85VNERBER84O2QxYLu0jVjYWa22It46xNuVWN
         lpgRMwY4gEcx4z1H2RlJ+yvBPba76dxn2eKGRbSl4K51AJNN+2MH5AUyDy9MCF0kfsni
         UYIi9Pf9MfbM6pAkCc9zZEZsUSjfoGmWNRgqqwTqPEx3aDwsCARFwmiZHnS4t8eqItAB
         Vv7QQsYxq2f95iNRW85ISFk27UtUtcMdOonH/nP8P1QRakJsWEN1of2qqom6Kpk7+rar
         tD7WTsODhfXoVQl3380O71xAW42OHFXZTRkhXTS2IDn/Fcpot0x2lx+DbgXiF6LKUyTb
         yzxw==
X-Gm-Message-State: AOAM531D7cjssX6TgsRpgNdwGy7zj0WA9Swg7nnltAAnyWhTv+SJxLjQ
        vVX/B6gy1ySVBr6YAah6MVGxVg==
X-Google-Smtp-Source: ABdhPJyn9GVZS822IZ4IVqcmFXjk4DgG4O/j+RPa4fPxVi5KBq5hEWqL5eq0BDDYukOyzKbs/qm8dQ==
X-Received: by 2002:adf:e801:: with SMTP id o1mr3900099wrm.3.1606397527585;
        Thu, 26 Nov 2020 05:32:07 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 09/17] ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg' param
Date:   Thu, 26 Nov 2020 13:31:44 +0000
Message-Id: <20201126133152.3211309-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/regd.c:378: warning: Function parameter or member 'reg' not described in 'ath_reg_apply_ir_flags'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/regd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index bee9110b91f38..b2400e2417a55 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -360,6 +360,7 @@ ath_reg_apply_beaconing_flags(struct wiphy *wiphy,
 /**
  * ath_reg_apply_ir_flags()
  * @wiphy: the wiphy to use
+ * @reg: regulatory structure - used for country selection
  * @initiator: the regulatory hint initiator
  *
  * If no country IE has been received always enable passive scan
-- 
2.25.1

