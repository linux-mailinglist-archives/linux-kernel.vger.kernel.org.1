Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A026DABB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIQLuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:50:40 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37703 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgIQLrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:47:32 -0400
Received: by mail-ej1-f68.google.com with SMTP id nw23so2846887ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0wPYXHFKWnzXcZvxAyuWaGId3CbXQh12hNVs3KjJzZs=;
        b=ttXhxYMVaRB59XFhzsNQXmH0CjY4zJzInSCI0zTAudsjw6D/nIQxOhWqi6/0MY/N1/
         hGfGqFZRgDF09ki0quvVhHhMoNyo6UUFWbf7P7TJJrzicUkdgOWt3pRiiPSQaR+Wmbqj
         61PVnu1PuA9Oi9sm2aP4u0UoIDIaFbfh6DcIxSaXcr4KBr9bq3PPRWeyhj+hBjfzBRNq
         TAsc7dWQyLbNikLTKRi18m6hcPqEZFmTK1sRmNXdVf3HHR0V9iqjVrrg8IGkOvEfWMOv
         Mmk+uPgP1ATx+HzSkuZVLPs99cd0I46fhn/qmht7JmEGF81+RnzqyFSBOkFcBVzbOi3D
         sCBw==
X-Gm-Message-State: AOAM530bC43Xnp0Un6odNBoG/Jvcrl9PvJ5ydZo98r7wZ/wm0tKgHo1O
        7Vhbmr+bPv4MaKi05riHaWQ4Nxz4qas=
X-Google-Smtp-Source: ABdhPJxSo4MpKibnv7ftT52924LJLPYQINpiZSsmtOH0vClC3344qC2F3z0BSniknoUCWQfY6j0G0Q==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr31896806ejf.134.1600343250218;
        Thu, 17 Sep 2020 04:47:30 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id k9sm16126842edr.3.2020.09.17.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:47:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@kernel.org>
Subject: [PATCH v2] regmap: Add support for 12/20 register formatting
Date:   Thu, 17 Sep 2020 13:47:27 +0200
Message-Id: <20200917114727.1120373-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices such as the AD5628 require 32 bits of data divided in 12 bits
for dummy, command and address, and 20 for data and dummy. Eg:

XXXXCCCCAAAADDDDDDDDDDDDDDDDXXXX

Where X is dont care, C is command, A is address and D is data bits.

Which would requierd the following regmap_config:

static const struct regmap_config config_dac = {
	.reg_bits = 12,
	.val_bits = 20,
	.max_register = 0xff,
};

Signed-off-by: Ricardo Ribalda <ribalda@kernel.org>
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

