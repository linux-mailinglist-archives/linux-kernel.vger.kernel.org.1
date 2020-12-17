Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8957D2DD209
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgLQNTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:19:11 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946BAC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:18:31 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id jx16so37799869ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2zePh1J6egeEyg3ok0zdWeirathsGkOFp972u7tFGq8=;
        b=D9zOymYcXj+rSusZRgBj2IBtw+v9xMZ1IwrM5xFW8Ztt/dNYcsJCMYehn7CmL8NmC7
         dVkJ6y8yYiLtkzI8JIUm9b808VACFGlWenNa63S+l0bC9MdvMGr2ST2gb7AlsNbqQUNw
         C8YgdLn8psK2MrBv5KOIf4cdfvrIGLloEcO4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2zePh1J6egeEyg3ok0zdWeirathsGkOFp972u7tFGq8=;
        b=bj8BzBfpgxRR7BjmYl1PEnDDYu058bbF2jKKrk3ScyD2wFnoPDq9O3l4nEzC0Jw6Y5
         aanO0Gun4Bn6NreECwtXxWIK5nYEWPyNv/Oh6YobGL50Yhvyrl2uXKtq9SNAH9NH7fOB
         4J1EVBIDKNvRlFwqiYMnohOT04AAXP5Vty5HdLXniC7pDwqWIHzptqFlbtuhOGj+zOaK
         s4d2y/tFALl37NvvVAANl6aZAzCZwhJ1DJetMnCRfU0Uo4pD5VLO0ZRyWVimCxOAa3oy
         gRKd1ePGd8Ig+BvdoBCtMaQiutyV3fOQw4UwpJBM4XK2AzwcHR4M89PcuclMudjaAQ4Y
         yuig==
X-Gm-Message-State: AOAM531q1pTJis+loLBC2AC4a/WLDxkd6wSI+J4GpJKft3aF+0ay8agR
        jBpCWyJl6WN5n4TNBKNIoh53rSvbAy6qTG1n
X-Google-Smtp-Source: ABdhPJxmf6iO4XDzIR4MQIUy3A6Lf8W/pOlRU578OuDG/O7U6dRig5JlYZP8tiTOviXAE/8ggOyEBg==
X-Received: by 2002:a17:906:705:: with SMTP id y5mr21113654ejb.428.1608211110292;
        Thu, 17 Dec 2020 05:18:30 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r23sm3720302ejd.56.2020.12.17.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 05:18:29 -0800 (PST)
Date:   Thu, 17 Dec 2020 14:18:22 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.11
Message-ID: <20201217131822.GA1236412@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.11

 - Improve performance of virtio-fs in mixed read/write workloads.

 - Try to revalidate cache before returning EEXIST on exclusive create.

 - Add a couple of miscellaneous bug fixes as well as some code cleanups.

Thanks,
Miklos

---
Miklos Szeredi (10):
      fuse: launder page should wait for page writeback
      virtiofs fix leak in setup
      virtiofs: simplify sb setup
      fuse: get rid of fuse_mount refcount
      fuse: simplify get_fuse_conn*()
      fuse: add fuse_sb_destroy() helper
      virtiofs: clean up error handling in virtio_fs_get_tree()
      fuse: always revalidate if exclusive create
      fuse: rename FUSE_WRITE_KILL_PRIV to FUSE_WRITE_KILL_SUIDGID
      fuse: fix bad inode

Vivek Goyal (6):
      fuse: introduce the notion of FUSE_HANDLE_KILLPRIV_V2
      fuse: set FUSE_WRITE_KILL_SUIDGID in cached write path
      fuse: setattr should set FATTR_KILL_SUIDGID
      fuse: don't send ATTR_MODE to kill suid/sgid for handle_killpriv_v2
      fuse: add a flag FUSE_OPEN_KILL_SUIDGID for open() request
      fuse: support SB_NOSEC flag to improve write performance

---
 fs/fuse/acl.c             |  6 +++++
 fs/fuse/dir.c             | 60 +++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/file.c            | 41 +++++++++++++++++++++++--------
 fs/fuse/fuse_i.h          | 41 ++++++++++++++++---------------
 fs/fuse/inode.c           | 61 ++++++++++++++++++++++-------------------------
 fs/fuse/readdir.c         |  4 ++--
 fs/fuse/virtio_fs.c       | 47 ++++++++++++++++--------------------
 fs/fuse/xattr.c           |  9 +++++++
 include/uapi/linux/fuse.h | 30 +++++++++++++++++++----
 9 files changed, 195 insertions(+), 104 deletions(-)
