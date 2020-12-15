Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE33D2DB4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgLOUUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLOUUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:20:32 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C19EC061257
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:19:52 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so11643409plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fOdDDR9wzzDqp5Uo0kLupRw2fi7nNuys7Q0YoKhDgNU=;
        b=mALWvE1c7elqMy6QvAPNVlcB92JxN5YoHlIpY5mdJdtsxE6Vk1lu0O5lQQoDndfpHV
         C+ztrzX26LyiywLY3CjmQEakT5yC/k5JyXnASa8io27pjRf8ada55mWrgQVHmSffZjlv
         wmpNUVrFM6zC+Atz2y+HDWiIHqPWXr7enIiAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fOdDDR9wzzDqp5Uo0kLupRw2fi7nNuys7Q0YoKhDgNU=;
        b=Bi4oYIqc5dVe8CbHSVC/SPDUO2wW4L2Tt1jOzqQyBpAGgULXRCalAftPSQ35ZSZIgO
         /AZtTf0ubNiwLgvSg7AuHwLjrWQVoy1OV5xMsarH6NKPVm5bGeJeBVedACfQ9kmMtBTq
         r3iCDFH9dC18gFd4JS/zmsWA0A1sxREtAoQo0g9Z0gfLs6tknskbTRloMx/yF02zagJZ
         9krRjQFfQlCfCBrHqltjEM97pvHY92I4S/h3zAQgRlT5vpCt8+fG0+wNHeXbEwMSqdnY
         K7mP7+IpPh/dabWSHS8U1HNYi9essJlTcD3f1h9B+/8CezsNXUMIykGCwU3t8dhrBaxt
         epSw==
X-Gm-Message-State: AOAM533WOFgyZLy8gCVtUUwPiCmWyPfBVMcZlW5+CIcUbtRM6i7t8Tn6
        +5yMAYG9k54ZDqE67NsSQTOupQ==
X-Google-Smtp-Source: ABdhPJwaRA0FFRlawRbz5DtEOLWO9wqdCR5Tz0VgkcJgaN7rnj7SzzxD0RIsqY8iltF+1sqYfO60XA==
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr521766pjt.228.1608063591883;
        Tue, 15 Dec 2020 12:19:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v6sm26579863pgk.2.2020.12.15.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:19:51 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:19:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Vasile-Laurentiu Stanimir 
        <vasile-laurentiu.stanimir@windriver.com>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>
Subject: [GIT PULL] pstore updates for v5.11-rc1
Message-ID: <202012151219.126DB90@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v5.11-rc1.

Thanks!

-Kees

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.11-rc1

for you to fetch changes up to 26fecbf7602dd69b649914e61526bd67c557fece:

  pstore: Move kmsg_bytes default into Kconfig (2020-12-01 12:09:17 -0800)

----------------------------------------------------------------
pstore updates for v5.11-rc1

- Clean up unused but exposed API (Christoph Hellwig)
- Provide KCONFIG for default size of kmsg buffer (Vasile-Laurentiu Stanimir)

----------------------------------------------------------------
Christoph Hellwig (3):
      pstore/zone: cap the maximum device size
      pstore/blk: update the command line example
      pstore/blk: remove {un,}register_pstore_blk

Vasile-Laurentiu Stanimir (1):
      pstore: Move kmsg_bytes default into Kconfig

 Documentation/admin-guide/pstore-blk.rst |  7 +--
 fs/pstore/Kconfig                        |  8 +++
 fs/pstore/blk.c                          | 83 ++++----------------------------
 fs/pstore/inode.c                        |  2 +-
 fs/pstore/internal.h                     |  1 -
 fs/pstore/platform.c                     |  2 +-
 fs/pstore/zone.c                         |  4 ++
 include/linux/pstore_blk.h               | 42 ----------------
 8 files changed, 26 insertions(+), 123 deletions(-)

-- 
Kees Cook
