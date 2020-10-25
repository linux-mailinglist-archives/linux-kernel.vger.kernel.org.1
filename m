Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4178F298156
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 11:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415238AbgJYKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 06:41:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415231AbgJYKln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 06:41:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603622502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K1lMPXuT/iwQ4NEr8qzlsyuvWWhJIYQ55CHdPb6wS9s=;
        b=p4UGfDC3B5qBo1pfMZNoT5+88WfO7eQ4J6ln/6UwH8nxlhHWEcqep4eBH9e+BUQCcYvAwo
        5cLogFJbYXNGBVmP1y191OapTItiMoNmdVbR1yC21Twn0/FMtfWUBXGlNeIdA6r77rY/vL
        1kKrDf1ABKGr4kRDFdrpkP2GkCPHGbk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6114AF87;
        Sun, 25 Oct 2020 10:41:41 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.10-rc1c
Date:   Sun, 25 Oct 2020 11:41:41 +0100
Message-Id: <20201025104141.4698-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1c-tag

xen: branch for v5.10-rc1c

It contains:

- a series for the Xen pv block drivers adding module parameters for
  better control of resource usge

- a cleanup series for the Xen event driver


Thanks.

Juergen

 Documentation/ABI/testing/sysfs-driver-xen-blkback |  9 +++
 .../ABI/testing/sysfs-driver-xen-blkfront          | 11 ++-
 Documentation/admin-guide/kernel-parameters.txt    |  7 ++
 arch/x86/xen/smp.c                                 | 19 +++--
 arch/x86/xen/xen-ops.h                             |  2 +
 drivers/block/xen-blkback/xenbus.c                 | 22 +++--
 drivers/block/xen-blkfront.c                       | 20 +++--
 drivers/xen/events/events_2l.c                     |  7 +-
 drivers/xen/events/events_base.c                   | 94 +++++++++++++++-------
 drivers/xen/events/events_fifo.c                   |  9 ++-
 drivers/xen/events/events_internal.h               | 70 +++-------------
 include/xen/events.h                               |  8 --
 12 files changed, 152 insertions(+), 126 deletions(-)

Juergen Gross (5):
      xen: remove no longer used functions
      xen/events: make struct irq_info private to events_base.c
      xen/events: only register debug interrupt for 2-level events
      xen/events: unmask a fifo event channel only if it was masked
      Documentation: add xen.fifo_events kernel parameter description

SeongJae Park (3):
      xen-blkback: add a parameter for disabling of persistent grants
      xen-blkfront: add a parameter for disabling of persistent grants
      xen-blkfront: Apply changed parameter name to the document
