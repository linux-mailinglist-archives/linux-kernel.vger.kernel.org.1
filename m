Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE73A23B126
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgHCXmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbgHCXmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:42:04 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BFAC06179E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:42:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w12so26754081iom.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FMp7t9zJsevOEX4yhVr5KoKILCcT3l3u0rcT+JXhAY=;
        b=QmPh5nUPZ/EESdkkBHbazCKwv58BbTK07a7ZwJHmzagU/Bz4f/E1vxoLzaRwdM18Ec
         zQL+cmXrtCJyMcJDC76O4BDu8yXMjiU4vSL3q775lP2gnzPpziQXmChMp8UmXGDoc9/r
         ZBGwYzEmn6I2arNS/DD88D7/M+xg1ZNcCF4lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FMp7t9zJsevOEX4yhVr5KoKILCcT3l3u0rcT+JXhAY=;
        b=AoCIAB0YlzTn3675h05qhTVZtIaVxVc2/l4hRgOjVkDpl+FmGEvKMa8hDRDcvfMnZi
         yXU1fbGW96QQfcoPGc6n9ABpXgY1DnTGrlbR6oF6CiU8ykv9QrywQJ26EGRIzrpQ6eJo
         qcWitT4XqbRtnemLAEho9uGdSO4jN79+BU72K8t8bbYFfBqJ8R9BXkTn+j/5vkoxDWwZ
         68NEg3koYJyDzkHFmtY+/DlPvu7x0THuzd0a2oyl4oMtnOJoz5hOSYzDnQ+dGBR1RxHd
         Asvk+EPpoCzaXH0tTEfd50w32Lc2PVqwJ6B76VTd8w3m6SrvlRtwzuHXwec480y77rQ5
         8FCQ==
X-Gm-Message-State: AOAM533DIuTeZw5ALtZPvwI9kAoxl65D3ndkgz3n976Hr1GDgd9zUyJ7
        /ELXqFYA6TT9p5NWbJICTg4/Da6W/bIvGQ==
X-Google-Smtp-Source: ABdhPJzjGK7YETFVd/XuYfzZTadZNnhp+w6G8pQCShVInAJwoMtBVMhKSEdDiv4NIJ6qjucNotgs0g==
X-Received: by 2002:a02:b689:: with SMTP id i9mr2549762jam.59.1596498123575;
        Mon, 03 Aug 2020 16:42:03 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:03 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 04/15] iio: sx9310: Remove acpi and of table macros
Date:   Mon,  3 Aug 2020 17:41:43 -0600
Message-Id: <20200803131544.v4.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids unused warnings due to acpi/of table macros.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
 - Added #include <linux/mod_devicetable.h>

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 3523ee5c8f0d2d..3642d23cd5e6f4 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -15,8 +15,8 @@
 #include <linux/i2c.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -1048,8 +1048,8 @@ MODULE_DEVICE_TABLE(i2c, sx9310_id);
 static struct i2c_driver sx9310_driver = {
 	.driver = {
 		.name	= "sx9310",
-		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
-		.of_match_table = of_match_ptr(sx9310_of_match),
+		.acpi_match_table = sx9310_acpi_match,
+		.of_match_table = sx9310_of_match,
 		.pm = &sx9310_pm_ops,
 	},
 	.probe		= sx9310_probe,
-- 
2.28.0.163.g6104cc2f0b6-goog

