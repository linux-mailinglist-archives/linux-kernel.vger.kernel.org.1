Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008A32AACE7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgKHSpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbgKHSpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:45:41 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52AAD20731;
        Sun,  8 Nov 2020 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604861139;
        bh=F45V+K+WEHd20709vAX2Z23LDrbQnLKlIyqpegGMIbY=;
        h=Date:From:To:Cc:Subject:From;
        b=PcXbLRx1P7z3tYihrhLEBfhybasgxJDqDzJqbaKcpmwzUlZnVxVrmKTnh3Jh46ZxH
         PdeXXfdTCa9dvfeQr5uyd2BWxusFmyenCuUkoq2atWRMvjoygUIL5PSERqhV/0ZqQg
         1FRglcz9HnyuUHGgKwerIgg99juy51SGOf6ot9pY=
Date:   Sun, 8 Nov 2020 19:46:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core documentation fixes for 5.10-rc3
Message-ID: <20201108184640.GA66927@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc3

for you to fetch changes up to d181bfe36715a1834958cf2d62253b624adfae51:

  Documentation: remove mic/index from misc-devices/index.rst (2020-11-04 11:38:32 +0100)

----------------------------------------------------------------
Driver core documentation fixes for 5.10-rc3

Here are some small Documentation fixes for 5.10-rc3 that were fallout
from the larger documentation update we did in 5.10-rc2.  Nothing major
here at all, but all of these have been in linux-next and resolve build
warnings when building the documentation files.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Documentation: remove mic/index from misc-devices/index.rst

Mauro Carvalho Chehab (5):
      docs: ABI: sysfs-driver-dma-ioatdma: what starts with /sys
      docs: ABI: sysfs-class-net: fix a typo
      docs: leds: index.rst: add a missing file
      scripts: get_abi.pl: Don't let ABI files to create subtitles
      scripts: get_api.pl: Add sub-titles to ABI output

 Documentation/ABI/stable/sysfs-driver-dma-ioatdma | 10 +++++-----
 Documentation/ABI/testing/sysfs-class-net         |  2 +-
 Documentation/leds/index.rst                      |  1 +
 Documentation/misc-devices/index.rst              |  1 -
 scripts/get_abi.pl                                | 23 +++++++++++++++++++++++
 5 files changed, 30 insertions(+), 7 deletions(-)
