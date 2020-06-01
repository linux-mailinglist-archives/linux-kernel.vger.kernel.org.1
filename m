Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0071A1EAC86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgFASht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbgFAShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:37:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966BC008638
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:31:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfpDD-001XF8-N9; Mon, 01 Jun 2020 18:31:03 +0000
Date:   Mon, 1 Jun 2020 19:31:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] uaccess __copy_from_user
Message-ID: <20200601183103.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Getting rid of __copy_from_user() callers -
patches that don't fit into other series

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.__copy_from_user

for you to fetch changes up to ff847781049c37dff9ad4af2bf2d7aad02622f96:

  pstore: switch to copy_from_user() (2020-04-23 10:52:48 -0400)

----------------------------------------------------------------
Al Viro (2):
      firewire: switch ioctl_queue_iso to use of copy_from_user()
      pstore: switch to copy_from_user()

 drivers/firewire/core-cdev.c | 4 +---
 fs/pstore/ram_core.c         | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)
