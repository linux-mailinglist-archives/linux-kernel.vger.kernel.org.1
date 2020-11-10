Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3169C2AD650
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgKJMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbgKJMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:33:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D89C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:33:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d12so10972866wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adL3l4Z6O1Wj+nFN/YxWHj+awQmL8BIw4xUsIWOJIFU=;
        b=faspQ8BzRWWLawQEXCxcNlRzXA70LzQ/kyT7u9kukuF/Vpiwo8YKS2m8B0ImHXd7V5
         3mbcXAk5tx5LRwOv55zrqFJs2elynUqtHwLdzkYhUhdldyGbn/+uCHUOdYgsueHgTUDL
         Uj4oP3yVWFXDe6rSizQKSrbRhKSH4d2+lVrMPlekPu3FkeV6v1ttK2KPaXv09c5o/qeT
         eMxYBFeCj/XrF2AGbHShK3MHDIBMARGYESjMKvYJIDA5ayOD8RZCe+pY2p1d3c6qEM/Z
         /thwSPnBl/GjtI4zT+HOq3q+127EJr7BNM8snvIn0WBppyQ4HAbolnk+M7l3gTXsBwQi
         0iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adL3l4Z6O1Wj+nFN/YxWHj+awQmL8BIw4xUsIWOJIFU=;
        b=iUlBuCo4hmiqW/+y4As3BxhoFohACjmef2Y18u1kcZ1/iYVKNQ/+ok8qLcuJ6W/tnx
         zF1A0NE4nJPWFacSoAH1l44/XHDVSMpS4pcZKQCZRceVVFI1JuMfubJLAtb3YsbHJGEG
         sq9C8ljQiUIarTroDYEixaBznrfgOjIX3m7VZJy9DD72T4ZCR5C5Sh5lQNV//RMbdsQc
         s91PR5qYFzWvukzWt6jsNjP5T0IOZKr2SFM8YFx7kgBZfkS0Sk+16Evz3Kj2HgduilfR
         pD7U/0oQeHHRw+gEhVygvv/qODm3phiNoKDaUFHkLmcgKJ+8Nj9eP/kjoPKNff0zhZLe
         xU6g==
X-Gm-Message-State: AOAM530f0nPruip0xtpQZXLqvae2XIeNLDeRIr6ZEkFxgnthjuvE5aAy
        mc06nyWLK6HkvQcndzVGYkvUhw==
X-Google-Smtp-Source: ABdhPJxZPply2n7CRqXgJ77F5nNnXHOb82wOg3adEzxhKYvTXvrxBXsFjrE/106amH39DfhVLRZQfA==
X-Received: by 2002:adf:e446:: with SMTP id t6mr22566685wrm.46.1605011627448;
        Tue, 10 Nov 2020 04:33:47 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id f8sm16706837wrt.88.2020.11.10.04.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 04:33:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/7] gpio: exar: refactor the driver
Date:   Tue, 10 Nov 2020 13:33:35 +0100
Message-Id: <20201110123342.3166-1-brgl@bgdev.pl>
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

Note: I didn't use the fancy method of offset calculation Andy and David
suggested because this series broke the driver according to Jan - let's
get it right before we modify it any more. I found a couple problems that
could maybe cause the crash. Jan: could you give it another spin?

Bartosz Golaszewski (7):
  gpio: exar: add a newline after the copyright notice
  gpio: exar: include idr.h
  gpio: exar: switch to a simpler IDA interface
  gpio: exar: use a helper variable for &pdev->dev
  gpio: exar: unduplicate address and offset computation
  gpio: exar: switch to using regmap
  gpio: exar: use devm action for freeing the IDA and drop remove()

 drivers/gpio/Kconfig     |   1 +
 drivers/gpio/gpio-exar.c | 154 +++++++++++++++++++--------------------
 2 files changed, 77 insertions(+), 78 deletions(-)

-- 
2.29.1

