Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11737249726
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHSHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgHSHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB8C061366
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r15so10540791wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzv6Xq3ihFFQsayom2Qdg9Hzw3ojwjKD2yhS4tVSkyI=;
        b=nM+ypooSib+F0Ke3ylfbyi7Y4o8dDRKGmtHuMTj7uxHi1swHTkHFLPAWPGEcB9PRtq
         BrnsThl6hPmiHgHibuMziQ4oqW/PJ+LzMvlVGwAvI+XmX3TJnNNACWaaA56oJodBnpqQ
         qUJA4Mm6BVOB6wvF5Yl8WVV/2XR6CCMob2C+8g+d/Gj8OCsBXiSvnOElaAPV2bCVt46H
         Tnq/dTxQcpckeMc5ysqvIb1ekOBsnDSiBqXiUYPm2eZ143wB+kT5uVt07gCrID5Vt45A
         0o2ivfUYudi5uJtDO9staymBqbf++Fnnt8pWaObBNJ0cji5pPNaMfiaePjRALpKzznL9
         mpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzv6Xq3ihFFQsayom2Qdg9Hzw3ojwjKD2yhS4tVSkyI=;
        b=dr6YYcJ/ltk33+/Q8eRrSu8YsoljM5WG9iIGHQ7LZEOxNahb/kN479kekpt2Owvv6R
         YihxUYUoc/QEGSljAJeUtBEgftSj2exCjb2reJ1NcZdeQBeNJlBwFO0DPdJHrneG3i1G
         V52rYVeFIzOgJbcpVTVvzSafCU19utDukxD6+o6O0k2I0mm03eSjXy+C14Sm2rybiuun
         dLXi27gcHM1YszQlSqltEcISovu8w7gzveGJ8wYMRWCqBtVOP4M4hAwoII84KDa6qOz+
         63sjAtFypIcgTjn44w4QZ9nL76NZXq9OrrAcw3510NR4AiKDOHDPGcHeva2xT2lXL/SN
         aALw==
X-Gm-Message-State: AOAM531L+CQJEZ3jOfdmQJExdhK2ng7xteDx+s0wrwbJVVXCvXhmjXct
        TpdxaEbk6xRByiQFyjrJspvPkg==
X-Google-Smtp-Source: ABdhPJwWppYkSDcF/4ZvGyCNz2QJ/Xpyz04bWKQclyPg0aI7E+e3saIIUN86GwwaXZYAsfmAgFy0Kw==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr2709963wrv.405.1597821862505;
        Wed, 19 Aug 2020 00:24:22 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        libertas-dev@lists.infradead.org
Subject: [PATCH 14/28] wireless: marvell: libertas: Fix 'timer_list' stored private data related dot-rot
Date:   Wed, 19 Aug 2020 08:23:48 +0100
Message-Id: <20200819072402.3085022-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/marvell/libertas/main.c:727: warning: Function parameter or member 't' not described in 'lbs_cmd_timeout_handler'
 drivers/net/wireless/marvell/libertas/main.c:727: warning: Excess function parameter 'data' description in 'lbs_cmd_timeout_handler'
 drivers/net/wireless/marvell/libertas/main.c:761: warning: Function parameter or member 't' not described in 'lbs_tx_lockup_handler'
 drivers/net/wireless/marvell/libertas/main.c:761: warning: Excess function parameter 'data' description in 'lbs_tx_lockup_handler'
 drivers/net/wireless/marvell/libertas/main.c:784: warning: Function parameter or member 't' not described in 'auto_deepsleep_timer_fn'
 drivers/net/wireless/marvell/libertas/main.c:784: warning: Excess function parameter 'data' description in 'auto_deepsleep_timer_fn'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: libertas-dev@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/marvell/libertas/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index 2233b59cdf444..ee4cf3437e28a 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -721,7 +721,7 @@ EXPORT_SYMBOL_GPL(lbs_resume);
  * lbs_cmd_timeout_handler - handles the timeout of command sending.
  * It will re-send the same command again.
  *
- * @data: &struct lbs_private pointer
+ * @t: Context from which to retrieve a &struct lbs_private pointer
  */
 static void lbs_cmd_timeout_handler(struct timer_list *t)
 {
@@ -755,7 +755,7 @@ static void lbs_cmd_timeout_handler(struct timer_list *t)
  * to the hardware. This is known to frequently happen with SD8686 when
  * waking up after a Wake-on-WLAN-triggered resume.
  *
- * @data: &struct lbs_private pointer
+ * @t: Context from which to retrieve a &struct lbs_private pointer
  */
 static void lbs_tx_lockup_handler(struct timer_list *t)
 {
@@ -777,7 +777,7 @@ static void lbs_tx_lockup_handler(struct timer_list *t)
 /**
  * auto_deepsleep_timer_fn - put the device back to deep sleep mode when
  * timer expires and no activity (command, event, data etc.) is detected.
- * @data:	&struct lbs_private pointer
+ * @t: Context from which to retrieve a &struct lbs_private pointer
  * returns:	N/A
  */
 static void auto_deepsleep_timer_fn(struct timer_list *t)
-- 
2.25.1

