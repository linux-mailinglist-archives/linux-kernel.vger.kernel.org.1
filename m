Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D125D780
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIDLgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgIDLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:10:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF9C06125F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:10:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so6281257wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CfYFcq4WmzTE0aAQvo/9AeYUJUnGPZBDIaHQZNs9Mgk=;
        b=f5nW2z5tDqaAYg5sxLoTMzCHrvDVedINE/fP+LzcN8jRXcaN1dQntgDS2Mb+UFdFtf
         25ntq9cGH9A5miW0aysMZXCh1p4xc7RlD0yI5A0p9pZKZz4XgpH6LEuuUTcGQef8a2YQ
         3w5MRxp+JuYHvnSnOGGca4Ud47zxvsWQeBSbi/w0yw5oMmODa/Cl2PI/G3OKzbD5SH9U
         jmSun0bXRSiSnZpVIuU3F0s8HPjmyLgUdbj1ZpROrw88MZ6w/hueWQ2pQnmF42TtxXKl
         2JKyJTXBGgvkhiAufwRVlmkmfhBR3NGfphsteCqPHGb/vCsH94stnRg5Filz7Nllo8WX
         CX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CfYFcq4WmzTE0aAQvo/9AeYUJUnGPZBDIaHQZNs9Mgk=;
        b=aafo51/tt+2dqS6H3/vYsUkyCq2Zl58E4hBIBGTo70F3Zo0qHTFGCC04nnq/Me490J
         x6gN21uQ5altTMdVm5yIWqSMxxBpxj+qTUN9wOEKnr90KTOlC335fJVQ4o8Q+notBt7S
         wcQXWJaK+OJhTijGeykei3c4f4rH6+v+tMZwMe5wHBrmQCuVXjvZxojUsVBkVER3Qjav
         8VkDe9cSck8HhLNKqlQlkRr8Gx/SS0YBgkMeM1DEHyXuL9e4ACxGFUT6Kcb8OD1bhMr+
         ejgIg2fS2pxl5/VxIa0NAmWA6N5J7Oe55Xl1Ql8Cbwfgp0TViH76PZjbutyEt4T0p3kS
         YDMA==
X-Gm-Message-State: AOAM530qEXODareOPnpDChWXB+WQjfas82mguwjgmN60yuJpgXSX6Hdm
        pmGexqjY8RrfTAxubyxeWSFweA==
X-Google-Smtp-Source: ABdhPJysubVO+eu8sCb1TjAknOixCMMqmkkoiYOwyOKCvL/mczCYJybOKqKxBva7/YQxCV1tzfKonw==
X-Received: by 2002:adf:f492:: with SMTP id l18mr7467352wro.280.1599217817574;
        Fri, 04 Sep 2020 04:10:17 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 06/18] crypto: sun8i-ss: better debug printing
Date:   Fri,  4 Sep 2020 11:09:51 +0000
Message-Id: <1599217803-29755-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the way debug info are printed.
Instead of printing raw numbers, let's add a bit of context.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 5cf00d03be1f..739874596c72 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -424,19 +424,19 @@ static int sun8i_ss_dbgfs_read(struct seq_file *seq, void *v)
 			continue;
 		switch (ss_algs[i].type) {
 		case CRYPTO_ALG_TYPE_SKCIPHER:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
 				   ss_algs[i].alg.skcipher.base.cra_driver_name,
 				   ss_algs[i].alg.skcipher.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
 			break;
 		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
 				   ss_algs[i].alg.rng.base.cra_driver_name,
 				   ss_algs[i].alg.rng.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_bytes);
 			break;
 		case CRYPTO_ALG_TYPE_AHASH:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
 				   ss_algs[i].alg.hash.halg.base.cra_driver_name,
 				   ss_algs[i].alg.hash.halg.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
-- 
2.26.2

