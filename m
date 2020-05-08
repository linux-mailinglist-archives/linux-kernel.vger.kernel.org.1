Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5571CB18D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEHORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHORl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:17:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E64A24956;
        Fri,  8 May 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588947459;
        bh=z6fbe8w+RwxkvSNeRN3EkkyZIHuGcL9vC9zLiGL4ddw=;
        h=Date:From:To:Cc:Subject:From;
        b=qVDInJXMDflY8epY1cXlVGKuYL+LtnsdV9zKPwKBkinGJxJcs+e6c0LuR/q8VVNXk
         So4NJq/mKIbjfqVOj2o6SR/vhUAAD2FxEP1lzjRRQIQYn1s8gGGyoWIcCKHeJz61QP
         gVeeZ5wCypVLLNi/PYF410v8jXDkMfhrYCBBQtK8=
Date:   Fri, 8 May 2020 16:17:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.7-rc5
Message-ID: <20200508141737.GA350607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc5

for you to fetch changes up to 2ae11c46d5fdc46cb396e35911c713d271056d35:

  tty: xilinx_uartps: Fix missing id assignment to the console (2020-05-04 18:55:45 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.7-rc5

Here are 3 small TTY/Serial/VT fixes for 5.7-rc5:
	- revert for the bcm63xx driver "fix" that was incorrect
	- vt unicode console bugfix
	- xilinx_uartps console driver fix

All of these have been in linux next with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Florian Fainelli (1):
      Revert "tty: serial: bcm63xx: fix missing clk_put() in bcm63xx_uart"

Nicolas Pitre (1):
      vt: fix unicode console freeing with a common interface

Shubhrajyoti Datta (1):
      tty: xilinx_uartps: Fix missing id assignment to the console

 drivers/tty/serial/bcm63xx_uart.c  | 4 +---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 drivers/tty/vt/vt.c                | 9 +++++++--
 3 files changed, 9 insertions(+), 5 deletions(-)
