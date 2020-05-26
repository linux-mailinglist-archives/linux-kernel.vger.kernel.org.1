Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991551AD852
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgDQIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729573AbgDQIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:12:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7CC061A10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 01:12:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c195so4326978wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tD0KI9x0MRAYK6FT5rpBjUdEdxT88eUPE1gMj/Yhtoo=;
        b=l/jnhEaweO99gK70zLQdCr74KQTZaB3i98vdStXNfm9NdMbYWQFC875/rIGixCPrOX
         wzvkOZfDqcxNdipTgBswIp9LFHHeWDww/b2tS1m7wGgU1eaQW+Pmnkktf1AI896200i8
         A02JGim7CVLZJV0TfU8sJl9go9peG/UaC6Efz2/A3qah+nC2/DxICnIFpzEpSygzWqjZ
         +Pp5B4gRzKVIlqPMkFQB7//Hn0HshEzl+WBc/sQK/L5TFxk4XU9ZZYgkU8+s3xCvabUm
         WDeoO5kllH8mMhxq0SsgT1RYhvZeFK/JSnS12azAR97fo2vd40TGJvMVh2Qz0xpGtNR2
         4S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tD0KI9x0MRAYK6FT5rpBjUdEdxT88eUPE1gMj/Yhtoo=;
        b=CCHqZRBaYtOpCgHhXgrWH9ANwew3PUvJvFObzEk2qDazqMmyT345qwxUUllXFYfQhH
         FpSXonCAjBEHv67Pb3DNG471UVmpufZEAJSsW915phlEECfzCXMD7I1HJYKJkBKJudzv
         bPQ0Mo0ngCH6G92R4KgFohKaP7/DaOudzLOBm+WrqBebypI2UD0LjOn0ahBwGG5NyEZ1
         4IWoWJNdGsph6yN04tUzYv0IsC9DkEx3HC+J4Haf1Aovn40i0aQTidZFjhQqHUOhMoFa
         tH8jDx7IhDQClvkM4R5a4zW7BYzu3jv9/HJ8kwgW/yEJ4ukepqgk2Vo2yrdKsszDQlEv
         BAwA==
X-Gm-Message-State: AGi0PuZcXTcyZN6Z9y33o7E9roFmOtCTBThYRmwcz8ZiJLiubXFgwL8p
        pOWE4Zc1PFPoWkZlWLtRWnwebw==
X-Google-Smtp-Source: APiQypIObru3l8PT0N4cFDeQ6cjO/zoZYmtd4rlp00jMya26O057clHwMsCJFiJFVFQ/y81haMlPKQ==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr2114896wme.20.1587111136828;
        Fri, 17 Apr 2020 01:12:16 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id o129sm1078078wme.16.2020.04.17.01.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:12:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/2] irq/irq_sim: try to improve the API
Date:   Fri, 17 Apr 2020 10:05:47 +0200
Message-Id: <20200417080549.23751-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The interrupt simulator API exposes a lot of custom data structures and
functions and doesn't reuse the interfaces already exposed by the irq
subsystem. This series tries to address it.

First, we make irq_domain_reset_irq_data() available to non-V2 domain API
users - that'll be used in the subsequent patch. Next we overhaul the
public interfaces - we hide all specific data structures and instead
rely on the irq_domain struct and virtual interrupt numberspace.

The end effect is that we limit the interrupt simulator API to three
functions (plus one device managed variant) and zero new structures.

v1: https://lkml.org/lkml/2019/8/12/558

v1 -> v2:
- instead of just making the new data structures opaque for users, remove
  them entirely in favor of irq_domain
- call irq_set_handler() & irq_domain_reset_irq_data() when unmapping
  the simulated interrupt
- fix a memory leak in error path
- make it possible to use irq_find_matching_fwnode() with the simulator
  domain
- correctly use irq_create_mapping() and irq_find_mapping(): only use the
  former at init-time and the latter at interrupt-time

v2 -> v3:
- drop the controverial changes to irq_domain code and only leave the
  changes to irq_sim and its users with the plan to revisit the former
  at a later time

Bartosz Golaszewski (2):
  irq: make irq_domain_reset_irq_data() available even for non-V2 users
  irq/irq_sim: simplify the API

 drivers/gpio/gpio-mockup.c          |  47 ++++--
 drivers/iio/dummy/iio_dummy_evgen.c |  32 ++--
 include/linux/irq_sim.h             |  34 ++---
 include/linux/irqdomain.h           |   4 +-
 kernel/irq/Kconfig                  |   1 +
 kernel/irq/irq_sim.c                | 225 +++++++++++++++++-----------
 kernel/irq/irqdomain.c              |  24 +--
 7 files changed, 216 insertions(+), 151 deletions(-)

-- 
2.25.0

