Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5452D1B8F13
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgDZKsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 06:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDZKsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:48:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2D52070A;
        Sun, 26 Apr 2020 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587898080;
        bh=b9r5swSjQSCMMIoW4pu4lLRQwmuEO51hBPR8ksb0J68=;
        h=Date:From:To:Cc:Subject:From;
        b=1tUeUl5XDMCcJK85q0Ened4juPSeVYeLiqzelGLVU8UHnK+vmr5szK6fZPe+Saqol
         u//ao36fJ2/Gi06ssQXtZRP9za9X1xYfReVE1gC0SoALmb8kGFhVuVA/5nv1yper59
         ykhC/98kzcl6omF311U+yP74iqBhdbgyV1rMEXss=
Date:   Sun, 26 Apr 2020 12:47:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.7-rc3
Message-ID: <20200426104758.GA2120856@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.7-rc3

for you to fetch changes up to 9c0c54a8daf465e6e6454ffe6fc999e81a22dbf9:

  interconnect: qcom: Fix uninitialized tcs_cmd::wait (2020-04-23 16:18:07 +0200)

----------------------------------------------------------------
Char/misc driver fixes for 5.7-rc3

Here are 4 small misc driver fixes for 5.7-rc3:
	- mei driver fix
	- interconnect driver fix
	- 2 fpga driver fixes

All have been in linux-next with no reported issue

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Benjamin Lee (1):
      mei: me: fix irq number stored in hw struct

Greg Kroah-Hartman (1):
      Merge tag 'fpga-fixes-for-5.7' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-linus

Mike Tipton (1):
      interconnect: qcom: Fix uninitialized tcs_cmd::wait

Shubhrajyoti Datta (1):
      fpga: zynq: Remove clk_get error message for probe defer

Xu Yilun (1):
      fpga: dfl: pci: fix return value of cci_pci_sriov_configure

 drivers/fpga/dfl-pci.c                | 6 ++++--
 drivers/fpga/zynq-fpga.c              | 3 ++-
 drivers/interconnect/qcom/bcm-voter.c | 5 +++--
 drivers/misc/mei/pci-me.c             | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)
