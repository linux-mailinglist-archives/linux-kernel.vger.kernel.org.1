Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40119DECA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgDCTuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 15:50:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37143 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:50:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so9972910wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZwalgJuNdjnU0AH+11/7zFoA2oqP3wkRvVgbyS9b41k=;
        b=KUVQPcnyz2hl7SCVBDI+1XsXZwodz/A+BMq7RJInRs48OWppiuWfPyn3Z7e/O+9Ku+
         3HlPHApGLzvMJs+0KFmGHj/6DUC23P9I2sSJDWPkk+YFZ2Q+B78IgzzUYzFLpc+dgn8r
         PndzOOMEAbb8Kg0i01xjsBVBJ/NkY32OR8lgja1akb26BTK54snwotBHjQNvVC7GTLyh
         T8md9A3jE00qFWhh1cLuTU9IBjwacoK0WRSxwOOpWinkGE+CQypkkEAp7Zr+vFheElVz
         E7fXNgg+imGbrYqZWVqTnvq7MHOMaQ1+e19T7UUWL0wfWgjinehkX8CITwHPlCPscYeI
         iVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZwalgJuNdjnU0AH+11/7zFoA2oqP3wkRvVgbyS9b41k=;
        b=eyAs/aBFNzSB8fACgQwkVANsOvGweYlqDNyXih8In6ODcRvXyqBsyERqCbce+L5FFx
         RUvFdOcHw21YmC3Ql/2TaUrY8PpZ+vnxyV0fv+pEJ+zitSAxBNSrEN0ONGAwitZ52wIU
         ERSJYLCiNC1Tis3/w6v1sTqReSBsYweXXtneq+UEyK4veAEQXdikshXCnqL5iF+hQO6e
         nL0rMS52aODBFT57aBV3VZwAkvETb60pf5qRGFJh7LChGvxMIQQ25/Yh9IFbxWmlGfLW
         nFx1Xr/MPD5+w36a5WA6TtE1I8quZPLrrgq84LYAxd+/WyxHbXGdc7G/M8NM0xdyTBd/
         Pc7Q==
X-Gm-Message-State: AGi0PuZz2hpbe8WnDlpipYLrBB1G9J6dI/H48VhX3VDYbpzCYzWCkMn+
        6bukBvRSiE/sziQLaZguikdm0g==
X-Google-Smtp-Source: APiQypJPD3CP1v4p+ZE6U2Aywvu5WeATMjzlv5PMn28lxY1pqFnQhQh7N1RgKP5cr5vCmeFo5f3YRw==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr10686337wre.155.1585943448089;
        Fri, 03 Apr 2020 12:50:48 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c17sm8102448wrp.28.2020.04.03.12.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 12:50:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/7] crypto: rng - add missing __crypto_rng_cast to the rng header
Date:   Fri,  3 Apr 2020 19:50:32 +0000
Message-Id: <1585943438-862-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
References: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add __crypto_rng_cast() to the rng header like other
__algo_cast functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/crypto/rng.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/crypto/rng.h b/include/crypto/rng.h
index 8b4b844b4eef..0e140f132efe 100644
--- a/include/crypto/rng.h
+++ b/include/crypto/rng.h
@@ -198,4 +198,9 @@ static inline int crypto_rng_seedsize(struct crypto_rng *tfm)
 	return crypto_rng_alg(tfm)->seedsize;
 }
 
+static inline struct crypto_rng *__crypto_rng_cast(struct crypto_tfm *tfm)
+{
+	return container_of(tfm, struct crypto_rng, base);
+}
+
 #endif
-- 
2.24.1

