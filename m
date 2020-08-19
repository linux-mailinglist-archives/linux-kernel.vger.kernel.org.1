Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29F324975B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgHSH3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgHSHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9744C061349
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so1086059wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXYENBinaCN+ks7DBcWZinXSV9BpT8CW1RxXg+imR4I=;
        b=e6I2zUm35cVi9dFGr/2WyrNR16/nLWhQxMYyQnM9+Z5wU7CzwJA0K2RlxVhx7Ow7XN
         c3yC3PFP/6F5WKaEP3sVw27CfQb0nBA8277d1UuXQyd/tk4VFU+ZzTvpKA/eNkC83idm
         fEKJZqjA98IDAup4I3XLkAzw/qkLZmDNMoO0kXPeNA38j7TaY9BCvnJFweNqB3nwvepT
         YbWU6enSU37CbsDkYj9Xz/zo+4Zicz9E73yZsyB9Y1YOB1Uo601HfHNkY99OvfvvabdI
         0lSqKO3ntZmlUMcF6OdQnKZmcOkvXFMUQb+09mfkNMJZwPSHbNtkm2L9rRkapqgiMyFc
         U3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXYENBinaCN+ks7DBcWZinXSV9BpT8CW1RxXg+imR4I=;
        b=oFoZX19voMfsMOzomV1Zr1I2aG3D5gHKq7zetFG/AjOhtWEDNAxRvYxY661PtdG4/1
         0rVjgxtDkXs+JjStDz0cd2tn+1O73H+siHmanAsgdKopA9lPY9H/SPNjjqZwqHHDgjjO
         zUw+5Rqe99bGXca09g3OQqlXBZ92YoG/jmeNvCWYMFnFb98MenvtiAVEWNpJVtd+/8Mg
         lGMEpuaQZlaD2eQzVeTG4IGirFltQ2teLbj1J9zLytlUixb4SCqT+RDf6xYwESNp6p49
         xv8QFxz3TDgXKJlERcY24Exy1oaazH03i3EiMO8wJtkC9m6NxI3YDwA8fTLtQ/HQ768F
         y17A==
X-Gm-Message-State: AOAM532XO7kW0jzUFHYnpa6CCPTf8xkFelkcsVYm7RjFA1nzGlsK43Ul
        7WGsaTdTNH/TP2qYNP6SoqwjZw==
X-Google-Smtp-Source: ABdhPJwWD5XjdrzI9FGmyd84dbQlnOONx1mPGNDXQd2rPN/ZIu2Ei5/wgcYH61as6iwvHXLQr1p05w==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr3380282wmb.173.1597821859109;
        Wed, 19 Aug 2020 00:24:19 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jouni Malinen <j@w1.fi>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 11/28] wireless: intersil: hostap: hostap_ap: Mark 'txt' as __always_unused
Date:   Wed, 19 Aug 2020 08:23:45 +0100
Message-Id: <20200819072402.3085022-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping this around to act as documentation, since its use is
currently #if'ed out at the end of the function.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intersil/hostap/hostap_ap.c: In function ‘handle_assoc’:
 drivers/net/wireless/intersil/hostap/hostap_ap.c:1507:8: warning: variable ‘txt’ set but not used [-Wunused-but-set-variable]

Cc: Jouni Malinen <j@w1.fi>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intersil/hostap/hostap_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/net/wireless/intersil/hostap/hostap_ap.c
index 3ec46f48cfde1..8bcc1cdcb75b0 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ap.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ap.c
@@ -1504,7 +1504,7 @@ static void handle_assoc(local_info_t *local, struct sk_buff *skb,
 	u16 resp = WLAN_STATUS_SUCCESS;
 	struct sta_info *sta = NULL;
 	int send_deauth = 0;
-	char *txt = "";
+	char __always_unused *txt = "";
 	u8 prev_ap[ETH_ALEN];
 
 	left = len = skb->len - IEEE80211_MGMT_HDR_LEN;
-- 
2.25.1

