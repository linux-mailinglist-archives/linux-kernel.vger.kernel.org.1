Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4136726832A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgINDiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:38:14 -0400
Received: from foss.arm.com ([217.140.110.172]:58106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgINDiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:38:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B17A1045;
        Sun, 13 Sep 2020 20:38:12 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2E7F3F718;
        Sun, 13 Sep 2020 20:38:09 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com
Subject: [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall bug
Date:   Mon, 14 Sep 2020 11:37:50 +0800
Message-Id: <20200914033754.29188-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

open-unlink-f*syscall bug is a well-known bug in 9p, we try to fix the bug
in this patch set.
I take Eric's and Greg's patches which constiute the 1/4 - 3/4 of this patch
set as the main frame of the solution. In patch 4/4, I fix the fid race issue
exists in Greg's patch.

Eric Van Hensbergen (1):
  fs/9p: fix create-unlink-getattr idiom

Greg Kurz (1):
  fs/9p: search open fids first

Jianyong Wu (2):
  fs/9p: track open fids
  9p: fix race issue in fid contention.

 fs/9p/fid.c             | 72 +++++++++++++++++++++++++++++++++++------
 fs/9p/fid.h             | 25 +++++++++++---
 fs/9p/vfs_dentry.c      |  2 +-
 fs/9p/vfs_dir.c         | 20 ++++++++++--
 fs/9p/vfs_file.c        |  3 +-
 fs/9p/vfs_inode.c       | 52 +++++++++++++++++++++--------
 fs/9p/vfs_inode_dotl.c  | 44 ++++++++++++++++---------
 fs/9p/vfs_super.c       |  7 ++--
 fs/9p/xattr.c           | 18 ++++++++---
 include/net/9p/client.h |  8 +++++
 net/9p/client.c         |  7 +++-
 11 files changed, 206 insertions(+), 52 deletions(-)

-- 
2.17.1

