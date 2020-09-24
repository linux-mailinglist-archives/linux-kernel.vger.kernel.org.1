Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B027702E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgIXLjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgIXLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:38:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76448C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so3399671wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuUI/vBtXJYb5lrBsJkZLuZDFBHGHAPpV5LdIYhZxrs=;
        b=2JjxeELoVhjSUqUOW7Hu6PuV0/8XE4XmUTBlFiT4aHyPLH3ILia0DHWLU9WpRD3eug
         Doo0iZvPyOKNTkzuBT/+nSrDhyW88XNL87nw5LxG2PXW/Ae0KrCxn97v/wQnrmKOzLH0
         X+TO0u9Ol4YBOS6q55foxfA/5VhgXEQzduJDQLlHFmK+onw5hakaKsbGSL1oaERfRso9
         NBX+c9TQXF1G/y0nHUBQD0ZqPJx7JQucTZlwrMv9qJJC0rCeTbZStnwP5R7bQU6MQYDk
         WOfdAqF7vbxN7cZRJTw/Sk6hghgevmg1VltBZCYIRY+xoPngnXc1DevbLBCo12X1beo6
         rOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuUI/vBtXJYb5lrBsJkZLuZDFBHGHAPpV5LdIYhZxrs=;
        b=lPeOPaOahiMNKX/u9ALh2MgLxWt/+Gd9B4FDJcNXlvZXSDsZ/HY3l98NN+r+j9ajSL
         Bzw4knyh1TELopleP1DBqBM8Z56XYGQscHGO5ojtEH/o1a+AyKkTJDI6wRUPTdYoZV1r
         zRt1W5wS7lNdRIAOINk1xcXzKYRE3NEzOu6G4C3ExLNKNJXWUerLvz/LgTn0SsosZ9CC
         3Swj0sQVcuJj8F3Is95w0iSv+HtQ45qNxSKq98Giydvd/Jy/52rH1hq1P5WWpshc9add
         20wqRvgwOC70aydt7Kks/fozu20ffztzVYTXdzj9RbMSp8X3k7u8kxG4TDBolh5uANXT
         kEcg==
X-Gm-Message-State: AOAM531G+HZ0SP3WFLhMloEc47DI3yojnVFUMLa69DMj59+dKpkApfP2
        VtN0X1iLUar+Teb4XmRQSUDGzA==
X-Google-Smtp-Source: ABdhPJy+q9F2YZlBGvmByGUC6iWaNWXvBE+GDse+Zy2s8RdQcOenlSRQL9b4btXOvyH61NP89sCczw==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr4567912wrg.131.1600947535186;
        Thu, 24 Sep 2020 04:38:55 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm3390133wmc.17.2020.09.24.04.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:38:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/9] gpio: mockup: remove unneeded return statement
Date:   Thu, 24 Sep 2020 13:38:39 +0200
Message-Id: <20200924113842.11670-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924113842.11670-1-brgl@bgdev.pl>
References: <20200924113842.11670-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's a return; at the end of a void function. This is not needed so
remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index c2b2f7d5ff34..de778b52f355 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -372,8 +372,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 		debugfs_create_file(name, 0200, chip->dbg_dir, priv,
 				    &gpio_mockup_debugfs_ops);
 	}
-
-	return;
 }
 
 static int gpio_mockup_name_lines(struct device *dev,
-- 
2.26.1

