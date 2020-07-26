Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7322DE27
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgGZLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 07:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZLMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:12:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BDF2065C;
        Sun, 26 Jul 2020 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595761968;
        bh=fYVEbI0lf7X2XpeFnSzNWDLoHFeugARWomH3e9e1gpo=;
        h=Date:From:To:Cc:Subject:From;
        b=Xvgblc7GB5EUqrV93wUgM59jSB/gpb/bOV+kfETpT1jUMLy2qImLHzJifnA+Y8ZI4
         wByiJ7mEaS3XKHFV2F458wWxQo52zKmWK8M8AIB4xzrpblEZIEtNoT0E40xw3FRvf2
         8vMoPXqni/HlbGSuD4vFBsWfP38hBDyB/rCrHiQg=
Date:   Sun, 26 Jul 2020 13:12:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.8-rc7
Message-ID: <20200726111246.GA1283734@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc7

for you to fetch changes up to faaff9765664009c1c7c65551d32e9ed3b1dda8f:

  staging: wlan-ng: properly check endpoint types (2020-07-22 19:49:37 +0200)

----------------------------------------------------------------
Staging driver fixes for 5.8-rc7

Here are 5 small staging driver fixes for 5.8-rc7 to resolve some
reported problems:
	- 4 comedi driver fixes for problems found with them
	- a syzbot-found fix for the wlang-ng driver that resolves a
	  much reported problem.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ian Abbott (4):
      staging: comedi: ni_6527: fix INSN_CONFIG_DIGITAL_TRIG support
      staging: comedi: addi_apci_1032: check INSN_CONFIG_DIGITAL_TRIG shift
      staging: comedi: addi_apci_1500: check INSN_CONFIG_DIGITAL_TRIG shift
      staging: comedi: addi_apci_1564: check INSN_CONFIG_DIGITAL_TRIG shift

Rustam Kovhaev (1):
      staging: wlan-ng: properly check endpoint types

 drivers/staging/comedi/drivers/addi_apci_1032.c | 20 ++++++++++++++------
 drivers/staging/comedi/drivers/addi_apci_1500.c | 24 +++++++++++++++++++-----
 drivers/staging/comedi/drivers/addi_apci_1564.c | 20 ++++++++++++++------
 drivers/staging/comedi/drivers/ni_6527.c        |  2 +-
 drivers/staging/wlan-ng/prism2usb.c             | 16 +++++++++++++++-
 5 files changed, 63 insertions(+), 19 deletions(-)
