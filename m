Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A07293AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405824AbgJTMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:09:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:46498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405798AbgJTMJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:09:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603195796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mN66kxz6vMIrIs3ZjXoTD87KAy1HjYEMfY65Crt1jqM=;
        b=ZJQUGnUkeFZz4I3m4la3/hTxp8M3+65EnmMlOo312EmAiLYbBosB3T6twMQro/uu5SlDWN
        bYYYc9kCxdidGhS2VblE0TYeNWfB/JU5YKTxkP5gsHrg2e3y8yFyg+PDSBBqIalv8OPEhc
        xMeHLeQcI+E3NGUxYMTWkgaqfdXFNRk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B22AABD1;
        Tue, 20 Oct 2020 12:09:56 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.10-rc1b
Date:   Tue, 20 Oct 2020 14:09:56 +0200
Message-Id: <20201020120956.29708-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1b-tag

xen: branch for v5.10-rc1b

It contains the following:

- A single patch for fixing the Xen security issue XSA-331 (malicious
  guests can DoS dom0 by triggering NULL-pointer dereferences or access
  to stale data).

- A larger series for fixing the Xen security issue XSA-332 (malicious
  guests can DoS dom0 by sending events at high frequency leading to
  dom0's vcpus being busy in IRQ handling for elongated times).


Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |   8 +
 drivers/block/xen-blkback/blkback.c             |  22 +-
 drivers/block/xen-blkback/xenbus.c              |   5 +-
 drivers/net/xen-netback/common.h                |  15 +
 drivers/net/xen-netback/interface.c             |  61 +++-
 drivers/net/xen-netback/netback.c               |  11 +-
 drivers/net/xen-netback/rx.c                    |  13 +-
 drivers/xen/events/events_2l.c                  |   9 +-
 drivers/xen/events/events_base.c                | 423 ++++++++++++++++++++++--
 drivers/xen/events/events_fifo.c                |  83 +++--
 drivers/xen/events/events_internal.h            |  20 +-
 drivers/xen/evtchn.c                            |   7 +-
 drivers/xen/pvcalls-back.c                      |  76 +++--
 drivers/xen/xen-pciback/pci_stub.c              |  13 +-
 drivers/xen/xen-pciback/pciback.h               |  12 +-
 drivers/xen/xen-pciback/pciback_ops.c           |  48 ++-
 drivers/xen/xen-pciback/xenbus.c                |   2 +-
 drivers/xen/xen-scsiback.c                      |  23 +-
 include/xen/events.h                            |  21 ++
 19 files changed, 707 insertions(+), 165 deletions(-)

Juergen Gross (13):
      xen/events: avoid removing an event channel while handling it
      xen/events: add a proper barrier to 2-level uevent unmasking
      xen/events: fix race in evtchn_fifo_unmask()
      xen/events: add a new "late EOI" evtchn framework
      xen/blkback: use lateeoi irq binding
      xen/netback: use lateeoi irq binding
      xen/scsiback: use lateeoi irq binding
      xen/pvcallsback: use lateeoi irq binding
      xen/pciback: use lateeoi irq binding
      xen/events: switch user event channels to lateeoi model
      xen/events: use a common cpu hotplug hook for event channels
      xen/events: defer eoi in case of excessive number of events
      xen/events: block rogue events for some time
