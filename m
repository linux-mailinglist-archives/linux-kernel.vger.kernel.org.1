Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5026F6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIRHYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIRHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C9C061354
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so4469920wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3NfwmgIkusrIFQh/foQlCaqxL73ivfTwGYpo+owuO8=;
        b=FBjC2lBJgTf02yY59wYmdUOTO8EzhTzonxlGgL2okMT0KFicBzAtQY0qV8nAQHUCr4
         69vUbx01Qz1CZ0mJ0zOJDes8v7oNqLFTtomIpaxRDZWjalbhpbllRnxbl15ZLaPs70WH
         gkk2Mt95FxliA+8Ogeh4fgvM9H3n6Uy0DcVQk3ocKawBzphUeMuxFBBcOH0LW0KU1zP6
         okmqLAEIJY+L1OYLtqrZK0MTEg32yRwxHjcDsbffj+NrVm2XIJwbOVaXA3p5GoSuUVej
         Z+lgZVlqvxIBojWuiXmr23l3eljiwz1fPKuAhG61JowNzqL0UrCxFEkumljrJqdsriPb
         WwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3NfwmgIkusrIFQh/foQlCaqxL73ivfTwGYpo+owuO8=;
        b=SOPdcCrzUNebfi497T73DaSZ8Rg9h8dJW0KNyeHudhQE2GOZWK8yZeM73NguksRhHj
         0yg3nZJDhEVZg3uJDbdEOYppyUFvpJ7+c/1U35H4t564LR6ozFyiDI15CIOAR3ovnObR
         2N757zbAFFyCDyL9RgOSaYh+d0c6oSKxPkbBxI2iqNJta7D3C9KRoMyNCAY+WnuwUcQx
         mAtQnq5bA3qN0mxjTQDjkeOoyirV/o+fEbpyPfs0NPuK+YeTN0rqAu7XJ9EM139vEcSV
         CuWjMtwXrD7Md7navLZijRvslpICFTDOzcxiSyA5ouuDWPjjEWi4hNPWsoyEORGTYxt+
         CBFg==
X-Gm-Message-State: AOAM530jkB835aKQi/5J1BZ3NvOJPwLdfMb1zL3lhGp3tIBzc0W2/eq4
        +8iScgUq1GBCKr4TCg2AOEvwfQ==
X-Google-Smtp-Source: ABdhPJyiEUHG4TOWclIOaejkiufPXE8kBmSlXhj5fEFu4UCDkbLnQ606xYLAMEzyVtWtnzsEJImRPw==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr14673116wml.50.1600413819812;
        Fri, 18 Sep 2020 00:23:39 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:39 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 13/17] crypto: sun8i-ce: Add stat_bytes debugfs
Date:   Fri, 18 Sep 2020 07:23:11 +0000
Message-Id: <1600413795-39256-14-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new stat_bytes counter in the sun8i-ce debugfs.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 9311c114947d..c80006853d10 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -280,6 +280,7 @@ struct sun8i_ce_hash_reqctx {
  * @alg:		one of sub struct must be used
  * @stat_req:		number of request done on this template
  * @stat_fb:		number of request which has fallbacked
+ * @stat_bytes:		total data size done by this template
  */
 struct sun8i_ce_alg_template {
 	u32 type;
@@ -293,6 +294,7 @@ struct sun8i_ce_alg_template {
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	unsigned long stat_req;
 	unsigned long stat_fb;
+	unsigned long stat_bytes;
 #endif
 };
 
-- 
2.26.2

