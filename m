Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92227C20A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgI2KKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2KKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:10:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C02C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:10:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k15so4674449wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wX07pSeUuLqA9wjMOYNBhUqlyD5UBvsVzAhl80AZh20=;
        b=SUUgbwPmv1HPLhX+VtkUbKJMt1hEhieePFb0t+WIuQX7veEzo16PF6UR+jveLb0dLU
         eVdkuFnstU26B1WMYRHzo8ci+a7NrAIskZLJqs29X1pf2JvVysAHdqH3KFGaeWer+WzB
         wBBEAZf6QkMgpRpw9d0A06fftXk6ZjTEqp6caDlatXmNIxVGDOylfGoDsf/2V83MmOun
         bUnzOcmr925AzmdLg+Oad/3dPqM+9ORedFQG3ekJoUcHwXFoF+6+KP9L8QLzR1muYk/9
         2Kk1Z0xkxyX6UYKVDqZjkaT+d1dE0TG8UhUz94q6MypiAH4ioOLOlp4dWDC7WjOtjQ4I
         E9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wX07pSeUuLqA9wjMOYNBhUqlyD5UBvsVzAhl80AZh20=;
        b=OlnwUivTZBwzivPndX24wKR30LnzhNgy6dbU1Wd5VmYJPt9LI6GrCj22zifLlLqzrx
         ieLPQBHhiEPHIkBkZpCvoImB2Yt9IvxXkpGSDKLSl/g4Bh6s2jSsUXovCYz71dnbJMZz
         ezQM8hJ6BUW919AkSaZTkFC0AfWmjQxoARhgCfQHo26Q32wNYu8+dt6pEBK3BThkpDj6
         d3RJFsk2ud4kDu78Muvat4DjY8YbQUvYMWHopFlJxyvPZa9mXtH/lDj49Myx9FP6DB5d
         rMpYqYe3f2Pb7IJSLEqFF8EcAwtZrdJO85fIKq6jGOKGT7YeClCR0AUz4pogEOtDQK0H
         3ELA==
X-Gm-Message-State: AOAM530XWbHot+Fm1tToPKbVwhbDGQ/VXbW07inzwKd9kOkMMEUZjXFd
        blHL6IldvPhjHPpT/FgtMJMEOQ==
X-Google-Smtp-Source: ABdhPJyu5A7kb1zd9o0XKRkIireLWaGzK0J84c5nNxmjTMndi7inQttwI+MoT+xB9vvauWg1QPJw5g==
X-Received: by 2002:a5d:44cc:: with SMTP id z12mr3468027wrr.189.1601374214037;
        Tue, 29 Sep 2020 03:10:14 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-68-189.w109-210.abo.wanadoo.fr. [109.210.51.189])
        by smtp.gmail.com with ESMTPSA id x19sm3380680wmj.48.2020.09.29.03.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 03:10:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 00/10] gpio: mockup: refactoring + documentation
Date:   Tue, 29 Sep 2020 12:09:54 +0200
Message-Id: <20200929101004.20288-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These patches were part of the bigger overhaul of gpio-mockup but since
the initial idea was dropped in favor of using configfs + sysfs in the
future I thought I'd resent just the refactoring of the existing code
+ documentation patches. I think it's good to apply them since we don't
really know when the new interface will be ready (configfs needs a new
functionality - commitable items - to support mockup chip instantiation).

v1 -> v2:
- check for NULL pointer in kfree_strarray() to avoid having to always pass
  a zeroed string count when the array pointer is NULL
- collect review tags from Andy

v2 -> v3:
- add a patch increasing the number of supported device properties
- rename the arguments in kfree_strarray()

Bartosz Golaszewski (10):
  lib: string_helpers: provide kfree_strarray()
  Documentation: gpio: add documentation for gpio-mockup
  gpio: mockup: drop unneeded includes
  gpio: mockup: use KBUILD_MODNAME
  gpio: mockup: use pr_fmt()
  gpio: mockup: remove unneeded return statement
  gpio: mockup: increase the number of supported device properties
  gpio: mockup: pass the chip label as device property
  gpio: mockup: use the generic 'gpio-line-names' property
  gpio: mockup: refactor the module init function

 .../admin-guide/gpio/gpio-mockup.rst          |  50 ++++++
 drivers/gpio/gpio-mockup.c                    | 158 +++++++++---------
 include/linux/string_helpers.h                |   2 +
 lib/string_helpers.c                          |  24 +++
 4 files changed, 156 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-mockup.rst

-- 
2.26.1

