Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97826CDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIPVDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:03:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41959 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIPQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so7600740lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 09:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GumrrFh8EgmUaaZHS6T2Ir2CSMD9+1qAkrgVmKMRPXc=;
        b=kAqLWBuHynqAllTxsipbVNMhvD1Nvt8pNXCbvD/mGIMwcRBDxqmxMelQtgDwePxbKh
         Jj+77eiVI/onwiNjR6uiFwp2wccIis9Qrzj51sGrD4rtKZvIZf3QOdoPvhMHHnm8qTOz
         P18jRAbMOt2mtQKNN3TcFwQL2l40nW14B3LHkqzgOJFcnlauV7kvxRRF4xU7p5htatlp
         F75VYQ1qnCUATUYuEUizEJm/o1Nu0fHz1D7WcEweZgzuuimsyN6CD8kHkVxdE2sVq2+u
         rnltXPH16ANx2ZWZkPMfEU7WPE5EIscfJxQL/Yp0vMldkphVxmIWYMLq0RwhzOSppH1z
         fIDA==
X-Gm-Message-State: AOAM532283+SjzJCYapwa9r6EUjHUduOTL2bgVIRIrp8DexcP8W36Tfo
        7F0U9cPpFKp5OmKJ33DI8qxuFdaiYw0=
X-Google-Smtp-Source: ABdhPJytHgZX0UdcccRAZJx779vCpzpC0my4+pB0WHqsFUNkxZ9o0grJ5MlzYv6GhzdjVM0HQ5jJ2g==
X-Received: by 2002:a05:6402:12d1:: with SMTP id k17mr27784256edx.323.1600272355542;
        Wed, 16 Sep 2020 09:05:55 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id s19sm12931759eja.54.2020.09.16.09.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 09:05:54 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ricardo@ribalda.com>
Subject: [PATCH] regmap: Add support for 12/20 register formatting
Date:   Wed, 16 Sep 2020 18:05:52 +0200
Message-Id: <20200916160552.1062243-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda <ricardo@ribalda.com>

Devices such as the AD5628 require 32 bits of data divided in 12 bits
for dummy, command and address, and 20 for data and dummy.

Signed-off-by: Ricardo Ribalda <ricardo@ribalda.com>
---
 drivers/base/regmap/regmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e93700af7e6e..14cdfee4c6ba 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -209,6 +209,18 @@ static bool regmap_volatile_range(struct regmap *map, unsigned int reg,
 	return true;
 }
 
+static void regmap_format_12_20_write(struct regmap *map,
+				     unsigned int reg, unsigned int val)
+{
+	u8 *out = map->work_buf;
+
+	out[0] = reg >> 4;
+	out[1] = (reg << 4) | (val >> 16);
+	out[2] = val >> 8;
+	out[3] = val;
+}
+
+
 static void regmap_format_2_6_write(struct regmap *map,
 				     unsigned int reg, unsigned int val)
 {
@@ -867,6 +879,16 @@ struct regmap *__regmap_init(struct device *dev,
 		}
 		break;
 
+	case 12:
+		switch (config->val_bits) {
+		case 20:
+			map->format.format_write = regmap_format_12_20_write;
+			break;
+		default:
+			goto err_hwlock;
+		}
+		break;
+
 	case 8:
 		map->format.format_reg = regmap_format_8;
 		break;
-- 
2.28.0

