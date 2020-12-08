Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025242D358E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgLHVtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLHVtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:49:09 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EECC0613CF;
        Tue,  8 Dec 2020 13:48:29 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmkqO-00HVWT-09; Tue, 08 Dec 2020 21:48:24 +0000
Date:   Tue, 8 Dec 2020 21:48:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] [brown paperbag] regression in sparc64 this cycle
Message-ID: <20201208214823.GJ3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4bbf439b09c5ac3f8b3e9584fe080375d8d0ad2d:

  fix return values of seq_read_iter() (2020-11-15 22:12:53 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 6220e48d9640538ff700f2e7d24c2f9277555fd6:

  [regression fix] really dumb fuckup in sparc64 __csum_partial_copy() changes (2020-12-08 16:37:47 -0500)

----------------------------------------------------------------
Al Viro (1):
      [regression fix] really dumb fuckup in sparc64 __csum_partial_copy() changes

 arch/sparc/lib/csum_copy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
