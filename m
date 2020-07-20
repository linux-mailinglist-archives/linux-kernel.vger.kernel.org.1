Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA23225593
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 03:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGTBqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 21:46:34 -0400
Received: from foss.arm.com ([217.140.110.172]:40784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgGTBqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:46:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2D10106F;
        Sun, 19 Jul 2020 18:46:33 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9035F3F66E;
        Sun, 19 Jul 2020 18:46:30 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, hch@lst.de, dhowells@redhat.com,
        lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [RFC PATCH 0/2] vfs:9p: fix open-unlink-fstat bug
Date:   Mon, 20 Jul 2020 09:46:20 +0800
Message-Id: <20200720014622.37364-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

how to reproduce:
in 9p guest:

struct stat *statbuf;
int fd;

fd = open("tmp", O_RDWR);
unlink("tmp");
fstat(fd, statbuf);

fstat will fail as "tmp" in 9p server side has been removed. 9p server
can't retrieve the file context as the guest has not passed it down.
so we should pass the file info down in 9p guest in getattr op.
it need add a new file member in "struct kstat" as "struct istat" does.

Jianyong Wu (2):
  vfs: pass file down when getattr to avoid losing info.
  9p: retrieve fid from file if it exists when getattr.

 fs/9p/vfs_inode.c      | 9 +++++++--
 fs/9p/vfs_inode_dotl.c | 9 +++++++--
 fs/stat.c              | 1 +
 include/linux/stat.h   | 6 ++++++
 4 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.17.1

