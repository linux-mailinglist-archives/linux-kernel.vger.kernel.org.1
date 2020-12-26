Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7A02E2E22
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgLZMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgLZMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:20:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A544C0613CF;
        Sat, 26 Dec 2020 04:19:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw27so5790447edb.5;
        Sat, 26 Dec 2020 04:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yL2fcbE5+ZP0jQqdAhaNB9vo2w/Z2fyL3TP12vjX7FU=;
        b=CckdE00RXIg+P0KXwsJ2zofSD+5xhSncRG6G+APdtZkMLB2RknEgvQ/HKJ+nlURq2F
         hn3yJQ4THduC7LanFchEBXYEVrNKq4a+T5RDsqY2atQm3mT2jvv5fqzugiq43TGpsmzw
         xh2vzap9jz3yBfykGOcAD9RAklebl/s5gxjqcuaxODBbokuQJM/8U8KdB50TsqOeBd3G
         9ic+Vl2tNLJrjL6yMxbYY1GTYipIR5gPa0bxWpx8zQWmQ+LQZ8oRYssW+gGLt/S4DXQb
         am28sItsBC2uhgqdFSsgQ3YAxY1PigWdShJBfo4JHyZn337c/70eqrLxJoLcxd7L9TWi
         8SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yL2fcbE5+ZP0jQqdAhaNB9vo2w/Z2fyL3TP12vjX7FU=;
        b=QQQmOikP6lmUYCqgKSDoQj//wK4eaQBX+h0DgAWcteAt323xAgsm6IXV7HsW6EREGy
         AUps+h8OsVKPT8fV/zii/su2ekEKyB5RSr7emz7MAZnnckhsPFTkVO0bwScHVpUCgiRC
         tLlo7c10ZQazOVvjQg2sHP/Vla/JbLOYSQhLxxTvp74MGi2Hojr4N0FmJmsDL1Q/XYAL
         FExFTP7sqUUtzS/O/1feq0xOU9z4AUPzT7ucM9+wRsLVg0xSo2ZRJ/OeLAI4oRsKc3Lh
         FQ31XBPmlqDqYrW4REizXUmZDgpQizWRqvdUgmUH1sl4IkqsUkI94S1hgMW8lFfQLp/U
         Bjwg==
X-Gm-Message-State: AOAM533ULopWKka2bae68omAGaPbI/IN2nGpoAUkPJdhgThxLLwuB4Z5
        7Q/z7tIJK8Tin7TZPIWLHQU=
X-Google-Smtp-Source: ABdhPJzsj81ND9dZvGlpw/Zntemt5voV2doEU3AM0Bu6D87Z1uIxXjmwFspZHh7RGGNPJXzYKGmjOA==
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr34967288edb.310.1608985174842;
        Sat, 26 Dec 2020 04:19:34 -0800 (PST)
Received: from localhost.localdomain (p200300f137218200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3721:8200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j9sm33842662eds.66.2020.12.26.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 04:19:34 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] clk: meson: clk-pll: make "ret" a signed integer
Date:   Sat, 26 Dec 2020 13:15:55 +0100
Message-Id: <20201226121556.975418-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
References: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error codes returned by meson_clk_get_pll_settings() are all
negative. Make "ret" a signed integer in meson_clk_pll_set_rate() to
make it match with the clk_ops.set_rate API as well as the data type
returned by meson_clk_get_pll_settings().

Fixes: 8eed1db1adec6a ("clk: meson: pll: update driver for the g12a")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 9404609b5ebf..5b932976483f 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -365,8 +365,9 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	unsigned int enabled, m, n, frac = 0, ret;
+	unsigned int enabled, m, n, frac = 0;
 	unsigned long old_rate;
+	int ret;
 
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
-- 
2.29.2

