Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF381A427E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJGYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 02:24:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgDJGYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:24:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BD58AC77;
        Fri, 10 Apr 2020 06:24:31 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.7-rc1
Date:   Fri, 10 Apr 2020 08:24:30 +0200
Message-Id: <20200410062430.20949-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.7-rc1b-tag

xen: branch for v5.7-rc1b

This is a second batch of Xen related patches:

- two cleanup patches
- a patch to fix a boot regression introduced earlier in 5.7
- a patch to fix wrong usage of memory allocation flags

Thanks.

Juergen

 arch/x86/xen/setup.c                  |  2 +-
 arch/x86/xen/xen-head.S               |  2 +-
 drivers/block/xen-blkfront.c          | 17 +++++--
 drivers/xen/events/events_2l.c        | 16 +++---
 drivers/xen/events/events_base.c      | 93 ++++++++++++++++++-----------------
 drivers/xen/events/events_fifo.c      | 22 ++++-----
 drivers/xen/events/events_internal.h  | 30 +++++------
 drivers/xen/evtchn.c                  | 13 ++---
 drivers/xen/gntdev-common.h           |  3 +-
 drivers/xen/gntdev.c                  |  2 +-
 drivers/xen/pvcalls-back.c            |  5 +-
 drivers/xen/pvcalls-front.c           | 15 +++---
 drivers/xen/xen-pciback/xenbus.c      |  7 +--
 drivers/xen/xen-scsiback.c            |  3 +-
 drivers/xen/xenbus/xenbus_client.c    |  6 +--
 include/xen/events.h                  | 22 ++++-----
 include/xen/interface/event_channel.h |  2 +-
 include/xen/xenbus.h                  |  5 +-
 18 files changed, 142 insertions(+), 123 deletions(-)

Jason Yan (1):
      x86/xen: make xen_pvmmu_arch_setup() static

Juergen Gross (2):
      xen/blkfront: fix memory allocation flags in blkfront_setup_indirect()
      x86/xen: fix booting 32-bit pv guest

Yan Yankovskyi (1):
      xen: Use evtchn_type_t as a type for event channels
