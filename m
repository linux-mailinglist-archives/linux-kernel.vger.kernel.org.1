Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A503E1DF770
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbgEWNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 09:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387770AbgEWNR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:17:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B6D207F9;
        Sat, 23 May 2020 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590239846;
        bh=OPW2qhK1n3chEw/w5oVvmjZurmMx+fWOu4qEWwCf1aU=;
        h=Date:From:To:Cc:Subject:From;
        b=TwG6U5wyo4Hj2aOrgHrzpejLbaMuM/oYVR9ktYEWGRuljOqDD7s4AWrc4c++Vr5QL
         GZpcxihwRz+JfPjSzsoHXq0nBCphGTTmMtGx3wOpXvRzS3xU4XQjtPWweEFxCuLmEk
         wmXV2D2guZwoKscUNvg+bcUdPj6Pah74adA1e6eU=
Date:   Sat, 23 May 2020 15:17:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fix for 5.7-rc7
Message-ID: <20200523131724.GA54852@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc7

for you to fetch changes up to 17b4efdf4e4867079012a48ca10d965fe9d68822:

  tty: serial: add missing spin_lock_init for SiFive serial console (2020-05-15 14:55:10 +0200)

----------------------------------------------------------------
TTY/Serial fix for 5.7-rc7

Here is a single serial driver fix for 5.7-rc7.  It resolves an issue
with the SiFive serial console init sequence that was reported a number
of times.

It has been in linux-next for a while now with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Sagar Shrikant Kadam (1):
      tty: serial: add missing spin_lock_init for SiFive serial console

 drivers/tty/serial/sifive.c | 1 +
 1 file changed, 1 insertion(+)
