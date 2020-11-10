Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844742ADE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbgKJS2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731464AbgKJS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:28:09 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA015C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:28:08 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcYNA-002xmz-MI; Tue, 10 Nov 2020 18:28:04 +0000
Date:   Tue, 10 Nov 2020 18:28:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] coredump/exit race fix
Message-ID: <20201110182804.GA705344@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Fix for multithreaded coredump playing fast and loose with getting
registers of secondary threads; if a secondary gets caught in the middle
of exit(2), the conditition it will be stopped in for dumper to examine
might be unusual enough for things to go wrong.  Quite a few architectures
are fine with that, but some are not.  Sat in -next for a while, survives
local beating, fix is fairly obvious...

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 77f6ab8b7768cf5e6bdd0e72499270a0671506ee:

  don't dump the threads that had been already exiting when zapped. (2020-10-28 16:39:49 -0400)

----------------------------------------------------------------
Al Viro (1):
      don't dump the threads that had been already exiting when zapped.

 kernel/exit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
