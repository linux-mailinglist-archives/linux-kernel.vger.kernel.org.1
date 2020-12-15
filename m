Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3D2DB515
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgLOU3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgLOUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:24:24 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57653C0617B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:15:38 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id hk16so240231pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sKLqDNMUz4VYLd0zfng7nglh1BuTwEhYbBm9YL3/2so=;
        b=a03DNyCkzpbW2CV134IeHXd1CSJ3OqdQ87GzXIr/1DDkn0rTKIxc+JLhFsSPQqekiQ
         7dqL97XijFCfDKV/SyPRfYvO3tAXrqEMcpthxundUmxQMAcfsSWcec1HOVRaEYXndHcN
         FalpxMgykvo53GHs0kWNdpA7L1Y2Vz6ufxu5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sKLqDNMUz4VYLd0zfng7nglh1BuTwEhYbBm9YL3/2so=;
        b=DMUNm0Do8nKYtDYuwvGX17urpQs3/KhB1lP9Pul7ZY08nMceLT18baBaVGd7rINRWf
         Ij14JX3ZzVlX+IuiBOEOXnM7G6TeqzrbMKWdgC8SNPtg4Y1EOw6glXy/lzF/oP2JaWwb
         7Ot/bKMxoVMd0TkkPlh1ygJfmfUb5kuRauEPxcrYWHy7SdjOVmFLuHP8MI1JChL6ZODp
         FH4yHc51IrHlBmgh1STLFxfjlwwcVA3GhxM9a3MaBPVJofjHtrP7kaKVRNSWcat8Kh4+
         YQWYTTcUFn+lnk48hBWPZNJLN+x1uEPwFHr38scRjND5vCntaIHS5FekJxBWDECkisMK
         lB8w==
X-Gm-Message-State: AOAM53259nOOHdEnlLGnqI+ZMficdGz6sz0d+UkCewDX7ODvE9OULd/o
        F4PHuKXJf1fwruRiNIWn3oiodA==
X-Google-Smtp-Source: ABdhPJxv41JZVfwu2IMWDtnvRNIvTNDXlvJcoJ2V7EujYBTiC9wAPG5sRhpJmJHCfAhsIi1Qqny2kA==
X-Received: by 2002:a17:90a:eacf:: with SMTP id ev15mr536439pjb.174.1608063337938;
        Tue, 15 Dec 2020 12:15:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c199sm26688287pfb.108.2020.12.15.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:15:37 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:15:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [GIT PULL] gcc-plugins updates for v5.11-rc1
Message-ID: <202012151215.E7AA7D6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugins updates for v5.11-rc1.

Thanks!

-Kees

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.11-rc1

for you to fetch changes up to 53a57e60de74a3531ae769b3241cc5169e1431ac:

  MAINTAINERS: Drop inactive gcc-plugins maintainer (2020-12-04 14:11:05 -0800)

----------------------------------------------------------------
gcc-plugins updates for v5.11-rc1

- Clean up gcc plugin builds now that GCC must be 4.9+ (Masahiro Yamada)
- Update MAINTAINERS (Kees Cook)

----------------------------------------------------------------
Kees Cook (1):
      MAINTAINERS: Drop inactive gcc-plugins maintainer

Masahiro Yamada (2):
      gcc-plugins: remove code for GCC versions older than 4.9
      gcc-plugins: simplify GCC plugin-dev capability test

 MAINTAINERS                                        |   1 -
 scripts/gcc-plugin.sh                              |  19 -
 scripts/gcc-plugins/Kconfig                        |   2 +-
 scripts/gcc-plugins/gcc-common.h                   | 407 ---------------------
 scripts/gcc-plugins/gcc-generate-gimple-pass.h     |  12 -
 scripts/gcc-plugins/gcc-generate-ipa-pass.h        |  23 --
 scripts/gcc-plugins/gcc-generate-rtl-pass.h        |  17 -
 scripts/gcc-plugins/gcc-generate-simple_ipa-pass.h |  17 -
 scripts/gcc-plugins/latent_entropy_plugin.c        |  12 -
 scripts/gcc-plugins/randomize_layout_plugin.c      |   4 -
 scripts/gcc-plugins/sancov_plugin.c                |   6 -
 scripts/gcc-plugins/stackleak_plugin.c             |   4 +-
 scripts/gcc-plugins/structleak_plugin.c            |   4 -
 13 files changed, 2 insertions(+), 526 deletions(-)
 delete mode 100755 scripts/gcc-plugin.sh

-- 
Kees Cook
