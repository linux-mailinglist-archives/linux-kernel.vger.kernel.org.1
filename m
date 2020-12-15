Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09222DAD30
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgLOM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:27:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:53330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgLOM0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:26:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608035167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W/+NQPp9SmxciIO27W4TJTaEMziV4Us8QYmGpci5wz8=;
        b=I7pIBULyYlgvQCQb2uACyroNg/x7g7yRZRQ8osRIwFf+LwlSltp1xO9j3rtNnH/XkB83xy
        8NEbXjaNtGe6WDyPSkUp5gsdOWp0UYxvpyALuB2SJRvz1Y+GSL/Lp6p2CPub0Ivl3QzdQu
        00/E6V/N+BxbQZyoP4wEJ2Cn5mgYG/g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DD0DADB3;
        Tue, 15 Dec 2020 12:26:07 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.11-rc1
Date:   Tue, 15 Dec 2020 13:26:06 +0100
Message-Id: <20201215122606.6874-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc1-tag

xen: branch for v5.11-rc1

It contains fixes for security issues just having been disclosed:

- a 5 patch series for fixing of XSA-349 (DoS via resource depletion in
  Xen dom0)

- a patch fixing XSA-350 (access of stale pointer in a Xen dom0)


Thanks.

Juergen

 drivers/block/xen-blkback/xenbus.c        |  4 +++-
 drivers/net/xen-netback/xenbus.c          |  6 +++++-
 drivers/xen/xen-pciback/xenbus.c          |  2 +-
 drivers/xen/xenbus/xenbus.h               |  2 ++
 drivers/xen/xenbus/xenbus_client.c        |  8 +++++++-
 drivers/xen/xenbus/xenbus_probe.c         |  1 +
 drivers/xen/xenbus/xenbus_probe_backend.c |  7 +++++++
 drivers/xen/xenbus/xenbus_xs.c            | 34 ++++++++++++++++++++-----------
 include/xen/xenbus.h                      | 15 +++++++++++++-
 9 files changed, 62 insertions(+), 17 deletions(-)

Pawel Wieczorkiewicz (1):
      xen-blkback: set ring->xenblkd to NULL after kthread_stop()

SeongJae Park (5):
      xen/xenbus: Allow watches discard events before queueing
      xen/xenbus: Add 'will_handle' callback support in xenbus_watch_path()
      xen/xenbus/xen_bus_type: Support will_handle watch callback
      xen/xenbus: Count pending messages for each watch
      xenbus/xenbus_backend: Disallow pending watch messages
