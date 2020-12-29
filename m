Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC742E6FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgL2KXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL2KXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:23:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B19C061793
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:22:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y23so1946817wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytjMzAKu5LCYuZoAMrb15qxU8LOs/06Hc9aPPLdeIlY=;
        b=MeNS3AUELWcPhkYCq5aiIXT5mwCKxJdcrpGmq69dlrfXaq+CUqlS/6NayCdahXapL2
         Rm7cwF68904QhasPDNmkbfcrfjmjeK0DYHw+8PN2mGgryPL4Y5vd1Mr+hYPowcEtdqqi
         VPtWSJ9ufwAvXrAwtqAuV4DqzV8AZSoo7jMqZqKDyf9/gi0x8D8TspD2vFA914kz9aq0
         9pIj6ShcGc3uGLB1Qz7amn1UpCsY+tmZGMEJYOQ4vsTfjSR2s+kv22YIuBG2ZO+xTDtl
         ND9nIctxrvZqVFnf3+8Vm6nQvA/2Dg7DGw2xGqBsE9RU/PGSkWF2Nar5GIdvudr2oK3l
         1r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytjMzAKu5LCYuZoAMrb15qxU8LOs/06Hc9aPPLdeIlY=;
        b=WM9cMfDFsliFSK1iavjVP+3K/wyGa1C9qy6ChEsLzzrXncqkTO0IT40PwhNxMfJzs/
         ubG6TsMko9j8GGcAZjIp0AVVpLjM4wdQw3Cmfif3i0G/gxX+d9+Nn4yyRNcEmINgpl9C
         CC8RhOmUkt/jP42cWyGbePAJNjM90NlhgkrGSPe5nm6xvMkUFliMDmRSqUotw73Qy/fu
         TNIOsGG+YImR6cwCk0E3uWt9SKHvFrJE5YOXi1lz23MX8THDGGAivuwocKO8NBDrLhpl
         iQiaojIiiuRZAAkQXPsWuUyZV0CuT7XVo6CgGQCH93dONsQ6I9jnPnUF4w6B6/OG7YN1
         kmlQ==
X-Gm-Message-State: AOAM5328Y0142XFWo1ar0uxqyUInVet8pxNysVsH8+MUmpdwUu6sxpjk
        qJSYk7uqY/pEtlGicZ0dbWvYxw==
X-Google-Smtp-Source: ABdhPJxquHBZlVVUk2J7p+jOB90QNuHTVjx8vNed59k2Fm47RGmUV1EHxpDGQ5oc2ZUUgPrzqXJgmw==
X-Received: by 2002:a7b:c7c8:: with SMTP id z8mr2888311wmk.87.1609237359235;
        Tue, 29 Dec 2020 02:22:39 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id h5sm61174512wrp.56.2020.12.29.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 02:22:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 0/4] configfs: implement committable items and add sample code
Date:   Tue, 29 Dec 2020 11:22:31 +0100
Message-Id: <20201229102235.29550-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Committable items in configfs are well defined and documented but unfortunately
so far never implemented.

The use-case we have over at the GPIO subsystem is using configfs in
conjunction with sysfs to replace our current gpio-mockup testing module
with one that will be much more flexible and will allow complete coverage
of the GPIO uAPI.

The current gpio-mockup module is controlled using module parameters which
forces the user to reload it everytime they need to change the chip
configuration or layout and makes it difficult to extend its functionality.

Testing module based on configfs would allow fine-grained control over dummy
GPIO chips but since GPIO devices must be configured before they are
instantiated, we need committable items.

This implements them and adds code examples to configfs_sample module. The
first two patches are just cosmetic.

v1 -> v2:
- fix a 'set but not used' build warning reported by kernel test robot

v2 -> v3:
- use (1UL << bit) instead of BIT() in patch 2/4
- extend configfs_dump_one() to make it print the new flags
- clear the CONFIGFS_USET_DIR bit on the live group dirent

Rebased on top of v5.11-rc1.

Bartosz Golaszewski (4):
  configfs: increase the item name length
  configfs: use (1UL << bit) for internal flags
  configfs: implement committable items
  samples: configfs: add a committable group

 Documentation/filesystems/configfs.rst |   6 +-
 fs/configfs/configfs_internal.h        |  22 +--
 fs/configfs/dir.c                      | 240 ++++++++++++++++++++++++-
 fs/configfs/file.c                     |   8 +
 include/linux/configfs.h               |   3 +-
 samples/configfs/configfs_sample.c     | 150 ++++++++++++++++
 6 files changed, 409 insertions(+), 20 deletions(-)

-- 
2.29.1

