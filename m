Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C7725D78A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgIDLhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbgIDLKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:10:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946DC061247
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:10:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so5706719wmm.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=a8BrO6udlqxdyuGU28A92cZCiYcUSD2su+5p7v7c3nvkb6/7BpS8K4IuVu5hUkvCGI
         OGWfgVVb8EafZ6VWTYtBakT9kf+WAtF3GfdYPafixsaXbZUhpKPvIXurJlVy3/yZYSt+
         4LTEwMPOiYKMTLgrKwz/2FKIURBdsrb7ffYKITbEeheUTjkoOkQGQFLs2S0seQLKVjLG
         LhVQ4BSyz9tlfwDDje+IR8ZDQVaeug4muuinxWCdk5Sqne0m7tx6uITRkuYnHrKgMJe1
         n1UBhPayZ1GqzXEhM0hy4KcVJ5EljdpwClVU1hUOmNvSdttGEmNhbzD7s8KSKxtZIN7P
         tE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=PpmkWTIVEVGtTtp9S3iO2BOJo5/8Qig9dPpcpRUr5UVWSmle6CTQ43vSRS0MZgOOJe
         k9IVZrbpbwd+UJyL27ryO/fPtJUFSwpDb4ub5lD6Dtlp9m6aD+UKoTxfe4RaVcriauPo
         p+jXNbBU0EEQeSHTrhWjyz1ITJjXkVBJpQ53sfevcMHoiYgoHeH7BcFLDP2sCx+J+Ci7
         t6k3MLnLHjaN3SFmjUAWkKvIOGfrCsZdP2I/BK/HbYzFaOjLD5PQeaILRuaRW/QiAXpM
         u+SaHyNca5iEuJUXYm4M2ruYrnVCDk3UHeMvP3kT+tBrQGAjmpBuiuGMrDXjrfjTZbLe
         T/5A==
X-Gm-Message-State: AOAM530T6Uf4hcox3DkaH8DYlgJkBFdbwhD9pd6BpNeL8TwXWNkaF3hD
        qnaVR+7N1/ai/w+TET7jf7YYzg==
X-Google-Smtp-Source: ABdhPJy04C8/p+fmq52PwzrBd2umCaqC3Mr5btRRscqtBGxSf3nIJbcHD7PikiMxfyp9Rp49HbattQ==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr7482650wme.159.1599217815551;
        Fri, 04 Sep 2020 04:10:15 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 04/18] crypto: sun8i-ss: fix a trivial typo
Date:   Fri,  4 Sep 2020 11:09:49 +0000
Message-Id: <1599217803-29755-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a trivial typo.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 377ea7acb54d..da71d8059019 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -100,7 +100,7 @@ struct ss_clock {
  * @alg_hash:	list of supported hashes. for each SS_ID_ this will give the
  *              corresponding SS_ALG_XXX value
  * @op_mode:	list of supported block modes
- * @ss_clks!	list of clock needed by this variant
+ * @ss_clks:	list of clock needed by this variant
  */
 struct ss_variant {
 	char alg_cipher[SS_ID_CIPHER_MAX];
-- 
2.26.2

