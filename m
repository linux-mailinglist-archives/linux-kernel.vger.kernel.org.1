Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4862E28AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 20:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgLXTCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 14:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgLXTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 14:02:45 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C32C061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 11:02:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b9so4333887ejy.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DY0LSNRuJC1VTeyAItmzj6dM2VdxUyAti0XxIdcaZ5E=;
        b=2Hpe/9xrT4zb3yTL9CqVhR3qbkcAZlcrex/9QmVwHiYnU5FGpHDjYQnhqRsWGwR3wK
         yE/9ocCEgIRo4zeJU5frghG2LiiqWZVf1OLu0ZhT97ZogfqwAspbxcFCFIGHBxyAuIbk
         0uNyrtgCFRG1aXjLxvFdEl24Shoo4nWdJhCqhFhXMTuprTiWjBhODbwN+3oqVcI+ihyF
         cHvFWTRtPmbq7zS0udGbvQq1qSlP+A39wDwavDMYBDgvdKwS+vRxr+wVAH3/L1AJjh7T
         tBrxi88QLFgkC1gT1ebLzHq159LlR1hFYxw/jfwyHHBpH/TTxn9cQTpBI1e7rdjksXkc
         3dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DY0LSNRuJC1VTeyAItmzj6dM2VdxUyAti0XxIdcaZ5E=;
        b=oKpp80NqyEueve0MNDI1kp/63kXVAPFxYei65dmJcrEM3hwMzkknNNnilgWnTVjioa
         6/UukCvOVa6ZYpTWGKU1pyRJJDgWsoPh27UxFQffUwOcnJvL2SEjmMaFCRe2IgGKO1/p
         yYYJfx4PXs5mAThxWLBpEugIvq5qiVmJ39F7dzaTZHOQitIeBMcmyIkkIT5ZbmJgOQRE
         t4paFkq3IS+dGK/aKBf0+Non0/jlne1H454R/SctrJD08cMJahHOpD9k6VV2cZS8YEgt
         8OQFICFKOzKHzMUrUU7lUigxlt+Q5Gb7r3SMgaHDeAACDQjh3qREuo4OJg+WdnVNjM4y
         x09w==
X-Gm-Message-State: AOAM530vnrCip8WyucWM7nW2lyVGMJ9xr4Ub4G76pddwH6RvwopvPfKV
        sQ5oBj5Hcdoi8q48A/WdNQmbP9Ebve+qkYx8O6YS+g==
X-Google-Smtp-Source: ABdhPJy/1Krz5HO9oGVYRjEamxCdyjL7FIkyx0/iZh9QIuQOwePG7Q6ROPFrOC+psbIFJvxzYJJgnYMQUctla/j4jgc=
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr29855808ejb.523.1608836523729;
 Thu, 24 Dec 2020 11:02:03 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 24 Dec 2020 11:01:53 -0800
Message-ID: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.11
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Twas the day before Christmas and the only thing stirring in libnvdimm
/ device-dax land is a pile of miscellaneous fixups and cleanups. If
this is too late for -rc1 I'll pull out the fixes and resubmit after
the holidays. The bulk of it has appeared in -next save the last two
patches to device-dax that are passed my build and unit tests.

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.11

---

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.11

for you to fetch changes up to 127c3d2e7e8a79628160e56e54d2be099bdd47c6:

  Merge branch 'for-5.11/dax' into for-5.11/libnvdimm (2020-12-24
10:14:04 -0800)

----------------------------------------------------------------
libnvdimm for 5.11

- Fix a long standing block-window-namespace issue surfaced by the ndctl
  change to attempt to preserve the kernel device name over a
  'reconfigure'

- Fix a few error path memory leaks in nfit and device-dax

- Silence a smatch warning in the ioctl path

- Miscellaneous cleanups

----------------------------------------------------------------
Dan Williams (4):
      libnvdimm/namespace: Fix reaping of invalidated
block-window-namespace labels
      ACPI: NFIT: Fix input validation of bus-family
      device-dax: Fix range release
      Merge branch 'for-5.11/dax' into for-5.11/libnvdimm

Enrico Weigelt (1):
      libnvdimm: Cleanup include of badblocks.h

Wang Hai (1):
      device-dax/core: Fix memory leak when rmmod dax.ko

Zhang Qilong (1):
      libnvdimm/label: Return -ENXIO for no slot in __blk_label_update

Zhen Lei (3):
      ACPI/nfit: avoid accessing uninitialized memory in acpi_nfit_ctl()
      device-dax: delete a redundancy check in dev_dax_validate_align()
      device-dax: Avoid an unnecessary check in alloc_dev_dax_range()

Zheng Yongjun (1):
      device-dax/pmem: Convert comma to semicolon

 drivers/acpi/nfit/core.c | 15 ++++++----
 drivers/dax/bus.c        | 71 ++++++++++++++++++------------------------------
 drivers/dax/pmem/core.c  |  2 +-
 drivers/dax/super.c      |  1 +
 drivers/nvdimm/btt.h     |  3 +-
 drivers/nvdimm/claim.c   |  1 +
 drivers/nvdimm/core.c    |  1 -
 drivers/nvdimm/label.c   | 13 ++++++++-
 8 files changed, 54 insertions(+), 53 deletions(-)
