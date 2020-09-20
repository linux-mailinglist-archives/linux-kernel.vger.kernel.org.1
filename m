Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4F27173C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgITS4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgITS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:56:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C1C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:56:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so14715427ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ndUrGHBk92F1HUk+uxxSKtBUDi6Sd7JPiTr1APxGa3w=;
        b=06+rJhdHVsBikc7My0jVdVWkFb6ll1c13PfOBaXFzXenuTkKwBRq+WHycaid/goujl
         vamZD6pIPUPBN2IevX0wGsoK1NY5XskGD4kP73Z/SRFMTvfT1BGRZy1p8HihAd1W9R4l
         DSjRGcwIfknnzdONQaCLqDdXHdw1gKQu3qCry/JTCaqAcaWhya8UrzZ9Nac//COnDQZx
         4uFTrCbGoL4RDWBCqiha51wc3/BcXxU59qX6LQtoYmJwkqBKGmAV7gUrysMGPfTxhM8e
         +YWXlZhBuWN31arVAB1ix7QvtwiAMLjlIgSO9n/j/JedEUD8YUYp0qubfIPo6EPyI2Bb
         uDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ndUrGHBk92F1HUk+uxxSKtBUDi6Sd7JPiTr1APxGa3w=;
        b=SbrZODUFNSZmh0m3/MSz8pRrMo2OqsL4KJXBH9E6eAlzvQFj9XChGjnPZ0HiDunAPU
         +khdUDVSRlkypFhp7ADANGl1tvvDpY53mIwOeqsSy5kcLbe75CCIPSNMNOhH9skdgwej
         IX4QtDv9B2qL/gU4lShYGATJDjb/CmOS50+GoJ7NS0lf7EDU1WShaiL907MR1ivOINZT
         qohilU58AV/+cW26nX6vuyRFPS7Rru8teLvoJ9X8J5DLr5htDe82w4IoAOgESFf/fk2N
         2hR6aJ1+C8b4Nt5iKoEGxZdKOfrz+DQ7IOMkfXEnrDnl9dqDEt18cY6ocbyuvXr2DwRU
         ow0A==
X-Gm-Message-State: AOAM531ItMDOufyxLfqGw5iGnaG523gKCbpkvC8/Vvk48YNpipY8ZrRD
        Z1LLRRb3ZheGcCfmjN5syhPZvX1iiBpZoLTqlReJQw==
X-Google-Smtp-Source: ABdhPJw5iohlXyCeLttrxkgBFQjc3U6GHH9QAJRXr6ebWx59BVm+Rbod9dk6PHIoy/8UAn87A2YkjANX8lc0r9162HY=
X-Received: by 2002:a17:906:8289:: with SMTP id h9mr46107743ejx.45.1600628159425;
 Sun, 20 Sep 2020 11:55:59 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 20 Sep 2020 11:55:48 -0700
Message-ID: <CAPcyv4h3oKM-2hoG=FWHJwzVqjptnpQV9C+W6txfp_qcBhd7yQ@mail.gmail.com>
Subject: libnvdimm fixes 5.9-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>,
        Jan Kara <jack@suse.cz>, Adrian Huang12 <ahuang12@lenovo.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc6

...to receive a handful of fixes to address a string of mistakes in
the mechanism for device-mapper to determine if its component devices
are dax capable. You will notice that this branch was rebased this
morning and it has not appeared in -next. I decided to cut short the
soak time because the infinite-recursion regression is currently
crashing anyone attempting to test filesystem-dax in 5.9-rc5+. The
most recent rebase folded in a compile fix reported by the kbuild
robot for the uncommon CONFIG_DAX=m case. It should, "should",  be all
good now.

---

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc6

for you to fetch changes up to d4c5da5049ac27c6ef8f6f98548c3a1ade352d25:

  dax: Fix stack overflow when mounting fsdax pmem device (2020-09-20
08:57:36 -0700)

----------------------------------------------------------------
libnvdimm fixes for 5.9-rc6

- Fix an original bug in device-mapper table reference counting when
  interrogating dax capability in the component device. This bug was
  hidden by the following bug.

- Fix device-mapper to use the proper helper (dax_supported() instead of
  the leaf helper generic_fsdax_supported()) to determine dax operation
  of a stacked block device configuration. The original implementation
  is only valid for one level of dax-capable block device stacking. This
  bug was discovered while fixing the below regression.

- Fix an infinite recursion regression introduced by broken attempts to
  quiet the generic_fsdax_supported() path and make it bail out before
  logging "dax capability not found" errors.

----------------------------------------------------------------
Adrian Huang (1):
      dax: Fix stack overflow when mounting fsdax pmem device

Dan Williams (1):
      dm/dax: Fix table reference counts

Jan Kara (1):
      dm: Call proper helper to determine dax support

 drivers/dax/super.c   | 16 ++++++++++------
 drivers/md/dm-table.c | 10 +++++++---
 drivers/md/dm.c       |  5 +++--
 include/linux/dax.h   | 22 ++++++++++++++++++++--
 4 files changed, 40 insertions(+), 13 deletions(-)
