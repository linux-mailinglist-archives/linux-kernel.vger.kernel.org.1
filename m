Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90C42A294B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgKBL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgKBLYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:53 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D32C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:52 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 13so9031970wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O00sHeoq7zqB2CJlcbUNyhU2GOaz7UJ685HbihqjKQM=;
        b=FxCRoUbjgVNKk7HNy0zfK7Ysq7fk/pGHTzojrVEkM6DLmw3ICYot6hqkuW9TacfsS7
         C1JitGKDV7nsumoh2YZSgBmp8X0Pbhtqo1bcQEHkwWjEDqef70DDjyndMdNy3lv8L8Lv
         CoivpKFBRslyMBL1Ae1LhHyziMeAPQkfdDVoN3iKlIZ/nOat4K8npipMSv6xug2OjzJC
         BoRviZDr/B42KExznjrNo3szFW3PcHnRK553HPrEwFHCh4LZRpO8bODHTJDyDaChy1R1
         ZIwqwnbSJmlup0QvMKaJBM3kKI7rkB0RsVdgF6Dz5Fc/kCoSDGafT72YM6xOf/eiDOze
         yHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O00sHeoq7zqB2CJlcbUNyhU2GOaz7UJ685HbihqjKQM=;
        b=tQu4FHjmbmMbOgZlCNW3uSXAULV9UncZBiTBQU10SdStrxYFKFj7nIE+znsSCMc3b0
         lafXWUw11yRa6/S0BvbmvM7YZU6Yidh+uB/LUE575lcNkEGZzjUaEL5bbK9oeEmNS1kJ
         R6m4rK6pGqRJy+w2FeJaYwZSIap//qCrRdLWlDyGNNhjdkhIDN/GpKkmp/vtKtFB8Un6
         hVVTw2PFpO+yT+lw+4Gbn9N2ssrIdmPkumDdC1AFxHQo0JgOVfleOwWYKJRvCyFz5giR
         6oyGZOwCpznup6rsIsqCxE4r1NijeoMe2CPqhVDOhTHzXomeTd/hHxy0dSuXoY6c+yPh
         8RBQ==
X-Gm-Message-State: AOAM5336SXJGOHBHarj8myU9gIZ2sS/ZsVD92LZmiEncxG8X/CpasP/d
        xyVoDXi76ehQmONhw2Ng1LI7gw==
X-Google-Smtp-Source: ABdhPJyeihrNn2QbmDeQeLSXqwCKFnxhucL/uwRzdauxI7/SvxS5e7FnGW8HV/kyWFK/61MdeNRReg==
X-Received: by 2002:a1c:103:: with SMTP id 3mr16981441wmb.81.1604316291370;
        Mon, 02 Nov 2020 03:24:51 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Fox Chen <mhchen@golf.ccl.itri.org.tw>,
        de Melo <acme@conectiva.com.br>,
        Gustavo Niemeyer <niemeyer@conectiva.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 24/41] wl3501_cs: Fix misspelling and provide missing documentation
Date:   Mon,  2 Nov 2020 11:23:53 +0000
Message-Id: <20201102112410.1049272-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/net/wireless/wl3501_cs.c:57:
 drivers/net/wireless/wl3501_cs.c:143: warning: Function parameter or member 'reg_domain' not described in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:143: warning: Excess function parameter 'reg_comain' description in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:469: warning: Function parameter or member 'data' not described in 'wl3501_send_pkt'
 drivers/net/wireless/wl3501_cs.c:469: warning: Function parameter or member 'len' not described in 'wl3501_send_pkt'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Fox Chen <mhchen@golf.ccl.itri.org.tw>
Cc: de Melo <acme@conectiva.com.br>
Cc: Gustavo Niemeyer <niemeyer@conectiva.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/wl3501_cs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 026e88b80bfc4..8ca5789c7b378 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -134,7 +134,7 @@ static const struct {
 
 /**
  * iw_valid_channel - validate channel in regulatory domain
- * @reg_comain: regulatory domain
+ * @reg_domain: regulatory domain
  * @channel: channel to validate
  *
  * Returns 0 if invalid in the specified regulatory domain, non-zero if valid.
@@ -458,11 +458,9 @@ static int wl3501_pwr_mgmt(struct wl3501_card *this, int suspend)
 /**
  * wl3501_send_pkt - Send a packet.
  * @this: Card
- *
- * Send a packet.
- *
- * data = Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
+ * @data: Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
  *                                   data[6] - data[11] is Src MAC Addr)
+ * @len: Packet length
  * Ref: IEEE 802.11
  */
 static int wl3501_send_pkt(struct wl3501_card *this, u8 *data, u16 len)
-- 
2.25.1

