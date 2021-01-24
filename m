Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3E301BF2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAXM6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbhAXM6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:58:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27FA022D37;
        Sun, 24 Jan 2021 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611493064;
        bh=Z41jeOMjbUJDw96IREMvb7hqUXg3d3N+1GjnvrFCoA8=;
        h=Date:From:To:Cc:Subject:From;
        b=Jjrru6ibucQ0U66oJah5qwCn58JY9DAX3I9oJQWjkbkMXvV0bjLBuZ8Bal4XLo5+b
         g/QeSVY1HuKMjNQXg6MAna9aan9x1OTUpz9diWpeQuJyqGGtHGp/HYQnJLXWuMnG9n
         A3zAH0eT13gr1BStPnCMcScj4AqxppdgAtH8H++M=
Date:   Sun, 24 Jan 2021 13:57:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial fixes for 5.11-rc5
Message-ID: <YA1uxr1Gy9UiHd1/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.11-rc5

for you to fetch changes up to 17749851eb9ca2298e7c3b81aae4228961b36f28:

  tty: fix up hung_up_tty_write() conversion (2021-01-22 11:01:55 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.11-rc5

Here are 3 small tty/serial fixes for 5.11-rc5 to resolve reported
problems:
	- 2 patches from you to fix up writing to ttys with splice
	- mvebu-uart driver fix for reported problem.

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge 9bb48c82aced ("tty: implement write_iter") into tty-linus

Linus Torvalds (2):
      tty: implement write_iter
      tty: fix up hung_up_tty_write() conversion

Pali Rohár (1):
      serial: mvebu-uart: fix tx lost characters at power off

 drivers/tty/serial/mvebu-uart.c | 10 +++++++-
 drivers/tty/tty_io.c            | 51 ++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 24 deletions(-)
