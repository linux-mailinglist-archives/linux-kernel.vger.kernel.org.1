Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A471A1DAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgDHIyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 04:54:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45599 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDHIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:54:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id v5so6825726wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1FwpYHoynE2gyCrz/nbvDvoG7yiJ9Y2XWNV93B0aQPs=;
        b=OcUCgo/uv/hUR/MlTD0/uA2O4PYZqP4bcPG6RsJzv2RbVwDcz6Gk81wkvWTL85Obs4
         k2+lD/L8+mnKDB0+NSM3m6NxdWG+vTcnppV+K8jcocyj6hoxdaYwuva3//hg5Bzk+ohF
         WXdgn8wCIyxgZ/gJqwcqUeQ5tlc6CnmrGm+4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1FwpYHoynE2gyCrz/nbvDvoG7yiJ9Y2XWNV93B0aQPs=;
        b=sEYQKPGtgrqMrNBHeZKF+N4bcqNottUv8tbKNzEXGi44A3b6HgYrGJUvIgJwnr61pA
         OM+J8zey2ED3L6BGhTEvQ/Pawk9q+MA8bPKo9azgohKvNLQwoB4f6p7euA12RuPFE5nx
         1kM5XSbGwgUYF25ec8WcfPbwHVJWTJljrBfFgDxYJr9biz0gGvZsMXk/jAxLVDtPvHrz
         sYIYf+AJRcrMH4ujPWvIlMdrcUTkR9yl5CCvn2aQ2agNccaLWJV6VIOkdSExsF5uosZx
         Fq6QfVKYgBOuxbnaudeSz0lszZ3+pylcwVt9EWgfgtokjsr+p1G63A2kmZicbBn/HExf
         4htg==
X-Gm-Message-State: AGi0PuazLqYMNmdChgw/p7UhtqBqXFGoDoYJhHd1f2k9hX7LBidI9F52
        vIM9BixMvkAVhsOpJJsjgH5LoQ==
X-Google-Smtp-Source: APiQypKMEZAToOUgXRdGrbEdio34X4BVF/X7L8iZVOwA5tv1WXLZRx/RAgoMcrrez/kzQKOMAjgLQQ==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr7566767wrn.187.1586336075386;
        Wed, 08 Apr 2020 01:54:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id j11sm34797250wrt.14.2020.04.08.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 01:54:34 -0700 (PDT)
Date:   Wed, 8 Apr 2020 10:54:23 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.7
Message-ID: <20200408085423.GA21974@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.7

 - Fix failure to copy-up files from certain NFSv4 mounts.

 - Sort out inconsistencies between st_ino and i_ino (used in /proc/locks).

 - Allow consistent (POSIX-y) inode numbering in more cases.

 - Allow virtiofs to be used as upper layer.

 - Miscellaneous cleanups and fixes.

Thanks,
Miklos

---
Al Viro (1):
      ovl: ovl_obtain_alias(): don't call d_instantiate_anon() for old

Amir Goldstein (10):
      ovl: fix value of i_ino for lower hardlink corner case
      ovl: fix out of date comment and unreachable code
      ovl: factor out helper ovl_get_root()
      ovl: simplify i_ino initialization
      ovl: check if upper fs supports RENAME_WHITEOUT
      ovl: strict upper fs requirements for remote upper fs
      ovl: use a private non-persistent ino pool
      ovl: avoid possible inode number collisions with xino=on
      ovl: enable xino automatically in more cases
      ovl: document xino expected behavior

Chengguang Xu (1):
      ovl: fix a typo in comment

Gustavo A. R. Silva (1):
      ovl: replace zero-length array with flexible-array member

Miklos Szeredi (7):
      ovl: document permission model
      ovl: ignore failure to copy up unknown xattrs
      ovl: restructure dentry revalidation
      ovl: separate detection of remote upper layer from stacked overlay
      ovl: decide if revalidate needed on a per-dentry basis
      ovl: allow remote upper
      ovl: fix WARN_ON nlink drop to zero

---
 Documentation/filesystems/overlayfs.rst |  82 +++++++++-
 fs/overlayfs/copy_up.c                  |  16 +-
 fs/overlayfs/dir.c                      |  31 +++-
 fs/overlayfs/export.c                   |  40 ++---
 fs/overlayfs/inode.c                    |  99 ++++++++----
 fs/overlayfs/namei.c                    |   5 +-
 fs/overlayfs/overlayfs.h                |  25 +++-
 fs/overlayfs/ovl_entry.h                |   2 +
 fs/overlayfs/readdir.c                  |  25 +++-
 fs/overlayfs/super.c                    | 258 ++++++++++++++++++++++----------
 fs/overlayfs/util.c                     |  40 +++--
 11 files changed, 460 insertions(+), 163 deletions(-)
