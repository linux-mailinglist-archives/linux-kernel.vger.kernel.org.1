Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59DD2A6DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgKDTbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbgKDTa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:30:58 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:30:58 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k10so21982058wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aE8AlEOJT9P+pbgFO2925Tf8enhX7i67KSrVU6g6Jdw=;
        b=CGG0ntkpOFV4TRjjvJFjmnJMXugj2mxhcoA30rQurHrxKNQWQDQyAFNHcioGScs7rk
         N5YSNXYWwfn3bsh2agO3bszdSPx8/s9FWZgzSxNQKxZ7qm7kY0AHWb5Co+Lt52QffvI0
         VMaWIF7nyqLWxX3SgAnjjB59z4fQ1ILmoqizqZwMbTjo0iR2bsdFftureOZghCJ3mieR
         QJ6f9OfIMyCdMxxUcpps5N7lSeGtExXxv3J/c/3lcYz2rANTctfhDnSf4Q7Zn1+NIORs
         intdnRkQi/aOyq+PatXiPFV8c9z5OrG4zsh2llYOlYSvSlXLZiPtEOiQ79Zi5BT3JmtQ
         jwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aE8AlEOJT9P+pbgFO2925Tf8enhX7i67KSrVU6g6Jdw=;
        b=Q4MRNrJW4uYGQEQO6KZKZ+Y/JFPtgoidnxSQoiWeF4WzmBjnhbTkUdpkd5WvMNx2XN
         55n1zFYU/wwGv+QOc6VBROVrjaKDTuHNtCOufvHeat8EYRJqJxeU07wTFwXiUf9LEYnf
         aWavrfzBoeOgT9d78/nvmEkDksNoyE9IO1yCpeZH1q0ItuaYymEnYxv0nBwasaAD8sda
         W3FX8TMJPP+DA2keAcW7GTAz5Uh94Zqkrwd6mpiTv0wnA4Ol85QlqmA+0GUHVAfYdStm
         owyrsWJQB7InBLTI1st0rWJjz2hQaYms0Ny815euk+QmTmorQSzjtwv6XG9J+tlayaVu
         TIjQ==
X-Gm-Message-State: AOAM5308PkEnCGOEFLEkifO689SoW0XPHLPcg/L7bR5zwNrLm0xNWNsw
        rqbi+Mk6DSnt4vokW8Ck2VIeug==
X-Google-Smtp-Source: ABdhPJz7iWx6nLyowWVcGP/GeIV6d6ZWY4cYwwt+Tc3Zt4dxD1bTOjc9KJjirRpDMCkKnEiT2o4xww==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr35765164wrm.41.1604518257130;
        Wed, 04 Nov 2020 11:30:57 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id m12sm4051671wrs.92.2020.11.04.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:30:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/8] regmap: provide regmap_assign_bits()
Date:   Wed,  4 Nov 2020 20:30:44 +0100
Message-Id: <20201104193051.32236-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104193051.32236-1-brgl@bgdev.pl>
References: <20201104193051.32236-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add another bits helper to regmap API: this one sets given bits if value
is true and clears them if it's false.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/regmap.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e7834d98207f..62099e7a3ed6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1148,6 +1148,15 @@ static inline int regmap_clear_bits(struct regmap *map,
 	return regmap_update_bits_base(map, reg, bits, 0, NULL, false, false);
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	if (value)
+		return regmap_set_bits(map, reg, bits);
+	else
+		return regmap_clear_bits(map, reg, bits);
+}
+
 int regmap_test_bits(struct regmap *map, unsigned int reg, unsigned int bits);
 
 /**
@@ -1554,6 +1563,13 @@ static inline int regmap_clear_bits(struct regmap *map,
 	return -EINVAL;
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_test_bits(struct regmap *map,
 				   unsigned int reg, unsigned int bits)
 {
-- 
2.29.1

