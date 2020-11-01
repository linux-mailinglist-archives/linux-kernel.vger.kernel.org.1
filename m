Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117AF2A1E33
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKANIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKANIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:08:41 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757FD208B6;
        Sun,  1 Nov 2020 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236119;
        bh=xuPt7xRSZgxYbAIJjWopt6d6RBzug/vvyxWqA/RixRQ=;
        h=Date:From:To:Cc:Subject:From;
        b=hR9F5nDU1OLiGo5DORUNgQrrJji9lxLFn3A84QvlNedJBmgDBMRNJV24VUc/aKtyH
         OWyQIGSA1eHrVJl4BvzomdUY9ZBTHBSFfiBSLhzaIlDKtot5fTYtRoaUy8GoMOi8GL
         2XlMyBaJSTMITHNM4whaPHgjcT2NDym3LQCtvIWQ=
Date:   Sun, 1 Nov 2020 14:09:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.10-rc2
Message-ID: <20201101130921.GA4115310@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc2

for you to fetch changes up to 7e97e4cbf30026b49b0145c3bfe06087958382c5:

  staging: fieldbus: anybuss: jump to correct label in an error path (2020-10-27 13:24:51 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.10-rc2

Here are some small staging driver fixes for issues that have been
reported in 5.10-rc1:
  - octeon driver fixes
  - wfx driver fixes
  - memory leak fix in vchiq driver
  - fieldbus driver bugfix
  - comedi driver bugfix

All of these have been in linux-next with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Sverdlin (2):
      staging: octeon: repair "fixed-link" support
      staging: octeon: Drop on uncorrectable alignment or FCS error

Ian Abbott (1):
      staging: comedi: cb_pcidas: Allow 2-channel commands for AO subdevice

Jing Xiangfeng (1):
      staging: fieldbus: anybuss: jump to correct label in an error path

Jérôme Pouiller (2):
      staging: wfx: fix use of uninitialized pointer
      staging: wfx: fix test on return value of gpiod_get_value()

Seung-Woo Kim (1):
      staging: mmal-vchiq: Fix memory leak for vchiq_instance

 drivers/staging/comedi/drivers/cb_pcidas.c         |  1 +
 drivers/staging/fieldbus/anybuss/arcx-anybus.c     |  2 +-
 drivers/staging/octeon/ethernet-mdio.c             |  6 ----
 drivers/staging/octeon/ethernet-rx.c               | 34 ++++++++++++----------
 drivers/staging/octeon/ethernet.c                  |  9 ++++++
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  | 19 +++++++++---
 drivers/staging/wfx/bh.c                           |  2 +-
 drivers/staging/wfx/data_tx.c                      |  6 ++--
 8 files changed, 49 insertions(+), 30 deletions(-)
