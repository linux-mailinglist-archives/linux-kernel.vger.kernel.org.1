Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46FC2F0788
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbhAJOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbhAJOJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:09:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1532F23741;
        Sun, 10 Jan 2021 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610287728;
        bh=H4C/kgtcqODsENedvtiyfwLLRJosZe1/by42z5lqayQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ooBtaeEloDWzze3HSAjQg6uJpHaNYeF/pGJ+ait60pYUJoysSOC/rYWpOOKENcI2P
         RILXB7dXpbw5h+u0coIC54iYFxwPVglnRnVGVSxrXUA78ryF5jMZ7oTjPPi5R2glap
         arzyIMUtSV1AslmItA9zBrJ4QolyPCvTIYJWuY2Y=
Date:   Sun, 10 Jan 2021 15:10:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.11-rc3
Message-ID: <X/sKurcTpwVvIuOs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.11-rc3

for you to fetch changes up to 00b8c557d096f0930d5c07df618223d3d06902d6:

  staging: ION: remove some references to CONFIG_ION (2021-01-06 17:39:38 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.11-rc3

Here are some small staging driver fixes for 5.11-rc3.  Nothing major,
just resolving some reported issues:
	- cleanup some remaining mentions of the ION drivers that were
	  removed in 5.11-rc1
	- comedi driver bugfix
	- 2 error path memory leak fixes

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (2):
      staging: spmi: hisi-spmi-controller: Fix some error handling paths
      staging: mt7621-dma: Fix a resource leak in an error handling path

Dan Carpenter (1):
      Staging: comedi: Return -EFAULT if copy_to_user() fails

Matthias Maennich (1):
      staging: ION: remove some references to CONFIG_ION

 drivers/staging/comedi/comedi_fops.c               |  4 +++-
 drivers/staging/hikey9xx/hisi-spmi-controller.c    | 21 +++++++++++++++------
 drivers/staging/media/atomisp/pci/atomisp_subdev.c | 20 --------------------
 drivers/staging/mt7621-dma/mtk-hsdma.c             |  4 +++-
 kernel/configs/android-recommended.config          |  1 -
 5 files changed, 21 insertions(+), 29 deletions(-)
