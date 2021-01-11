Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817EB2F0E37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbhAKIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbhAKIdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:33:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:32:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g20so23572749ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ajHMde4950cYeMJhNre75T8f60RmpxvchPzXJvdwbA=;
        b=f1w/0TOLj5ch3hL8dwmn/nHz8mlb69YwpFVsR/7fOujw3w+ncRZL9yFlcbEdcBzCpT
         RykWgBgVZLafIQuHuCfNh7mYWNbujcOrATHqkOH5yVscrOiz72WjJ8T0Ob90LRthEMcj
         NuTGetiuTK+apm9cTq5rYSCTUx1sqcw3LdfRjFtWr07Jya80ypNQDWtNv26/d2PHPuRD
         AmX1kp6CloUe7ucHej+6sPTV5SmAMftGvc+U/8J9tJADRM5vVsoHREwTWsfeCLWAgpkz
         drPNTji7vX/9HlrsM6449PF9Q7qfPd1VRykSIBkNxvKM+gRyQN6eWj4Vmuz8zhg5oh1y
         OgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ajHMde4950cYeMJhNre75T8f60RmpxvchPzXJvdwbA=;
        b=EZcrri34CaRqXfZubJqtNUZJvIV/D2tuCM5/j4CPNH1SOplbixOmWhhB/VHNJE2twP
         dpGND5X0xtCdyVW2djOkpSr6MrTlqjuzvZaiEU7Tmlh2Irs9loF3XSU2lth1iaE858m7
         vCR/c4ADzefWRPgdLAw0QQUcpnfsKbpU0rjva2f0o4Gk1tsgTRyWB6VO89w7yb6rIlPn
         gANext7ratKnfpoLJXnj2EzlhHRixQcXZueMp6MVfpAXUopfRImeTy4tIGUxpjlUc+6L
         B7io2Y9nPaOvToAExtgPDoqNn636z1Rj9R/aq6UH5IChcE475wjiAc5VhCJzsZO3H6/t
         zrYA==
X-Gm-Message-State: AOAM530Ik5o8cnv1DYWNnSJbIihfXvS+jmgKYVqyy4+VfyajM/spA5f2
        Q2aGE3kibG+M2pB2gZAZw8hsPEqESBEtA//DEClr7rYmemc=
X-Google-Smtp-Source: ABdhPJxOVN4dQ2ezCv18/mFrynxNnqIaPdz8ZaaubWLz5gC2Mp4PP7oDkjvLFn2O6j1Uk+3Bh0nB7uYKlJ63oZG9lT8=
X-Received: by 2002:a17:906:3513:: with SMTP id r19mr9828913eja.445.1610353945154;
 Mon, 11 Jan 2021 00:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20201229102235.29550-1-brgl@bgdev.pl>
In-Reply-To: <20201229102235.29550-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Jan 2021 09:32:14 +0100
Message-ID: <CAMRc=MdpYinY1zobG7e9Ds7KdX5-S5hVzHv8ZsShuPqK__QcAQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/4] configfs: implement committable items and
 add sample code
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:22 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Committable items in configfs are well defined and documented but unfortunately
> so far never implemented.
>
> The use-case we have over at the GPIO subsystem is using configfs in
> conjunction with sysfs to replace our current gpio-mockup testing module
> with one that will be much more flexible and will allow complete coverage
> of the GPIO uAPI.
>
> The current gpio-mockup module is controlled using module parameters which
> forces the user to reload it everytime they need to change the chip
> configuration or layout and makes it difficult to extend its functionality.
>
> Testing module based on configfs would allow fine-grained control over dummy
> GPIO chips but since GPIO devices must be configured before they are
> instantiated, we need committable items.
>
> This implements them and adds code examples to configfs_sample module. The
> first two patches are just cosmetic.
>
> v1 -> v2:
> - fix a 'set but not used' build warning reported by kernel test robot
>
> v2 -> v3:
> - use (1UL << bit) instead of BIT() in patch 2/4
> - extend configfs_dump_one() to make it print the new flags
> - clear the CONFIGFS_USET_DIR bit on the live group dirent
>
> Rebased on top of v5.11-rc1.
>
> Bartosz Golaszewski (4):
>   configfs: increase the item name length
>   configfs: use (1UL << bit) for internal flags
>   configfs: implement committable items
>   samples: configfs: add a committable group
>
>  Documentation/filesystems/configfs.rst |   6 +-
>  fs/configfs/configfs_internal.h        |  22 +--
>  fs/configfs/dir.c                      | 240 ++++++++++++++++++++++++-
>  fs/configfs/file.c                     |   8 +
>  include/linux/configfs.h               |   3 +-
>  samples/configfs/configfs_sample.c     | 150 ++++++++++++++++
>  6 files changed, 409 insertions(+), 20 deletions(-)
>
> --
> 2.29.1
>

Joel, Christoph,

This series in its current form has been on the list for many weeks.
Are there any objections from your side against merging it for v5.12?

Best regards,
Bartosz Golaszewski
