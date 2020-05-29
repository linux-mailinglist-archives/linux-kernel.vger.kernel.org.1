Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274681E7731
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE2HlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 03:41:14 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33507 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2HlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:13 -0400
Received: by mail-pj1-f65.google.com with SMTP id z15so2902995pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxdWIOmMtZof5Zd2ToCNUZnFH4PwEYqbI1WQa7Nahtk=;
        b=IGAL/WpZ2pNsZnmhQAtKgzLh89KB0O+lVMoPCs9FNJ/3O35Jdx5X0fhev0F2sD/GAc
         aXR+N7prajry6lbqOQ024R9Ac5J1n3bjs1VYJUWpyxhqEw0Pdb14CqpOUb6LHHf/PuMc
         yMbqbUpAgUXQX+GDQ3puDn2976PHiaoqrF8RmymThTjfP96v8JqR0FykbTKTY1dLyo0x
         tpHsrv02Q2WYXUMV6l/LoaGz6U+QCFOTiMLDSQpRwsc5a8/l98q2RG9H1nyErLo2s9Rl
         vu8wUgZkwthgr1Q2lyO4tXwXDPp1JfUBiCQwchtFJNl7V1N+AXAVAT6QZmBlPRO2LuI0
         fqGw==
X-Gm-Message-State: AOAM530541H6lFgB1kBU00uQZGleIahgQD8GxmZmeQCEkS61w6FPiphP
        M03nHkFap+xaR4cQhklArXI=
X-Google-Smtp-Source: ABdhPJx/Y2UkOfRCeSrfHd17IdoL/kq5WzGQ2U9aMMVJNt5xrKYQiwN4acpehMl/gpWlkneskvxS6A==
X-Received: by 2002:a17:90b:1002:: with SMTP id gm2mr8188726pjb.197.1590738072133;
        Fri, 29 May 2020 00:41:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s1sm6842049pjp.27.2020.05.29.00.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E3ADF40605; Fri, 29 May 2020 07:41:09 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 00/13] sysctl: spring cleaning
Date:   Fri, 29 May 2020 07:40:55 +0000
Message-Id: <20200529074108.16928-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Me and Xiaoming are working on some kernel/sysctl.c spring cleaning.
During a recent linux-next merge conflict it became clear that
the kitchen sink on kernel/sysctl.c creates too many conflicts,
and so we need to do away with stuffing everyone's knobs on this
one file.

This is part of that work. This is not expected to get merged yet, but
since our delta is pretty considerable at this point, we need to piece
meal this and collect reviews for what we have so far. This follows up
on some of his recent work.

This series focuses on a new helper to deal with subdirectories and
empty subdirectories. The terminology that we will embrace will be
that things like "fs", "kernel", "debug" are based directories, and
directories underneath this are subdirectories.

In this case, the cleanup ends up also trimming the amount of
code we have for sysctls.

If this seems reasonable we'll kdocify this a bit too.

This code has been boot tested without issues, and I'm letting 0day do
its thing to test against many kconfig builds. If you however spot
any issues please let us know.

Luis Chamberlain (9):
  sysctl: add new register_sysctl_subdir() helper
  cdrom: use new sysctl subdir helper register_sysctl_subdir()
  hpet: use new sysctl subdir helper register_sysctl_subdir()
  i915: use new sysctl subdir helper register_sysctl_subdir()
  macintosh/mac_hid.c: use new sysctl subdir helper
    register_sysctl_subdir()
  ocfs2: use new sysctl subdir helper register_sysctl_subdir()
  test_sysctl: use new sysctl subdir helper register_sysctl_subdir()
  sysctl: add helper to register empty subdir
  fs: move binfmt_misc sysctl to its own file

Xiaoming Ni (4):
  inotify: simplify sysctl declaration with register_sysctl_subdir()
  firmware_loader: simplify sysctl declaration with
    register_sysctl_subdir()
  eventpoll: simplify sysctl declaration with register_sysctl_subdir()
  random: simplify sysctl declaration with register_sysctl_subdir()

 drivers/base/firmware_loader/fallback.c       |  4 +
 drivers/base/firmware_loader/fallback.h       | 11 +++
 drivers/base/firmware_loader/fallback_table.c | 22 ++++-
 drivers/cdrom/cdrom.c                         | 23 +----
 drivers/char/hpet.c                           | 22 +----
 drivers/char/random.c                         | 14 +++-
 drivers/gpu/drm/i915/i915_perf.c              | 22 +----
 drivers/macintosh/mac_hid.c                   | 25 +-----
 fs/binfmt_misc.c                              |  1 +
 fs/eventpoll.c                                | 10 ++-
 fs/notify/inotify/inotify_user.c              | 11 ++-
 fs/ocfs2/stackglue.c                          | 27 +-----
 include/linux/inotify.h                       |  3 -
 include/linux/poll.h                          |  2 -
 include/linux/sysctl.h                        | 21 ++++-
 kernel/sysctl.c                               | 84 +++++++++++--------
 lib/test_sysctl.c                             | 23 +----
 17 files changed, 144 insertions(+), 181 deletions(-)

-- 
2.26.2

