Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0332A2CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKBO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgKBOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:22:35 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28AC061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:22:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id x7so14840710wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jw3oq9QTE7nFTaO8GB8D/I4qCpQ+Kq8IawJXBfxGxQ8=;
        b=htAF5Ujg6yCl9eqYEVMVTYCl4kGp3ZTnkUV9UbXU9g8dU+97BuZIfMHctZHTz0z0iw
         3eeHUCRmY8CY6eXn1cDdvLdt+IN29epMqgLCrzN+vh79zTaxv2xPgxDqSO0vH5XTJUcT
         uUZiGkBOEP+VgLPnP9/BvaBT0yvVKQWomOnkUC7OZJUyWRpMj8ozdkZdC++M0csjtDhg
         G+hSVlYLvT3l0jnZaioFiFNdMmwIUzI/gRoZgrDigurfpQRk25DlBetOiCQtEgLwlH1I
         EBRWmy2aF7gaNgRBK0IcpKqT8Seoyx0RZc5wln1sAOFpvOfIYtdWwsU+GUDBNT8syjpt
         S6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jw3oq9QTE7nFTaO8GB8D/I4qCpQ+Kq8IawJXBfxGxQ8=;
        b=tooDTr9QXmmzi3avpKsxwWfYtqJwp9DNJFSkfJdm3pKMIl+l0oVyTP2mgcBDUCuuSO
         0Q69LAgxHyzy+CIciPoehMcMiNw0sWggH1asDpd3qNQzjDy+TwQ8VqYR/edwm0u+C1eD
         ETVLGiBo7aBXUO614uiLTA+40E2xIIheU9kPnXElT2Ax7axZkFv5h3L3sIuU2pizZypQ
         RisZYBouecZieG+6b5E7fE43yHywnMRHVoi2Kzoa13woJO/XP7ueLu/N6YZVjgqXhKjE
         jQUK5zjxuABNGQZD+i3N0zq6JYfy4lLP5QA5udtrd42FmLgnut22v5Haup6zUG8RyM2A
         /7Dg==
X-Gm-Message-State: AOAM533eEwRg+CJkYgeKwxgTS6NyC+vfDZeL1soq/HkyNTg2MQxekcgb
        HBKIDvOmtKOfuxLL2X8n7//wQg==
X-Google-Smtp-Source: ABdhPJzSQGvgcpKNMN8/+kAWDq0KWVIo0vIEPBTqaI3e1RKL5IFUmYi3Hy6oECVzYa5AsZyknYP3ww==
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr14427807wrx.155.1604326953520;
        Mon, 02 Nov 2020 06:22:33 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 3sm16182987wmd.19.2020.11.02.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:22:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/4] device: provide devm_krealloc_array()
Date:   Mon,  2 Nov 2020 15:22:25 +0100
Message-Id: <20201102142228.14949-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102142228.14949-1-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When allocating an array of elements, users should check for
multiplication overflow or preferably use one of the provided helpers
like: devm_kmalloc_array().

This provides devm_krealloc_array() for users who want to reallocate
managed arrays.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/device.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 5ed101be7b2e..e77203faea55 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -226,6 +226,17 @@ static inline void *devm_kmalloc_array(struct device *dev,
 
 	return devm_kmalloc(dev, bytes, flags);
 }
+static inline void *
+devm_krealloc_array(struct device *dev, void *ptr, size_t new_n,
+		    size_t new_size, gfp_t gfp)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return devm_krealloc(dev, ptr, bytes, gfp);
+}
 static inline void *devm_kcalloc(struct device *dev,
 				 size_t n, size_t size, gfp_t flags)
 {
-- 
2.29.1

