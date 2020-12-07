Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEF32D1663
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgLGQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:35:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbgLGQec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5e7kjkHucInmY6VdK0kaV1CkQzCu8JkZBTGnROzaxRs=;
        b=NWtxsNqfSRpG9tU24hWuVWjZH1edhPl2BISzr53d2pmnhkHtKPKc/gXphL7/DGhWdOPeNS
        qm1Ng+L9L71C6f9FYXiwtZOEfc4JOjtdAm6bsB2/RrhWHoebx9UeMiY/uoeLQsYRodnVJk
        VQt+Qpe64w7cDdVYcFJk4NPr253jeTE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-_-zsp-QKNN6mjUPHqIcmlw-1; Mon, 07 Dec 2020 11:33:01 -0500
X-MC-Unique: _-zsp-QKNN6mjUPHqIcmlw-1
Received: by mail-ed1-f72.google.com with SMTP id bf13so5987818edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5e7kjkHucInmY6VdK0kaV1CkQzCu8JkZBTGnROzaxRs=;
        b=MUS30Q6qW8fICHXaPPmkSsttZKkdP6U1e8LfdSRY0INWPK012mlUbMmxKIpPNROe6+
         yLUmsiRKbJcprr/yEMpv2TG1C2sqmfGtTp8hIZTJwfKd6BRoUUhVtM70cO0T6mA8S7ox
         rgzuNd8ZooF5XigMwJ2M3plhINSIiiwQCJNW8gPfmW8ssgdjWoezWk3qTZHyIv5QsR5z
         ApEdgPNmg7LNAeNq8cOmoCT3LtdZYj8PnRk1QCvCa+VVQw0byE8gTozbcvNvY667f/yv
         yNNniWXiWsEqDtBm876mOYh1svYHcPLStwss/d92r+pDQQZ0SKWybuNxwJCN1eo8LWmK
         mXtA==
X-Gm-Message-State: AOAM531f+KrVVmuxC5DibGwJBcLJZJknMG2Kz59Q+84axv46Q9gNvU0i
        GjIToPynIN/QAuwKkEfkwE/gsttH+VsKeXtIXOuXvMtDkXMG4S2Gvq11hkuysHlc9jwfcnD5huZ
        jpQL8MPP2EE8w/jPcj1C4cYcm
X-Received: by 2002:a50:9991:: with SMTP id m17mr20534896edb.48.1607358779668;
        Mon, 07 Dec 2020 08:32:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyiWs/rTwHaBsh/+l8c/SlsiYGPKleuSTJhMPZmdQ1Awha2DjwFfkQcPHng6uKbXr0raglUg==
X-Received: by 2002:a50:9991:: with SMTP id m17mr20534881edb.48.1607358779439;
        Mon, 07 Dec 2020 08:32:59 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:32:58 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 00/10] allow unprivileged overlay mounts
Date:   Mon,  7 Dec 2020 17:32:45 +0100
Message-Id: <20201207163255.564116-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've done some more work to verify that unprivileged mount of overlayfs is
safe.

One thing I did is to basically audit all function calls made by overlayfs
to see if it's normally called with any checks and whether overlayfs calls
it with the same (permission and other) checks.

Some of this work has already made it into 5.8 and this series contains
more fixes.

A general observation is that overlayfs does not call security_path_*()
hooks on the underlying fs.  I don't see this as a problem, because a
simple bind mount done inside a private mount namespace also defeats the
path based security checks.  Maybe I'm missing something here, so I'm
interested in comments from AppArmor and Tomoyo developers.

Eric, do you have thought about what to look for with respect to
unprivileged mount safety and whether you think this is ready for upstream?

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-unpriv-v2

Thanks,
Miklos


Miklos Szeredi (10):
  vfs: move cap_convert_nscap() call into vfs_setxattr()
  vfs: verify source area in vfs_dedupe_file_range_one()
  ovl: check privs before decoding file handle
  ovl: make ioctl() safe
  ovl: simplify file splice
  ovl: user xattr
  ovl: do not fail when setting origin xattr
  ovl: do not fail because of O_NOATIME
  ovl: do not get metacopy for userxattr
  ovl: unprivieged mounts

 fs/overlayfs/copy_up.c     |   3 +-
 fs/overlayfs/file.c        | 126 +++----------------------------------
 fs/overlayfs/inode.c       |  10 ++-
 fs/overlayfs/namei.c       |   3 +
 fs/overlayfs/overlayfs.h   |   8 ++-
 fs/overlayfs/ovl_entry.h   |   1 +
 fs/overlayfs/super.c       |  56 +++++++++++++++--
 fs/overlayfs/util.c        |  12 +++-
 fs/remap_range.c           |  10 ++-
 fs/xattr.c                 |  17 +++--
 include/linux/capability.h |   2 +-
 security/commoncap.c       |   3 +-
 12 files changed, 110 insertions(+), 141 deletions(-)

-- 
2.26.2

