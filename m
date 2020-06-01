Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA51EAC88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgFASh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgFAShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:37:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C73C008637
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:30:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfpCD-001XDo-Rr; Mon, 01 Jun 2020 18:30:01 +0000
Date:   Mon, 1 Jun 2020 19:30:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] uaccess __put_user
Message-ID: <20200601183001.GD23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	__put_user() calls removal - the patches that don't
fit into any other series

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.__put_user

for you to fetch changes up to ebe6976d3634a311367f72c2402f148ab9f23920:

  pcm_native: result of put_user() needs to be checked (2020-04-26 09:33:49 -0400)

----------------------------------------------------------------
Al Viro (3):
      compat sysinfo(2): don't bother with field-by-field copyout
      scsi_ioctl.c: switch SCSI_IOCTL_GET_IDLUN to copy_to_user()
      pcm_native: result of put_user() needs to be checked

 drivers/scsi/scsi_ioctl.c | 20 ++++++++++----------
 kernel/sys.c              | 33 +++++++++++++++++----------------
 sound/core/pcm_native.c   | 12 ++++++++----
 3 files changed, 35 insertions(+), 30 deletions(-)
