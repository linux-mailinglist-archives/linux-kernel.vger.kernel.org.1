Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895F527B797
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgI1XNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgI1XNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB331C05BD1E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:05:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u6so2898550iow.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NuGxB8yCQyfl8m9V0CkWYOyAigdUp2kf6vGRj1Y/jrw=;
        b=AHKwTPsgH48I27z39EKzCiQpSUcgI9O2yF9awvt4BWhO00wPb6NYSgkbbvGL2O9sZv
         gBhHIpyqjDGrIKYz7l8n/zsIcG/J61NOcxTk9XW7m+40XieeDwFhv82Xn7/CvaLZgq94
         /AGSXOrBQTlA3bOQJuUDx1Zg08Q/ElpKUPQgw6SQwu3YQY+9G4IZpBUpCrXnIuO1acqB
         gEvGa4mw5TyQvZoDUNxaeNADFlYJgnD0bwDhLQeMXbz7ZY4Ne7t6nbk9h4kGcLWCp0Vh
         6D5ZJCiy1IU1TfdNzCvrETqjSLTBFhpU79op8LxidNph01MvCDSNvNcfPiihwo+tWDgS
         Rwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NuGxB8yCQyfl8m9V0CkWYOyAigdUp2kf6vGRj1Y/jrw=;
        b=ZjsZ2Vc+C43b/sHJalDk7zEK9xCaRQ1kocIAY6BG8tawinN6jJJJ9zpa9x7UAhWz2n
         09cbpyTv8JCg3WsOI+/lqEBJuaPr0fX5onigpa5KBlPBKfsQd8GTVnLKTskDySU0ZzN8
         0TXHTmsISPySM2nuQ7Xa2ka5hKVuU61W8LtMT7lUlkfdLuwoxhK2VEbzeorfZnhlApKm
         yMEyzbN+/E3pXla3fia686zxU3FK5b2pN1DVy5tuCfaOv4ZKrl8VwHCFQJ92WO0jXuGf
         EjxLMJk5LVMOPsSoddL3OW7Sfzwv4KA3cWsUI6f0vobBwXGBLf7HCrfrAtyNXWEtdM/J
         i5ZQ==
X-Gm-Message-State: AOAM532+gUfaShntxvBsveV8Sw38tRvGy94IjjjR7MUaGmnqUJFhxg1V
        Amdf4OCTUjaco+A8n1T2cmYGDQ==
X-Google-Smtp-Source: ABdhPJzZq0Spz0R/vFIJw6h8QtWBPNbOEUYA1B7CjR9GHGj4rLJ/VPVyP8DvOI+F042JknYBH3Kwwg==
X-Received: by 2002:a05:6638:220c:: with SMTP id l12mr708832jas.139.1601334300066;
        Mon, 28 Sep 2020 16:05:00 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 137sm1009039ioc.20.2020.09.28.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:04:59 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/10] net: ipa: fix two comments
Date:   Mon, 28 Sep 2020 18:04:46 -0500
Message-Id: <20200928230446.20561-11-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200928230446.20561-1-elder@linaro.org>
References: <20200928230446.20561-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipa_uc_response_hdlr() a comment uses the wrong function name
when it describes where a clock reference is taken.  Fix this.

Also fix the comment in ipa_uc_response_hdlr() to correctly refer to
ipa_uc_setup(), which is where the clock reference described here is
taken.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_reg.h | 2 +-
 drivers/net/ipa/ipa_uc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index eb4e39fa7d4bd..e542598fd7759 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -426,7 +426,7 @@ enum ipa_cs_offload_en {
 	IPA_CS_RSVD
 };
 
-/** enum ipa_aggr_en - aggregation type field in ENDP_INIT_AGGR_N */
+/** enum ipa_aggr_en - aggregation enable field in ENDP_INIT_AGGR_N */
 enum ipa_aggr_en {
 	IPA_BYPASS_AGGR		= 0,
 	IPA_ENABLE_AGGR		= 1,
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index 1a0b04e0ab749..b382d47bc70d9 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -144,7 +144,7 @@ static void ipa_uc_response_hdlr(struct ipa *ipa, enum ipa_irq_id irq_id)
 	 * should only receive responses from the microcontroller when it has
 	 * sent it a request message.
 	 *
-	 * We can drop the clock reference taken in ipa_uc_init() once we
+	 * We can drop the clock reference taken in ipa_uc_setup() once we
 	 * know the microcontroller has finished its initialization.
 	 */
 	switch (shared->response) {
-- 
2.20.1

