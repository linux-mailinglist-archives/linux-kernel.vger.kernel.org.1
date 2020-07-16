Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40880222702
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgGPPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 11:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgGPPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:30:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5572065F;
        Thu, 16 Jul 2020 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913409;
        bh=PawmqB/Q7xJKCoLY3kW1NBAdHFKr3B51rLnHjLEUNTk=;
        h=Date:From:To:Cc:Subject:From;
        b=CxYdGa2CractfD+g6Ox7/oaikKnNvCP7gAVSaCIjnQr9zzJST4Lr/+OhWX7o1ryRM
         zx0Pt5j9gg4GyErqpE7IlO6ym2jwrwaQrSbkv28gWFpwtqJvAt/kbyXFQgFofKCNve
         hcoz0R7Txsq4CnmG1cAHcQgHL/9Tq8dPs69dcdcc=
Date:   Thu, 16 Jul 2020 17:30:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.8-rc6
Message-ID: <20200716153003.GA2379010@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.8-rc6

for you to fetch changes up to 2451e746478a6a6e981cfa66b62b791ca93b90c8:

  driver core: Avoid deferred probe due to fw_devlink_pause/resume() (2020-07-10 15:20:38 +0200)

----------------------------------------------------------------
Driver core fixes for 5.8-rc6

Here are 3 driver core fixes for 5.8-rc6.

They resolve some issues found with the deferred probe code for some
types of devices on some embedded systems.  They have been tested a
bunch and have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Saravana Kannan (3):
      driver core: Don't do deferred probe in parallel with kernel_init thread
      driver core: Rename dev_links_info.defer_sync to defer_hook
      driver core: Avoid deferred probe due to fw_devlink_pause/resume()

 drivers/base/base.h    |  1 -
 drivers/base/core.c    | 44 ++++++++++++++++++++++++++++++++------------
 drivers/base/dd.c      |  5 -----
 include/linux/device.h |  5 +++--
 4 files changed, 35 insertions(+), 20 deletions(-)
