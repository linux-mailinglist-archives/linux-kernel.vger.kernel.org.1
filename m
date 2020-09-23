Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC253275989
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIWOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:12:00 -0400
Received: from foss.arm.com ([217.140.110.172]:47046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:12:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D00A113E;
        Wed, 23 Sep 2020 07:11:59 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 927EA3F73B;
        Wed, 23 Sep 2020 07:11:56 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        qemu_oss@crudebyte.com
Cc:     groug@kaod.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com
Subject: [PATCH RFC v2 0/4] 9p: fix open-unlink-f*syscall bug.
Date:   Wed, 23 Sep 2020 22:11:42 +0800
Message-Id: <20200923141146.90046-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

open-unlink-f*syscall bug is well-known in 9p. We try to fix the bug
in this patch set.
I take Eric's and Greg's patches which constiute the 1/4 - 3/4 of this patch
set as the main frame of the solution. In patch 4/4, I fix the fid race issue
exists in Greg's patch.

change log:
v1 to v2:
        (1) in patch 4/4: do fid refcounter down in the clunk helper.
        (2) int patch 4/4: remove the enum value denoting from which of the
inode or dentry fids are allcated.

Eric Van Hensbergen (1):
  fs/9p: fix create-unlink-getattr idiom

Greg Kurz (1):
  fs/9p: search open fids first

Jianyong Wu (2):
  fs/9p: track open fids
  9p: fix race issue in fid contention.

 fs/9p/fid.c             | 69 ++++++++++++++++++++++++++++++++++++++---
 fs/9p/fid.h             | 11 ++++++-
 fs/9p/vfs_dentry.c      |  2 ++
 fs/9p/vfs_dir.c         |  6 +++-
 fs/9p/vfs_file.c        |  1 +
 fs/9p/vfs_inode.c       | 47 ++++++++++++++++++++++------
 fs/9p/vfs_inode_dotl.c  | 35 +++++++++++++++++----
 fs/9p/vfs_super.c       |  1 +
 fs/9p/xattr.c           | 16 ++++++++--
 include/net/9p/client.h |  7 +++++
 net/9p/client.c         | 14 ++++++---
 11 files changed, 179 insertions(+), 30 deletions(-)

-- 
2.17.1

