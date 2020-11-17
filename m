Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9172B72A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKQXty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:49:54 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:53451 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQXty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605656993; x=1637192993;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5JkuS5sMNNqMK7prMFueAtoWBVlDGevEn+fHZUkSofc=;
  b=W/s7d52kjZpCWzYIXA9MMwmoL6u46jTA/y+uVMCO10cyKez8g62klNEO
   GscqjPd3N4HWVcLyMhQNBDn23vo+JzJlALUEMApfNA+l+zyVVBpp7gamx
   9T0baGmNFox6bPndIRIsu8ZVe28vxBDO1I9vBYhQK7bC7B51L6FZrlRza
   g=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="64304400"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 17 Nov 2020 23:49:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 4B6D1A21B5;
        Tue, 17 Nov 2020 23:49:45 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:44 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:44 +0000
Received: from localhost (10.143.193.228) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Nov 2020 23:49:43 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v1 0/3] Fixes to L1D flushing (on top of linux-next and
Date:   Wed, 18 Nov 2020 10:49:31 +1100
Message-ID: <20201117234934.25985-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were concerns with the current interface (checking for the state
of SMT of the core at opt-in time [1]). These patches change the
interface to send a SIGBUS to the task if

a. It opts into L1D flushing
b. Runs on a core with SMT enabled

There are also documentation fixes. I've tested the patches at my end,
but would appreciate a broad review of the change in functionality
and/or any recommended doc updates.


[1] http://lkml.iu.edu/hypermail/linux/kernel/2009.3/09310.html
[2] http://lkml.iu.edu/hypermail/linux/kernel/2009.3/09613.html

NOTE: For testing these patches, specifically the SIGBUS behaviour,
there needs to be contention on the CPU where the task that opts
into L1D flushing is running to see the SIGBUS being sent to it
(the deterministic bit is that if there is scope of data leak
the task will get killed)

Balbir Singh (3):
  x86/mm: change l1d flush runtime prctl behaviour
  Documentation: Update the new SIGBUS behaviour for tasks
  Documentation/l1d_flush: Fix up warning with labels

 .../admin-guide/hw-vuln/l1d_flush.rst         | 12 +++---
 arch/Kconfig                                  |  4 ++
 arch/x86/Kconfig                              |  1 +
 arch/x86/mm/tlb.c                             | 37 +++++++++++--------
 include/linux/sched.h                         | 10 +++++
 5 files changed, 42 insertions(+), 22 deletions(-)

-- 
2.17.1

