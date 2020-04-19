Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041D1AF84C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDSHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgDSHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:45:19 -0400
X-Greylist: delayed 844 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Apr 2020 00:45:18 PDT
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E1C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 00:45:18 -0700 (PDT)
Received: from pabs by master.debian.org with local (Exim 4.92)
        (envelope-from <pabs@master.debian.org>)
        id 1jQ4Q1-00040I-4w; Sun, 19 Apr 2020 07:31:09 +0000
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Paul Wise <pabs3@bonedaddy.net>
Subject: [PATCH 0/3] dm raid/raid1: enable discard support when any devices support discard
Date:   Sun, 19 Apr 2020 15:30:23 +0800
Message-Id: <20200419073026.197967-1-pabs3@bonedaddy.net>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes dm raid and dm raid1 (mirroring) consistent with md raid,
which supports discard when only some of the devices support discard.

Another patch will be needed to fix the queue discard limits sysfs files,
fixing `fstrim --fstab`, but these patches suffice to fix `fstrim /` and
I haven't finished figuring out how the queue discard limits are set yet.

Paul Wise (3):
  dm: add support for targets that allow discard when one device does
  dm raid: only check for RAID 4/5/6 once during discard support setup
  dm raid/raid1: enable discard support when any devices support discard

 drivers/md/dm-cache-target.c  |  2 +-
 drivers/md/dm-clone-target.c  |  2 +-
 drivers/md/dm-log-writes.c    |  2 +-
 drivers/md/dm-raid.c          | 21 ++++++++++-----------
 drivers/md/dm-raid1.c         |  1 +
 drivers/md/dm-table.c         | 32 +++++++++++++++++++++-----------
 drivers/md/dm-thin.c          |  8 ++++----
 drivers/md/dm-zoned-target.c  |  2 +-
 include/linux/device-mapper.h | 13 ++++++++-----
 include/uapi/linux/dm-ioctl.h |  4 ++--
 10 files changed, 50 insertions(+), 37 deletions(-)

-- 
2.26.1

