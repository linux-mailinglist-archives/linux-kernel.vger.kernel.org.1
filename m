Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A202C26E4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIQTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgIQS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8027C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:59:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so3184652wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/FQeEcWUlQDqfQ8wanTKIcTElJ0+/H0Q34PjAFqIS2E=;
        b=UDH2kSarbkBuYBTeWj3n0fqUdD9XU0XvPc+4NOngHaapEW0SOpuLQ8y2YcruoNZeEX
         svVWs1RwWe/w6VHGkXAOgYyz3Cix45a6NYx3vT6cF0+ufr8RGH7pgc/1fC9yA3KIbmZE
         MTt7xB/yrUVL+6MJpVcF2vyvi/2cOm2JzUH6JFmGAgB61p5NzL4KKCADVFcHVZh7q+UF
         ohOzgpHwsME46bLgBALQPJR3APlbQv4PT/DrXz2a7r+k3AZWUjujgKyUqrLxY2ve1zWl
         96ociw42g1nxXnxTmBpW5arpqMbDoUXiYheqCebLj3yquFlTwDkxwk7xLLnZtqD4h3cP
         N53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/FQeEcWUlQDqfQ8wanTKIcTElJ0+/H0Q34PjAFqIS2E=;
        b=A5pqGdRjEyz5PBRG3uCNjoiBsZdxgM5AdZG+V2A4hQ1uiJtSDzgAoifAe7SSmudeo3
         /o271oVvNkJzKuiLE3D8E3pGSZ6gkQPRHxcSaxAA+o5G6cqqLO/ulQt8DKziiyWXd7jg
         JvI19aWYdncU+vbJXnRPXtct81zWw2kJBsF0Wy4A6pZn0Hj6gHFHLDtV/9gjBqolToHb
         81sLGZ8OKryy05NJg/W+3fran5RCn4h6GrR56QyPj0zGRww2lYtngcW66an17ouDbKV0
         sU4JiTQUH03joicHE/l3HKDhLQ94v+pQXg+wGs2E+6HmytAsBmsFBnacY7FxlWmhPWTS
         4Kzw==
X-Gm-Message-State: AOAM533FrQJ754fBIfCPs8nhDmll+jkDK9B/LqO+cSFvSd4ONJi4eTYU
        dyI59m7cQDQvDD75HpUefgyvFg==
X-Google-Smtp-Source: ABdhPJzbVDEFcxbw/TjYhFdXwMyu3mguWYl6vvOW6/lfjbNAQgC808oX9KFWtD4HV3w00/BjD7ipww==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr35007812wru.191.1600369184565;
        Thu, 17 Sep 2020 11:59:44 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id f23sm16639470wmc.3.2020.09.17.11.59.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:59:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: procfs: Removing some useless only space lines
Date:   Thu, 17 Sep 2020 18:59:36 +0000
Message-Id: <1600369176-28975-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some line got only spaces, remove them

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/proc.c b/crypto/proc.c
index 08d8c2bc7e62..12fccb9c5205 100644
--- a/crypto/proc.c
+++ b/crypto/proc.c
@@ -36,7 +36,7 @@ static void c_stop(struct seq_file *m, void *p)
 static int c_show(struct seq_file *m, void *p)
 {
 	struct crypto_alg *alg = list_entry(p, struct crypto_alg, cra_list);
-	
+
 	seq_printf(m, "name         : %s\n", alg->cra_name);
 	seq_printf(m, "driver       : %s\n", alg->cra_driver_name);
 	seq_printf(m, "module       : %s\n", module_name(alg->cra_module));
@@ -59,7 +59,7 @@ static int c_show(struct seq_file *m, void *p)
 		alg->cra_type->show(m, alg);
 		goto out;
 	}
-	
+
 	switch (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
 	case CRYPTO_ALG_TYPE_CIPHER:
 		seq_printf(m, "type         : cipher\n");
-- 
2.26.2

