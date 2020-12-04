Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDE2CEB8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgLDKBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:01:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0238C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:00:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x6so775501wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKq6hvqHkl6EP6cELbb++9s2YOFBa7fo3DwvGqwYs/U=;
        b=UFHwSkvXvW+ifZ+Z/SuUC0cL5r82plTNr5K4NcN00pOyjP/uvWuQHv70f+3kekzJL5
         hRcR+bmjYSw8PMuxmF+G8Y4rsNa02x+7LlVaVaZYyXYL+oSeYjDZt1Izpj00GCMYdISg
         hFOTgF7iD6+G4o44g2rJ04ykOczHBZo8vyqHMBMkOSZVcPUuHc8HClsEQsedx/7+94yJ
         I8mxHijR9UfWwBMB3JlCNWmCK1so2Js1S5UgtlVVIed4OBzaTpiSQ3UNZRlDZa5KLHYQ
         dGEH6ILLNNAsPCoWD0M+Rcf5qQNzbvnIc6Wl7ChkvWehjhO4Ea8wfp+OuxsHB7hpWWqq
         bFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKq6hvqHkl6EP6cELbb++9s2YOFBa7fo3DwvGqwYs/U=;
        b=WBthIXBS6rMXr/t6gR0Vda64tpRn0I8eQBxVquIM5QIr6N8N8XMXScIOe0q0Supzbs
         xU4eDQ8gV9AA74PZNIAw6lSOI7+zXK/569pxmGHiQmzOCyYg+C3C6uoZttU5U7sA+vJq
         6HfN8W982XWnTPppBxUrjFO3MTITeoZls2zk8PnQJXM6jJN60ck1f+vjTkSQ6fe59cpZ
         p7zqRAZ+spJGrWQ+EaIDRndyRFRbmlGLoBnvUiVKtdTF8mb6o5Sny7hzFwHxTZItbohT
         x+4MJGe+OZGhnQI2EOGH1WwRSPE5WtpF/jjcyTChE+4op3YX0oLr/GFNkZxAawVNfVyy
         xoIQ==
X-Gm-Message-State: AOAM533Cl/BzxQ4oW7eWJ9OFUeS4lPSL/EMohkK+8bOUWQfR+FFLuanw
        PC+tM5aQZpRrHuGBl0kZ+NuqMA==
X-Google-Smtp-Source: ABdhPJwA6QvbkDcEznrgzvoh/E3Bk2WQyRVuS0J1kVnFMNyOqEm2gJM0ydYkNqpjVDa/z+myoKtUJw==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr3917307wrw.378.1607076050745;
        Fri, 04 Dec 2020 02:00:50 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id v4sm2907436wru.12.2020.12.04.02.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:00:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/4] configfs: implement committable items and add sample code
Date:   Fri,  4 Dec 2020 11:00:35 +0100
Message-Id: <20201204100039.19159-1-brgl@bgdev.pl>
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

