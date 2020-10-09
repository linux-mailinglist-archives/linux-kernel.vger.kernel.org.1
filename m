Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0143328851B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgJIIVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbgJIIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:21:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7AC0613D4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 01:21:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so9827089lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=F1p8lcOc9v2xuW4LU+iaVDSBE7WFr+KfWRzRc7BHXDY=;
        b=rpDXXyrrfosFnOf9GTHHzweLt53ZXhelBHex63dDvXuyFC6LtW66pMvLqsySf0OiyO
         E5cy/Lj+6gmXH9WO977BftnM6y7dhe1vKqjMzA5y4pBVhTIHlPFDO13FqPitr0azQLIH
         Lt/Q0kh79IFMwPkL5mzpPO8WeUFNwQtlKP7gNYX3MVI8lgl5tOWDxYP6SMzKQW/HPQuH
         venyEaLYu8uNd//s38EEhyEmgpEFWcjnuHSaDHtRIFNbdzwzEbPHTIHYAv9ZF3bk7mJ7
         pqXqiwfM6kJF1eCZygDVmIFThuGTzXzpP8UDF91gaAPeELK92fKxKcUZab/+qLF88HhC
         FzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F1p8lcOc9v2xuW4LU+iaVDSBE7WFr+KfWRzRc7BHXDY=;
        b=Ta4VN4mCVURUzZRfn0tETRQKeMxtcwAcvaEliq70/2YYO9fAaPs9+Wn4aedqBw3BW4
         DRRC/9OZg1mraZVzgmdG7NK9MEB284V1HJMQiMDDWJzoQoJe05CZI5xl8q60GAPFgt/O
         /YM6V43lJ6woqpSiMoPN5/P+ysqRJOz1Jeor1ASh5Mt33JgNoNkjrH7prAToaskwe9+e
         lJMyBBh6F1xQa/vDdj7SVVCXpvX4qoRWbeHQJZLWs8Nn+FseZrZp/XIwTBu0kOKX7SVK
         SpEMni93sLxUeCSjKvEiHDYnMvZSVj3LO+wGXj6f2Uhz0FZ9AVPGF/GLboMV7OZ43Psx
         XN5g==
X-Gm-Message-State: AOAM532XsuBSqXOCNX0R29r3vzwAnX5AQaP0h4BuwavPqv/dvckIAy3E
        AAYfkZCBJil7ElqRw77tKs6CUT4SjQzzVVxsuFsWd/2wg19IJZCi
X-Google-Smtp-Source: ABdhPJyumXXapH+JIFNDv3e4VC/Q+k+gafCJclzodbwPI9k7n4hYPERxQB8VpDRb3NOqvCj1uvycDHT2MOa8bwTF5gY=
X-Received: by 2002:a19:824f:: with SMTP id e76mr2494555lfd.572.1602231659591;
 Fri, 09 Oct 2020 01:20:59 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Oct 2020 10:20:48 +0200
Message-ID: <CACRpkdYLfx9qRb1hHi=u+hLxzYE=0aku+_8-KwYocHmPowMZbQ@mail.gmail.com>
Subject: [GIT PULL] late GPIO fixes for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some two late GPIO fixes: one IRQ issue and one compilation
issue for UML.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.9-3

for you to fetch changes up to 8b81edd80baf12d64420daff1759380aa9a14998:

  gpio: pca953x: Survive spurious interrupts (2020-10-07 11:47:41 +0200)

----------------------------------------------------------------
Some late fixes for the v5.9 kernel:

- Fix a compilation issue with User Mode Linux.

- Handle spurious interrupts properly in the PCA953x driver.

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: Disable compat ->read() code in UML case

Marc Zyngier (1):
      gpio: pca953x: Survive spurious interrupts

 drivers/gpio/gpio-pca953x.c | 17 +++++++++++++++--
 drivers/gpio/gpiolib-cdev.c |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)
