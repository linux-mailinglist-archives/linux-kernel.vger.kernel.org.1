Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA8277017
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgIXLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbgIXLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:38:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245D1C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so3196367wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38tFXZO/xNQY1Ryhqk0ixri0sl8E4vYZ3bH752VHOf4=;
        b=wfm3BVCIiKYb0LwpFdvrg59EW2nWHfTOqaUFAj0qo+jC5BNKds3G1c0EYc3wc4Jvo9
         qiTWqV8urdUlac6rowUlVB3KGHDQFXn9VyQZCFvIPQlNS1nRbDGDwtYIz2xWEtFdKWrB
         3eqLRs639j5AVmluOUpY8cPNScQWZB+Btfi5XBRpnWBC9xBjNwZ9NNEaafEGiL+YYXzW
         0TR2pR5H5hKhKk18KJVlRabUX83O2Muv34OPrV8zCUXFPIttKrYLHucMJ8FKmnjwaiLM
         UqoZiKh3t/nJM5pw4JF0MeTrAhAlVb9jDB8Y6fxJaRQqUzIoBpzJlaJ5dQMedFXna8c8
         Sy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38tFXZO/xNQY1Ryhqk0ixri0sl8E4vYZ3bH752VHOf4=;
        b=F31Ne+i3B9Z5GPqh/xw9D+tOpX3wf2rUv3bbnKsrtX0IJraExovGYoPRNU6aDrJ59A
         MftVdGn/Gikh5ApW3GRG2UXa9jo04fDqv5Uk5QWf6AQqRz7DL/Hgdid73vM4C7zWWhpC
         A+R6woOBXIcmV5uWYBwT0zwBSyr1k6wcC30SrXil2EG3/sejd02Awl+w4C0gXYY4YKTG
         99eZVM2g/3cdYxSxEjpG3eN4CchPPFgXaLcoUbSZj/Kywak4OGASr6ekrf/D2TTUK0JN
         JgXuDtN/D7aooeuiZKco93KXqS6XjZae6E03rMg1Sch9qZQZ+oVQY7oeI3o5uaPLyKYb
         ib6w==
X-Gm-Message-State: AOAM532l2/4BZ7WPq8vqdMGiPztGxnVEf1VmzjMjxa5O6/WUPeiFkns2
        XaIr0/2F22QgNbTFicgF5Qxfhg==
X-Google-Smtp-Source: ABdhPJxRA+J/+iFKjoXyeKGk7hmuTJJI3JDJ9FyrQ9bljbCM2utr8gxH3eRWMklqkS0jxniqYwv+0Q==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr4518078wma.32.1600947531822;
        Thu, 24 Sep 2020 04:38:51 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm3390133wmc.17.2020.09.24.04.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:38:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/9] gpio: mockup: drop unneeded includes
Date:   Thu, 24 Sep 2020 13:38:36 +0200
Message-Id: <20200924113842.11670-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924113842.11670-1-brgl@bgdev.pl>
References: <20200924113842.11670-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This module doesn't need gpio/consumer.h - it's a provider. It also
doesn't use any symbols from init.h so let's remove both includes.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 1652897fdf90..c5092773afd8 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -8,9 +8,7 @@
  */
 
 #include <linux/debugfs.h>
-#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
-- 
2.26.1

