Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925E52B4171
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgKPKmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgKPKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:42:48 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277B2C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:42:47 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so23135467wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Bx0bwB8usWIGXQU6DeOYV9xHI+q7mXHS7hZ1vV9tck=;
        b=Sjo+8Err9noENP9ZXt891O85sVDqiqCyYo93SgK3VG6j6OwaDV9Zazkwf7yHNzSRJP
         l1Ry1Fi4Jboo6Ng2zV2I/WMRBXQ4dLiOBRs/utowNCNilwma6LT3WKPmbBUbYGMk49GC
         d1Neh+N+ksSLgoI/D0Jm+UtPim0A/gxOdRi8qoG+kOP4mrHnPbeqocB5M3uLR1icTcvD
         yiLrRZ8JS39+mKPCx8G8fy5ZY+XhW2VpM45HUWUUo2yk78tXdYonWS1GRJIHhEbmk+T7
         SKo1GCRF7UAlguKOgJpdq4WsMBDu0F9OUaztQ6pV5Qs7XGL/n4tfvtJAYfw3ZTb0v8qB
         7jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Bx0bwB8usWIGXQU6DeOYV9xHI+q7mXHS7hZ1vV9tck=;
        b=Ut1Uh1xBI+1hZ3bqWEejvU9CqbViZZHYVxp0DgM/3LcJbZs8J/BffRdzeRXT8yV13J
         k0Q/L/U05yFW5eL/10z1yOGPZv8FjVTG7O7y2Q3ezPWyhBEKVkN2C7F8X8MYriCcJsGj
         PMle438dhxzRKJNcZhL/+HHe/oeuE6PyW4594Z30+sZY056Ikf8rJneXUcY6NuHp8MkA
         npL9P7OoEBAjJm89mZIbgs/dIQFybfOdPcpa9jt6SCcvB8JzyLcMdzwz/tDSRW8vxEcd
         mwCthA7vIIRUDolX9I+21MXQdLCigUtRnppb6vrt7EzmhUQ2gjR/Tq9selWoyCfCRteB
         y/HQ==
X-Gm-Message-State: AOAM530XS1xNQ5JSJBG8m/Y4FMnlGorlpBp9O340YKUoiMyqlaYymp5m
        5tkgRCe9A/8r2YxpzjkOzMGdwA4l1PS5jA==
X-Google-Smtp-Source: ABdhPJzN3VlxVGSntXS+YyLoLvOZXfSX/aWdI21WZGt10d7rsuaDIcqV9aBmHWK/N7Uw47a/raxJzw==
X-Received: by 2002:a1c:97:: with SMTP id 145mr14413406wma.72.1605523365855;
        Mon, 16 Nov 2020 02:42:45 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id v16sm20583283wml.33.2020.11.16.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:42:45 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/7] gpio: exar: refactor the driver
Date:   Mon, 16 Nov 2020 11:42:35 +0100
Message-Id: <20201116104242.19907-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I just wanted to convert the driver to using simpler IDA API but ended up
quickly converting it to using regmap. Unfortunately I don't have the HW
to test it so marking the patches that introduce functional change as RFT
and Cc'ing the original author.

v1 -> v2:
- add new regmap helper: regmap_assign_bits()
- fix lvl vs sel register access
- set value in direction_output callback

v2 -> v3:
- drop the regmap helper from series

v3 -> v4:
- renamed the regmap variable to 'regmap' as leaving the old name caused me
  to miss an assignment leading to a crash (culprit spotted by Andy Shevchenko)

v4 -> v5:
- set the reg_bits to 11 in regmap config
- collect review tags from Andy

Bartosz Golaszewski (7):
  gpio: exar: add a newline after the copyright notice
  gpio: exar: include idr.h
  gpio: exar: switch to a simpler IDA interface
  gpio: exar: use a helper variable for &pdev->dev
  gpio: exar: unduplicate address and offset computation
  gpio: exar: switch to using regmap
  gpio: exar: use devm action for freeing the IDA and drop remove()

 drivers/gpio/Kconfig     |   1 +
 drivers/gpio/gpio-exar.c | 160 ++++++++++++++++++++-------------------
 2 files changed, 82 insertions(+), 79 deletions(-)

-- 
2.29.1

